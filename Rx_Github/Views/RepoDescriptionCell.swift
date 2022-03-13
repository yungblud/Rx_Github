//
//  RepoDescriptionCell.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/14.
//

import UIKit
import SnapKit

class RepoDescriptionCell: UICollectionViewCell {
    public lazy var repoDescpriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(repoDescpriptionLabel)
        
        self.repoDescpriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(description: String) {
        self.repoDescpriptionLabel.text = description
        self.repoDescpriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
    }
}
