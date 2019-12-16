//
//  HPCharacter.swift
//  HarryPotter
//
//  Created by Alex Rhodes on 12/4/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation


struct Character: Codable {
    let id: String
    let name: String
//    let role: String
    let ministryOfMagic: Bool
    let orderOfThePhoenix: Bool
    let dumbledoresArmy: Bool
    let bloodStatus: String
    let species: String
    let deathEater: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case ministryOfMagic
        case orderOfThePhoenix
        case dumbledoresArmy
        case bloodStatus
        case deathEater
        case species
    }
        
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        ministryOfMagic = try container.decode(Bool.self, forKey: .ministryOfMagic)
        orderOfThePhoenix = try container.decode(Bool.self, forKey: .orderOfThePhoenix)
        dumbledoresArmy = try container.decode(Bool.self, forKey: .ministryOfMagic)
        deathEater = try container.decode(Bool.self, forKey: .deathEater)
        bloodStatus = try container.decode(String.self, forKey: .bloodStatus)
        species = try container.decode(String.self, forKey: .species)


    }
   
    init(id: String, name: String, minOfMagic: Bool, orderOfThePheonix: Bool, dumbledoresArmy: Bool, deathEater: Bool, bloodStatus: String, species: String) {
        self.id = id
        self.name = name
        self.ministryOfMagic = minOfMagic
        self.orderOfThePhoenix = orderOfThePheonix
        self.dumbledoresArmy = dumbledoresArmy
        self.deathEater = deathEater
        self.bloodStatus = bloodStatus
        self.species = species

    }

}
