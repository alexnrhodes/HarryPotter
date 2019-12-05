//
//  House.swift
//  HarryPotter
//
//  Created by Alex Rhodes on 12/4/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

struct House: Codable {
    let id: String
    let name: String
    let mascot: String
    let headOfHouse: String
    let houseGhost: String
    let founder: String
    let members: [String]
    let values: [String]
    let colors: [String]
    
    enum CodingKeys: String, CodingKey {
       case id = "_id"
       case name
       case mascot
       case headOfHouse
       case houseGhost
       case founder
       case members
       case values
       case colors
        
        enum MemberKeys: String, CodingKey {
               case name
           }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let mascot = try container.decode(String.self, forKey: .mascot)
        let headOfHouse = try container.decode(String.self, forKey: .headOfHouse)
        let houseGhost = try container.decode(String.self, forKey: .houseGhost)
        let founder = try container.decode(String.self, forKey: .founder)
        let values = try container.decode([String].self, forKey: .values)
        let colors = try container.decode([String].self, forKey: .colors)

        self.id = id
        self.name = name
        self.mascot = mascot
        self.headOfHouse = headOfHouse
        self.houseGhost = houseGhost
        self.founder = founder
        self.values = values
        self.colors = colors
        
        var memberNames: [String] = []
        var memberContainerArray = try container.nestedUnkeyedContainer(forKey: .members)
        while !memberContainerArray.isAtEnd {
            let nameContainer = try memberContainerArray.nestedContainer(keyedBy: CodingKeys.MemberKeys.self)
            let name = try nameContainer.decode(String.self, forKey: .name)
            memberNames.append(name)
        }
        self.members = memberNames
        
        
        
    }
    
    init(id: String, name: String, mascot: String, headOfHouse: String, houseGhost: String, founder: String, members: [String], values: [String], colors: [String]) {
        self.id = id
        self.name = name
        self.mascot = mascot
        self.headOfHouse = headOfHouse
        self.houseGhost = houseGhost
        self.founder = founder
        self.members = members
        self.values = values
        self.colors = colors
    }
}

