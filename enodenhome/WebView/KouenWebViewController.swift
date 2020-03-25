//
//  KouenWebViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2020/01/09.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//

import UIKit
import WebKit

class KouenWebViewController: UIViewController, WKUIDelegate {

    var KouenWeb: WKWebView!

        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            KouenWeb = WKWebView(frame: .zero, configuration: webConfiguration)
            KouenWeb.uiDelegate = self
            KouenWeb.navigationDelegate = self as? WKNavigationDelegate
            view = KouenWeb
            
            //スワイプで戻る設定
            KouenWeb.allowsBackForwardNavigationGestures = true
            navigationController?.interactivePopGestureRecognizer?.delegate = self
            
            print("湘南海岸公園WEBページ表示")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

             let myURL =
                URL(string: "https://www.enoden.co.jp/train/station/shonankaigankoen/")
                   let myRequest = URLRequest(url: myURL!)
                   KouenWeb.load(myRequest)
        }
        
        //様々なリンクを開けるようにする
        func webView(_ KouenWeb: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {


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
                KouenWeb.load(URLRequest(url: url))
                return nil
            }
            return nil
        }
        
    }


    extension KouenWebViewController: UIGestureRecognizerDelegate {
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            // webViewの履歴がなければnavigationControllerのスワイプジェスチャーを有効化
            return !KouenWeb.canGoBack
        }
    }
