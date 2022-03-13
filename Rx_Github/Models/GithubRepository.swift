//
//  GithubRepository.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import Foundation

struct GithubRepository: Codable {
    var basicInformation: GithubRepositoryBasicInformation
    var owner: GithubRepositoryOwner
    var counts: GithubRepositoryCounts
    var language: String?
    
    init(basicInformation: GithubRepositoryBasicInformation, owner: GithubRepositoryOwner, counts: GithubRepositoryCounts, language: String?) {
        self.basicInformation = basicInformation
        self.owner = owner
        self.counts = counts
        if let language = language {
            self.language = language
        }
    }
}

struct GithubRepositoryBasicInformation: Codable {
    var name: String
    var full_name: String
    var description: String?
    
    init(name: String, fullName: String, description: String?) {
        self.name = name
        self.full_name = fullName
        if let description = description {
            self.description = description
        }
    }
}

struct GithubRepositoryOwner: Codable {
    var avatar_url: String
    
    init(avatar_url: String) {
        self.avatar_url = avatar_url
    }
}

struct GithubRepositoryCounts: Codable {
    var stargazers_count: Int
    var watchers_count: Int
    var forks_count: Int
    
    init(starGazersCount: Int, watchersCount: Int, forksCount: Int) {
        self.stargazers_count = starGazersCount
        self.watchers_count = watchersCount
        self.forks_count = forksCount
    }
}
