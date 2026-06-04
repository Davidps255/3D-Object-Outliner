shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 0.8, 0.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 2.0;
uniform float transparency_tolerance : hint_range(0.0, 1.0) = 0.1;
uniform bool fade = true;
uniform bool rounded = true;

void fragment() {
	// Store how it should look
	// Do outline rendering
	// Re add how it should look
	
    if (texture(TEXTURE, UV).a > transparency_tolerance) // Checks if pixel is not part of the object
	{
		COLOR = vec4(0.0); // Set color to transparent
	}
	else
	{
		bool neighbor = false;
		float max_dist = pow(outline_width, 2); // Squaring to avoid sqrt
		float min_dist = max_dist;
		for (float x = -outline_width; x <= outline_width; ++x)
		{
			for (float y = -outline_width; y <= outline_width; ++y)
			{
				float dist = pow(x, 2) + pow(y, 2); // Skipping sqrt in dist check
				
				if (rounded && dist > max_dist)
					continue;
				
				vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
				if (texture(TEXTURE, UV + offset).a > 0.0) // If pixel at offset has an alpha value
				{
					neighbor = true;
					min_dist = min(min_dist, dist);
				}
			}
		}
		
		if (neighbor) // If a neighboring pixel is part of the object, draw the outline
		{
			COLOR = outline_color;
			if (fade)
			{
				//COLOR.a = (sqrt(max_dist) - sqrt(min_dist)) / sqrt(max_dist); // Accurate
				//COLOR.a = sqrt((max_dist - min_dist) / max_dist); // Faster
				COLOR.a = (max_dist - min_dist) / max_dist; // Fastest
			}
        }
	}
}
