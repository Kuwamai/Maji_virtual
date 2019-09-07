Shader "Test/Scale"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float3 unpack_movie() {
                float v = 0;
                v = tex2Dlod(_MainTex, float4(0.5, 0.5,0,0));
                return v;
            }

            v2f vert(appdata v)
            {
                v2f o;
                float3 scale = unpack_movie();
                v.vertex *= scale.x * 0.1 + 0.9;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 color = fixed4(i.uv.x, i.uv.y, 0, 1);
                return color;
            }

            ENDCG
        }
    }
}