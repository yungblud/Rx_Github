//
//  GithubRepository.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import Foundation

struct GithubRepository: Codable {
    var name: String
    var full_name: String
    var owner: GithubRepositoryOwner
    
    init(name: String, fullName: String, owner: GithubRepositoryOwner) {
        self.name = name
        self.full_name = fullName
        self.owner = owner
    }
}

struct GithubRepositoryOwner: Codable {
    var avatar_url: String
    
    init(avatar_url: String) {
        self.avatar_url = avatar_url
    }
}
