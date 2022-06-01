//
//  HomeController.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import UIKit
import SnapKit
import RxSwift

class HomeController: UIViewController {
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .greyish
        return view
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CarsTableViewCell.self, forCellReuseIdentifier: "CarsTableViewCell")        
        return tableView
    }()
    
    var viewModel = CarListViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cars"
        
        setupView()
        bindTableData()
        viewModel.fetchCarList()
    }
}

extension HomeController {
    fileprivate func setupView() {
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
            
        topView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    fileprivate func bindTableData() {
        viewModel.anotherCarList.bind(
            to: tableView.rx.items(
                cellIdentifier: "CarsTableViewCell",
                cellType: CarsTableViewCell.self)
        ) { (row, model, cell) in
//            cell.textLabel?.text = model.dateTime
            
            cell.loadData(data: model)
            
        }
    }
}
