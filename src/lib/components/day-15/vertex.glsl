varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;

uniform float pulseTimer;

void main() {
    // Pass the UV coordinates to the fragment shader
    vUv = uv;
    
    // Transform the position from local space to world space
    vec4 worldPosition = modelMatrix * vec4(position, 1.0);
    
    // Zero out the Y component in world space
    worldPosition.y = pulseTimer * position.z;

    // Pass the transformed position to the fragment shader
    vPosition = worldPosition.xyz;
    
    // Transform the normal into world space (without affecting the Y component)
    vNormal = normalize((modelMatrix * vec4(normal, 0.0)).xyz);
    
    // Project the modified position (after zeroing Y) into clip space
    gl_Position = projectionMatrix * viewMatrix * worldPosition;
}
