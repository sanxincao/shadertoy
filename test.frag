#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float sphere(vec3 ray, vec3 dir, vec3 center, float radius)
{
	vec3 rc = ray-center;
	float c = dot(rc, rc) - (radius*radius);
	float b = dot(dir, rc);
	float d = b*b - c;
	float t = -b - sqrt(abs(d));
	float st = step(0.0, min(t,d));
	return mix(-1.0, t, st);
}//programme t

vec3 background(float t, vec3 rd)
{
	vec3 light = normalize(vec3(sin(t), 0.2, cos(t)));//draw circle
	float sun = max(0.0, dot(rd,light));
	float sky = max(0.0, dot(rd, vec3(0.0, 1.0, 0.0)));
	float ground = max(0.0, -dot(rd, vec3(0.0, 1.0, 0.0)));
	return 
		(pow(sun, 256.0)+0.2*pow(sun, 2.0))*vec3(2.0, 1.6, 1.0) +
		pow(ground, 0.5)*vec3(0.4, 0.3, 0.2) +
		pow(sky, 1.0)*vec3(0.5, 0.6, 0.7);
}

void main()
{
	vec2 uv =// gl_FragCoord.xy / u_resolution.xy;
	(-1.0 + 2.0*gl_FragCoord.xy / u_resolution.xy)
	 * vec2(u_resolution.x/u_resolution.y, 1.0);
	vec3 ro = vec3(0.0, 1.0, -3.0);
	vec3 rd = normalize(vec3(uv, 1.0));//RAY VECTOR
	vec3 p = vec3(0.0, 0.0, 0.0);
	float t = sphere(ro, rd, p, 1.0);
	vec3 nml = normalize(p - (ro+rd*t));//N
	vec3 bgCol = background(u_time, rd);
	rd = reflect(rd, nml);
	vec3 col = background(u_time, rd) * vec3(0.9,0.8, 1.0);
	gl_FragColor = vec4( mix(bgCol, col, step(0.0, t)), 1.0 );
}