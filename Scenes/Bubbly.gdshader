shader_type canvas_item;

// Define uniforms for edge and center colors, edge width, and softness
uniform vec4 edge_color = vec4(0.3, 0.7, 1.0, 1.0); // Default edge color
uniform vec4 center_color = vec4(1.0, 1.0, 1.0, 1); // Default center (transparent)
uniform float edge_width = 0.3; // Width of the colored edge
uniform float softness = 0.5; // Edge softness

void fragment() {
    vec2 uv = UV; // Get UV coordinates
    vec2 center = vec2(0.5, 0.5); // Bubble center in UV space
    float dist = 1.3; // distance(uv, center); // Distance from the center
    float edge_factor = smoothstep(1.0 - edge_width, 1.0, dist); // Edge smoothing

    // Interpolate between center and edge colors
    vec4 color = mix(center_color, edge_color, edge_factor);

    // Control transparency outside the bubble edge
    float alpha = 1.0 - smoothstep(1.0, 1.0 + softness, dist);
    color.a *= alpha;

    COLOR = color; // Output the final color
}
