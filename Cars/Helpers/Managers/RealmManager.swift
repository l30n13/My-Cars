//
//  RealmManager.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 2/6/22.
//

import Foundation
import RealmSwift

struct RealmManager {
    
    static func addData(data: [RealmCarsModel]) {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        data.forEach { data in
            if realm.objects(RealmCarsModel.self).filter("id = \(data.id ?? 0)").count == 0 {
                try! realm.write{
                    realm.add(data)
                }
            }
        }
    }
    
    static func getLocalData() -> [RealmCarsModel] {
        let realm = try! Realm()
        return realm.objects(RealmCarsModel.self).map{ RealmCarsModel($0.id, $0.title, $0.dateTime, $0.ingress, $0.image, $0.imageData) }
    }
}
