import json
import os
import re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SCENE_DIR = os.path.join(ROOT, "scene")
SCRIPTS_DIR = os.path.join(ROOT, "scripts")
DOCS_DIR = os.path.join(ROOT, "docs")
INDEX_PATH = os.path.join(DOCS_DIR, "INDEX.md")

EXT_RESOURCE_RE = re.compile(r'^\[ext_resource type="([^"]+)" .* path="([^"]+)" id="([^"]+)"\]$')
NODE_RE = re.compile(r'^\[node name="([^"]+)" type="([^"]+)"(?: parent="([^"]+)")?.*\]$')
SCRIPT_RE = re.compile(r'^\s*script = ExtResource\("([^"]+)"\)')
INSTANCE_RE = re.compile(r'instance=ExtResource\("([^"]+)"\)')
UNIQUE_RE = re.compile(r'^\s*unique_name_in_owner = true')
CONNECTION_RE = re.compile(r'^\[connection signal="([^"]+)" from="([^"]+)" to="([^"]+)" method="([^"]+)"\]$')

ROLE_RE = re.compile(r'^# ROLE:\s*(.*)$')
OWNS_RE = re.compile(r'^# OWNS:\s*(.*)$')
TALKS_RE = re.compile(r'^# TALKS_TO:\s*(.*)$')
API_RE = re.compile(r'^# API:\s*(.*)$')


