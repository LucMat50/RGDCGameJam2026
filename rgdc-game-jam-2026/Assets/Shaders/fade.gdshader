// FADE
shader_type canvas_item;

// Range from solid to transparent
uniform float progress: hint_range(0.0, 1.0);

// FRAGMENT
	// Called for every pixel the material is visible on.
	// sets canvas item color to progress
void fragment() {
	COLOR.a = progress;
}