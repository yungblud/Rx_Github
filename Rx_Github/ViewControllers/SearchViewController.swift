//
//  ViewController.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/11.
//

import UIKit

import RxCocoa
import RxSwift

class SearchViewController: UIViewController {
    fileprivate let githubService: GithubService
    fileprivate var disposeBag = DisposeBag()
    
    fileprivate let searchBar = UISearchBar()
    fileprivate let tableView = UITableView()
    
    init(githubService: GithubService) {
        self.githubService = githubService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationItem.titleView = self.searchBar
        self.searchBar.placeholder = "Search"
        
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        self.bind()
    }

    func bind() {
        self.searchBar.rx.text.changed
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .debug()
            .flatMapLatest({ [weak self] query -> Observable<[String]> in
                guard let `self` = self else { return .just([]) }
                guard let query = query else { return .just([]) }
                return self.githubService.search(query: query)
            })
            .bind(to: self.tableView.rx.items(cellIdentifier: "cell")) { row, name, cell in
                cell.textLabel?.text = name
            }
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                guard let selectedCell = self.tableView.cellForRow(at: indexPath) else { return }
                guard let selectedRepoFullName = selectedCell.textLabel?.text else { return }
                guard let navigationController = self.navigationController else { return }
                let repoViewController = RepoViewController(repoFullName: selectedRepoFullName, githubService: self.githubService)
                navigationController.pushViewController(repoViewController, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
}
