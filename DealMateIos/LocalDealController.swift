//
//  LocalDealController.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/16/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import MapKit

class LocalDealController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var locationManager: CLLocationManager? = nil
    var city: String = ""
    let getLocation = GetLocation()
    var localDeal: [NSDictionary] = []
    
    @IBOutlet weak var LocalDealTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self;
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        LocalDealTable.estimatedRowHeight = 266
        LocalDealTable.delegate = self
        LocalDealTable.dataSource = self
        LocalDealTable.register(LocalDealRow.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.city != "" {
            return
        }
        
        let location: CLLocation = locations[0]
        getLocation.getCity(location: location, completion: {result in
            if let city = result["City"] as? String {
                if self.city != city {
                    self.city = city
                    self.getLocalDeal()
                }
            }
        })
    }
    
    func getLocalDeal() {
        Alamofire.request("http://192.241.203.172:8000/local/\(self.city)", method: .get).validate().responseJSON { response in
            switch(response.result) {
            case .success:
                self.localDeal = response.result.value as! [NSDictionary]
                self.LocalDealTable.reloadData()
            case.failure(let error):
                print(error)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localDeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocalDealRow
            = Bundle.main.loadNibNamed("LocalDealRow",
                                       owner: self,
                                       options: nil)?.first
                as! LocalDealRow
        let item = localDeal[indexPath.row]
        let url = URL(string: (item["imagePath"] as? String)!)
        cell.DealTitle.text = item["overview"] as? String
        cell.DealStore.text = item["source"] as? String
        cell.DealOverview.text = item["title"] as? String
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if data != nil {
                    cell.DealImage?.image = UIImage(data: data!)
                }
            }
        }
        return cell
    }
}
