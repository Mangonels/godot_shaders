shader_type spatial;

render_mode depth_draw_always;

uniform vec4 color1 : source_color; // Gradient rgba start color
uniform vec4 color2 : source_color; // Gradient rgba end color

uniform float top_mesh_extreme_vertex_height;
uniform float bottom_mesh_extreme_vertex_height;

varying vec3 frag_coords_converter;

// Remaps value within min_value to max_value range, into min_remap to max_remap range.
float remap(float value, float min_value, float max_value, float min_remap, float max_remap)
{
	return (value - min_value) / (max_value - min_value) * (max_remap - min_remap) + min_remap;
}

void vertex() 
{
	//frag_coords_converter = (vec4(VERTEX, 1.0) * INV_VIEW_MATRIX).xyz;
	
	//The vertex coordinates (sent to fragment shader through uniform) 
	//are interpolated to generate the local fragment position
	frag_coords_converter = VERTEX;
}

void fragment() {
	//EMISSION = vec3(1,1,1);
	//ALPHA = 0.75;
	
	//ALBEDO = vec3(UV.y * 1.0f, 0.0f, 0.0f);
	
	float remapped_fragment_height = remap(frag_coords_converter.y, bottom_mesh_extreme_vertex_height, top_mesh_extreme_vertex_height, 0, 1);
	ALBEDO = vec3(mix(color1.r, color2.r, remapped_fragment_height), mix(color1.g, color2.g, remapped_fragment_height), mix(color1.b, color2.b, remapped_fragment_height));
	ALPHA = mix(color1.a, color2.a, remapped_fragment_height);
}