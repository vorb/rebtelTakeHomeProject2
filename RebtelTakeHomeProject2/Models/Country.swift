//
//  Country.swift
//  RebtelTakeHomeProject
//
//  Created by Sebastian Mendez on 2021-09-12.
//

import Foundation

struct Country: Codable, Hashable {
    var name: String
    var alpha2Code: String
    var capital: String
    var numericCode: String?
    var population: Int
    var region: String
    var area: Double?
    var languages: [Language]
}
