//
//  WebViewController.swift
//  Example
//
//  Created by y.marui on 2020/10/18.
//

import UIKit
import WebKit
import TDTabView

class WebViewController: TDTabChildViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: "https://www.apple.com")!)
        webView.load(request)
    }
    
    @IBAction func didTapRightButton(_ sender: Any) {
        exitFullScreen()
    }
}
