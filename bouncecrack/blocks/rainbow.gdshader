shader_type canvas_item;

uniform float sin_frequency : hint_range(0.1, 2.0) = 0.5;  // frequency of the rainbow
uniform float sin_offset : hint_range(0.0, 360.0) = 0.0;   // offset of the rainbow, useful to differentiate objects using the same shader
uniform float light_offset : hint_range(0.0, 1.0) = 0.5;   // this offsets all color channels; if set to 0 only red green and blue colors will be shown.

uniform float speed = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec4 animated_line_color = vec4(light_offset + sin(2.0*3.14*sin_frequency*TIME*speed),
							   light_offset + sin(2.0*3.14*sin_frequency*TIME*speed + radians(120.0)),
							   light_offset + sin(2.0*3.14*sin_frequency*TIME*speed + radians(240.0)),
							   1.0);
	
	vec4 color = texture(TEXTURE, UV);
	
	COLOR = mix(color, animated_line_color, color.a);


}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
