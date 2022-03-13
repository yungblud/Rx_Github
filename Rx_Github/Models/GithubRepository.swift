//
//  GithubRepository.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

struct GithubRepository: Codable {
    var name: String
    var full_name: String
    
    init(name: String, fullName: String) {
        self.name = name
        self.full_name = fullName
    }
}
