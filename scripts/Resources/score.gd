# ROLE: Score data for stars and palaces.
# OWNS: base_score, perm/temp score and multipliers.
# TALKS_TO: none.
# API: init_palace.
# INVARIANTS: base_multiple initialized to 1 for palaces.
extends Resource
class_name Score

@export var base_score:int = 0 
var perm_score:int = 0 
var temp_score:int = 0 
var base_multiple:int = 0 
var perm_multiple:int = 0 
var temp_multiple:int = 0 

####宫位基础倍率为1
func init_palace():
	base_multiple = 1
