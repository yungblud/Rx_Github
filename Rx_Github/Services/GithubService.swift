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
                let description = json["description"] as? String
                guard let starGazersCount = json["stargazers_count"] as? Int else { return nil }
                guard let watchersCount = json["watchers_count"] as? Int else { return nil }
                guard let forksCount = json["forks_count"] as? Int else { return nil }
                let language = json["language"] as? String
                let githubRepositoryBasicInformation = GithubRepositoryBasicInformation(name: name, fullName: fullName, description: description)
                let githubRepositoryOwner = GithubRepositoryOwner(avatar_url: ownerAvatarURL)
                let githubRepositoryCounts = GithubRepositoryCounts(starGazersCount: starGazersCount, watchersCount: watchersCount, forksCount: forksCount)
                let githubRepository = GithubRepository(basicInformation: githubRepositoryBasicInformation, owner: githubRepositoryOwner, counts: githubRepositoryCounts, language: language)
                return githubRepository
            })
            .catch { error in
                return .empty()
            }
    }
}
