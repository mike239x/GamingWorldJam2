shader_type canvas_item;

uniform float gray : hint_range(0.0, 1.0) = 0.5;
uniform float brightness : hint_range(0.0, 1.0) = 0.5;
//uniform vec4 shift_color : source_color;
uniform vec4 attract_color : source_color;
uniform float attract_force : hint_range(0.0, 1.0) = 0.5;
// use alpha for attraction / shift force

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	COLOR = textureLod(screen_texture, SCREEN_UV, 0.0);
	float lumi = dot(COLOR, vec4(0.447,0.878,0.171,0.0));
	vec4 grayscale = vec4(lumi, lumi, lumi, COLOR.a);
	vec4 result = mix(COLOR, grayscale, gray);
	COLOR = result;
	//COLOR.rgb += shift_color.rgb * shift_color.a;
	COLOR.rgb = mix(COLOR.rgb, attract_color.rgb, attract_force * lumi);
	COLOR.rgb *= brightness;
}
