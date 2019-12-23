#version 330
in INTERFACE 
{
    vec2 uv;
 	float on;
	float id;
     } In;
uniform sampler2D texture0; 
uniform float u_time;
uniform vec3 baseColor;
#define numberSprites 8.0
out vec4 fragColor;
float rand(vec2 co){
    	return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
         }
 void main(){	
      	// If not on, discard flash immediatly.\n
          	if(In.on < 0.5){
                		discard;
                         	}	
                             
    float mask = 0.0;	
	// If up half, read from texture atlas.\n 
    	if(In.uv.y > 0.0){
    // Select a sprite, depending on time and flash id.
	float shift = floor(mod(15.0 * time, numberSprites)) + floor(rand(In.id * vec2(time,1.0)));
    vec2 globalUV = vec2(0.5 * mod(shift, 2.0), 0.25 * floor(shift/2.0));		
    	// Scale UV to fit in one sprite from atlas.\n 		
    vec2 localUV = In.uv * 0.5 + vec2(0.25,-0.25);	
    localUV.y = min(-0.05,localUV.y); 
    //Safety clamp on the upper side (or you could set clamp_t)\n 	
	// Read in black and white texture do determine opacity (mask).\n 	
    vec2 finalUV = globalUV + localUV;	
    mask = texture(textureFlash,finalUV).r; 	
    } 	
    	// Colored sprite.	vec4 spriteColor = vec4(baseColor,In.on * mask); 	
 	// Circular halo effect.
    float haloAlpha = 1.0 - smoothstep(0.07,0.5,length(In.uv));
    vec4 haloColor = vec4(1.0,1.0,1.0, In.on * haloAlpha * 0.92);	
   // Mix the sprite color and the halo effect.\n 	
   fragColor = mix(spriteColor, haloColor, haloColor.a); 	 	
   // Boost intensity.\n 	
   fragColor *= 1.1;
    }