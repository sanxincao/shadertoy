# How to use


Load the latest version of glsl-canvas.js on your page by adding this line to your HTML:

"""  <script type="text/javascript" src="https://rawgit.com/actarian/glsl-canvas/master/dist/glsl-canvas.min.js"></script> """

## With npm

If you are using npm package manager type this command on your terminal:
 
 
npm install glsl-canvas-js --save

##  Run with html

Add a canvas element on your page with class name glsl-canvas and assign a shader through a url using the data-fragment-url attribute.
 

Or write your shader directly in code using the data-fragment attribute.

"""<canvas class="glsl-canvas" data-fragment-url="fragment.glsl" width="500" height="500"></canvas>
GlslCanvas will automatically load a WebGL context in that <canvas> element, compile the shader and animate it for you."""

##  Run with javascript
Create a <canvas> element and attach a new instance of GlslCanvas.

let canvas = document.createElement('canvas');
let glsl = new GlslCanvas(canvas);
All the .glsl-canvas instances will be stored in the GlslCanvas.items array.


##  Default Uniforms
These uniforms are automatically loaded for you.

name	
u_time      	a float representing elapsed time in seconds.
u_resolution	a vec2 representing the dimensions of the viewport.
u_mouse	        a vec2 representing the position of the mouse, defined in Javascript with .setMouse({x:[value],y:[value]).

u_texture_N	    a sampler2D containing textures loaded with the data-textures attribute.
Attributes
name	
data-fragment	load a fragment shader by providing the content of the shader as a string
data-vertex	    load a vertex shader by providing the content of the shader as a string
data-fragment-url	load a fragment shader by providing a valid url
data-vertex-url	load a vertex shader by providing a valid url
data-textures	load a list of texture urls separated by commas (ex: data-textures="color.jpg,normal.png,bump.jpg"). Textures will be assigned in order to uniform sampler2D variables with names following this style: u_texture_0, u_texture_1, u_texture_2, etc.
controls	enable play on over functionality

data-autoplay	enable autoplay with controls feature
Events
name	argument
load	GlslCanvas instance
error	Error
textureError	TextureError
render	GlslCanvas instance
over	MouseEvent
out	MouseEvent
move	{ x:, y: }
click	MouseEvent
Methods
name	parameters
load	fragment: string, vertex: string
on	eventName: string, callback: Function
setTexture	key: string, target: string or element, options:TextureOptions
setUniform	key: string, ...values: number or string
setUniforms	uniforms: { [key: string]: number[] or string }
play	
pause	
toggle	
destroy	
##  Tips
You can change the content of the shader as many times you want. Here are some examples:

// load only the fragment shader
let fragment = 'main() { gl_FragColor = vec4(1.0); }';
glsl.load(fragment);

// load a fragment and vertex shader
let vertex = 'attribute vec4 a_position; main(){ gl_Position = a_position; }';
glsl.load(fragment, vertex);
You can also send your custom uniforms to a shader with .setUniform('name', ...values). GlslCanvas will parse the value you provide to determine its type. If the value is a string, GlslCanvas will parse it as the url of a texture.

// assign .5 to 'uniform float u_brightness'
glsl.setUniform('u_brightness', 0.5); 

// assign (.2,.3) to 'uniform vec2 u_position'
glsl.setUniform('u_position', 0.2, 0.3);

// assign a red color to 'uniform vec3 u_color'
glsl.setUniform('u_color', 1.0, 0.0, 0.0); 

// load a new texture and assign it to 'uniform sampler2D u_texture'
glsl.setUniform('u_texture', 'data/texture.jpg');