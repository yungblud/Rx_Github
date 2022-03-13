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
    
    init(basicInformation: GithubRepositoryBasicInformation, owner: GithubRepositoryOwner) {
        self.basicInformation = basicInformation
        self.owner = owner
    }
}

struct GithubRepositoryBasicInformation: Codable {
    var name: String
    var full_name: String
    var description: String
    
    init(name: String, fullName: String, description: String) {
        self.name = name
        self.full_name = fullName
        self.description = description
    }
}

struct GithubRepositoryOwner: Codable {
    var avatar_url: String
    
    init(avatar_url: String) {
        self.avatar_url = avatar_url
    }
}
