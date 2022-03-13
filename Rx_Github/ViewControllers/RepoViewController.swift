//
//  RepoViewController.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/12.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

class RepoViewController: UIViewController, UIScrollViewDelegate {
    fileprivate let repoFullName: String
    fileprivate let githubService: GithubService
    fileprivate var disposeBag = DisposeBag()
    
    fileprivate let currentRepository = PublishSubject<GithubRepository>()
    fileprivate let repoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.alwaysBounceVertical = true
        cv.register(RepoBasicInformationCell.self, forCellWithReuseIdentifier: "BasicInformationCell")
        cv.register(OwnerAvatarCell.self, forCellWithReuseIdentifier: "OwnerAvatarCell")
        return cv
    }()
    
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
        
        self.repoCollectionView.keyboardDismissMode = .onDrag
        self.repoCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.view.addSubview(self.repoCollectionView)
        
        self.bind()
    }
    
    func bind() {
        self.githubService.getRepo(fullName: self.repoFullName)
            .debug()
            .compactMap { $0 }
            .bind(to: self.currentRepository)
            .disposed(by: self.disposeBag)
    
        self.currentRepository
            .map { $0.basicInformation.full_name }
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: self.disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<GithubRepoSectionModel> { dataSource, collectionView, indexPath, item in
            switch dataSource[indexPath] {
            case let .OwnerAvatarSectionItem(avatarURL):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OwnerAvatarCell", for: indexPath) as! OwnerAvatarCell
                cell.configure(avatarURL: avatarURL)
                return cell
            case let .BasicInformationSectionItem(basicInformation):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicInformationCell", for: indexPath) as! RepoBasicInformationCell
                cell.configure(basicInformation: basicInformation)
                return cell
            }
        } configureSupplementaryView: { dataSource, collectionView, Kind, indexPath in
            return UICollectionReusableView()
        } moveItem: { dataSource, sourceIndexPath, destinationIndexPath in
            
        } canMoveItemAtIndexPath: { dataSource, indexPath in
            return false
        }

        self.currentRepository
            .map({ githubRepo -> [GithubRepoSectionModel] in
                let sections: [GithubRepoSectionModel] = [
                    .OwnerAvatarSection(items: [.OwnerAvatarSectionItem(avatarURL: githubRepo.owner.avatar_url)]),
                    .BasicInformationSection(items: [.BasicInformationSectionItem(basicInformation: githubRepo.basicInformation)])
                ]
                return sections
            })
            .bind(to: self.repoCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.repoCollectionView.frame = self.view.bounds
    }
}


extension RepoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 250.0)
        }
        return CGSize(width: collectionView.frame.width, height: 100.0)
    }
}
