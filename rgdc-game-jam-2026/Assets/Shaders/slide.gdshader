// SLIDE
shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0);
uniform bool reverse = true;

// FRAGMENT
	// Called for every pixel the material is visible on.
void fragment() {
	vec2 rect = UV;
	
	if (UV.x >= progress){
		if (!reverse){
			discard;
		}
	}
	else if (reverse){
		discard;
	}
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
