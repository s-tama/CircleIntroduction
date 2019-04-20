//
// SceneTransition.cs
// Actor: Tama
//

using System.Collections;
using System.Collections.Generic;
using UnityEngine;


/// <summary>
/// シーン遷移
/// </summary>
public class SceneTransition : MonoBehaviour
{

    [SerializeField]
    private Material mat = null;


    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, this.mat);
    }
}
