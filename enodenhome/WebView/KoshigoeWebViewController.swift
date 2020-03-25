//
//  KoshigoeWebViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2020/01/09.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//

import UIKit
import WebKit

class KoshigoeWebViewController: UIViewController, WKUIDelegate {

    var KoshigoeWeb: WKWebView!

        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            KoshigoeWeb = WKWebView(frame: .zero, configuration: webConfiguration)
            KoshigoeWeb.uiDelegate = self
            KoshigoeWeb.navigationDelegate = self as? WKNavigationDelegate
            view = KoshigoeWeb
            
            //スワイプで戻る設定
            KoshigoeWeb.allowsBackForwardNavigationGestures = true
            navigationController?.interactivePopGestureRecognizer?.delegate = self
            
            print("腰越WEBページ表示")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

             let myURL = URL(string: "https://www.enoden.co.jp/train/station/koshigoe/")
                   let myRequest = URLRequest(url: myURL!)
                   KoshigoeWeb.load(myRequest)
        }
        
        //様々なリンクを開けるようにする
        func webView(_ KoshigoeWeb: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {


            guard let url = navigationAction.request.url else {
                return nil
            }

            if url.absoluteString.range(of: "//itunes.apple.com/") != nil {
                if UIApplication.shared.responds(to: #selector(UIApplication.open(_:options:completionHandler:))) {
                    UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false], completionHandler: { (finished: Bool) in

                    })
                } else {
                    UIApplication.shared.open(url)
                    return nil
                }
            } else if !url.absoluteString.hasPrefix("http://") && !url.absoluteString.hasPrefix("https://") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                    return nil
                }
            }

            // target="_blank"のリンクを開く
            guard let targetFrame = navigationAction.targetFrame, targetFrame.isMainFrame else {
                KoshigoeWeb.load(URLRequest(url: url))
                return nil
            }
            return nil
        }
        
    }


    extension KoshigoeWebViewController: UIGestureRecognizerDelegate {
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            // webViewの履歴がなければnavigationControllerのスワイプジェスチャーを有効化
            return !KoshigoeWeb.canGoBack
        }
    }

