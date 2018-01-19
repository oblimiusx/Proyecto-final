//
//  ViewControllerEvidence.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 11/22/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit
import WebKit
class ViewControllerEvidence: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webViewFrame: WKWebView!
    var webView: WKWebView!

    /*
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webViewFrame = webView
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var myUrl: URL
        
        let evidenceOne = "http://www.lanacion.com.ar/2058518-cada-vez-mas-universidades-publicas-instalan-banos-mixtos"
        let evidenceTwo = "http://www.bbc.com/mundo/noticias/2011/07/110718_suecia_preescolar_genero_neutro_amab.shtml"
        let evidenceThree = "http://www.perspectivasur.com/3/66794-se-inaugur-la-primera-escuela-pblica-del-pas-con-baos-mixtos"
        
        if self.webViewFrame.tag == 0 {
            myUrl = URL(string: evidenceOne)!
        } else if self.webViewFrame.tag == 1 {
            myUrl = URL(string: evidenceTwo)!
        } else {
            myUrl = URL(string: evidenceThree)!
        }
        
        let myRequest = URLRequest(url: myUrl)
        webViewFrame.load(myRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
