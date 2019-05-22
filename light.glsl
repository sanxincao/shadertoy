
#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
//uniform sampler2D iChannel0;
uniform sampler2D u_texture_0;
void main()
{    
    vec2 p = gl_FragCoord.xy/u_resolution.xy;
    vec4 c = vec4(texture2D(u_texture_0, p).rgb, 1.0);
    gl_FragColor = vec4(mix(c, 1.-c, smoothstep(-.3,.3,abs(cos(p.y+u_time*20.0)+3.4))));
}