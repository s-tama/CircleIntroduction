//
// Patora.cs
// Actor: Tama
//

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


/// <summary>
/// パトラ君クラス
/// </summary>
public class Patora : MonoBehaviour
{

    [SerializeField]
    private Renderer[] model = new Renderer[0];

    private ClosingPatora closing;
    private Animation anim;
    private bool isFinishedAction;

    private Func<bool> callOnFinished;


    /// <summary>
    /// 開始
    /// </summary>
    private void Start()
    {
        this.closing = new ClosingPatora(this.model[0]);

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
            if (!this.closing.Update())
            {
                this.closing.Reset();
                this.callOnFinished();
            }
            this.isFinishedAction = true;
        }
    }

    #region プロパティ
    public bool IsFinishedAction
    {
        get { return this.isFinishedAction; }
    }

    public void SetFunc(Func<bool> func)
    {
        this.callOnFinished = func;
    }
    #endregion
}
