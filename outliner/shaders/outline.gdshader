shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 0.8, 0.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 2.0;
uniform float transparency_tolerance: hint_range(0.0, 1.0) = 0.1;

void fragment() {
	COLOR = vec4(0.0);// Set color to transparent by default
	
    if (texture(TEXTURE, UV).a < transparency_tolerance) { // If outside of the object
        float max_alpha = 0.0;
        for (float x = -outline_width; x <= outline_width; x++) {
            for (float y = -outline_width; y <= outline_width; y++) {
                vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
                max_alpha = max(max_alpha, texture(TEXTURE, UV + offset).a);
            }
        }
		
        if (max_alpha > 0.0) { // If a neighboring pixel is part of the object, draw the outline
            COLOR = outline_color;
        }
    }
}
