//
//  GithubService.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/12.
//

import RxCocoa
import RxSwift

class GithubService {
    func search(query: String) -> Observable<[String]> {
        guard !query.isEmpty else { return .just([]) }
        let url = URL(string: "https://api.github.com/search/repositories?q=\(query)")!
        return URLSession.shared.rx.json(url: url)
            .map { data -> [String] in
                guard let json = data as? [String: Any] else { return [] }
                guard let items = json["items"] as? [[String: Any]] else { return [] }
                return items.compactMap { $0["full_name"] as? String }
            }
            .catchAndReturn([])
    }
    
    func getRepo(fullName: String) -> Observable<GithubRepository> {
        let url = URL(string: "https://api.github.com/repos/\(fullName)")!
        return URLSession.shared.rx.json(url: url)
            .compactMap({ data -> GithubRepository? in
                guard let json = data as? [String: Any] else { return nil }
                guard let name = json["name"] as? String else { return nil }
                guard let fullName = json["full_name"] as? String else { return nil }
                guard let owner = json["owner"] as? [String: Any] else { return nil }
                guard let ownerAvatarURL = owner["avatar_url"] as? String else { return nil }
                let githubRepositoryOwner = GithubRepositoryOwner(avatar_url: ownerAvatarURL)
                let githubRepository = GithubRepository(name: name, fullName: fullName, owner: githubRepositoryOwner)
                return githubRepository
            })
            .catch { error in
                return .empty()
            }
    }
}
