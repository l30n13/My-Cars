//
//  CarListViewModel.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import Foundation
import RxSwift
import RxCocoa
import NotificationBannerSwift
import IHProgressHUD

class CarListViewModel {
    var anotherCarList = PublishSubject<[CarsViewModel]>()
    var carsList = BehaviorSubject(value: [CarsViewModel]())
    var isNoInternet = PublishSubject<Bool>()
    
    func fetchCarList() {
        IHProgressHUD.show()
        RequestManager.request(using: .ARTICLE_LIST, params: nil, type: .get) { [weak self] (response) in
            IHProgressHUD.dismiss()
            if let response = try? JSONDecoder().decode(CarsResponse.self, from: response), let data = response.content {
                self?.carsList.onNext(data.map(CarsViewModel.init))
                self?.anotherCarList.onNext(data.map(CarsViewModel.init))
            }
        } failure: { (error) in
            IHProgressHUD.dismiss()
            switch error {
            case .noInternet:
                let banner = FloatingNotificationBanner(title: "No Internet!", subtitle: "Please make sure you are connected to the internet. Thank you!", titleFont: .SFUIText(.medium, size: 15), subtitleFont: .SFUIText(.regular, size: 15), style: .warning)
                banner.show()
                break
            case .networkProblem:
                break
            case .errorDescription(_):
                break
            }
            DLog(error)
        }
    }
}
