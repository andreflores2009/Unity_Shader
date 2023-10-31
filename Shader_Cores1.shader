Shader "Custom/Shader_Cores1"
{
    // Propriedades do Shader
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}  // Textura principal
        _Glossiness ("Smoothness", Range(0, 1)) = 0.5  // Suavidade
        _Metallic ("Metallic", Range(0, 1)) = 0.0  // Metálico
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }  // Tipo de renderização
        LOD 100  // Nível de detalhe (Level of Detail)

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows  // Configuração do Surface Shader

        // Estrutura de entrada para o shader
        struct Input
        {
            float2 uv_MainTex;  // Coordenadas de textura
        };

        // Declaração de variáveis globais
        sampler2D _MainTex;  // Textura principal
        half _Glossiness;  // Suavidade
        half _Metallic;  // Metálico

        /*
        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)
        */

        // Cor do fundo (branco)
        fixed3 backgroundColor = float3(1.0, 1.0, 1.0);


        // Função para configurar a saída do shader
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Lógica de mudança de cor com base no tempo usando a função sin
            float time = _Time.y;
            float frequency = 1.0;  // Ajuste a frequência conforme necessário

            // Cores de início e fim
            fixed3 startColor = float3(1.0, 0.5, 0.8);    // Rosa
            fixed3 endColor = float3(0.5, 0.7, 1.0);      // Azul

            // Calcula a interpolação linear entre as cores
            fixed3 lerpedColor = lerp(startColor, endColor, 0.5 + 0.5 * sin(time * frequency));

            // Defina a cor do fundo para branco
            //o.Albedo = backgroundColor * lerpedColor;
            o.Albedo = lerpedColor;  // Cor albedo
            o.Metallic = _Metallic;  // Metálico
            o.Smoothness = _Glossiness;  // Suavidade
            o.Alpha = 1.0;  // Configuração de opacidade constante
        }
        ENDCG  // Fim do bloco CG (C for Graphics)
    }

    FallBack "Diffuse"  // Se falhar, use o shader Diffuse padrão
}