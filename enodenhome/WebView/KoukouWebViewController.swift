//
//  KoukouWebViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2020/01/09.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//

import UIKit
import WebKit

class KoukouWebViewController: UIViewController, WKUIDelegate {

    var KoukouWeb: WKWebView!

        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            KoukouWeb = WKWebView(frame: .zero, configuration: webConfiguration)
            KoukouWeb.uiDelegate = self
            KoukouWeb.navigationDelegate = self as? WKNavigationDelegate
            view = KoukouWeb
            
            //スワイプで戻る設定
            KoukouWeb.allowsBackForwardNavigationGestures = true
            navigationController?.interactivePopGestureRecognizer?.delegate = self
            
            print("鎌倉高校前WEBページ表示")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

             let myURL = URL(string: "https://www.enoden.co.jp/train/station/kamakurakokomae/")
                   let myRequest = URLRequest(url: myURL!)
                   KoukouWeb.load(myRequest)
        }
        
        //様々なリンクを開けるようにする
        func webView(_ KoukouWeb: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {


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
                KoukouWeb.load(URLRequest(url: url))
                return nil
            }
            return nil
        }
        
    }


    extension KoukouWebViewController: UIGestureRecognizerDelegate {
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            // webViewの履歴がなければnavigationControllerのスワイプジェスチャーを有効化
            return !KoukouWeb.canGoBack
        }
    }


