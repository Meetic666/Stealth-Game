using UnityEngine;
using System.Collections;

public class StealthRenderingPostProcess : MonoBehaviour 
{
	public Material m_StealthMaterial;

	void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		Graphics.Blit(source, destination, m_StealthMaterial);
	}
}
