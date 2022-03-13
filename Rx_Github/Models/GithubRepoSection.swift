//
//  GithubRepoSection.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import RxDataSources

enum GithubRepoSectionModel {
    case OwnerAvatarSection(items: [GithubRepoSectionItem])
    case RepoDescriptionSection(items: [GithubRepoSectionItem])
    case CountsSection(items: [GithubRepoSectionItem])
    case LanguageSection(items: [GithubRepoSectionItem])
}

enum GithubRepoSectionItem {
    case OwnerAvatarSectionItem(avatarURL: String, basicInformation: GithubRepositoryBasicInformation)
    case RepoDescriptionSection(description: String)
    case CountsSection(counts: GithubRepositoryCounts)
    case LanguageSection(language: String)
}

extension GithubRepoSectionModel: SectionModelType {
    typealias Item = GithubRepoSectionItem
    
    var items: [GithubRepoSectionItem] {
        switch self {
        case .OwnerAvatarSection(items: let items):
            return items.map { $0 }
        case .RepoDescriptionSection(items: let items):
            return items.map { $0 }
        case .CountsSection(items: let items):
            return items.map { $0 }
        case .LanguageSection(items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: GithubRepoSectionModel, items: [GithubRepoSectionItem]) {
        switch original {
        case .OwnerAvatarSection(items: _):
            self = .OwnerAvatarSection(items: items)
        case .RepoDescriptionSection(items: _):
            self = .RepoDescriptionSection(items: items)
        case .CountsSection(items: _):
            self = .CountsSection(items: items)
        case .LanguageSection(items: _):
            self = .LanguageSection(items: items)
        }
    }
}
