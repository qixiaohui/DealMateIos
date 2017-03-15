//
//  DealListController.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/15/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import Foundation
import UIKit

class DealListController: UIViewController {
    var category: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
