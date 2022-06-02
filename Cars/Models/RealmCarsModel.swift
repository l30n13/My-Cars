//
//  RealmCarsModel.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 2/6/22.
//

import Foundation
import RealmSwift

class RealmCarsModel: Object, CarsData, Codable {
    @Persisted var id : Int?
    @Persisted var title : String?
    @Persisted var dateTime : String?
    @Persisted var ingress : String?
    @Persisted var image : String?
    @Persisted var imageData : Data?
    
    override init() {
        
    }
    init(_ id: Int?, _ title: String?, _ dateTime: String?, _ ingress: String?, _ image: String?, _ imageData: Data?) {
        self.id = id
        self.title = title
        self.dateTime = dateTime
        self.ingress = ingress
        self.image = image
        self.imageData = imageData
    }
}
