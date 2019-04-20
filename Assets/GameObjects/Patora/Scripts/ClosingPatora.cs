//
// ClosingPatora.cs
// Actor: Tama
//

using System.Collections;
using System.Collections.Generic;
using UnityEngine;


/// <summary>
/// パトラ君の画面を閉じるエフェクト
/// </summary>
public class ClosingPatora
{

    private Renderer ren;

    private float scanLineTail;
    private float scanLineSpeed;

    private float time;


    /// <summary>
    /// コンストラクタ
    /// </summary>
    /// <param name="renderer"></param>
    public ClosingPatora(Renderer renderer)
    {
        this.ren = renderer;
        this.time = 0;

        Reset();
    }

    /// <summary>
    /// 更新
    /// </summary>
    /// <returns></returns>
    public bool Update()
    {
        this.time += Time.deltaTime;

        if (this.time >= 3)
        {
            this.scanLineTail -= Time.deltaTime;
            this.scanLineTail = Mathf.Max(0, this.scanLineTail);
        }

        this.ren.sharedMaterial.SetFloat("_ScanLineTail", this.scanLineTail);
        this.ren.sharedMaterial.SetFloat("_ScanLineSpeed", this.scanLineSpeed);

        if (this.scanLineTail <= 0) return false;
        return true;
    }

    /// <summary>
    /// 初期化
    /// </summary>
    public void Reset()
    {
        this.scanLineTail = 5;
        this.scanLineSpeed = 10;

        this.ren.sharedMaterial.SetFloat("_ScanLineTail", this.scanLineTail);
        this.ren.sharedMaterial.SetFloat("_ScanLineSpeed", this.scanLineSpeed);
    }
}
