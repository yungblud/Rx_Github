//
//  RepoViewController.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/12.
//

import UIKit

import RxCocoa
import RxSwift

class RepoViewController: UIViewController {
    fileprivate let repoFullName: String
    fileprivate let githubService: GithubService
    fileprivate var disposeBag = DisposeBag()
    
    fileprivate let currentRepository = PublishSubject<GithubRepository>()
    
    init(repoFullName: String, githubService: GithubService) {
        self.repoFullName = repoFullName
        self.githubService = githubService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.bind()
    }
    
    func bind() {
        self.githubService.getRepo(fullName: self.repoFullName)
            .debug()
            .compactMap { $0 }
            .bind(to: self.currentRepository)
            .disposed(by: self.disposeBag)
    
        self.currentRepository
            .map { $0.full_name }
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: self.disposeBag)
            
    }
}
