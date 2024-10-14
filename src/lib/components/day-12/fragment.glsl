

varying vec2 vUv;
varying vec3 vPosition;

uniform float Itime;

void main(){
    vec2 uv = vUv;
    uv = (vUv - 0.5) * 2.0;

    vec3 col = vec3(1.0, 0.0, 0.0);
    float d = length(uv);
    d = sin(d * 8. + Itime) / 8.;
    d = abs(d);
    d = 0.02 / d;
    col *= d;
    gl_FragColor=vec4(col,1.);
}