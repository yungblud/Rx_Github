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
    fileprivate var dataSource: RxCollectionViewSectionedReloadDataSource<GithubRepoSectionModel>? = nil
    
    fileprivate let currentRepository = PublishSubject<GithubRepository>()
    fileprivate lazy var repoCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.repoCollectionViewFlowLayout)
        cv.alwaysBounceVertical = true
        cv.contentInsetAdjustmentBehavior = .always
        cv.register(OwnerAvatarSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "OwnerAvatarSectionHeader")
        cv.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DefaultSectionHeader")
        cv.register(RepoBasicInformationCell.self, forCellWithReuseIdentifier: "BasicInformationCell")
        cv.register(RepoDescriptionCell.self, forCellWithReuseIdentifier: "DescriptionCell")
        cv.register(DefaultCollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        return cv
    }()
    fileprivate lazy var repoCollectionViewFlowLayout: UICollectionViewStretchFlowLayout = {
        let layout = UICollectionViewStretchFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return layout
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
        self.repoCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp.edges)
        }
        
        self.bind()
    }
    
    func bind() {
        self.githubService.getRepo(fullName: self.repoFullName)
            .debug()
            .compactMap { $0 }
            .bind(to: self.currentRepository)
            .disposed(by: self.disposeBag)

        let dataSource = RxCollectionViewSectionedReloadDataSource<GithubRepoSectionModel> { dataSource, collectionView, indexPath, item in
            switch dataSource[indexPath] {
            case let .OwnerAvatarSectionItem(_, basicInformation):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicInformationCell", for: indexPath) as! RepoBasicInformationCell
                cell.configure(basicInformation: basicInformation)
                return cell
            case let .RepoDescriptionSection(description):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath) as! RepoDescriptionCell
                cell.configure(description: description)
                return cell
            }
        } configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            switch dataSource[indexPath] {
            case let .OwnerAvatarSectionItem(avatarURL, _):
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OwnerAvatarSectionHeader", for: indexPath) as? OwnerAvatarSectionHeader else { return UICollectionReusableView() }
                sectionHeader.configure(avatarURL: avatarURL)
                return sectionHeader
            default:
                let defaultHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DefaultSectionHeader", for: indexPath) as UICollectionReusableView
                return defaultHeader
            }
        } moveItem: { dataSource, sourceIndexPath, destinationIndexPath in

        } canMoveItemAtIndexPath: { dataSource, indexPath in
            return false
        }
        
        self.dataSource = dataSource

        self.currentRepository
            .map({ githubRepo -> [GithubRepoSectionModel] in
                let sections: [GithubRepoSectionModel] = [
                    .OwnerAvatarSection(items: [.OwnerAvatarSectionItem(avatarURL: githubRepo.owner.avatar_url, basicInformation: githubRepo.basicInformation)]),
                    .RepoDescriptionSection(items: [.RepoDescriptionSection(description: githubRepo.basicInformation.description)])
                ]
                return sections
            })
            .bind(to: self.repoCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
    }
}


extension RepoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let stretchHeaderLayout = collectionViewLayout as? UICollectionViewStretchFlowLayout else { return CGSize(width: 0, height: 0) }
        if section == 0 {
            stretchHeaderLayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 250.0)
            return stretchHeaderLayout.headerReferenceSize
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.zero
        guard let dataSource = self.dataSource else { return CGSize.zero }
        let section = dataSource.sectionModels[indexPath.section]
        let targetItem = section.items[indexPath.item]
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width -= 20
        switch targetItem {
        case let .OwnerAvatarSectionItem(_, basicInformation):
            size = "\(basicInformation.name)(\(basicInformation.full_name))".size(fits: collectionViewSize, font: .systemFont(ofSize: 25, weight: .bold), maximumNumberOfLines: 0)
        case let .RepoDescriptionSection(description):
            size = "\(description)".size(fits: collectionViewSize, font: .systemFont(ofSize: 12, weight: .medium), maximumNumberOfLines: 0)
        }
        size.width = collectionView.frame.width
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
