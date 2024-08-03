shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D shadow_texture;
uniform vec2 offset = vec2(8.0, 8.0);
uniform vec4 modulate : source_color = vec4(0.0, 0.0, 0.0, 0.5);

void fragment() {
	vec2 ps = TEXTURE_PIXEL_SIZE;

	//vec4 shadow = vec4(modulate.rgb, texture(TEXTURE, UV - offset * ps).a * modulate.a);
	vec4 shadow = vec4(modulate.rgb, texture(shadow_texture, UV - offset * ps).a * modulate.a);
	vec4 col = texture(TEXTURE, UV);

	COLOR = mix(shadow, col, col.a);
}