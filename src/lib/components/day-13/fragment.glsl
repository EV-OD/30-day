

varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;

uniform float Itime;

float mapRange(float value, float inMin, float inMax, float outMin, float outMax) {
    return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin);
}

uniform vec3 lightPosition;
vec3 lightColor = vec3(1.0, 0.0, 0.4667);
float intensity = 2.0;


void main(){
    vec2 uv = vUv;
    uv = (vUv - 0.5) * 2.0;

    float decay = intensity / pow(length(lightPosition - vPosition), 2.0);

    vec3 color = lightColor * dot(lightPosition, vNormal) * decay;

    gl_FragColor=vec4(color,1.);
}