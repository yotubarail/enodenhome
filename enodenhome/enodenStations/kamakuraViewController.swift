//
//  kamakuraViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2019/05/23.
//  Copyright © 2019 滝浪翔太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class kamakuraViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let imagePick = UIImagePickerController()
    
    let user = Auth.auth().currentUser
    
    
    @IBOutlet weak var kamakuraImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationItemにタイトルを表示
        self.navigationItem.title = "鎌倉 EN15"
        
        imagePick.delegate = self

        let storage = Storage.storage()
        let reference = storage.reference(forURL: "gs://XXX.appspot.com")
        let child = reference.child("KamakuraImages/" + user!.uid + "/"+"kamakura.jpg")
//        child.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if error != nil {
//            } else {
//                self.kamakuraImage.image = UIImage(data: data!)
//            }
//        }
        kamakuraImage.sd_setImage(with: child)

    }
    
    @IBAction func changeImage(_ sender: Any) {
        imagePick.sourceType = .photoLibrary
        imagePick.modalPresentationStyle = .fullScreen
        present(imagePick, animated: true, completion: nil)
    }
    
    
    // カメラロールから写真を選ぶ
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.originalImage] as? UIImage {
            self.kamakuraImage.contentMode = .scaleAspectFit
            self.kamakuraImage.image = pickedImage
        }
        
        //保存のアラートを出す
        let alert: UIAlertController = UIAlertController(title: "保存しますか？", message: "Want to save?", preferredStyle:  UIAlertController.Style.alert)

        // OKの場合
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            self.upload()
            SDImageCache.shared.clearMemory()
            SDImageCache.shared.clearDisk()
        })
        
        //キャンセルの場合
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
          
            (action: UIAlertAction!) -> Void in
            print("選択をキャンセルしました")
            self.loadView()
        })


        alert.addAction(defaultAction)
        alert.addAction(cancelAction)


        self.present(alert, animated: true, completion: nil)
    }
    
    // Firebaseにアップロード
    fileprivate func upload() {
     
     let storageRef = Storage.storage().reference(forURL: "gs://enodenhome.appspot.com").child("KamakuraImages/" + user!.uid + "/"+"kamakura.jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = self.kamakuraImage.image?.jpegData(compressionQuality: 0.3) {
            storageRef.putData(uploadData, metadata: metaData) { (metadata , error) in
                if error != nil {
                    print("error: \(error!.localizedDescription)")
                 return
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print("error: \(error!.localizedDescription)")
                    }
                    print("url: \(url!.absoluteString)")
                 
                })
            }
        }
    }
    
    
    
    // 写真を選ぶのをキャンセル
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("キャンセルされました")
    }
    

    @IBAction func tapKamakuraWeb(_ sender: Any) {
        let nextView = storyboard?.instantiateViewController(withIdentifier: "KamakuraWebChoose") as! KamakuraWebViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
   

}
