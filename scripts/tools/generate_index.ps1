$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$sceneDir = Join-Path $root "scene"
$scriptsDir = Join-Path $root "scripts"
$docsDir = Join-Path $root "docs"
$indexPath = Join-Path $docsDir "INDEX.md"

New-Item -ItemType Directory -Force -Path $docsDir | Out-Null

$extResourceRe = '^\[ext_resource type="([^"]+)" .* path="([^"]+)" id="([^"]+)"\]$'
$nodeRe = '^\[node name="([^"]+)" type="([^"]+)"(?: parent="([^"]+)")?.*\]$'
$scriptRe = '^\s*script = ExtResource\("([^"]+)"\)'
$instanceRe = 'instance=ExtResource\("([^"]+)"\)'
$uniqueRe = '^\s*unique_name_in_owner = true'
$connRe = '^\[connection signal="([^"]+)" from="([^"]+)" to="([^"]+)" method="([^"]+)"\]$'

$roleRe = '^# ROLE:\s*(.*)$'
$ownsRe = '^# OWNS:\s*(.*)$'
$talksRe = '^# TALKS_TO:\s*(.*)$'
$apiRe = '^# API:\s*(.*)$'

function RelPath($path) {
    return (Resolve-Path $path).Path.Replace($root.Path + "\", "").Replace("\", "/")
}

function Parse-Tscn($path) {
    $lines = Get-Content $path
    $extMap = @{}
    $scriptResources = @{}
    $packedScenes = New-Object System.Collections.Generic.List[string]
    $nodes = New-Object System.Collections.Generic.List[hashtable]
    $current = $null

    foreach ($line in $lines) {
        if ($line -match $extResourceRe) {
            $rtype = $Matches[1]
            $rpath = $Matches[2]
            $rid = $Matches[3]
            $extMap[$rid] = @{ type = $rtype; path = $rpath }
            if ($rtype -eq "PackedScene") { $packedScenes.Add($rpath) | Out-Null }
            if ($rtype -eq "Script") { $scriptResources[$rid] = $rpath }
            continue
        }
        if ($line -match $nodeRe) {
            $current = @{
                name = $Matches[1]
                type = $Matches[2]
                parent = ($Matches[3] | ForEach-Object { $_ }) -as [string]
                script = ""
                instance = ""
                unique = $false
            }
            $nodes.Add($current) | Out-Null
            continue
        }
        if ($null -ne $current) {
            if ($line -match $scriptRe) {
                $rid = $Matches[1]
                if ($scriptResources.ContainsKey($rid)) {
                    $current.script = $scriptResources[$rid]
                }
                continue
            }
            if ($line -match $instanceRe) {
                $rid = $Matches[1]
                if ($extMap.ContainsKey($rid) -and $extMap[$rid].type -eq "PackedScene") {
                    $current.instance = $extMap[$rid].path
                }
                continue
            }
            if ($line -match $uniqueRe) {
                $current.unique = $true
                continue
            }
        }
    }

    $connections = @()
    foreach ($line in $lines) {
        if ($line -match $connRe) {
            $connections += @{
                signal = $Matches[1]
                from = $Matches[2]
                to = $Matches[3]
                method = $Matches[4]
            }
        }
    }

    $rootNode = if ($nodes.Count -gt 0) { $nodes[0] } else { @{ name = ""; type = "" } }
    $keyNodes = @()
    foreach ($n in $nodes) {
        if ($n.script -or $n.instance -or $n.unique) { $keyNodes += $n }
    }

    return @{
        root = "$($rootNode.name) ($($rootNode.type))"
        key_nodes = $keyNodes
        packed_scenes = $packedScenes
        connections = $connections
    }
}

function Parse-Gd($path) {
    $lines = Get-Content $path
    if ($lines.Count -eq 0) {
        return @{
            class_name = ""
            extends = ""
            role = ""
            owns = ""
            talks_to = ""
            api = ""
        }
    }
    $role = ""
    $owns = ""
    $talks = ""
    $api = ""
    foreach ($line in $lines[0..([Math]::Min(19, $lines.Count - 1))]) {
        if ($line -match $roleRe) { $role = $Matches[1].Trim() }
        if ($line -match $ownsRe) { $owns = $Matches[1].Trim() }
        if ($line -match $talksRe) { $talks = $Matches[1].Trim() }
        if ($line -match $apiRe) { $api = $Matches[1].Trim() }
    }
    $className = ""
    $extends = ""
    foreach ($line in $lines) {
        if ($line -match '^class_name\s+(.+)$') { $className = $Matches[1].Trim() }
        if ($line -match '^extends\s+(.+)$') { $extends = $Matches[1].Trim() }
        if ($className -and $extends) { break }
    }
    return @{
        class_name = $className
        extends = $extends
        role = $role
        owns = $owns
        talks_to = $talks
        api = $api
    }
}

$sceneEntries = @()
Get-ChildItem -Path $sceneDir -Recurse -Filter "*.tscn" | Sort-Object FullName | ForEach-Object {
    $info = Parse-Tscn $_.FullName
    $sceneEntries += @{
        path = (RelPath $_.FullName)
        root = $info.root
        key_nodes = $info.key_nodes
        packed_scenes = $info.packed_scenes
        connections = $info.connections
    }
}

$scriptEntries = @()
Get-ChildItem -Path $scriptsDir -Recurse -Filter "*.gd" | Sort-Object FullName | ForEach-Object {
    $info = Parse-Gd $_.FullName
    $scriptEntries += @{
        path = (RelPath $_.FullName)
        class_name = $info.class_name
        extends = $info.extends
        role = $info.role
        owns = $info.owns
        talks_to = $info.talks_to
        api = $info.api
    }
}

$autoloads = @{}
$projectPath = Join-Path $root "project.godot"
if (Test-Path $projectPath) {
    $text = Get-Content $projectPath
    $inAutoload = $false
    foreach ($line in $text) {
        if ($line.Trim() -eq "[autoload]") { $inAutoload = $true; continue }
        if ($line.StartsWith("[") -and $line.Trim() -ne "[autoload]") { $inAutoload = $false }
        if ($inAutoload -and $line -match "=") {
            $parts = $line.Split("=", 2)
            $autoloads[$parts[0].Trim()] = $parts[1].Trim()
        }
    }
}

$sb = New-Object System.Text.StringBuilder
$sb.AppendLine("# Project Index") | Out-Null
$sb.AppendLine("") | Out-Null
$sb.AppendLine("## Scenes") | Out-Null
$sb.AppendLine("") | Out-Null
foreach ($s in $sceneEntries) {
    $sb.AppendLine("- $($s.path)") | Out-Null
    $sb.AppendLine("  - root: $($s.root)") | Out-Null
    if ($s.packed_scenes.Count -gt 0) {
        $sb.AppendLine("  - packed_scenes:") | Out-Null
        foreach ($p in $s.packed_scenes) {
            $sb.AppendLine("    - $p") | Out-Null
        }
    }
    if ($s.key_nodes.Count -gt 0) {
        $sb.AppendLine("  - key_nodes:") | Out-Null
        foreach ($n in $s.key_nodes) {
            $script = if ($n.script) { $n.script } else { "-" }
            $inst = if ($n.instance) { $n.instance } else { "-" }
            $uniq = if ($n.unique) { "unique" } else { "-" }
            $sb.AppendLine("    - $($n.name) ($($n.type)) parent=$($n.parent) script=$script instance=$inst $uniq") | Out-Null
        }
    }
    if ($s.connections.Count -gt 0) {
        $sb.AppendLine("  - connections:") | Out-Null
        foreach ($c in $s.connections) {
            $sb.AppendLine("    - $($c.from) -> $($c.to) : $($c.signal) -> $($c.method)") | Out-Null
        }
    }
    $sb.AppendLine("") | Out-Null
}

$sb.AppendLine("## Scripts") | Out-Null
$sb.AppendLine("") | Out-Null
foreach ($s in $scriptEntries) {
    $sb.AppendLine("- $($s.path)") | Out-Null
    if ($s.class_name) { $sb.AppendLine("  - class_name: $($s.class_name)") | Out-Null }
    if ($s.extends) { $sb.AppendLine("  - extends: $($s.extends)") | Out-Null }
    if ($s.role) { $sb.AppendLine("  - ROLE: $($s.role)") | Out-Null }
    if ($s.owns) { $sb.AppendLine("  - OWNS: $($s.owns)") | Out-Null }
    if ($s.talks_to) { $sb.AppendLine("  - TALKS_TO: $($s.talks_to)") | Out-Null }
    if ($s.api) { $sb.AppendLine("  - API: $($s.api)") | Out-Null }
    $sb.AppendLine("") | Out-Null
}

$sb.AppendLine("## Systems / Managers") | Out-Null
$sb.AppendLine("") | Out-Null
if ($autoloads.Count -gt 0) {
    $sb.AppendLine("### AutoLoad") | Out-Null
    $sb.AppendLine("") | Out-Null
    foreach ($key in $autoloads.Keys) {
        $sb.AppendLine("- ${key}: $($autoloads[$key])") | Out-Null
    }
}

$sb.AppendLine("") | Out-Null
$sb.AppendLine("## Raw Data (JSON)") | Out-Null
$sb.AppendLine("") | Out-Null
$payload = @{
    scenes = $sceneEntries
    scripts = $scriptEntries
    autoloads = $autoloads
}
$sb.AppendLine('```json') | Out-Null
$sb.AppendLine(($payload | ConvertTo-Json -Depth 6)) | Out-Null
$sb.AppendLine('```') | Out-Null

$sb.ToString() | Set-Content -Path $indexPath -Encoding UTF8
