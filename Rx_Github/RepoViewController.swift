//
//  RepoViewController.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/12.
//

import UIKit

class RepoViewController: UIViewController {
    fileprivate let repoFulleName: String
    init(repoFullName: String) {
        self.repoFulleName = repoFullName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
