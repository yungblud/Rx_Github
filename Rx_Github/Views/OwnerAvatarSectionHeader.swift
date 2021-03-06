//
//  OwnerAvatarSectionHeader.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import UIKit
import SnapKit

class OwnerAvatarSectionHeader: UICollectionReusableView {
    fileprivate lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(avatarURL: String) {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        DispatchQueue.global().async { [weak self] in
            guard let `self` = self else { return }
            let imageURL = URL(string: avatarURL)!
            guard let data = try? Data(contentsOf: imageURL) else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
}
