//
//  SearchDealController.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/15/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class SearchDealController: UIViewController {
    
    
    @IBOutlet weak var SearchResultTable: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    var searchResult: [NSDictionary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResult.count
//    }
}
