//
//  DefaultCollectionViewCell.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import UIKit

class DefaultCollectionViewCell: UICollectionViewCell {
    fileprivate lazy var isModified: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
