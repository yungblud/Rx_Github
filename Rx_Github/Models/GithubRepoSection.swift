//
//  GithubRepoSection.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import RxDataSources

enum GithubRepoSectionModel {
    case FullNameSection(items: [GithubRepoSectionItem])
    case NameSection(items: [GithubRepoSectionItem])
}

enum GithubRepoSectionItem {
    case FullNameSectionItem(fullName: String)
    case NameSectionItem(name: String)
}

extension GithubRepoSectionModel: SectionModelType {
    typealias Item = GithubRepoSectionItem
    
    var items: [GithubRepoSectionItem] {
        switch self {
        case .FullNameSection(items: let items):
            return items.map { $0 }
        case .NameSection(items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: GithubRepoSectionModel, items: [GithubRepoSectionItem]) {
        switch original {
        case .FullNameSection(items: _):
            self = .FullNameSection(items: items)
        case .NameSection(items: _):
            self = .NameSection(items: items)
        }
    }
}
