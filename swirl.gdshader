shader_type canvas_item;

uniform float swirl_strength = 1;
uniform float radius = .5;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 uv = SCREEN_UV - vec2(0.5);
    float dist = length(uv);

    // Calculate rotation based on distance
    float angle = atan(uv.y, uv.x) + (swirl_strength * (radius - dist) / radius);

    // Only apply if within radius
    if (dist < radius) {
        uv = vec2(cos(angle), sin(angle)) * dist;
    }

    COLOR = texture(SCREEN_TEXTURE, uv + vec2(0.5));
}
