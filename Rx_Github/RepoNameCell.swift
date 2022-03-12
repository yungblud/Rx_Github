//
//  RepoNameCell.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import UIKit
import SnapKit

class RepoNameCell: UICollectionViewCell {
    fileprivate lazy var nameLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.backgroundColor = .white
        self.nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(name: String) {
        self.nameLabel.text = name
    }
}
