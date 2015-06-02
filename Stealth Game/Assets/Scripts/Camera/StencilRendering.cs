using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class StencilRendering : MonoBehaviour 
{
	public Material m_StencilMaterial;
	public Renderer m_PlayerRenderer;

	Renderer[] m_ObjectRenderers;

	List<Material> m_ObjectMaterials = new List<Material>();

	Camera m_Camera;

	void Start()
	{
		m_ObjectRenderers = FindObjectsOfType<Renderer>();

		foreach(Renderer objectRenderer in m_ObjectRenderers)
		{
			m_ObjectMaterials.Add (objectRenderer.material);
		}

		m_Camera = GetComponent<Camera>();
	}

	public void Render()
	{
		SetUpRenderers(true);

		m_Camera.Render ();

		SetUpRenderers(false);
	}

	void SetUpRenderers(bool isRenderingStencil)
	{
		int index = 0;

		foreach(Renderer objectRenderer in m_ObjectRenderers)
		{
			if(isRenderingStencil)
			{
				m_ObjectMaterials[index] = objectRenderer.material;

				objectRenderer.material = m_StencilMaterial;

				if(objectRenderer == m_PlayerRenderer)
				{
					objectRenderer.material.color = Color.white;
				}
			}
			else
			{
				objectRenderer.material = m_ObjectMaterials[index];
			}

			index++;
		}
	}
}
