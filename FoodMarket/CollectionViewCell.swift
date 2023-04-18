//
//  CollectionViewCell.swift
//  FoodMarket
//
//  Created by Vyacheslav Usikov on 15.04.2023.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
   static let identifier = "banners.cell"
    
    lazy var myImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    lazy var myLabelName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        contentView.addSubview(myLabelName)
        contentView.addSubview(myImageView)
    }
    func setupConstraints() {
        
        
        
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            myLabelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ),
            myLabelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myLabelName.topAnchor.constraint(equalTo: myImageView.bottomAnchor),
            myLabelName.heightAnchor.constraint(equalToConstant: 16),
            myLabelName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
