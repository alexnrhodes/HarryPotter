//
//  House.swift
//  HarryPotter
//
//  Created by Alex Rhodes on 12/4/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

struct Member: Codable {
    let name: String
}

struct House: Codable {
    let id: String
    let name: String
    let mascot: String
    let headOfHouse: String
    let houseGhost: String
    let founder: String
    let members: [Member]
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
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        mascot = try container.decode(String.self, forKey: .mascot)
        headOfHouse = try container.decode(String.self, forKey: .headOfHouse)
        houseGhost = try container.decode(String.self, forKey: .houseGhost)
        founder = try container.decode(String.self, forKey: .founder)
        values = try container.decode([String].self, forKey: .values)
        colors = try container.decode([String].self, forKey: .colors)

        
//        var memberNames: [Member] = []
        let memberContainerArray = try container.nestedUnkeyedContainer(forKey: .members)
        while !memberContainerArray.isAtEnd {
//            let nameContainer = try memberContainerArray.nestedContainer(keyedBy: CodingKeys.MemberKeys.self)
//            let name = try nameContainer.decode(Member.self, forKey: .name)
//            memberNames.append(name)
        }
        self.members = memberContainerArray as! [Member]
        
        
        
    }
    
    init(id: String, name: String, mascot: String, headOfHouse: String, houseGhost: String, founder: String, members: [Member], values: [String], colors: [String]) {
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

