//
//  ViewController.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/11.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationItem.titleView = self.searchBar
        self.searchBar.placeholder = "Search"
    }


}

