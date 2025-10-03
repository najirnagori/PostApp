//
//  PostModal.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import Foundation

struct Post: Codable, Identifiable, Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
