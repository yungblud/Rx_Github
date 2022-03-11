//
//  ViewController.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/11.
//

import UIKit

import RxCocoa
import RxSwift

class ViewController: UIViewController {
    fileprivate let searchBar = UISearchBar()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationItem.titleView = self.searchBar
        self.searchBar.placeholder = "Search"
        
        self.bind()
    }

    func bind() {
        self.searchBar.rx.text.changed
            .throttle(.milliseconds(3000), scheduler: MainScheduler.instance)
            .debug()
            .subscribe { [weak self] input in
                guard let `self` = self else { return }
                guard let inputElement = input.element else { return }
                guard let value = inputElement else { return }
                print(value)
            }
            .disposed(by: self.disposeBag)
    }
}

