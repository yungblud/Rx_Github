//
//  FixedBottomButton.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/14.
//

import UIKit

class FixedBottomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("View it on github", for: .normal)
        self.backgroundColor = UIColor.init(rgb: 0x4c6ef5)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = UIColor.init(rgb: 0x4263eb)
            } else {
                self.backgroundColor = UIColor.init(rgb: 0x4c6ef5)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
