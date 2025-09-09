shader_type canvas_item;
render_mode blend_mix, unshaded;

// The full color of the rectangle
uniform vec4 rect_color : source_color = vec4(1.0, 0.2, 0.2, 1.0); // red

// Hole configuration
uniform vec2 hole_position = vec2(0.0, 0.0); // Top-left corner of the hole (in pixels)
uniform vec2 hole_size = vec2(50.0, 50.0);   // Width and height of the hole (square or rectangle)

void fragment() {
    // Convert UV to local pixel coordinates
    vec2 pixel_pos = UV * vec2(textureSize(TEXTURE, 0));

    // Check if we're inside the hole area
    bool in_hole = pixel_pos.x > hole_position.x &&
                   pixel_pos.x < hole_position.x + hole_size.x &&
                   pixel_pos.y > hole_position.y &&
                   pixel_pos.y < hole_position.y + hole_size.y;

    if (in_hole) {
        discard; // Make transparent
    }

    COLOR = rect_color;
}
