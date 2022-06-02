//
//  CarsTableViewCell.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import UIKit
import SnapKit
import SDWebImage

class CarsTableViewCell: UITableViewCell {
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.sd_imageTransition = .fade
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .SFUIText(.medium, size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .SFUIText(.regular, size: 13)
        label.textColor = .greyish
        label.numberOfLines = 0
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .SFUIText(.medium, size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func prepareForReuse() {
        image.image = nil
        titleLabel.text = nil
        timeLabel.text = nil
        detailsLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarsTableViewCell {
    private func setupUI() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0).priority(.medium)
            make.height.equalTo(346)
        }
        image.addSubview(activityIndicator)
        (activityIndicator).snp.makeConstraints { make in
            make.top.equalTo(image.snp.top)
            make.leading.equalTo(image.snp.leading)
            make.trailing.equalTo(image.snp.trailing)
            make.bottom.equalTo(image.snp.bottom)
        }
        
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(446).priority(.low)
        }
        
        mainView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(252)
            make.leading.equalTo(mainView.snp.leading).offset(16)
            make.trailing.equalTo(mainView.snp.trailing).offset(-42)
        }
        mainView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        mainView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(18)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalTo(mainView.snp.bottom).offset(-16)
        }
        
        contentView.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top).offset(-20)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.black!.withAlphaComponent(0.0).cgColor, UIColor.black!.cgColor, UIColor.black!.cgColor, UIColor.black!.cgColor]
            gradientLayer.frame = self.gradientView.bounds
            self.gradientView.layer.addSublayer(gradientLayer)
        }
        
        contentView.bringSubviewToFront(mainView)
    }
}

extension CarsTableViewCell {
    func loadData(data: CarsViewModel) {
        image.sd_setImage(with: URL(string: data.carImage), completed: { [weak self] (image, error, cacheType, url) in
            if error == nil {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        })
        
        titleLabel.text = data.title
        timeLabel.text = data.dateTime
        detailsLabel.text = data.details
    }
}
