shader_type canvas_item;
uniform int level : hint_range(1,5);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 InC= texture(TEXTURE,UV);
	vec4 level_5_color = vec4(1.0-UV[0]*0.3,1.0-UV[1]*0.8,UV[0]*0.8,InC.a);
	vec4 level_3_color = vec4(UV[0]*0.8,UV[1]*0.5,0.8,InC.a);
	vec4 level_2_color = vec4(UV[0]*0.3,1.0-UV[1]*0.8,1.0-UV[0]*0.8,InC.a);
	vec4 level_1_color = vec4(UV[0]*0.6,0.4,0.8,InC.a);
	vec4 level_4_color = vec4(UV[0]*0.8,UV[1]*0.8,0.8,InC.a);
	vec4 default_color = vec4(UV[0]*0.5,UV[1]*0.5,0.8,InC.a);
	//COLOR = vec4(0.3,0.5,0.8,InC.a);
	vec4 final_color = level_1_color;
	if (level == 1) {
        final_color = level_1_color;
    } else if (level == 2) {
        final_color = level_2_color;
    } else if (level == 3) {
        final_color = level_3_color;
    } else if (level == 4) {
        final_color = level_4_color;
    } else if (level == 5) {
        final_color = level_5_color;
    }

    COLOR = final_color;
	COLOR = level_1_color;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
