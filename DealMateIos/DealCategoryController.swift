//
//  DealCategoryController.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/15/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import Foundation
import UIKit

class DealCategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var CategoryList: UITableView!
    
    var currentIndex: Int = 0
    
    let categoryList: [String] = ["laptops-ultrabooks",
                                  "desktops",
                                  "accessories-add-ons",
                                  "monitors", "" +
                                  "networking-servers",
                                  "software",
                                  "printers",
                                  "hdtvs-home-theater",
                                  "cameras-camcorders",
                                  "speakers-headphones",
                                  "accessories-apps",
                                  "tablets",
                                  "unlocked-phones",
                                  "games",
                                  "hardware",
                                  "accessories-watches",
                                  "automotive",
                                  "clothing-shoes",
                                  "entertainment",
                                  "gadgets-novelty",
                                  "health-fitness",
                                  "home-outdoors",
                                  "home-improvement-tools-garden"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CategoryList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationController?.isNavigationBarHidden = true
        self.CategoryList.dataSource = self
        self.CategoryList.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "DealList", sender: nil)
        print(indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = categoryList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destSeque = segue.destination as! DealListController
        destSeque.category = categoryList[currentIndex]
    }
    
}
