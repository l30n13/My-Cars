//
//  CarsData.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 2/6/22.
//

import Foundation

protocol CarsData {
    var id : Int? { get set }
    var title : String? { get set }
    var dateTime : String? { get set }
    var ingress : String? { get set }
    var image : String? { get set }
    var imageData : Data? { get set }
}
