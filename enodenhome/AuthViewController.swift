//
//  authViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2020/01/21.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

class authViewController: UIViewController, FUIAuthDelegate {

    @IBOutlet weak var AuthButton: UIButton!

    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    // 認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUIEmailAuth(),
        FUIGoogleAuth()
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // authUIのデリゲート
        self.authUI.delegate = self
        self.authUI.providers = providers
        AuthButton.addTarget(self,action: #selector(self.AuthButtonTapped(sender:)),for: .touchUpInside)
        
    
    }
    

    @objc func AuthButtonTapped(sender : AnyObject) {
        // FirebaseUIのViewの取得
        let authViewController = self.authUI.authViewController()
        // FirebaseUIのViewの表示
        authViewController.modalPresentationStyle = .fullScreen
        self.present(authViewController, animated: true, completion: nil)
    }

    //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // 認証に成功した場合
        if error == nil {
            self.performSegue(withIdentifier: "toTopView", sender: self)
            print("ログイン成功")
        }else{
            // エラー時の処理をここに書く
            print("ログイン失敗")
        }
        
        }
}
