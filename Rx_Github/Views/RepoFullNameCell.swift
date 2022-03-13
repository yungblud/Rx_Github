//
//  RepoFullNameCell.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import UIKit

class RepoFullNameCell: UICollectionViewCell {
    fileprivate let fullNameLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.addSubview(self.fullNameLabel)
        self.fullNameLabel.backgroundColor = .white
        self.fullNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(fullName: String) {
        self.fullNameLabel.text = fullName
    }
}
