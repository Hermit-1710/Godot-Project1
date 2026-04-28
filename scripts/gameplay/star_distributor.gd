# ROLE: Place stars from inventory into palaces.
# OWNS: distribution timing and placement logic.
# TALKS_TO: StarPanel, PalaceContainer, StarIcon, AudioPlayer.
# API: clear_palaces, distribute_inventory, place_star_in_palace.
# INVARIANTS: star_panel has palace indices 0..11.
extends RefCounted
class_name StarDistributor

func clear_palaces(star_panel: StarPanel) -> void:
	if not star_panel:
		return
	for i in range(12):
		var palace: PalaceContainer = star_panel.find_palace(i)
		if palace:
			palace.clear()

func distribute_inventory(
		inventory: Array[StarInstance],
		rng: RandomNumberGenerator,
		star_panel: StarPanel,
		star_scene: PackedScene,
		add_sound: AudioStream,
		tree: SceneTree
) -> void:
	if not star_panel or not rng or not star_scene or not tree:
		return
	for star in inventory:
		var palace_index := rng.randi_range(0, 11)
		place_star_in_palace(palace_index, star, star_panel, star_scene, add_sound)
		await tree.create_timer(0.3).timeout

func place_star_in_palace(
		palace_index: int,
		star: StarInstance,
		star_panel: StarPanel,
		star_scene: PackedScene,
		add_sound: AudioStream
) -> void:
	var palace: PalaceContainer = star_panel.find_palace(palace_index)
	if not palace:
		return
	star.palace_index = palace_index
	star.in_palace = true
	var star_icon: StarIcon = star_scene.instantiate()
	star_icon.can_drop.connect(star_panel.reset_staricon)
	palace.add_star(star_icon)
	star_icon.initial(star)
	if add_sound:
		AudioPlayer.audio_play(add_sound)
