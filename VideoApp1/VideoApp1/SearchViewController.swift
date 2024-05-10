//
//  SearchViewController.swift
//  VideoApp1
//
//  Created by 민웅킴 on 5/10/24.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "검색"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissSearch))
    }
    
    @objc func dismissSearch() {
        dismiss(animated: true, completion: nil)
    }
    
}
