# Project Index

## Scenes

- scene/Autoload/AudioPlayer.tscn
  - root: AudioGlobalPlayer (Node)

- scene/Autoload/drag_manager.tscn
  - root: DragManager (Node2D)
  - key_nodes:
    - DragManager (Node2D) parent= script=res://scripts/autoload/drag_manager.gd instance=- -

- scene/Autoload/scene_transition_manager.tscn
  - root: SceneTransitionManager (Node)

- scene/Autoload/StarInfo.tscn
  - root: starinfo (PanelContainer)
  - key_nodes:
    - starinfo (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -
    - startexture (TextureRect) parent=MarginContainer/VBoxContainer/鏄熸洔 鍥炬爣&Title script=- instance=- unique
    - name (Label) parent=MarginContainer/VBoxContainer/鏄熸洔 鍥炬爣&Title/VBoxContainer script=- instance=- unique
    - classification (Label) parent=MarginContainer/VBoxContainer/鏄熸洔 鍥炬爣&Title/VBoxContainer script=- instance=- unique
    - Button (Button) parent=MarginContainer/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- unique
    - 鏄熸洔绛夌骇 (VBoxContainer) parent=MarginContainer script=- instance=- unique

- scene/Autoload/StarInfoPopup.tscn
  - root: StarInfoPopup (PanelContainer)
  - key_nodes:
    - StarInfoPopup (PanelContainer) parent= script=res://scripts/autoload/star_info_popup.gd instance=- -
    - 鏄熻€€ (Label) parent=MarginContainer/VBoxContainer/HBoxContainer script=- instance=- unique
    - 绛夌骇 (Label) parent=MarginContainer/VBoxContainer/HBoxContainer script=- instance=- unique
    - 鏄熺郴 (Label) parent=MarginContainer/VBoxContainer/HBoxContainer2 script=- instance=- unique
    - 闃撮槼 (Label) parent=MarginContainer/VBoxContainer/HBoxContainer2 script=- instance=- unique
    - 浜旇 (Label) parent=MarginContainer/VBoxContainer/HBoxContainer2 script=- instance=- unique
    - 鏁堟灉 (Label) parent=MarginContainer/VBoxContainer script=- instance=- unique
    - 鎻忚堪 (Label) parent=MarginContainer/VBoxContainer script=- instance=- unique

- scene/Component/graggable_component.tscn
  - root: GraggableComponent (Container)

- scene/GamePage.tscn
  - root: Node2D (Node2D)
  - packed_scenes:
    - res://scene/鏄熺洏绯荤粺/鏄熺洏.tscn
  - key_nodes:
    - CenterContainer (CenterContainer) parent=Board/PanelContainer script=- instance=res://scene/鏄熺洏绯荤粺/鏄熺洏.tscn -
  - connections:
    - Board/Button -> Board/PanelContainer/CenterContainer/鍛界洏 : pressed -> _on_button_pressed

- scene/main_scene.tscn
  - root: MainScene (Node2D)
  - packed_scenes:
    - res://scene/鏄熺洏绯荤粺/鏄熺洏MainPage.tscn
    - res://scene/version0.1/GPVersion1.tscn
  - key_nodes:
    - Menu (MarginContainer) parent=CanvasLayer script=res://scripts/main_menu.gd instance=- -
    - New_Game (Button) parent=CanvasLayer/Menu/VBoxContainer/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - Button4 (Button) parent=CanvasLayer/Menu/VBoxContainer/VBoxContainer script=- instance=res://scene/鏄熺洏绯荤粺/鏄熺洏MainPage.tscn -

- scene/Plant.tscn
  - root: plantnode (PanelContainer)
  - key_nodes:
    - plantnode (PanelContainer) parent= script=res://scripts/plant_node.gd instance=- -

- scene/scene_transition/circle_transition.tscn
  - root: Circle Transition (CanvasLayer)

- scene/scene_transition/fade_transition.tscn
  - root: Fade Transition (CanvasLayer)
  - key_nodes:
    - Fade Transition (CanvasLayer) parent= script=res://scripts/utilities/transition.gd instance=- -

- scene/star_choice_panel.tscn
  - root: 閫夋嫨interface (Panel)
  - packed_scenes:
    - res://scene/Autoload/StarInfo.tscn
  - key_nodes:
    - 閫夋嫨interface (Panel) parent= script=res://scripts/star_choice_panel.gd instance=- -
    - StarInfoHolder (HBoxContainer) parent=CenterContainer/VBoxContainer script=- instance=res://scene/Autoload/StarInfo.tscn unique

- scene/starInfo/BLUE_cardback.tscn
  - root: starinfo (PanelContainer)
  - key_nodes:
    - starinfo (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -

- scene/starInfo/GOLD_cardback.tscn
  - root: starinfo (PanelContainer)
  - key_nodes:
    - starinfo (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -

- scene/starInfo/level_Ui.tscn
  - root: TextureRect (TextureRect)

- scene/starInfo/PURPLE_cardback.tscn
  - root: starinfo (PanelContainer)
  - key_nodes:
    - starinfo (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -

- scene/starInfo/RED_cardback.tscn
  - root: starinfo (PanelContainer)
  - key_nodes:
    - starinfo (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -

- scene/starInfo/红鸾星.tscn
  - root: MarginContainer (MarginContainer)

- scene/starInfo/火星.tscn
  - root: 鐏槦 (PanelContainer)
  - key_nodes:
    - 鐏槦 (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -

- scene/starInfo/太阳星.tscn
  - root: 澶槼 (PanelContainer)
  - key_nodes:
    - 澶槼 (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -

- scene/starInfo/太阴星.tscn
  - root: 绾㈣壊 (PanelContainer)
  - key_nodes:
    - 绾㈣壊 (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -

- scene/starInfo/紫薇星.tscn
  - root: 绱枃 (PanelContainer)
  - key_nodes:
    - 绱枃 (PanelContainer) parent= script=res://scripts/DataClass/starInfo.gd instance=- -
    - Button (Button) parent=MarginContainer/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- unique

- scene/starInfo/左辅星.tscn
  - root: MarginContainer (MarginContainer)

- scene/starText/StarTextNode.tscn
  - root: StarText (Container)
  - key_nodes:
    - StarText (Container) parent= script=res://scripts/star/star_text_node.gd instance=- -
    - Sprite2D (TextureRect) parent=. script=- instance=- unique
  - connections:
    - . -> . : mouse_entered -> _on_mouse_entered
    - . -> . : mouse_exited -> _on_mouse_exited

- scene/TEST.tscn
  - root: Node2D (Node2D)
  - packed_scenes:
    - res://scene/閾滈挶.tscn
    - res://scene/閾滈挶body.tscn
    - res://scene/starText/StarTextNode.tscn
  - key_nodes:
    - Node2D (Node2D) parent= script=- instance=res://scene/閾滈挶body.tscn -
    - GameButton (Button) parent=VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - GameButton2 (Button) parent=VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=res://scene/starText/StarTextNode.tscn -
  - connections:
    - VBoxContainer/GameButton -> StarText : pressed -> count_score_dynamic_effect

- scene/UI/计分板单计分.tscn
  - root: VBoxContainer (VBoxContainer)
  - key_nodes:
    - Round number (Label) parent=VBoxContainer script=- instance=- unique
    - current_score_label (RichTextLabel) parent=VBoxContainer/HBoxContainer script=- instance=- unique
    - target_score_label (Label) parent=VBoxContainer/HBoxContainer script=- instance=- unique

- scene/version0.1/GPVersion1.tscn
  - root: Node2D (Node2D)
  - packed_scenes:
    - res://scene/星盘系统/星盘.tscn
    - res://scene/图鉴/GuideBook.tscn
    - res://scene/信息栏.tscn
    - res://scene/star_choice_panel.tscn
    - res://scene/铜钱body.tscn
  - key_nodes:
    - debug (CanvasLayer) parent=. script=res://scripts/debug/debug.gd instance=- -
    - unfold (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - fold (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - pick (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - Guide (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - shop (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - Boss (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - add_random_star (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - next_round (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - bag unfold (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - bag fold2 (Button) parent=debug/VBoxContainer script=res://scripts/DataClass/GameButton.gd instance=- -
    - 星曜效果&计分 (Node) parent=. script=res://scripts/gameplay/score_controller.gd instance=- -
    - 各组件动效管理脚本 (Node) parent=. script=res://scripts/UI/ui_manager.gd instance=- -
    - 游戏运行逻辑 (Node) parent=. script=res://scripts/gameplay/game_controller.gd instance=- -
    - Interactable Object (CanvasLayer) parent=. script=- instance=res://scene/铜钱body.tscn -
    - chessboard (PanelContainer) parent=Board script=- instance=- unique
    - CenterContainer (CenterContainer) parent=Board/chessboard/MarginContainer script=- instance=res://scene/星盘系统/星盘.tscn unique
    - GameButton (Button) parent=Board/chessboard script=res://scripts/DataClass/GameButton.gd instance=res://scene/图鉴/GuideBook.tscn unique
    - StarBag (GridContainer) parent=Board/Panel/Label script=- instance=res://scene/信息栏.tscn -
    - 确认提交 (Button) parent=UI script=- instance=res://scene/star_choice_panel.tscn unique
    - AudioStreamPlayer (AudioStreamPlayer) parent=. script=res://scripts/GameBG_audio_player.gd instance=- -
  - connections:
    - debug/VBoxContainer/add_random_star -> 游戏运行逻辑 : pressed -> _on_add_random_star_pressed
    - debug/VBoxContainer/next_round -> 星曜效果&计分 : pressed -> debug_advance_round
    - debug/VBoxContainer/bag unfold -> 各组件动效管理脚本 : pressed -> bag_unfold_movement
    - debug/VBoxContainer/bag fold2 -> 各组件动效管理脚本 : pressed -> bag_fold_movement

- scene/version0.1/PalaceV01.tscn
  - root: Palace (PanelContainer)
  - packed_scenes:
    - res://scene/鏄熺洏绯荤粺/StarLabelNode.tscn
  - key_nodes:
    - Label (Label) parent=StarContainer script=- instance=res://scene/鏄熺洏绯荤粺/StarLabelNode.tscn -
    - PalaceData (Node) parent=. script=res://scripts/DataClass/PalaceData.gd instance=- -

- scene/计分UI模块.tscn
  - root: VBoxContainer (VBoxContainer)
  - key_nodes:
    - VBoxContainer (VBoxContainer) parent= script=res://scripts/UI/璁″垎ui妯″潡.gd instance=- -

- scene/立绘test.tscn
  - root: TextureRect (TextureRect)
  - key_nodes:
    - TextureRect (TextureRect) parent= script=res://texture_rect.gd instance=- -
  - connections:
    - . -> . : mouse_entered -> _on_mouse_entered
    - . -> . : mouse_exited -> _on_mouse_exited
    - Button -> . : pressed -> test_transitiontype

- scene/立绘test反色.tscn
  - root: TextureRect (TextureRect)
  - key_nodes:
    - TextureRect (TextureRect) parent= script=res://texture_rect.gd instance=- -
  - connections:
    - . -> . : mouse_entered -> _on_mouse_entered
    - . -> . : mouse_exited -> _on_mouse_exited
    - Button -> . : pressed -> test_transitiontype

- scene/铜钱.tscn
  - root: 閾滈挶 (Sprite2D)
  - key_nodes:
    - 閾滈挶 (Sprite2D) parent= script=res://scripts/Interactive Object/閾滈挶.gd instance=- -

- scene/铜钱body.tscn
  - root: 閾滈挶 (CharacterBody2D)
  - key_nodes:
    - 閾滈挶 (CharacterBody2D) parent= script=res://scripts/Interactive Object/閾滈挶rigidbody.gd instance=- -

- scene/图鉴/GuideBook.tscn
  - root: 璇鹃interface (TextureRect)

- scene/图鉴/star.tscn
  - root: Star (TextureRect)

- scene/图鉴/star_sets.tscn
  - root: star sets (HBoxContainer)
  - packed_scenes:
    - res://scene/鍥鹃壌/star.tscn
  - key_nodes:
    - star sets (HBoxContainer) parent= script=res://scripts/鍥鹃壌/star_sets.gd instance=res://scene/鍥鹃壌/star.tscn -

- scene/图鉴/课题.tscn
  - root: Panel (Control)
  - packed_scenes:
    - res://scene/鍥鹃壌/star_sets.tscn
  - key_nodes:
    - menu (VBoxContainer) parent=PanelContainer/Contents script=res://scripts/UI/plants_status_UI.gd instance=- -
    - Label (Label) parent=PanelContainer/Contents/menu/璇鹃 script=- instance=res://scene/鍥鹃壌/star_sets.tscn -
    - Label (Label) parent=PanelContainer/Contents/menu/璇鹃2 script=- instance=res://scene/鍥鹃壌/star_sets.tscn -
    - Label (Label) parent=PanelContainer/Contents/menu/鍗曟潯3 script=- instance=res://scene/鍥鹃壌/star_sets.tscn -

- scene/信息栏.tscn
  - root: 主要信息&计分UI (PanelContainer)
  - key_nodes:
    - 主要信息&计分UI (PanelContainer) parent= script=res://scripts/UI/game_info_panel.gd instance=- -

- scene/星盘系统/Empty Palace.tscn
  - root: Container (Container)

- scene/星盘系统/StarLabelNode.tscn
  - root: StarNode (PanelContainer)
  - key_nodes:
    - StarNode (PanelContainer) parent= script=res://scripts/star_node.gd instance=- -
  - connections:
    - . -> . : mouse_entered -> _on_mouse_entered
    - . -> . : mouse_exited -> _on_mouse_exited

- scene/星盘系统/宫位.tscn
  - root: Palace (PanelContainer)
  - packed_scenes:
    - res://scene/starText/StarTextNode.tscn
    - res://scene/璁″垎UI妯″潡.tscn
  - key_nodes:
    - StarContainer (GridContainer) parent=MarginContainer script=- instance=res://scene/starText/StarTextNode.tscn unique
    - PalaceData (Node) parent=. script=res://scripts/DataClass/PalaceData.gd instance=- -
    - CenterContainer (CenterContainer) parent=. script=- instance=res://scene/璁″垎UI妯″潡.tscn -

- scene/星盘系统/星盘.tscn
  - root: 鍛界洏 (GridContainer)
  - packed_scenes:
    - res://scene/鏄熺洏绯荤粺/瀹綅.tscn
    - res://scene/鏄熺洏绯荤粺/Empty Palace.tscn
  - key_nodes:
    - 鍛界洏 (GridContainer) parent= script=res://scripts/world/star_board.gd instance=res://scene/鏄熺洏绯荤粺/瀹綅.tscn -

- scene/星盘系统/星盘MainPage.tscn
  - root: 鍛界洏 (GridContainer)
  - packed_scenes:
    - res://scene/鏄熺洏绯荤粺/瀹綅.tscn
    - res://scene/鏄熺洏绯荤粺/Empty Palace.tscn
  - key_nodes:
    - 鍛界洏 (GridContainer) parent= script=res://scripts/world/star_board.gd instance=res://scene/鏄熺洏绯荤粺/瀹綅.tscn -

## Scripts

- scripts/autoload/drag_manager.gd
  - class_name: Global_Drag_Manager
  - extends: Node2D
  - ROLE: Global drag controller for star drag-and-drop.
  - OWNS: star_temp, drag_offset, hovered_palace_index, is_dragging.
  - TALKS_TO: StarIcon.
  - API: is_dragging setter, _process.

- scripts/autoload/star_info_popup.gd
  - class_name: StarInfoPopup
  - extends: PanelContainer
  - ROLE: Lightweight star info popup for hover display.
  - OWNS: none (UI nodes in scene).
  - TALKS_TO: StarData.
  - API: init, set_star_info, show_popup_at, hide_popup.

- scripts/autoload/star_info_popup_texture.gd
  - class_name: StarInfoTextPopup
  - extends: PanelContainer
  - ROLE: Text popup for star info (texture variant).
  - OWNS: none (UI nodes in scene).
  - TALKS_TO: StarData.
  - API: init, set_star_info, show_popup_at, hide_popup.

- scripts/Component/graggable_component.gd
  - class_name: GraggableComponent
  - extends: Container

- scripts/core/star_instance.gd
  - class_name: StarInstance
  - extends: RefCounted
  - ROLE: Runtime star state attached to a StarData.
  - OWNS: data, level, scores, multipliers, palace placement.
  - TALKS_TO: StarData.
  - API: get_base_score, get_total_score.

- scripts/core/star_inventory.gd
  - class_name: StarInventory
  - extends: RefCounted
  - ROLE: Runtime inventory for star instances and upgrades.
  - OWNS: items list and upgrade logic.
  - TALKS_TO: StarInstance, StarData.
  - API: find_by_id, add_new, reset_palace_flags, clear.

- scripts/DataClass/DynamicEffectClass.gd

- scripts/DataClass/GameButton.gd
  - class_name: GameButton
  - extends: Button

- scripts/DataClass/PalaceData.gd
  - class_name: PalaceData
  - extends: Node
  - ROLE: Runtime palace data container.
  - OWNS: palace_id, index, stars_in_palace, notes.
  - TALKS_TO: StarInstance.
  - API: add_star, get_star_count, find_star_by_id.

- scripts/DataClass/PlantData.gd
  - class_name: PlantData
  - extends: Resource

- scripts/DataClass/StarDatabase.gd
  - class_name: StarsDatabase
  - extends: Resource

- scripts/DataClass/starInfo.gd
  - class_name: StarInfo
  - extends: PanelContainer
  - ROLE: Star info card UI for selection panels.
  - OWNS: UI nodes for name, classification, description, level.
  - TALKS_TO: StarData, GameButton.
  - API: init, show_button, hide_button, be_chose.

- scripts/DataClass/starrule.gd
  - class_name: StarRule
  - extends: Resource

- scripts/DataClass/starrule_group.gd
  - class_name: StarRuleGroup
  - extends: Resource

- scripts/DataClass/starrules_total.gd
  - class_name: StarRuleTotal
  - extends: Resource

- scripts/debug/debug.gd
  - extends: CanvasLayer

- scripts/GameBG_audio_player.gd
  - extends: AudioStreamPlayer

- scripts/gameplay/game_controller.gd
  - class_name: GameController
  - extends: Node
  - ROLE: Game controller for round flow, star inventory, distribution, and choice.
  - OWNS: catalog, inventory, exam_level, luck, rarity_distribution, rng.
  - TALKS_TO: UI_Manager, StarChoices, StarPanel, ScoreController, AudioPlayer, StarIcon, RarityPicker, StarBalance, StarInventory, StarDistributor.
  - API: start_round, submit_round, open_star_choice_ui, add_or_upgrade_star, pick_random_star, update_backpack_ui.

- scripts/gameplay/random/rarity_picker.gd
  - class_name: RarityPicker
  - extends: RefCounted
  - ROLE: Rarity selection helper for star picking.
  - OWNS: distribution table, luck.
  - TALKS_TO: none.
  - API: pick_rarity.

- scripts/gameplay/rules/score_calculator.gd
  - class_name: ScoreCalculator
  - extends: RefCounted
  - ROLE: Score calculator for star instances.
  - OWNS: none.
  - TALKS_TO: StarInstance.
  - API: score_star.

- scripts/gameplay/score_controller.gd
  - class_name: ScoreController
  - extends: Node
  - ROLE: Score controller for per-round scoring and progression.
  - OWNS: round_score, total_score, target_score_list, target_score, round_index.
  - TALKS_TO: StarPanel, AudioPlayer, UI score labels, ScoreCalculator, StarBalance.
  - API: count_score, give_coin, debug_advance_round.

- scripts/gameplay/star_distributor.gd
  - class_name: StarDistributor
  - extends: RefCounted
  - ROLE: Place stars from inventory into palaces.
  - OWNS: distribution timing and placement logic.
  - TALKS_TO: StarPanel, PalaceContainer, StarIcon, AudioPlayer.
  - API: clear_palaces, distribute_inventory, place_star_in_palace.

- scripts/Interactive Object/铜钱.gd
  - extends: Sprite2D

- scripts/Interactive Object/铜钱rigidbody.gd
  - class_name: Coin
  - extends: CharacterBody2D

- scripts/main_menu.gd
  - extends: MarginContainer

- scripts/plant_node.gd
  - class_name: PlantNode
  - extends: PanelContainer

- scripts/Resources/score.gd
  - class_name: Score
  - extends: Resource
  - ROLE: Score data for stars and palaces.
  - OWNS: base_score, perm/temp score and multipliers.
  - TALKS_TO: none.
  - API: init_palace.

- scripts/Resources/star.gd
  - class_name: StarData
  - extends: Resource
  - ROLE: Star prototype data (immutable during runtime).
  - OWNS: id, name, rarity, texture_path, description, score.
  - TALKS_TO: Score (resource).
  - API: has_tag.

- scripts/Resources/star_balance.gd
  - class_name: StarBalance
  - extends: Resource
  - ROLE: Balance configuration for rarity and scoring targets.
  - OWNS: rarity_distribution, target_score_list, exam_names, luck.
  - TALKS_TO: GameController, ScoreController.
  - API: none.

- scripts/Resources/starset.gd
  - class_name: StarSet
  - extends: Resource
  - ROLE: Star collection and rarity index.
  - OWNS: starset_total, starset_rarity, starset_temp.
  - TALKS_TO: StarData.
  - API: build_rarity_index.

- scripts/star.gd
  - extends: PanelContainer

- scripts/star/star_text_node.gd
  - class_name: StarIcon
  - extends: Container
  - ROLE: Star icon view with drag, hover, and score effects.
  - OWNS: star_instance, hover tween, popup reference.
  - TALKS_TO: GlobalDragManager, StarInfoPop, PalaceContainer signals, AudioPlayer.
  - API: initial, count_score_dynamic_effect, upgrade_effect.

- scripts/star_choice_panel.gd
  - class_name: StarChoices
  - extends: Panel
  - ROLE: Star choice panel for picking new stars.
  - OWNS: unchosen_starset, lock buttons.
  - TALKS_TO: StarInfo, AudioPlayer, GameController.
  - API: add_unchose_starset, return_chose_star, emit_refresh, close.

- scripts/star_node.gd
  - class_name: StarLabelNode
  - extends: PanelContainer

- scripts/UI/game_info_panel.gd
  - class_name: GameInfoPanel
  - extends: PanelContainer
  - ROLE: Main info panel for exam/round/score display.
  - OWNS: labels for exam, round, total score, submit/modify counts.
  - TALKS_TO: ScoreController, GameController, StarBalance.
  - API: _on_round_changed, _on_score_updated, _on_submit_left_changed, _on_modify_left_changed.

- scripts/UI/ui_manager.gd
  - class_name: UI_Manager
  - extends: Node
  - ROLE: UI panel animation manager for round flow.
  - OWNS: fold states and target positions for panels.
  - TALKS_TO: GameButton, UI panels (chessboard/count/guide/bag).
  - API: PlayRoundStartTween, round_end_dynamic_effect, open_guidebook.

- scripts/UI/计分ui模块.gd
  - extends: VBoxContainer

- scripts/utilities/better_tilemap.gd
  - extends: TileMap

- scripts/utilities/save_area.gd
  - class_name: SaveArea extends Area2D

- scripts/utilities/save_manager.gd
  - extends: Node

- scripts/utilities/scene_transition_manager.gd
  - extends: Node

- scripts/utilities/script_utilities.gd
  - class_name: ScriptUtilities extends Object

- scripts/utilities/transition.gd
  - class_name: Transition extends CanvasLayer

- scripts/world/palace_container.gd
  - class_name: PalaceContainer
  - extends: PanelContainer
  - ROLE: Palace container for stars and hover signaling.
  - OWNS: palace_index, star_container, palette colors.
  - TALKS_TO: GlobalDragManager, StarIcon.
  - API: add_star, clear, get_stars, set_normal_color.

- scripts/world/star_board.gd
  - class_name: StarPanel
  - extends: GridContainer
  - ROLE: Star board panel with palace lookup and highlight effects.
  - OWNS: palace_minimum_size, group membership.
  - TALKS_TO: PalaceContainer, GlobalDragManager, StarIcon.
  - API: find_palace, reset_staricon, hightlight_starpanel, normal_starpanel.

- scripts/图鉴/star_sets.gd
  - extends: HBoxContainer

## Systems / Managers

### AutoLoad

- StarInfoPop: "*res://scene/Autoload/StarInfo.tscn"
- CsvImport: "*res://scene/Autoload/Autoload_CSVImport.gd"
- ShaderGlobals: "*res://scene/Autoload/Shader Globals.gd"
- AudioPlayer: "*res://scene/Autoload/AudioPlayer.tscn"
- GlobalDragManager: "*res://scene/Autoload/drag_manager.tscn"
- SceneTransitionManager: "*res://scene/Autoload/scene_transition_manager.tscn"

## Raw Data (JSON)

```json
{
    "scenes":  [
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/Autoload/AudioPlayer.tscn",
                       "root":  "AudioGlobalPlayer (Node)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/Autoload/drag_manager.tscn",
                       "root":  "DragManager (Node2D)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "DragManager",
                                             "script":  "res://scripts/autoload/drag_manager.gd",
                                             "type":  "Node2D",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/Autoload/scene_transition_manager.tscn",
                       "root":  "SceneTransitionManager (Node)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/Autoload/StarInfo.tscn",
                       "root":  "starinfo (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "starinfo",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "startexture",
                                             "script":  "",
                                             "type":  "TextureRect",
                                             "parent":  "MarginContainer/VBoxContainer/鏄熸洔 鍥炬爣\u0026Title",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "name",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer/鏄熸洔 鍥炬爣\u0026Title/VBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "classification",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer/鏄熸洔 鍥炬爣\u0026Title/VBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "Button",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "MarginContainer/VBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "鏄熸洔绛夌骇",
                                             "script":  "",
                                             "type":  "VBoxContainer",
                                             "parent":  "MarginContainer",
                                             "instance":  "",
                                             "unique":  true
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/Autoload/StarInfoPopup.tscn",
                       "root":  "StarInfoPopup (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "StarInfoPopup",
                                             "script":  "res://scripts/autoload/star_info_popup.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "鏄熻€€",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer/HBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "绛夌骇",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer/HBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "鏄熺郴",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer/HBoxContainer2",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "闃撮槼",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer/HBoxContainer2",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "浜旇",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer/HBoxContainer2",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "鏁堟灉",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "鎻忚堪",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "MarginContainer/VBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/Component/graggable_component.tscn",
                       "root":  "GraggableComponent (Container)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/鏄熺洏绯荤粺/鏄熺洏.tscn"
                                         ],
                       "path":  "scene/GamePage.tscn",
                       "root":  "Node2D (Node2D)",
                       "connections":  [
                                           {
                                               "from":  "Board/Button",
                                               "to":  "Board/PanelContainer/CenterContainer/鍛界洏",
                                               "method":  "_on_button_pressed",
                                               "signal":  "pressed"
                                           }
                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "CenterContainer",
                                             "script":  "",
                                             "type":  "CenterContainer",
                                             "parent":  "Board/PanelContainer",
                                             "instance":  "res://scene/鏄熺洏绯荤粺/鏄熺洏.tscn",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/鏄熺洏绯荤粺/鏄熺洏MainPage.tscn",
                                             "res://scene/version0.1/GPVersion1.tscn"
                                         ],
                       "path":  "scene/main_scene.tscn",
                       "root":  "MainScene (Node2D)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "Menu",
                                             "script":  "res://scripts/main_menu.gd",
                                             "type":  "MarginContainer",
                                             "parent":  "CanvasLayer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "New_Game",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "CanvasLayer/Menu/VBoxContainer/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Button4",
                                             "script":  "",
                                             "type":  "Button",
                                             "parent":  "CanvasLayer/Menu/VBoxContainer/VBoxContainer",
                                             "instance":  "res://scene/鏄熺洏绯荤粺/鏄熺洏MainPage.tscn",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/Plant.tscn",
                       "root":  "plantnode (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "plantnode",
                                             "script":  "res://scripts/plant_node.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/scene_transition/circle_transition.tscn",
                       "root":  "Circle Transition (CanvasLayer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/scene_transition/fade_transition.tscn",
                       "root":  "Fade Transition (CanvasLayer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "Fade Transition",
                                             "script":  "res://scripts/utilities/transition.gd",
                                             "type":  "CanvasLayer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/Autoload/StarInfo.tscn"
                                         ],
                       "path":  "scene/star_choice_panel.tscn",
                       "root":  "閫夋嫨interface (Panel)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "閫夋嫨interface",
                                             "script":  "res://scripts/star_choice_panel.gd",
                                             "type":  "Panel",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "StarInfoHolder",
                                             "script":  "",
                                             "type":  "HBoxContainer",
                                             "parent":  "CenterContainer/VBoxContainer",
                                             "instance":  "res://scene/Autoload/StarInfo.tscn",
                                             "unique":  true
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/BLUE_cardback.tscn",
                       "root":  "starinfo (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "starinfo",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/GOLD_cardback.tscn",
                       "root":  "starinfo (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "starinfo",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/level_Ui.tscn",
                       "root":  "TextureRect (TextureRect)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/PURPLE_cardback.tscn",
                       "root":  "starinfo (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "starinfo",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/RED_cardback.tscn",
                       "root":  "starinfo (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "starinfo",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/红鸾星.tscn",
                       "root":  "MarginContainer (MarginContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/火星.tscn",
                       "root":  "鐏槦 (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "鐏槦",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/太阳星.tscn",
                       "root":  "澶槼 (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "澶槼",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/太阴星.tscn",
                       "root":  "绾㈣壊 (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "绾㈣壊",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/紫薇星.tscn",
                       "root":  "绱枃 (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "绱枃",
                                             "script":  "res://scripts/DataClass/starInfo.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Button",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "MarginContainer/VBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starInfo/左辅星.tscn",
                       "root":  "MarginContainer (MarginContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/starText/StarTextNode.tscn",
                       "root":  "StarText (Container)",
                       "connections":  [
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_entered",
                                               "signal":  "mouse_entered"
                                           },
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_exited",
                                               "signal":  "mouse_exited"
                                           }
                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "StarText",
                                             "script":  "res://scripts/star/star_text_node.gd",
                                             "type":  "Container",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Sprite2D",
                                             "script":  "",
                                             "type":  "TextureRect",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  true
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/閾滈挶.tscn",
                                             "res://scene/閾滈挶body.tscn",
                                             "res://scene/starText/StarTextNode.tscn"
                                         ],
                       "path":  "scene/TEST.tscn",
                       "root":  "Node2D (Node2D)",
                       "connections":  [
                                           {
                                               "from":  "VBoxContainer/GameButton",
                                               "to":  "StarText",
                                               "method":  "count_score_dynamic_effect",
                                               "signal":  "pressed"
                                           }
                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "Node2D",
                                             "script":  "",
                                             "type":  "Node2D",
                                             "parent":  "",
                                             "instance":  "res://scene/閾滈挶body.tscn",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "GameButton",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "GameButton2",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "VBoxContainer",
                                             "instance":  "res://scene/starText/StarTextNode.tscn",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/UI/计分板单计分.tscn",
                       "root":  "VBoxContainer (VBoxContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "Round number",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "VBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "current_score_label",
                                             "script":  "",
                                             "type":  "RichTextLabel",
                                             "parent":  "VBoxContainer/HBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "target_score_label",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "VBoxContainer/HBoxContainer",
                                             "instance":  "",
                                             "unique":  true
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/星盘系统/星盘.tscn",
                                             "res://scene/图鉴/GuideBook.tscn",
                                             "res://scene/信息栏.tscn",
                                             "res://scene/star_choice_panel.tscn",
                                             "res://scene/铜钱body.tscn"
                                         ],
                       "path":  "scene/version0.1/GPVersion1.tscn",
                       "root":  "Node2D (Node2D)",
                       "connections":  [
                                           {
                                               "from":  "debug/VBoxContainer/add_random_star",
                                               "to":  "游戏运行逻辑",
                                               "method":  "_on_add_random_star_pressed",
                                               "signal":  "pressed"
                                           },
                                           {
                                               "from":  "debug/VBoxContainer/next_round",
                                               "to":  "星曜效果\u0026计分",
                                               "method":  "debug_advance_round",
                                               "signal":  "pressed"
                                           },
                                           {
                                               "from":  "debug/VBoxContainer/bag unfold",
                                               "to":  "各组件动效管理脚本",
                                               "method":  "bag_unfold_movement",
                                               "signal":  "pressed"
                                           },
                                           {
                                               "from":  "debug/VBoxContainer/bag fold2",
                                               "to":  "各组件动效管理脚本",
                                               "method":  "bag_fold_movement",
                                               "signal":  "pressed"
                                           }
                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "debug",
                                             "script":  "res://scripts/debug/debug.gd",
                                             "type":  "CanvasLayer",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "unfold",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "fold",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "pick",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Guide",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "shop",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Boss",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "add_random_star",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "next_round",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "bag unfold",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "bag fold2",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "debug/VBoxContainer",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "星曜效果\u0026计分",
                                             "script":  "res://scripts/gameplay/score_controller.gd",
                                             "type":  "Node",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "各组件动效管理脚本",
                                             "script":  "res://scripts/UI/ui_manager.gd",
                                             "type":  "Node",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "游戏运行逻辑",
                                             "script":  "res://scripts/gameplay/game_controller.gd",
                                             "type":  "Node",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Interactable Object",
                                             "script":  "",
                                             "type":  "CanvasLayer",
                                             "parent":  ".",
                                             "instance":  "res://scene/铜钱body.tscn",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "chessboard",
                                             "script":  "",
                                             "type":  "PanelContainer",
                                             "parent":  "Board",
                                             "instance":  "",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "CenterContainer",
                                             "script":  "",
                                             "type":  "CenterContainer",
                                             "parent":  "Board/chessboard/MarginContainer",
                                             "instance":  "res://scene/星盘系统/星盘.tscn",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "GameButton",
                                             "script":  "res://scripts/DataClass/GameButton.gd",
                                             "type":  "Button",
                                             "parent":  "Board/chessboard",
                                             "instance":  "res://scene/图鉴/GuideBook.tscn",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "StarBag",
                                             "script":  "",
                                             "type":  "GridContainer",
                                             "parent":  "Board/Panel/Label",
                                             "instance":  "res://scene/信息栏.tscn",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "确认提交",
                                             "script":  "",
                                             "type":  "Button",
                                             "parent":  "UI",
                                             "instance":  "res://scene/star_choice_panel.tscn",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "AudioStreamPlayer",
                                             "script":  "res://scripts/GameBG_audio_player.gd",
                                             "type":  "AudioStreamPlayer",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/鏄熺洏绯荤粺/StarLabelNode.tscn"
                                         ],
                       "path":  "scene/version0.1/PalaceV01.tscn",
                       "root":  "Palace (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "Label",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "StarContainer",
                                             "instance":  "res://scene/鏄熺洏绯荤粺/StarLabelNode.tscn",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "PalaceData",
                                             "script":  "res://scripts/DataClass/PalaceData.gd",
                                             "type":  "Node",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/计分UI模块.tscn",
                       "root":  "VBoxContainer (VBoxContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "VBoxContainer",
                                             "script":  "res://scripts/UI/璁″垎ui妯″潡.gd",
                                             "type":  "VBoxContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/立绘test.tscn",
                       "root":  "TextureRect (TextureRect)",
                       "connections":  [
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_entered",
                                               "signal":  "mouse_entered"
                                           },
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_exited",
                                               "signal":  "mouse_exited"
                                           },
                                           {
                                               "from":  "Button",
                                               "to":  ".",
                                               "method":  "test_transitiontype",
                                               "signal":  "pressed"
                                           }
                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "TextureRect",
                                             "script":  "res://texture_rect.gd",
                                             "type":  "TextureRect",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/立绘test反色.tscn",
                       "root":  "TextureRect (TextureRect)",
                       "connections":  [
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_entered",
                                               "signal":  "mouse_entered"
                                           },
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_exited",
                                               "signal":  "mouse_exited"
                                           },
                                           {
                                               "from":  "Button",
                                               "to":  ".",
                                               "method":  "test_transitiontype",
                                               "signal":  "pressed"
                                           }
                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "TextureRect",
                                             "script":  "res://texture_rect.gd",
                                             "type":  "TextureRect",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/铜钱.tscn",
                       "root":  "閾滈挶 (Sprite2D)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "閾滈挶",
                                             "script":  "res://scripts/Interactive Object/閾滈挶.gd",
                                             "type":  "Sprite2D",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/铜钱body.tscn",
                       "root":  "閾滈挶 (CharacterBody2D)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "閾滈挶",
                                             "script":  "res://scripts/Interactive Object/閾滈挶rigidbody.gd",
                                             "type":  "CharacterBody2D",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/图鉴/GuideBook.tscn",
                       "root":  "璇鹃interface (TextureRect)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/图鉴/star.tscn",
                       "root":  "Star (TextureRect)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/鍥鹃壌/star.tscn"
                                         ],
                       "path":  "scene/图鉴/star_sets.tscn",
                       "root":  "star sets (HBoxContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "star sets",
                                             "script":  "res://scripts/鍥鹃壌/star_sets.gd",
                                             "type":  "HBoxContainer",
                                             "parent":  "",
                                             "instance":  "res://scene/鍥鹃壌/star.tscn",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/鍥鹃壌/star_sets.tscn"
                                         ],
                       "path":  "scene/图鉴/课题.tscn",
                       "root":  "Panel (Control)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "menu",
                                             "script":  "res://scripts/UI/plants_status_UI.gd",
                                             "type":  "VBoxContainer",
                                             "parent":  "PanelContainer/Contents",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Label",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "PanelContainer/Contents/menu/璇鹃",
                                             "instance":  "res://scene/鍥鹃壌/star_sets.tscn",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Label",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "PanelContainer/Contents/menu/璇鹃2",
                                             "instance":  "res://scene/鍥鹃壌/star_sets.tscn",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "Label",
                                             "script":  "",
                                             "type":  "Label",
                                             "parent":  "PanelContainer/Contents/menu/鍗曟潯3",
                                             "instance":  "res://scene/鍥鹃壌/star_sets.tscn",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/信息栏.tscn",
                       "root":  "主要信息\u0026计分UI (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "主要信息\u0026计分UI",
                                             "script":  "res://scripts/UI/game_info_panel.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/星盘系统/Empty Palace.tscn",
                       "root":  "Container (Container)",
                       "connections":  [

                                       ],
                       "key_nodes":  [

                                     ]
                   },
                   {
                       "packed_scenes":  [

                                         ],
                       "path":  "scene/星盘系统/StarLabelNode.tscn",
                       "root":  "StarNode (PanelContainer)",
                       "connections":  [
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_entered",
                                               "signal":  "mouse_entered"
                                           },
                                           {
                                               "from":  ".",
                                               "to":  ".",
                                               "method":  "_on_mouse_exited",
                                               "signal":  "mouse_exited"
                                           }
                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "StarNode",
                                             "script":  "res://scripts/star_node.gd",
                                             "type":  "PanelContainer",
                                             "parent":  "",
                                             "instance":  "",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/starText/StarTextNode.tscn",
                                             "res://scene/璁″垎UI妯″潡.tscn"
                                         ],
                       "path":  "scene/星盘系统/宫位.tscn",
                       "root":  "Palace (PanelContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "StarContainer",
                                             "script":  "",
                                             "type":  "GridContainer",
                                             "parent":  "MarginContainer",
                                             "instance":  "res://scene/starText/StarTextNode.tscn",
                                             "unique":  true
                                         },
                                         {
                                             "name":  "PalaceData",
                                             "script":  "res://scripts/DataClass/PalaceData.gd",
                                             "type":  "Node",
                                             "parent":  ".",
                                             "instance":  "",
                                             "unique":  false
                                         },
                                         {
                                             "name":  "CenterContainer",
                                             "script":  "",
                                             "type":  "CenterContainer",
                                             "parent":  ".",
                                             "instance":  "res://scene/璁″垎UI妯″潡.tscn",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/鏄熺洏绯荤粺/瀹綅.tscn",
                                             "res://scene/鏄熺洏绯荤粺/Empty Palace.tscn"
                                         ],
                       "path":  "scene/星盘系统/星盘.tscn",
                       "root":  "鍛界洏 (GridContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "鍛界洏",
                                             "script":  "res://scripts/world/star_board.gd",
                                             "type":  "GridContainer",
                                             "parent":  "",
                                             "instance":  "res://scene/鏄熺洏绯荤粺/瀹綅.tscn",
                                             "unique":  false
                                         }
                                     ]
                   },
                   {
                       "packed_scenes":  [
                                             "res://scene/鏄熺洏绯荤粺/瀹綅.tscn",
                                             "res://scene/鏄熺洏绯荤粺/Empty Palace.tscn"
                                         ],
                       "path":  "scene/星盘系统/星盘MainPage.tscn",
                       "root":  "鍛界洏 (GridContainer)",
                       "connections":  [

                                       ],
                       "key_nodes":  [
                                         {
                                             "name":  "鍛界洏",
                                             "script":  "res://scripts/world/star_board.gd",
                                             "type":  "GridContainer",
                                             "parent":  "",
                                             "instance":  "res://scene/鏄熺洏绯荤粺/瀹綅.tscn",
                                             "unique":  false
                                         }
                                     ]
                   }
               ],
    "autoloads":  {
                      "StarInfoPop":  "\"*res://scene/Autoload/StarInfo.tscn\"",
                      "CsvImport":  "\"*res://scene/Autoload/Autoload_CSVImport.gd\"",
                      "ShaderGlobals":  "\"*res://scene/Autoload/Shader Globals.gd\"",
                      "AudioPlayer":  "\"*res://scene/Autoload/AudioPlayer.tscn\"",
                      "GlobalDragManager":  "\"*res://scene/Autoload/drag_manager.tscn\"",
                      "SceneTransitionManager":  "\"*res://scene/Autoload/scene_transition_manager.tscn\""
                  },
    "scripts":  [
                    {
                        "talks_to":  "StarIcon.",
                        "owns":  "star_temp, drag_offset, hovered_palace_index, is_dragging.",
                        "class_name":  "Global_Drag_Manager",
                        "path":  "scripts/autoload/drag_manager.gd",
                        "extends":  "Node2D",
                        "role":  "Global drag controller for star drag-and-drop.",
                        "api":  "is_dragging setter, _process."
                    },
                    {
                        "talks_to":  "StarData.",
                        "owns":  "none (UI nodes in scene).",
                        "class_name":  "StarInfoPopup",
                        "path":  "scripts/autoload/star_info_popup.gd",
                        "extends":  "PanelContainer",
                        "role":  "Lightweight star info popup for hover display.",
                        "api":  "init, set_star_info, show_popup_at, hide_popup."
                    },
                    {
                        "talks_to":  "StarData.",
                        "owns":  "none (UI nodes in scene).",
                        "class_name":  "StarInfoTextPopup",
                        "path":  "scripts/autoload/star_info_popup_texture.gd",
                        "extends":  "PanelContainer",
                        "role":  "Text popup for star info (texture variant).",
                        "api":  "init, set_star_info, show_popup_at, hide_popup."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "GraggableComponent",
                        "path":  "scripts/Component/graggable_component.gd",
                        "extends":  "Container",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "StarData.",
                        "owns":  "data, level, scores, multipliers, palace placement.",
                        "class_name":  "StarInstance",
                        "path":  "scripts/core/star_instance.gd",
                        "extends":  "RefCounted",
                        "role":  "Runtime star state attached to a StarData.",
                        "api":  "get_base_score, get_total_score."
                    },
                    {
                        "talks_to":  "StarInstance, StarData.",
                        "owns":  "items list and upgrade logic.",
                        "class_name":  "StarInventory",
                        "path":  "scripts/core/star_inventory.gd",
                        "extends":  "RefCounted",
                        "role":  "Runtime inventory for star instances and upgrades.",
                        "api":  "find_by_id, add_new, reset_palace_flags, clear."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/DataClass/DynamicEffectClass.gd",
                        "extends":  "",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "GameButton",
                        "path":  "scripts/DataClass/GameButton.gd",
                        "extends":  "Button",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "StarInstance.",
                        "owns":  "palace_id, index, stars_in_palace, notes.",
                        "class_name":  "PalaceData",
                        "path":  "scripts/DataClass/PalaceData.gd",
                        "extends":  "Node",
                        "role":  "Runtime palace data container.",
                        "api":  "add_star, get_star_count, find_star_by_id."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "PlantData",
                        "path":  "scripts/DataClass/PlantData.gd",
                        "extends":  "Resource",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "StarsDatabase",
                        "path":  "scripts/DataClass/StarDatabase.gd",
                        "extends":  "Resource",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "StarData, GameButton.",
                        "owns":  "UI nodes for name, classification, description, level.",
                        "class_name":  "StarInfo",
                        "path":  "scripts/DataClass/starInfo.gd",
                        "extends":  "PanelContainer",
                        "role":  "Star info card UI for selection panels.",
                        "api":  "init, show_button, hide_button, be_chose."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "StarRule",
                        "path":  "scripts/DataClass/starrule.gd",
                        "extends":  "Resource",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "StarRuleGroup",
                        "path":  "scripts/DataClass/starrule_group.gd",
                        "extends":  "Resource",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "StarRuleTotal",
                        "path":  "scripts/DataClass/starrules_total.gd",
                        "extends":  "Resource",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/debug/debug.gd",
                        "extends":  "CanvasLayer",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/GameBG_audio_player.gd",
                        "extends":  "AudioStreamPlayer",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "UI_Manager, StarChoices, StarPanel, ScoreController, AudioPlayer, StarIcon, RarityPicker, StarBalance, StarInventory, StarDistributor.",
                        "owns":  "catalog, inventory, exam_level, luck, rarity_distribution, rng.",
                        "class_name":  "GameController",
                        "path":  "scripts/gameplay/game_controller.gd",
                        "extends":  "Node",
                        "role":  "Game controller for round flow, star inventory, distribution, and choice.",
                        "api":  "start_round, submit_round, open_star_choice_ui, add_or_upgrade_star, pick_random_star, update_backpack_ui."
                    },
                    {
                        "talks_to":  "none.",
                        "owns":  "distribution table, luck.",
                        "class_name":  "RarityPicker",
                        "path":  "scripts/gameplay/random/rarity_picker.gd",
                        "extends":  "RefCounted",
                        "role":  "Rarity selection helper for star picking.",
                        "api":  "pick_rarity."
                    },
                    {
                        "talks_to":  "StarInstance.",
                        "owns":  "none.",
                        "class_name":  "ScoreCalculator",
                        "path":  "scripts/gameplay/rules/score_calculator.gd",
                        "extends":  "RefCounted",
                        "role":  "Score calculator for star instances.",
                        "api":  "score_star."
                    },
                    {
                        "talks_to":  "StarPanel, AudioPlayer, UI score labels, ScoreCalculator, StarBalance.",
                        "owns":  "round_score, total_score, target_score_list, target_score, round_index.",
                        "class_name":  "ScoreController",
                        "path":  "scripts/gameplay/score_controller.gd",
                        "extends":  "Node",
                        "role":  "Score controller for per-round scoring and progression.",
                        "api":  "count_score, give_coin, debug_advance_round."
                    },
                    {
                        "talks_to":  "StarPanel, PalaceContainer, StarIcon, AudioPlayer.",
                        "owns":  "distribution timing and placement logic.",
                        "class_name":  "StarDistributor",
                        "path":  "scripts/gameplay/star_distributor.gd",
                        "extends":  "RefCounted",
                        "role":  "Place stars from inventory into palaces.",
                        "api":  "clear_palaces, distribute_inventory, place_star_in_palace."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/Interactive Object/铜钱.gd",
                        "extends":  "Sprite2D",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "Coin",
                        "path":  "scripts/Interactive Object/铜钱rigidbody.gd",
                        "extends":  "CharacterBody2D",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/main_menu.gd",
                        "extends":  "MarginContainer",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "PlantNode",
                        "path":  "scripts/plant_node.gd",
                        "extends":  "PanelContainer",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "none.",
                        "owns":  "base_score, perm/temp score and multipliers.",
                        "class_name":  "Score",
                        "path":  "scripts/Resources/score.gd",
                        "extends":  "Resource",
                        "role":  "Score data for stars and palaces.",
                        "api":  "init_palace."
                    },
                    {
                        "talks_to":  "Score (resource).",
                        "owns":  "id, name, rarity, texture_path, description, score.",
                        "class_name":  "StarData",
                        "path":  "scripts/Resources/star.gd",
                        "extends":  "Resource",
                        "role":  "Star prototype data (immutable during runtime).",
                        "api":  "has_tag."
                    },
                    {
                        "talks_to":  "GameController, ScoreController.",
                        "owns":  "rarity_distribution, target_score_list, exam_names, luck.",
                        "class_name":  "StarBalance",
                        "path":  "scripts/Resources/star_balance.gd",
                        "extends":  "Resource",
                        "role":  "Balance configuration for rarity and scoring targets.",
                        "api":  "none."
                    },
                    {
                        "talks_to":  "StarData.",
                        "owns":  "starset_total, starset_rarity, starset_temp.",
                        "class_name":  "StarSet",
                        "path":  "scripts/Resources/starset.gd",
                        "extends":  "Resource",
                        "role":  "Star collection and rarity index.",
                        "api":  "build_rarity_index."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/star.gd",
                        "extends":  "PanelContainer",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "GlobalDragManager, StarInfoPop, PalaceContainer signals, AudioPlayer.",
                        "owns":  "star_instance, hover tween, popup reference.",
                        "class_name":  "StarIcon",
                        "path":  "scripts/star/star_text_node.gd",
                        "extends":  "Container",
                        "role":  "Star icon view with drag, hover, and score effects.",
                        "api":  "initial, count_score_dynamic_effect, upgrade_effect."
                    },
                    {
                        "talks_to":  "StarInfo, AudioPlayer, GameController.",
                        "owns":  "unchosen_starset, lock buttons.",
                        "class_name":  "StarChoices",
                        "path":  "scripts/star_choice_panel.gd",
                        "extends":  "Panel",
                        "role":  "Star choice panel for picking new stars.",
                        "api":  "add_unchose_starset, return_chose_star, emit_refresh, close."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "StarLabelNode",
                        "path":  "scripts/star_node.gd",
                        "extends":  "PanelContainer",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "ScoreController, GameController, StarBalance.",
                        "owns":  "labels for exam, round, total score, submit/modify counts.",
                        "class_name":  "GameInfoPanel",
                        "path":  "scripts/UI/game_info_panel.gd",
                        "extends":  "PanelContainer",
                        "role":  "Main info panel for exam/round/score display.",
                        "api":  "_on_round_changed, _on_score_updated, _on_submit_left_changed, _on_modify_left_changed."
                    },
                    {
                        "talks_to":  "GameButton, UI panels (chessboard/count/guide/bag).",
                        "owns":  "fold states and target positions for panels.",
                        "class_name":  "UI_Manager",
                        "path":  "scripts/UI/ui_manager.gd",
                        "extends":  "Node",
                        "role":  "UI panel animation manager for round flow.",
                        "api":  "PlayRoundStartTween, round_end_dynamic_effect, open_guidebook."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/UI/计分ui模块.gd",
                        "extends":  "VBoxContainer",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/utilities/better_tilemap.gd",
                        "extends":  "TileMap",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "SaveArea extends Area2D",
                        "path":  "scripts/utilities/save_area.gd",
                        "extends":  "",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/utilities/save_manager.gd",
                        "extends":  "Node",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/utilities/scene_transition_manager.gd",
                        "extends":  "Node",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "ScriptUtilities extends Object",
                        "path":  "scripts/utilities/script_utilities.gd",
                        "extends":  "",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "Transition extends CanvasLayer",
                        "path":  "scripts/utilities/transition.gd",
                        "extends":  "",
                        "role":  "",
                        "api":  ""
                    },
                    {
                        "talks_to":  "GlobalDragManager, StarIcon.",
                        "owns":  "palace_index, star_container, palette colors.",
                        "class_name":  "PalaceContainer",
                        "path":  "scripts/world/palace_container.gd",
                        "extends":  "PanelContainer",
                        "role":  "Palace container for stars and hover signaling.",
                        "api":  "add_star, clear, get_stars, set_normal_color."
                    },
                    {
                        "talks_to":  "PalaceContainer, GlobalDragManager, StarIcon.",
                        "owns":  "palace_minimum_size, group membership.",
                        "class_name":  "StarPanel",
                        "path":  "scripts/world/star_board.gd",
                        "extends":  "GridContainer",
                        "role":  "Star board panel with palace lookup and highlight effects.",
                        "api":  "find_palace, reset_staricon, hightlight_starpanel, normal_starpanel."
                    },
                    {
                        "talks_to":  "",
                        "owns":  "",
                        "class_name":  "",
                        "path":  "scripts/图鉴/star_sets.gd",
                        "extends":  "HBoxContainer",
                        "role":  "",
                        "api":  ""
                    }
                ]
}
```

