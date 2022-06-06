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
    private let refreshControl = UIRefreshControl()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .greyishBrownTwo
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.refreshControl = refreshControl
        tableView.register(CarsTableViewCell.self, forCellReuseIdentifier: "CarsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        label.textColor = UIColor.black
        label.font = .SFUIText(.medium, size: 20)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "No Data Found"
        return label
    }()
    
    private var viewModel = CarListViewModel()
    private var carList: [CarsViewModel] = []
    
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
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
        viewModel.carsList.bind { [weak self] (data) in
            self?.carList = data
            self?.tableView.reloadData()
            
            self?.refreshControl.endRefreshing()
            if data.count > 0 {
                self?.tableView.backgroundView        = nil
            } else {
                self?.tableView.backgroundView        = self?.emptyLabel
                self?.tableView.separatorStyle        = .none
            }
        }.disposed(by: bag)
        
        //MARK: Commented this tableview load data using RxSwift because it is making the tableview laggy
//        viewModel.carsList.bind(
//            to: tableView.rx.items(
//                cellIdentifier: "CarsTableViewCell",
//                cellType: CarsTableViewCell.self)
//        ) { [weak self] (row, model, cell) in
//            self?.refreshControl.endRefreshing()
//            cell.loadData(data: model)
//        }.disposed(by: bag)
    }
}

extension HomeController {
    @objc private func refreshTableView(_ sender: Any) {
        viewModel.fetchCarList()
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarsTableViewCell", for: indexPath) as! CarsTableViewCell
        cell.loadData(data: carList[indexPath.row])
        return cell
    }
}
