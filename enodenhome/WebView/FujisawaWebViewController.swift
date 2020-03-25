//
//  FujisawaWebViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2019/12/19.
//  Copyright © 2019 滝浪翔太. All rights reserved.
//

import UIKit
import WebKit

class FujisawaWebViewController: UIViewController, WKUIDelegate {
    
    var FujisawaWeb: WKWebView!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        FujisawaWeb = WKWebView(frame: .zero, configuration: webConfiguration)
        FujisawaWeb.uiDelegate = self
        FujisawaWeb.navigationDelegate = self as? WKNavigationDelegate
        view = FujisawaWeb
        
        //スワイプで戻る設定
        FujisawaWeb.allowsBackForwardNavigationGestures = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        print("藤沢WEBページ表示")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

         let myURL = URL(string: "https://www.enoden.co.jp/train/station/fujisawa/")
               let myRequest = URLRequest(url: myURL!)
               FujisawaWeb.load(myRequest)
    }
    
    //様々なリンクを開けるようにする
    func webView(_ FujisawaWeb: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {


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
            FujisawaWeb.load(URLRequest(url: url))
            return nil
        }
        return nil
    }
    
}


extension FujisawaWebViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // webViewの履歴がなければnavigationControllerのスワイプジェスチャーを有効化
        return !FujisawaWeb.canGoBack
    }
}

