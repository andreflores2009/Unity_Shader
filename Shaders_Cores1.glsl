precision mediump float;
uniform vec2 u_resolution;
uniform float u_time;

float random(vec2 st) {
    float a = 9.9898;
    float b = 7.233;
    float c = 1.5453123;
    return fract(sin(dot(st.xy, vec2(a, b)) + u_time) * c);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    // Organiza o tamanho da tela
    st.x *= u_resolution.x / u_resolution.y;

    float time = mod(u_time, 6.283185);

    vec3 startColor = vec3(1.0, 0.5, 0.8); // Rosa
    vec3 endColor = vec3(0.5, 0.7, 1.0);   // Azul

    vec3 lerpedColor = mix(startColor, endColor, 0.5 + 0.5 * sin(time));

    float rnd = random(st);
    //vec3 color = rnd * lerpedColor; //usa efeitos de funcao frac
    vec3 color = lerpedColor;


    // Sugerindo valores para Metallic e Glossiness
    float myMetallic = 0.9; // Valor entre 0.0 e 1.0
    float myGlossiness = 0.8; // Valor entre 0.0 e 1.0

    gl_FragColor = vec4(color, 1.0);
    gl_FragColor.g *= myMetallic;
    gl_FragColor.a *= myGlossiness;
}