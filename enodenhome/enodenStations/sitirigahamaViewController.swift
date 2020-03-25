//
//  sitirigahamaViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2019/05/23.
//  Copyright © 2019 滝浪翔太. All rights reserved.
//

import UIKit
import Firebase

class sitirigahamaViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let imagePick = UIImagePickerController()
    
    let user = Auth.auth().currentUser

    @IBOutlet weak var sitirigahamaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "七里ヶ浜(Shichirigahama)EN09"
        
        imagePick.delegate = self

        let storage = Storage.storage()
        let reference = storage.reference(forURL: "gs://enodenhome.appspot.com")
        let child = reference.child("SitirigahamaImages/" + user!.uid + "/"+"sitirigahama.jpg")
        child.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
            } else {
                self.sitirigahamaImage.image = UIImage(data: data!)
            }
        }

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
            self.sitirigahamaImage.contentMode = .scaleAspectFit
            self.sitirigahamaImage.image = pickedImage
        }
        
        //保存のアラートを出す
        let alert: UIAlertController = UIAlertController(title: "保存しますか？", message: "Want to save?", preferredStyle:  UIAlertController.Style.alert)

        // OKの場合
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            
            (action: UIAlertAction!) -> Void in
            print("OK")
            
            self.upload()
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
     
     let storageRef = Storage.storage().reference(forURL: "gs://enodenhome.appspot.com").child("SitirigahamaImages/" + user!.uid + "/"+"sitirigahama.jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = self.sitirigahamaImage.image?.jpegData(compressionQuality: 0.3) {
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
    

    @IBAction func tapSitirigahamaWeb(_ sender: Any) {
        let nextView = storyboard?.instantiateViewController(withIdentifier: "SitirigahamaWebChoose") as! SitirigahamaWebViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }


}
