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
}
