#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D u_texture_0;
void main() {
	vec2 st = gl_FragCoord.xy/u_resolution.xy;
	gl_FragColor =vec4(texture2D( u_texture_0,st).rgb,1.0);
}
