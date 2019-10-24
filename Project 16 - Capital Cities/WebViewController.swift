//
//  WebViewController.swift
//  Project 16 - Capital Cities
//
//  Created by Sean Williams on 24/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var capitalCity: String!
    
    @IBOutlet var webView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var capital = capitalCity {
            if capital == "Washington DC" {
                capital = "Washington,_D.C."
            }
            let urlString = "https://en.wikipedia.org/wiki/\(capital)"
            if let url = URL(string: urlString) {
                let urlRequest = URLRequest(url: url)
                webView.load(urlRequest)
            }
        }


    

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
