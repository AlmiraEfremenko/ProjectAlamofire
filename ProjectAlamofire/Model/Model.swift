//
//  Model.swift
//  ProjectAlamofire
//
//  Created by MAC on 24.02.2022.
//

import Foundation

struct Cards: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let name: String
    let type: String?
    let text: String?
    let imageUrl: String?
}
