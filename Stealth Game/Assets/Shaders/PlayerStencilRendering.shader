Shader "Custom/PlayerStencilRendering" 
{
	Properties 
	{
		_Color("Color", Color) = (0,0,0,0)
	}
	
	SubShader 
	{
		Pass
		{		
			CGPROGRAM
			#pragma vertex vertShader
			#pragma fragment fragShader

			fixed4 _Color;

			struct VertexInput 
			{
				float4 m_Position : POSITION0;
			};
			
			struct FragmentData
			{
				float4 m_Position : POSITION0;
			};

			FragmentData vertShader(VertexInput input)
			{
				FragmentData output;
				output.m_Position = mul(UNITY_MATRIX_MVP, input.m_Position);				
				return output;
			}
			
			float4 fragShader(FragmentData input) : COLOR0
			{
				fixed4 resultColor = _Color;
				return resultColor;
			}
			
			ENDCG
		}
	} 
	FallBack "Diffuse"
}
