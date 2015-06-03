using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class StencilRendering : MonoBehaviour 
{
	public Shader m_PlayerStencilShader;

	void Start()
	{
		GetComponent<Camera>().SetReplacementShader(m_PlayerStencilShader, "");
	}
}