def read_text(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


def iter_files(root, suffix):
    for dirpath, _, filenames in os.walk(root):
        for name in filenames:
            if name.endswith(suffix):
                yield os.path.join(dirpath, name)


def rel_path(path):
    return os.path.relpath(path, ROOT).replace("\\", "/")


def parse_tscn(path):
    text = read_text(path).splitlines()
    ext_map = {}
    packed_scenes = []
    script_resources = {}
    nodes = []
    current_node = None
    unique_next = False

    for line in text:
        m = EXT_RESOURCE_RE.match(line)
        if m:
            rtype, rpath, rid = m.groups()
            ext_map[rid] = {"type": rtype, "path": rpath}
            if rtype == "PackedScene":
                packed_scenes.append(rpath)
            if rtype == "Script":
                script_resources[rid] = rpath
            continue

        m = NODE_RE.match(line)
        if m:
            name, ntype, parent = m.groups()
            current_node = {
                "name": name,
                "type": ntype,
                "parent": parent or "",
                "script": "",
                "instance": "",
                "unique": False,
            }
            nodes.append(current_node)
            unique_next = False
            continue

        if current_node:
            m = SCRIPT_RE.match(line)
            if m:
                rid = m.group(1)
                current_node["script"] = script_resources.get(rid, "")
                continue

            m = INSTANCE_RE.search(line)
            if m:
                rid = m.group(1)
                inst = ext_map.get(rid, {})
                if inst.get("type") == "PackedScene":
                    current_node["instance"] = inst.get("path", "")
                continue

            if UNIQUE_RE.match(line):
                current_node["unique"] = True
                continue

    connections = []
    for line in text:
        m = CONNECTION_RE.match(line)
        if m:
            signal, source, target, method = m.groups()
            connections.append(
                {"signal": signal, "from": source, "to": target, "method": method}
            )

    root_node = nodes[0] if nodes else {"name": "", "type": ""}
    key_nodes = []
    for n in nodes:
        if n["script"] or n["instance"] or n["unique"]:
            key_nodes.append(n)

    return {
        "root": f'{root_node["name"]} ({root_node["type"]})',
        "key_nodes": key_nodes,
        "packed_scenes": packed_scenes,
        "connections": connections,
    }


def parse_gd(path):
    lines = read_text(path).splitlines()
    role = owns = talks = api = ""
    for line in lines[:20]:
        m = ROLE_RE.match(line)
        if m:
            role = m.group(1).strip()
        m = OWNS_RE.match(line)
        if m:
            owns = m.group(1).strip()
        m = TALKS_RE.match(line)
        if m:
            talks = m.group(1).strip()
        m = API_RE.match(line)
        if m:
            api = m.group(1).strip()
    class_name = ""
    extends = ""
    for line in lines:
        if line.startswith("class_name "):
            class_name = line.split(" ", 1)[1].strip()
        if line.startswith("extends "):
            extends = line.split(" ", 1)[1].strip()
        if class_name and extends:
            break
    return {
        "class_name": class_name,
        "extends": extends,
        "role": role,
        "owns": owns,
        "talks_to": talks,
        "api": api,
    }


def main():
    os.makedirs(DOCS_DIR, exist_ok=True)

    scene_entries = []
    for path in sorted(iter_files(SCENE_DIR, ".tscn")):
        info = parse_tscn(path)
        scene_entries.append(
            {
                "path": rel_path(path),
                "root": info["root"],
                "key_nodes": info["key_nodes"],
                "packed_scenes": info["packed_scenes"],
                "connections": info["connections"],
            }
        )

    script_entries = []
    for path in sorted(iter_files(SCRIPTS_DIR, ".gd")):
        info = parse_gd(path)
        script_entries.append(
            {
                "path": rel_path(path),
                **info,
            }
        )

    autoloads = {}
    project_path = os.path.join(ROOT, "project.godot")
    if os.path.exists(project_path):
        text = read_text(project_path)
        in_autoload = False
        for line in text.splitlines():
            if line.strip() == "[autoload]":
                in_autoload = True
                continue
            if line.startswith("[") and line.strip() != "[autoload]":
                in_autoload = False
            if in_autoload and "=" in line:
                key, value = line.split("=", 1)
                autoloads[key.strip()] = value.strip()

    with open(INDEX_PATH, "w", encoding="utf-8") as f:
        f.write("# Project Index\n\n")
        f.write("## Scenes\n\n")
        for s in scene_entries:
            f.write(f"- {s['path']}\n")
            f.write(f"  - root: {s['root']}\n")
            if s["packed_scenes"]:
                f.write("  - packed_scenes:\n")
                for p in s["packed_scenes"]:
                    f.write(f"    - {p}\n")
            if s["key_nodes"]:
                f.write("  - key_nodes:\n")
                for n in s["key_nodes"]:
                    script = n["script"] or "-"
                    inst = n["instance"] or "-"
                    uniq = "unique" if n["unique"] else "-"
                    f.write(
                        f"    - {n['name']} ({n['type']}) parent={n['parent']} script={script} instance={inst} {uniq}\n"
                    )
            if s["connections"]:
                f.write("  - connections:\n")
                for c in s["connections"]:
                    f.write(
                        f"    - {c['from']} -> {c['to']} : {c['signal']} -> {c['method']}\n"
                    )
            f.write("\n")

        f.write("## Scripts\n\n")
        for s in script_entries:
            f.write(f"- {s['path']}\n")
            if s["class_name"]:
                f.write(f"  - class_name: {s['class_name']}\n")
            if s["extends"]:
                f.write(f"  - extends: {s['extends']}\n")
            if s["role"]:
                f.write(f"  - ROLE: {s['role']}\n")
            if s["owns"]:
                f.write(f"  - OWNS: {s['owns']}\n")
            if s["talks_to"]:
                f.write(f"  - TALKS_TO: {s['talks_to']}\n")
            if s["api"]:
                f.write(f"  - API: {s['api']}\n")
            f.write("\n")

        f.write("## Systems / Managers\n\n")
        if autoloads:
            f.write("### AutoLoad\n\n")
            for name, value in autoloads.items():
                f.write(f"- {name}: {value}\n")
        f.write("\n")

        f.write("## Raw Data (JSON)\n\n")
        payload = {
            "scenes": scene_entries,
            "scripts": script_entries,
            "autoloads": autoloads,
        }
        f.write("```json\n")
        f.write(json.dumps(payload, ensure_ascii=False, indent=2))
        f.write("\n```\n")


if __name__ == "__main__":
    main()
