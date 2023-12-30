shader_type canvas_item;

void fragment() {
	if (COLOR != vec4(0.0,0.0,0.0,1.0)) {
		COLOR.a = 0.0;
	}
}

