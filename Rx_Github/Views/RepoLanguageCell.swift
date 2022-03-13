//
//  RepoLanguageCell.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/14.
//

import UIKit

class RepoLanguageCell: UICollectionViewCell {
    fileprivate lazy var countsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.countsLabel)
        self.countsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(language: String) {
        self.countsLabel.text = "🔠 \(language)"
        self.countsLabel.font = .systemFont(ofSize: 13, weight: .semibold)
    }
}
