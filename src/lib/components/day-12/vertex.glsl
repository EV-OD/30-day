
varying vec2 vUv;
varying vec3 vPosition;

uniform vec3 pulsePosition;
uniform float pulseTimer;

float offset = 0.5;
float mapValue(float value, float min1, float max1, float min2, float max2) {
    return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

void main() {

    vec3 resultPos = position;
    for(float i = 0.0; i < 20.0; i += 4.0) {
    float r = i * pulseTimer;
        if(length(position.xy - pulsePosition.xy) < r && length(position.xy - pulsePosition.xy) > r - offset) {
            float amp = mapValue(i, 0.0, 20.0, 2.0, 0.0);
            float damped = mapValue(pulseTimer,0.0 ,1.0, amp,0.0);
            float dis = (r + (r - offset)) / 2.0;
            vec2 origin = pulsePosition.xy + normalize(position - pulsePosition).xy * dis;
            vec2 distance = position.xy - origin;
            resultPos = vec3(position.x , position.y , position.z + damped * sin(mapValue(abs(distance.x), 0.0, offset / 2.0, 3.14 / 4.0, 0.0)) * sin(mapValue(abs(distance.y), 0.0, offset / 2.0, 3.14 / 4.0, 0.0)));
        }
    }
    gl_Position = projectionMatrix * modelViewMatrix * vec4(resultPos, 1.0);

  vUv = uv;
  vPosition = (modelMatrix * vec4(position, 1.0)).xyz;
}