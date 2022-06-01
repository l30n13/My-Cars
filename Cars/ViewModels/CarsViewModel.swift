//
//  CarsViewModel.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import Foundation

struct CarsViewModel {
    var carData: CarsModel
    
    init(carData: CarsModel) {
        self.carData = carData
    }
    
    var carImage: String {
        carData.image ?? ""
    }
    var title: String {
        carData.title ?? ""
    }
    var dateTime: String {
        let fromDateFormat = DateFormatter()
        fromDateFormat.dateFormat = "dd.MM.yyyy HH:mm"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd MMM\(isInCurrentYear ? "" : " yyyy"), \(deviceTimeFormat == .twelveHour ? "hh:mm a": "HH:mm")"
        
        if let fromDate = fromDateFormat.date(from: carData.dateTime ?? "") {
            return dateFormat.string(from: fromDate)
        } else {
            return ""
        }
    }
    var details: String {
        carData.ingress ?? ""
    }
}

extension CarsViewModel {
    fileprivate enum TimeFormat {
        case twelveHour
        case twentyFourHour
    }
    
    fileprivate var deviceTimeFormat: TimeFormat {
        let locale = NSLocale.current
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if formatter.contains("a") {
            //phone is set to 12 hours
            return .twelveHour
        } else {
            //phone is set to 24 hours
            return .twentyFourHour
        }
    }
    
    fileprivate var isInCurrentYear: Bool {
        let currentDate = Calendar.current
        let fromDateFormat = DateFormatter()
        fromDateFormat.dateFormat = "dd.MM.yyyy HH:mm"
        let fromDate = fromDateFormat.date(from: carData.dateTime ?? "")!
        
        return currentDate.isDate(fromDate, equalTo: Date(), toGranularity: .year)
    }
}
