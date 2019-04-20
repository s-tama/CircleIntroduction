//
// TitleDirector.cs
//

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;


/// <summary>
/// タイトルシーンの監督クラス
/// </summary>
public class TitleDirector : MonoBehaviour
{

    [SerializeField]
    private Patora patora = null;

    [SerializeField]
    private Image titleLogo = null;


    /// <summary>
    /// 開始
    /// </summary>
    private void Start()
    {
        this.titleLogo.gameObject.SetActive(false);

        // 終了時点で行う処理を記述
        this.patora.SetFunc(()=>{
            SceneManager.LoadScene("MainScene");
            return true;
        });
    }

    /// <summary>
    /// 更新
    /// </summary>
    private void Update()
    {
        // パトラ君のアクションが終了したら、ロゴを表示する
        if (this.patora.IsFinishedAction)
        {
            this.titleLogo.gameObject.SetActive(true);
        }
    }
}
