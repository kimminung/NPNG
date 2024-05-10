//
//  CollectionViewCell.swift
//  VideoApp1
//
//  Created by 민웅킴 on 5/10/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
    }
    
    func configureUI() {
        
    }
}
