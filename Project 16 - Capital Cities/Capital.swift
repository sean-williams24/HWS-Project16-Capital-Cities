//
//  Capital.swift
//  Project 16 - Capital Cities
//
//  Created by Sean Williams on 24/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    
}
