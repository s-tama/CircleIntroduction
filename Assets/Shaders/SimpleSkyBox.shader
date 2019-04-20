//
// SimpleSkyBox.shader
// Actor: Tama
//

// 空に使うシェーダ
Shader "Custom/SimpleSkyBox"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color0("Color 0", Color) = (1, 1, 1, 1)
		_Color1("Color 1", Color) = (0, 0.5, 1, 1)
	}
		SubShader
		{
			Tags
			{
				"RenderType" = "Background"
				"Queue" = "Background"
				"PreviewType" = "SkyBox"
			}
			LOD 100

			Pass
			{
				ZWrite Off
				Cull Off

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;

				float4 _Color0;
				float4 _Color1;
				float _Parameter;

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = v.uv;
					return o;
				}

				float4 frag(v2f i) : SV_Target
				{
					float4 c = i.uv.y*0.5 + 0.5;
					return lerp(_Color0, _Color1, c);
				}
				ENDCG
			}
		}
}
