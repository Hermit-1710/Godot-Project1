shader_type canvas_item;

void fragment() {
	vec4 InC= texture(TEXTURE,UV);
	vec4 default_color = vec4(UV[0]*0.5,UV[1]*0.5,0.8,InC.a);
	COLOR = vec4(0.3,0.5,0.8,InC.a);
	//COLOR = default_color;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
