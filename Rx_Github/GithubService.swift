//
//  GithubService.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/12.
//

import RxCocoa
import RxSwift

struct GithubRepository: Codable {
    var name: String
    var full_name: String
    
    init(name: String, fullName: String) {
        self.name = name
        self.full_name = fullName
    }
}

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
    
    func getRepo(fullName: String) -> Observable<GithubRepository?> {
        let url = URL(string: "https://api.github.com/repos/\(fullName)")!
        return URLSession.shared.rx.json(url: url)
            .map { data -> GithubRepository? in
                guard let json = data as? [String: Any] else { return nil }
                guard let name = json["name"] as? String else { return nil }
                guard let fullName = json["full_name"] as? String else { return nil }
                let githubRepository = GithubRepository(name: name, fullName: fullName)
                return githubRepository
//                guard let data = data as? Data else { return nil }
//                let decoder = JSONDecoder()
//                guard let githubRepository = try? decoder.decode(GithubRepository.self, from: data) else { return nil }
//                return githubRepository
            }
            .catch({ error in
                print("myError, \(error.localizedDescription)")
                return .just(nil)
            })
    }
}
