//
//  User.swift
//  GapApp
//
//  Created by NAMAN GARG on 6/18/21.
//

import Foundation

struct User: Codable {
    let userName, password: String?

    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case password = "Password"
    }
}

struct Completion: Codable {
    let result: String?

    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}



