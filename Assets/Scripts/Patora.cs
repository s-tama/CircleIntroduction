//
// Patora.cs
//

using System.Collections;
using System.Collections.Generic;
using UnityEngine;


/// <summary>
/// パトラ君クラス
/// </summary>
public class Patora : MonoBehaviour
{

    [SerializeField]
    private GameObject model = null;

    private Animation anim;
    private bool isFinishedAction;


    /// <summary>
    /// 開始
    /// </summary>
    private void Start()
    {
        this.anim = GetComponent<Animation>();
        this.isFinishedAction = false;
    }

    /// <summary>
    /// 更新
    /// </summary>
    private void Update()
    {
        // アニメーションが終了したら、アクション終了フラグを立てる
        if (this.anim.isPlaying != true)
        {
            this.isFinishedAction = true;
        }
    }

    #region プロパティ
    public bool IsFinishedAction
    {
        get { return this.isFinishedAction; }
    }
    #endregion
}
