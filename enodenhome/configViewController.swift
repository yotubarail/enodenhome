//
//  configViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2020/01/22.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class configViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    let configMenu1: NSMutableArray = ["お問い合わせ"]
    let configMenu2: NSMutableArray = ["ログアウト", "アカウント削除"]
    
    
    var section1: Dictionary = [String: NSMutableArray]()
    var section2: Dictionary = [String: NSMutableArray]()
    var sections: Array = [Dictionary<String,NSMutableArray>]()
    
    @IBOutlet weak var configTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "設定"
        
        section1 = ["お問い合わせ": configMenu1]
        section2 = ["アカウント": configMenu2]
        
        sections.append(section1)
        sections.append(section2)
        
        configTableView.delegate = self
        configTableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return self.sections.count
       }
       
       // セクションのタイトルを返す。
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           var title = ""
           for (key) in sections[section].keys
           {
               title = key
           }
           return title
       }
       
       // セルの数を返す。
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            // テーブルビューのセル数の設定する。
           switch section {
           case 0:
               return self.configMenu1.count
           case 1:
               return self.configMenu2.count
           default: return 0
           }
       }
    
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // セルにテキストを出力する。
           let cell = tableView.dequeueReusableCell(withIdentifier:  "configCell", for:indexPath as IndexPath)
           for (value) in sections[indexPath.section].values
           {
            cell.textLabel?.text = value[indexPath.row] as? String
            cell.textLabel?.font = UIFont.systemFont(ofSize:20)
           }
        
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
            
            
        case 0: switch indexPath.row {
            
        case 0: tableView.deselectRow(at: indexPath, animated: true)
            if MFMailComposeViewController.canSendMail() {
                 let mailViewController = MFMailComposeViewController()
                       mailViewController.mailComposeDelegate = self
                       mailViewController.setSubject("江ノ電ホーム 問い合わせ")
                       mailViewController.setToRecipients(["313kei@gmail.com"])
                       mailViewController.setMessageBody("登録したメールアドレス: \n\n問い合わせ内容", isHTML: false)
                       
                       present(mailViewController, animated: true, completion: nil)
            } else {
                 let alert = UIAlertController(title: "メール用のアカウントが設定されていません", message: nil, preferredStyle: .alert)
                 let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                 alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
            
            
            default: break
            }
            
        case 1: switch indexPath.row {
            
            // ログアウトを選択したとき
            case 0: tableView.deselectRow(at: indexPath, animated: true)
                let firebaseAuth = Auth.auth()
                let alert: UIAlertController = UIAlertController(title: "ログアウトしますか？", message: "Want to log out?", preferredStyle:  UIAlertController.Style.alert)
            
                // OKの場合
                let defaultAction: UIAlertAction = UIAlertAction(title: "ログアウト", style: UIAlertAction.Style.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    
                    do {
                        try firebaseAuth.signOut()
                        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "auth") as! authViewController
                        self.navigationController?.pushViewController(nextView, animated: true)
                        self.navigationController?.setNavigationBarHidden(true,animated: true)
                        print("ログアウトしました")
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                })
            
                //キャンセルの場合
                let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
              
                    (action: UIAlertAction!) -> Void in
                    print("ログアウトをキャンセルしました")
                })
                alert.addAction(defaultAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            
            
            // アカウント削除を選択したとき
            case 1: tableView.deselectRow(at: indexPath, animated: true)
            
                let deleteAlert: UIAlertController = UIAlertController(title: "アカウントを削除しますか？", message: "Want to delete your account?", preferredStyle:  UIAlertController.Style.alert)
            
            // OKの場合
                let defaultAction: UIAlertAction = UIAlertAction(title: "削除", style: UIAlertAction.Style.default, handler:{
                    (action: UIAlertAction!) -> Void in
                    do {
                        
                        Auth.auth().currentUser?.delete()
                        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "auth") as! authViewController
                        self.navigationController?.pushViewController(nextView, animated: true)
                        self.navigationController?.setNavigationBarHidden(true,animated: true)
                        print("アカウント削除しました")
                    }
                })
              //キャンセルの場合
                let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            
                    (action: UIAlertAction!) -> Void in
                    print("アカウント削除をキャンセルしました")
                })
                deleteAlert.addAction(defaultAction)
                deleteAlert.addAction(cancelAction)
                self.present(deleteAlert, animated: true, completion: nil)
                    
            
            default: break
            }
           
            
            
            
        default: break
        }
    }
   
    
     func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                    
                  switch result {
                  case .cancelled:
                    print("メールの送信キャンセル")
                  case .saved:
                    print("下書きに保存")
                  case .sent:
                    print("メール送信成功")
                  case .failed:
                    print("メール送信失敗")
                  default: return
                  }
                  dismiss(animated: true, completion: nil)
                }

}
