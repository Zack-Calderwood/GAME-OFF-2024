shader_type canvas_item;

// Light position in screen coordinates (normalized from 0 to 1)
uniform vec2 fixed_light_screen_position;
uniform float light_radius = 100.0;
uniform float fade_distance = 10.0;

// Target color for the light that will reveal the sprite
uniform vec3 target_light_color : hint_color;
// Tolerance for color matching
uniform float color_tolerance = 0.1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Get the position of the current fragment (pixel) in screen space
   // Convert screen UV to pixel coordinates
    vec2 pixel_position = SCREEN_UV * vec2(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y);

    // Distance from the light position to the current pixel
    float dist = distance(fixed_light_screen_position * vec2(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y), pixel_position);

    // Check if the pixel is within the light radius
    if (dist < light_radius) {
        // Sample the light color at this point (approximated as `target_light_color`)
        vec3 light_color = target_light_color;  // Simulated light color
        
        // Calculate the difference between the current light color and the target color
        float color_difference = distance(light_color, target_light_color);

        // If the color difference is within tolerance, reveal the sprite
        if (color_difference <= color_tolerance) {
            float alpha = clamp((light_radius - dist) / fade_distance, 0.0, 1.0);
            COLOR = texture(TEXTURE, UV) * vec4(1.0, 1.0, 1.0, alpha);
        } else {
            // Make pixel transparent if color doesn't match
            COLOR.a = 0.0;
        }
    } else {
        // Fully transparent if outside the light radius
        COLOR.a = 0.0;
    }
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
