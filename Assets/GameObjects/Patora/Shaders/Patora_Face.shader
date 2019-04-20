//
// Patora_Face.shader
// Actor: Tama
//

// パトラ君の顔用に使うシェーダー	
Shader "Patora/Patora_Face"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1, 1 ,1, 1)
		_NoiseX("NoiseX", Range(0, 1)) = 0
		_Offset("Offset", Vector) = (0, 0, 0, 0)
		_RGBNoise("RGBNoise", Range(0, 1)) = 0
		_SinNoiseWidth("SineNoiseWidth", Float) = 1
		_SinNoiseScale("SinNoiseScale", Float) = 1
		_SinNoiseOffset("SinNoiseOffset", Float) = 1
		_ScanLineTail("Tail", Float) = 0.5
		_ScanLineSpeed("TailSpeed", Float) = 100
		_Close("Close", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
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

            sampler2D _MainTex;		// メインテクスチャ
			float4 _Color;			// 色
			float2 _Offset;			// オフセット値
			float _SinNoiseWidth;	// ノイズ幅
			float _SinNoiseOffset;	// ノイズオフセット
			float _SinNoiseScale;	// ノイズの大きさ
			float _NoiseX;			// Xノイズ
			float _RGBNoise;		// RGBノイズ
			float _ScanLineTail;
			float _ScanLineSpeed;
			float _Close;

			// ランダムな値を返す関数
			float rand(float2 co) 
			{
				return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
			}

			// 余りを求める
			float2 mod(float2 a, float2 b)
			{
				return a - floor(a / b) * b;
			}

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
                return o;
            }

           float4 frag (v2f i) : SV_Target
            {
				float2 inUV = i.uv;
				float2 uv = i.uv - 0.5;

				// uv座標を再計算し、画像を歪ませる
				float vignet = length(uv);
				uv /= 1 - vignet * 0.2;
				float2 texUV = uv + 0.5;

				// 画面外なら描画しない（黒で塗りつぶす）
				if (max(abs(uv.y) - 0.5, abs(uv.x) - 0.5) > 0)
				{
					return float4(0, 0.8, 1, 1);
				}

				// 色を計算
				float3 col;

				// ノイズ、オフセットを適用
				texUV.x += sin(texUV.y * _SinNoiseWidth + _SinNoiseOffset)*_SinNoiseScale;
				texUV += _Offset;
				texUV.x += (rand(floor(texUV * 500) + _Time.y) - 0.5) * _NoiseX;
				texUV = mod(texUV, 1);

				// 色を取得、RGBを少しずつずらす
				col.r = tex2D(_MainTex, texUV).r;
				col.g = tex2D(_MainTex, texUV - float2(0.002, 0)).g;
				col.b = tex2D(_MainTex, texUV - float2(0.002, 0)).b;

				// RGBノイズ
				if (rand((rand(floor(texUV.y * 500) + _Time.y) - 0.5) + _Time.y) < _RGBNoise)
				{
					col.r = rand(uv + float2(123 + _Time.y, 0));
					col.g = rand(uv + float2(123 + _Time.y, 1));
					col.b = rand(uv + float2(123 + _Time.y, 2));
				}

				// スキャンラインを描画
				float scanLineColor = sin(_Time.y * 10 + uv.y * 100) / 2 + 0.5;
				col *= 0.5 + clamp(scanLineColor + 0.5, 0, 1) * 0.5;

				// スキャンラインの残像を描画
				float tail = clamp((frac(uv.y + _Time.y * _ScanLineSpeed) - 1 + _ScanLineTail) / min(_ScanLineTail, 1), 0, 1);
				col *= tail;

				// 画面端を暗くする
				col *= 1 - vignet * _Close;

                return float4(col, 1)*_Color;
            }
            ENDCG
        }
    }
}
