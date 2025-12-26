shader_type canvas_item;

uniform float transparency = 1.0;

void fragment() {
    COLOR.a *= transparency;
}