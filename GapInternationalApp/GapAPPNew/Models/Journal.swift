//
//  Journal.swift
//  GapApp
//
//  Created by NAMAN GARG on 6/18/21.
//

import Foundation
import Foundation

// MARK: - JournalElement
struct JournalElement: Codable {
    let userName, chapterName, comment: String?
    let level: Int?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case chapterName = "ChapterName"
        case comment = "Comment"
        case level = "Level"
        case date = "Date"
    }
}

typealias Journal = [JournalElement]

