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
    var carsList = PublishSubject<[CarsViewModel]>()
    
    func fetchCarList() {
        IHProgressHUD.show()
        RequestManager.request(using: .ARTICLE_LIST, params: nil, type: .get) { [weak self] (response) in
            IHProgressHUD.dismiss()
            if let response = try? JSONDecoder().decode(CarsResponse.self, from: response), let data = response.content {
                self?.carsList.onNext(data.map(CarsViewModel.init))
                self?.saveIntoLocal(data: data)
            }
        } failure: { [weak self] (error) in
            IHProgressHUD.dismiss()
            switch error {
            case .noInternet:
                let banner = FloatingNotificationBanner(title: "No Internet!", subtitle: "Please make sure you are connected to the internet. Thank you!", titleFont: .SFUIText(.medium, size: 15), subtitleFont: .SFUIText(.regular, size: 15), style: .warning)
                banner.show()
                
                self?.loadFromLocal()
                break
            case .networkProblem:
                self?.loadFromLocal()
                break
            case .errorDescription(_):
                self?.loadFromLocal()
                break
            }
            DLog(error)
        }
    }
}

extension CarListViewModel {
    private func saveIntoLocal(data: [CarsModel]) {
        let realmData = data.map { RealmCarsModel($0.id, $0.title, $0.dateTime, $0.ingress, $0.image, $0.imageData) }
        RealmManager.addData(data: realmData)
    }
    private func loadFromLocal() {
        carsList.onNext(RealmManager.getLocalData().map(CarsViewModel.init))
    }
}
