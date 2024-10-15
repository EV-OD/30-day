varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;

void main() {
    // Pass the UV coordinates to the fragment shader
    vUv = uv;
    
    // Transform the position from local space to world space
    vPosition = (modelMatrix * vec4(position, 1.0)).xyz;
    
    // Correctly transform and normalize the normal vector in world space
    vNormal = normalize(normalMatrix * normal);
    
    // Calculate the position in clip space (for rendering)
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
