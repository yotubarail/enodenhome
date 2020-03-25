//
//  YanagikoujiWebViewController.swift
//  enodenhome
//
//  Created by 滝浪翔太 on 2020/01/09.
//  Copyright © 2020 滝浪翔太. All rights reserved.
//

import UIKit
import WebKit

class YanagikoujiWebViewController: UIViewController,WKUIDelegate {

    var YanagikoujiWeb: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        YanagikoujiWeb = WKWebView(frame: .zero, configuration: webConfiguration)
        YanagikoujiWeb.uiDelegate = self
        YanagikoujiWeb.navigationDelegate = self as? WKNavigationDelegate
        view = YanagikoujiWeb
        
        //スワイプで戻る設定
        YanagikoujiWeb.allowsBackForwardNavigationGestures = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        print("柳小路WEBページ表示")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.enoden.co.jp/train/station/yanagikoji/")
        let myRequest = URLRequest(url: myURL!)
        YanagikoujiWeb.load(myRequest)

        
    }
    
    //様々なリンクを開けるようにする
    func webView(_ YanagikoujiWeb: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {


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
            YanagikoujiWeb.load(URLRequest(url: url))
            return nil
        }
        return nil
    }

    

}

extension YanagikoujiWebViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // webViewの履歴がなければnavigationControllerのスワイプジェスチャーを有効化
        return !YanagikoujiWeb.canGoBack
    }
}
