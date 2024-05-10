//
//  ViewController.swift
//  VideoApp1
//
//  Created by 민웅킴 on 5/9/24.
//

import UIKit
import SnapKit

class ViewController: ManageVC {
    
    let searchBar = UISearchBar()
    let lookedBook = UILabel()
    
    let collectionViewflowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewflowLayout)
    
    let resultOfSearching = UILabel()
    let tableView = UITableView()
    let tab = UITabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBarController?.delegate = self
        
        setupConstraints()
        configureUI()
        tapbar()
    }
    
    override func tapbar() {
        
        let searchTabBarItem = UITabBarItem(title: "검색", image: nil, selectedImage: nil)
        let searchVC = SearchViewController()
        searchVC.tabBarItem = searchTabBarItem
        searchTabBarItem.tag = 1
        
        let cartBookVC = CartViewController()
        let cartBookNavigationController = UINavigationController(rootViewController: cartBookVC)
        cartBookNavigationController.tabBarItem = UITabBarItem(title: "담긴 책",image: nil, selectedImage: nil)
        
//        viewControllers = [searchVC, cartBookNavigationController]
//        searchTabBarItem.action = #selector(openSearchVC)
        self.viewControllers = [cartBookNavigationController]
    }
    
    @objc func openSearchVC(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1{
            let searchVC = SearchViewController()
            let searchNavigationController = UINavigationController(rootViewController: searchVC)
            present(searchNavigationController, animated: true, completion: nil)
        }
    }
    
    override func setupConstraints() {
        view.addSubview(collectionView)
        [searchBar, lookedBook, collectionView, resultOfSearching, tableView].forEach {
            view.addSubview($0)
        }
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
//        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
//        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.left.right.equalToSuperview().inset(10)
//            $0.top.left.right.equalTo(additionalSafeAreaInsets).inset(10)
            $0.height.equalTo(30)
        }
//        
//        lookedBook.translatesAutoresizingMaskIntoConstraints = false
//        lookedBook.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
//        lookedBook.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
//        lookedBook.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        lookedBook.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(lookedBook.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    override func configureUI() {
        lookedBook.text = "최근 본 책"
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {return UICollectionViewCell() }
        
        cell.configureUI()
        
        return cell
    }
    
    
}
