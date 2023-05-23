//
//  Card.swift
//  JSONDecoderTask
//
//  Created by Kuanysh al-Khattab Auyelgazy on 15.05.2023.
//

import Foundation

struct Cards: Codable {
    var cards: [Card]
}

struct Card: Codable {
    let name: String
    let manaCost: String?
    let cmc: Int
    let type: String
    let rarity: String
    let printings: [String]
    let originalText: String?
}
