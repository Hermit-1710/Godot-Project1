extends Resource
class_name StarRule

@export_enum("被动","入场","特殊效果","结算分数","结算后") var phase
@export_enum("tag星曜数量","存在星曜","拥有钱币数量","庙旺位","孤星","天下大同") var trigger_type
@export_enum("辅佐星","科甲星","桃花星","财星","煞星","破耗星")var trigger_tag
@export_enum("无","同宫","对宫","三方四正","全局") var trigger_scope
@export var trigger_value:float			

@export_enum("召唤临时星曜","提高稀有度","增加移动次数","庇护星曜","临时移除星曜","禁止星曜效果",
			"复制星曜效果","星曜加分","星曜倍率","加钱","宫位分数",
			"宫位倍率") var effect_type
@export_enum("临时","永久") var effect_duration
@export_enum("无","同宫","对宫","三方四正","全局") var effect_scope
@export_enum("辅佐星","科甲星","桃花星","财星","煞星","破耗星","临时星","全部星耀") var effect_tag:String
@export var effect_target:String
@export var effect_value:float
