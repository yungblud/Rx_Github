//
//  GithubRepoSection.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import RxDataSources

enum GithubRepoSectionModel {
    case OwnerAvatarSection(items: [GithubRepoSectionItem])
    case BasicInformationSection(items: [GithubRepoSectionItem])
}

enum GithubRepoSectionItem {
    case OwnerAvatarSectionItem(avatarURL: String)
    case BasicInformationSectionItem(basicInformation: GithubRepositoryBasicInformation)
}

extension GithubRepoSectionModel: SectionModelType {
    typealias Item = GithubRepoSectionItem
    
    var items: [GithubRepoSectionItem] {
        switch self {
        case .OwnerAvatarSection(items: let items):
            return items.map { $0 }
        case .BasicInformationSection(items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: GithubRepoSectionModel, items: [GithubRepoSectionItem]) {
        switch original {
        case .OwnerAvatarSection(items: _):
            self = .OwnerAvatarSection(items: items)
        case .BasicInformationSection(items: _):
            self = .BasicInformationSection(items: items)
        }
    }
}
