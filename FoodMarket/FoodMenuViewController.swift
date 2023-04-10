//
//  FoodMenuViewController.swift
//  FoodMarket
//
//  Created by Vyacheslav Usikov on 06.04.2023.
//

import Foundation
import UIKit

class FoodMenuViewController: UIViewController {
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Moscow", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var bannersCollectionView: UICollectionView = {
        let view = createCollectionView(layout: Self.createBannersLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.bannersCellIdentifier)
        
        return view
    }()
    
    lazy var categoriesCollectionView: UICollectionView = {
        let view = createCollectionView(layout: Self.createCategoriesLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.categoriesCellIdentifier)
        return view
    }()
    
    lazy var productsCollectionView: UICollectionView = {
        let view = createCollectionView(layout: Self.createProductsLayout())
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.productsCellIdentifier)
        return view
    }()
    
    lazy var contentStackView: UIStackView = {
        let arrangedSubviews = [bannersCollectionView, categoriesCollectionView, productsCollectionView]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        return stackView
    }()
    
    
    var contentTopConstraint: NSLayoutConstraint!
    
    init (){
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    //MARK: - View live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
    }
    
    //MARK: - Private Func
    
    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    private func setupHierarchy() {
        view.addSubview(contentStackView)
        view.addSubview(headerView)
        headerView.addSubview(cityButton)
        
    }
    
    private func setupLayout() {
        contentTopConstraint = contentStackView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constant.headerHeight)
        
        contentTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            cityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            cityButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            cityButton.heightAnchor.constraint(equalToConstant: Constant.headerHeight),
            
            contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            bannersCollectionView.heightAnchor.constraint(equalToConstant: Constant.bannersHeight),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: Constant.categoriesHeight)
        ])
    }
    
    private func setupView() {
        view.backgroundColor = .darkGray
        title = "Hello world"
    }
    
    private func createCollectionView(layout: UICollectionViewLayout) ->
    UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
}


//MARK: - Extension

extension FoodMenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannersCollectionView:
            return 8
        case categoriesCollectionView:
            return 8
        case productsCollectionView:
            return 8
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let color = [UIColor.red, .blue, .green]
        
        switch collectionView {
        case bannersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.bannersCellIdentifier, for: indexPath)
            cell.backgroundColor = color[indexPath.row % color.count]
            return cell
        case categoriesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.categoriesCellIdentifier, for: indexPath)
            cell.backgroundColor = color[indexPath.row % color.count]
            return cell
        case productsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.productsCellIdentifier, for: indexPath)
            cell.backgroundColor = color[indexPath.row % color.count]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

extension FoodMenuViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView === productsCollectionView else { return }
        let offset = scrollView.contentOffset.y
        if offset > Constant.bannersHeight {
            contentTopConstraint.constant = Constant.headerHeight - Constant.bannersHeight
            
        } else if offset < 0 {
            
            print(offset)
            contentTopConstraint.constant = Constant.headerHeight
        } else {
            
            print(offset)
            contentTopConstraint.constant = Constant.headerHeight - offset
        }
    }
    
}


extension FoodMenuViewController {
    static func createBannersLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 16, height: Constant.bannersHeight)
        return layout
    }
    
    static func createCategoriesLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 128, height: Constant.categoriesHeight)
        return layout
    }
    
    static func createProductsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width , height: 128)
        return layout
    }
}

private extension FoodMenuViewController {
    enum Constant {
        static let headerHeight: CGFloat = 64
        static let bannersHeight: CGFloat = 128
        static let categoriesHeight: CGFloat = 64
        static let bannersCellIdentifier = "banners.cell"
        static let categoriesCellIdentifier = "categories.cell"
        static let productsCellIdentifier = "products.cell"
    }
    
    
}
