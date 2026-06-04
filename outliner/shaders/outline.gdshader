shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 0.8, 0.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 2.0;
uniform float transparency_tolerance : hint_range(0.0, 1.0) = 0.1;
uniform bool fade = true;

void fragment() {
	// Store how it should look
	// Do outline rendering
	// Re add how it should look
	
    if (texture(TEXTURE, UV).a > transparency_tolerance) { // Checks if pixel is not part of the object
		COLOR = vec4(0.0); // Set color to transparent
    } else {
		float max_alpha = 0.0;
		float min_dist = pow(outline_width, 2) + 1.0;
		//float temp_alpha = 0.0;
		//float temp_x = 0.0;
		//float temp_y = 0.0;
        for (float x = -outline_width; x <= outline_width; x++) {
            for (float y = -outline_width; y <= outline_width; y++) {
                vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
                max_alpha = max(max_alpha, texture(TEXTURE, UV + offset).a);
				min_dist = min(min_dist, pow(x, 2) + pow(y, 2)); // Skipping sqrt in dist check
            }
        }
		
        if (max_alpha > 0.0) { // If a neighboring pixel is part of the object, draw the outline
            COLOR = outline_color;
			if (fade) {
				//COLOR.a = 1.0 - (min_dist - 1.0) / outline_width;
				COLOR.a = 1.0 - (sqrt(min_dist) - 1.0) / outline_width;
			}
        }
	}
}
