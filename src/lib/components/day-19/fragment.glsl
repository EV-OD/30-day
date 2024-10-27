

varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormal;

uniform float Itime;

float mapRange(float value, float inMin, float inMax, float outMin, float outMax) {
    return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin);
}

uniform vec3 lightPosition;
vec3 lightColor = vec3(1.0, 0.0, 0.4667);
float lightIntensity = 100.0;


void main() {
    vec2 uv = vUv;
    uv = (vUv - 0.5) * 2.0; // Adjust UV coordinates

    // Normalize the normal and calculate the light direction
    vec3 normal = normalize(vNormal);
    vec3 lightDir = normalize(lightPosition - vPosition);
    
    // Calculate distance to the light and apply the inverse square law for decay
    float distance = length(lightPosition - vPosition);
    float decay = lightIntensity / (distance * distance); // Inverse square law
    
    // Lambertian reflection (diffuse shading): dot product between normal and light direction
    float lambert = max(dot(normal, lightDir), 0.0);

    // Calculate the final color using the light color, decay, and Lambertian reflection
    vec3 color = lightColor * lambert * decay;

    // Output the color
    gl_FragColor = vec4(color, 1.0);
}