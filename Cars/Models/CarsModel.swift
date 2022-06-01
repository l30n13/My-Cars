//
//  CarsModel.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import Foundation

struct CarsResponse : Codable {
    var status : String?
    var content : [CarsModel]?
    var serverTime : Int?
}

struct CarsModel : Codable {
    var id : Int?
    var title : String?
    var dateTime : String?
    var tags : [String]?
    var content : [CarsDetailsModel]?
    var ingress : String?
    var image : String?
    var created : Int?
    var changed : Int?
}


struct CarsDetailsModel : Codable {
    var type : String?
    var subject : String?
    var description : String?
}
