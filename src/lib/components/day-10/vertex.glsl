
varying vec2 vUv;
varying vec3 vPosition;
uniform float time;

void main() {
    float f = 4.0;
    float a = 4.0;
    vec4 result = vec4( position.x, a * sin(position.x / f + time * 0.7) + position.y  + a / 3.0 * sin(position.z / f + time * 0.7), position.z, 1.0 );
    gl_Position = projectionMatrix * modelViewMatrix * result;
    vUv = uv;
    vPosition = (modelMatrix * vec4(position, 1.0)).xyz;
}