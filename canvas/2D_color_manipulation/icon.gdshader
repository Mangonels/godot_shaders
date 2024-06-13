shader_type canvas_item;

void vertex() {

}

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	//COLOR = input_color;
	//COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	COLOR = vec4(1.0, 1.0, 1.0, input_color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
