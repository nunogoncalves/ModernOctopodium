//
//  Users.swift
//  ModernOctopodium
//
//  Created by Nuno Gonçalves on 30/08/2019.
//  Copyright © 2019 numicago. All rights reserved.
//

import Foundation

struct User: Decodable, Hashable {
    let avatarURL: URL
    let username: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "gravatar_url"
        case username = "login"
    }
}

struct Users: Decodable, Hashable {
    let users: [User]
}
