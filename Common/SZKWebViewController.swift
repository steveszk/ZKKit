//
//  WHWebViewViewController.swift
//  client
//
//  Created by 盛子康 on 2021/4/28.
//
import WebKit

public class SZKWebViewController: UIViewController {
    
    public let webView = WKWebView()
    public let progress = UIProgressView()
    public var canload = false
    
    public var needHideBar = false
    public var webTitle:String?
    public var url:String?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    public func setupUI(){
        
        if !needHideBar{
            title = webTitle
        }
        
        webView.addTo(toSuperView: view).layout { (make) in
            make.edges.equalTo(view)
            }.config { (view) in
                if let urlStr = url,let link = URL(string: urlStr){
                    view.load(URLRequest(url: link))
                    view.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
                    canload = true
                }
        }
        
        progress.addTo(toSuperView: webView).layout { (make) in
            make.leading.trailing.top.equalTo(webView)
            make.height.equalTo(2)
            }.config { (view) in
                view.tintColor = SZKKitConfig.themeColor
                view.trackTintColor = .white
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progress.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progress.alpha = 0
                }, completion: { (finish) in
                    self.progress.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if needHideBar{
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
//        webView.configuration.userContentController.add(self, name: test)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if needHideBar{
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
//        webView.configuration.userContentController.removeScriptMessageHandler(forName: test)
    }
    
    deinit {
        if canload{
            webView.removeObserver(self, forKeyPath: "estimatedProgress")
        }
        LogInfo(message: "SZKWeb ViewController Release")
    }
}

//extension SZKWebViewController:WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate{
//
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if message.name == test{}
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript(test) { _, error in}
//    }
//}
