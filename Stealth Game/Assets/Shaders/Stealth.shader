Shader "Custom/Stealth" 
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		
		u_Background ("Background", 2D) = "white" {}
		u_PlayerStencil ("Player Stencil", 2D) = "white" {}
		u_Mask ("Mask", 2D) = "white" {}
		u_StealthPercentage ("Stealth Percentage", Range(0, 1)) = 0
	}
	
	SubShader 
	{
		Pass
		{		
			CGPROGRAM
			#pragma vertex vertShader
			#pragma fragment fragShader

			sampler2D u_PlayerStencil;
			sampler2D u_Background;
			sampler2D u_Mask;
			sampler2D _MainTex;
			
			fixed u_StealthPercentage;

			struct VertexInput 
			{
				float4 m_Position : POSITION0;
				float2 m_UV : TEXCOORD0;
			};
			
			struct FragmentData
			{
				float4 m_Position : POSITION0;
				float2 m_UV : TEXCOORD0;
			};

			FragmentData vertShader(VertexInput input)
			{
				FragmentData output;
				output.m_Position = mul(UNITY_MATRIX_MVP, input.m_Position);
				output.m_UV = input.m_UV;
				
				return output;
			}
			
			float4 fragShader(FragmentData input) : COLOR0
			{
				fixed4 mainColor = tex2D(_MainTex, input.m_UV);
				
				input.m_UV.y = 1.0 - input.m_UV.y;
				
				fixed4 stencil = tex2D(u_PlayerStencil, input.m_UV);
				
				if(stencil.r != 0.0)
				{
					fixed4 maskColor = tex2D(u_Mask, input.m_UV);
					
					if(u_StealthPercentage >= maskColor.r)
					{
						mainColor = tex2D(u_Background, input.m_UV);
					}
				}
				
				return mainColor;
			}
			
			ENDCG
		}
	} 
	FallBack "Diffuse"
}
