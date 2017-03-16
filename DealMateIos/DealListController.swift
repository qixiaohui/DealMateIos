//
//  DealListController.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/15/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class DealListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var DealListTableView: UITableView!
    
    // false mean come from search
    // true mean come from deal list
    var identifier: Bool = false
    var category: String = ""
    var subCategory: String = ""
    var searchString: String = ""
    var dealList: [NSDictionary] = []
    
    var rowIndex: Int = 0
    
    let baseUrl: String = "http://192.241.203.172:8000/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DealListTableView.delegate = self
        self.DealListTableView.dataSource = self
        self.DealListTableView.rowHeight = UITableViewAutomaticDimension
        self.DealListTableView.estimatedRowHeight = 275
        self.DealListTableView.register(DealListRowTableViewCell.self, forCellReuseIdentifier: "cell")
        if(identifier == true) {
            self.getDeal()
        } else {
            self.searchDeal()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowIndex = indexPath.row
        performSegue(withIdentifier: "DealDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DealListRowTableViewCell
            = Bundle.main.loadNibNamed("DealListRowTableViewCell",
                                       owner: self,
                                       options: nil)?.first
                as! DealListRowTableViewCell
        let deal = dealList[indexPath.row]
        let url = URL(string: (deal["imagePath"] as? String)!)
        let title = deal["title"] as? String
        var shipping: String = ""
        let currentPrice = deal["price"] as? String
        let originalPrice = deal["listPrice"] as? String
        if((deal["shipping"] as? String) == "FREE SHIPPING") {
            shipping = (deal["shipping"] as? String)!
        }
        let overview = deal["overview"] as? String
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.DealImage?.image = UIImage(data: data!)
            }
        }
        cell.DealTitle?.text = title
        cell.FreeShippingLabel?.text = shipping
        cell.OverviewLabel?.text = overview
        cell.OriginalPrice?.text = "list price "+originalPrice!
        cell.CurrentPrice?.text = currentPrice
        return cell
    }
    
    func getDeal() {
        var url: String = ""
        url = self.baseUrl + "deals/\(category)/\(subCategory)"
        ajax(url: url)
    }
    
    func searchDeal() {
        var url: String = ""
        url = self.baseUrl + "search?content=\(searchString)"
        ajax(url: url)
    }
    
    func ajax(url: String) {
        Alamofire.request(url, method: .get).validate().responseJSON { reponse in
            switch(reponse.result) {
            case .success:
                self.dealList = reponse.result.value as! [NSDictionary]
                self.DealListTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destSegue = segue.destination as! DealDetailController
        if(dealList.count > 0) {
            destSegue.id = dealList[rowIndex]["id"] as! Int
            destSegue.titleText = dealList[rowIndex]["title"] as! String
        } else {
            destSegue.id = 1;
        }
    }
}
