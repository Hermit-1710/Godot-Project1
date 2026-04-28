# 项目地图

## 项目一句话目标
回合制星曜抽取与摆放玩法，通过宫位分布与计分达成目标分数并进入下一阶段。

## 核心玩法循环（主流程）
1) 回合开始：清盘、展开面板、准备本回合布局  
2) 星曜分配：将背包星曜随机分配到 12 宫位  
3) 玩家调整：拖拽星曜调整宫位  
4) 提交结算：逐宫位计分并累加总分  
5) 回合结束：关闭面板并弹出选星  
6) 选星/升级：选择新星或升级已有星  
7) 进入下一回合

## 入口场景与启动链路
- 入口场景：`res://scene/main_scene.tscn`（见 `project.godot` 的 `run/main_scene`）
- 启动链路：
  - `main_scene.tscn` -> 进入 `scene/version0.1/GPVersion1.tscn`
  - `GPVersion1.tscn` 挂载核心系统：
	- `scripts/gameplay/game_controller.gd` (GameController)
	- `scripts/gameplay/score_controller.gd` (ScoreController)
	- `scripts/UI/ui_manager.gd` (UI_Manager)
	- `scene/星盘系统/星盘.tscn` (StarPanel + PalaceContainer)
	- `scene/star_choice_panel.tscn` (StarChoices)
	- `scene/信息栏.tscn` (GameInfoPanel)

## 系统分层与职责
- UI
  - 展示信息、按钮触发、计分显示、星曜详情弹窗
- World
  - 星盘布局与宫位容器、拖拽承载、动效
- Gameplay
  - 回合流程、抽卡/升级、计分规则与回合推进
- Data
  - 静态资源（StarData/StarSet/Score）与运行期实例（StarInstance）
- Tools
  - 文档/索引生成脚本、调试工具

## 关键约定
- 命名规范：脚本 class_name 与文件职责一致（如 GameController/ScoreController）
- 节点引用策略：
  - 运行期系统使用 @export 绑定场景节点
  - 可变场景结构使用 UniqueName 或导出 NodePath 统一接线
- 信号/事件策略：
  - 逻辑层发信号（round_started/stars_distributed/count_finished）
  - UI/场景监听信号更新表现
- 资源加载策略：
  - 静态数据集中在 `res://data` / `res://scripts/Resources`
  - 动态实例基于 `StarInstance`，不修改资源原型
- 存档策略：
  - 当前未实现存档（后续应独立 SaveManager 管理）

## 改节点结构的安全策略
1) 优先使用 UniqueName 标记关键节点  
2) 对外脚本统一改为 @export 引用，不直接写死 NodePath  
3) 迁移步骤：
   - 先增量添加新节点与脚本
   - 完成新绑定后，再删除旧节点与旧脚本引用
   - 最后清理连接与失效资源

## 项目结构（目录）
- `scene/` 场景与 UI
- `scripts/` 逻辑与数据脚本
- `scripts/gameplay/` 玩法主流程控制器
- `scripts/world/` 场景/棋盘/宫位容器逻辑
- `scripts/UI/` UI 展示与面板动画逻辑
- `scripts/core/` 运行期核心数据结构
- `scripts/Resources/` 静态资源数据结构
- `scripts/DataClass/` 旧数据与展示脚本
- `scripts/autoload/` AutoLoad 单例脚本
- `docs/` 项目文档与索引
- `assets/` 贴图、字体等资源
- `sound/` 音效与音乐

## 场景与节点结构（概述）
- `GPVersion1.tscn`：主玩法场景，包含 Board、UI、StarPanel、计分板、选择界面
- `星盘系统/星盘.tscn`：12 宫位网格，子节点为 `宫位.tscn`
- `star_choice_panel.tscn`：回合结束选星界面
- `信息栏.tscn`：主信息面板（考试、回合、总分）

## 系统实现逻辑（概述）
- GameController（`scripts/gameplay/game_controller.gd`）
  - 回合启动、随机分配、选星升级、背包刷新、提交/修改次数管理
- ScoreController（`scripts/gameplay/score_controller.gd`）
  - 逐宫位计分、回合推进、目标分更新
- RarityPicker（`scripts/gameplay/random/rarity_picker.gd`）
  - 稀有度抽取与幸运值权重
- ScoreCalculator（`scripts/gameplay/rules/score_calculator.gd`）
  - 星曜得分计算
- StarInventory（`scripts/core/star_inventory.gd`）
  - 背包星曜管理与升级
- StarDistributor（`scripts/gameplay/star_distributor.gd`）
  - 星曜投放与宫位清理
- StarBalance（`scripts/Resources/star_balance.gd`）
  - 稀有度分布、目标分数与幸运值配置
- StarPanel / PalaceContainer
  - 宫位布局、星曜落点、宫位高亮
- StarIcon
  - 星曜显示、拖拽、计分动效、详情弹窗

## 数据结构（概述）
- StarData（资源原型）：星曜配置、稀有度、贴图、描述、基础分
- StarSet（资源集合）：星曜总表 + 稀有度索引
- StarInstance（运行期实例）：等级、宫位、临时/永久分数
- StarInventory（运行期容器）：星曜列表与升级记录
- Score（资源）：基础分与倍率配置
- StarBalance（资源）：稀有度分布与目标分配置

## 文档更新要求
- 每完成一个功能或结构变更，更新 `docs/PROJECT.md` 与 `docs/INDEX.md`

## 回合状态机（简述）
- INIT：进入场景，等待首次选星
- CHOOSING：选星/刷新/关闭
- READY：允许开始回合
- DISTRIBUTING：发牌中
- PLAYER：拖拽调整中
- SCORING：提交计分中
