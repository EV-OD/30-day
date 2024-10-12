

varying vec2 vUv;
varying vec3 vPosition;
uniform float time;


void main() {
    vec3 color = vec3(abs(vUv.y * time / 10.0 ), abs(vUv.y * time  / 10.0), abs(vUv.x * time / 10.0));
    gl_FragColor = vec4(color,1.);

}
