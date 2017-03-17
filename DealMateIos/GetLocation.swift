//
//  GetLocation.swift
//  DealMateIos
//
//  Created by qixiaohui on 3/16/17.
//  Copyright © 2017 qixiaohui. All rights reserved.
//

import Foundation
import MapKit

struct Typealiases {
    typealias JSONDict = [String:Any]
}

class GetLocation {
    func getCity(location: CLLocation, completion: @escaping (Typealiases.JSONDict) -> ()) {
        let geoCoder  = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placeMarks, error) -> Void in
            if error != nil {
                print(error)
            } else {
                let placeArray = placeMarks as [CLPlacemark]!
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                completion(placeMark.addressDictionary as! Typealiases.JSONDict)
            }
        })
    }
}
