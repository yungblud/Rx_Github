//
//  RepoBasicInformationCell.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import UIKit
import SnapKit

class RepoBasicInformationCell: UICollectionViewCell {
    fileprivate lazy var repoNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    fileprivate lazy var isModified: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(repoNameLabel)
        
        self.repoNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(basicInformation: GithubRepositoryBasicInformation) {
        self.repoNameLabel.text = "\(basicInformation.name)(\(basicInformation.full_name))"
        self.repoNameLabel.font = .systemFont(ofSize: 25, weight: .bold)
    }
}
