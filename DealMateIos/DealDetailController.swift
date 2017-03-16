//
//  DealDetailController.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/15/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DealDetailController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var DealImage: UIImageView!
    @IBOutlet weak var DescriptionWeb: UIWebView!
    @IBOutlet weak var NavigationBar: UINavigationBar!
    @IBOutlet weak var DealTitle: UILabel!
    @IBOutlet weak var HeightConstrain: NSLayoutConstraint!
    
    var id: Int = 0
    var category: String = ""
    var titleText: String = ""
    var deal: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeal(id: id)
        self.DealTitle.text = titleText
        DescriptionWeb.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func getDeal(id: Int) {
        Alamofire.request("http://192.241.203.172:8000/detail/"+String(id), method: .get).validate().responseJSON { response in
            switch(response.result) {
            case .success:
                self.deal = response.result.value as! [String: Any]
                self.loadViewData()
            case.failure(let error):
                print(error)
            }
            
        }
    }
    
    func loadViewData() {
        let url = URL(string: (self.deal["mainPoster"] as? String)!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.DealImage?.image = UIImage(data: data!)
            }
        }
        let html = (self.deal["detailDescription"] as! String)
            .replacingOccurrences(of: "\\n", with: "")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "<a", with: "<p")
            .replacingOccurrences(of: "</a", with: "</p");
        let baseUrl = Bundle.main.bundleURL
        DescriptionWeb.loadHTMLString(html, baseURL: baseUrl)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.scrollView.isScrollEnabled=false;
        HeightConstrain.constant = webView.scrollView.contentSize.height
    }
}
