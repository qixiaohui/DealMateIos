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
    
    let categoryList: [String] = ["computers/laptops-ultrabooks",
                                  "computers/desktops",
                                  "computers/accessories-add-ons",
                                  "computers/monitors",
                                  "computers/networking-servers",
                                  "computers/software",
                                  "computers/printers",
                                  "electronics/hdtvs-home-theater",
                                  "electronics/cameras-camcorders",
                                  "electronics/speakers-headphones",
                                  "tablets-phones/accessories-apps",
                                  "tablets-phones/tablets",
                                  "tablets-phones/unlocked-phones",
                                  "gaming/games",
                                  "gaming/hardware",
                                  "lifestyle-home/accessories-watches",
                                  "lifestyle-home/automotive",
                                  "lifestyle-home/clothing-shoes",
                                  "lifestyle-home/entertainment",
                                  "lifestyle-home/gadgets-novelty",
                                  "lifestyle-home/health-fitness",
                                  "lifestyle-home/home-outdoors",
                                  "lifestyle-home/home-improvement-tools-garden"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CategoryList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.CategoryList.dataSource = self
        self.CategoryList.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "DealList", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = categoryList[indexPath.row].components(separatedBy: "/")[1]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destSeque = segue.destination as! DealListController
        destSeque.identifier = true
        destSeque.category = categoryList[currentIndex].components(separatedBy: "/")[0]
        destSeque.subCategory = categoryList[currentIndex].components(separatedBy: "/")[1]
    }
    
}
