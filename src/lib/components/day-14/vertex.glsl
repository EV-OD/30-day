varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;

void main() {
    // Pass the UV coordinates to the fragment shader
    vUv = uv;
    
    // Transform the position from local space to world space
    vPosition = (modelMatrix * vec4(position, 1.0)).xyz;
    
    // Transform the normal into world space
    vNormal = normalize((modelMatrix * vec4(normal, 0.0)).xyz);

    
    // Calculate the position in clip space (for rendering)
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
