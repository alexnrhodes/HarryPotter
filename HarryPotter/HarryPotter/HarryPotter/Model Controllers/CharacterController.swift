//
//  CharacterController.swift
//  HarryPotter
//
//  Created by Alex Rhodes on 12/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

class CharacterController {
    
    var characters: [Character]?
    
    let baseURL = URL(string: "https://www.potterapi.com/v1/")!
    
    let keyQuery = URLQueryItem(name: "key", value: "$2a$10$ZXBuTf7U3LY0xTqo1J5JS.rPiLvyfek9Qs3ReFVYijgWKuGTARtEi")
    
    func getAllCharacters(completion: @escaping (Error?, [Character]?) -> Void) {
        
        var url = baseURL.appendingPathComponent("characters")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [keyQuery]
        url = components.url!
        print(url)
        
        
        Group.dispatchGroup.enter()
        URLSession.shared.dataTask(with: url) {data,_,error in
            
            if let error = error {
                NSLog("Error retrieving ALL characters: \(error)")
                completion(error,nil)
            }
            
            guard let data = data else {
                NSLog("Retrieved bad data")
                return
            }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                var organizedCharacters = [Character]()
                
                for char in characters {
                    let character = Character(id: char.id, name: char.name, minOfMagic: char.ministryOfMagic, orderOfThePheonix: char.orderOfThePhoenix, dumbledoresArmy: char.dumbledoresArmy, deathEater: char.deathEater, bloodStatus: char.bloodStatus, species: char.species)
                    organizedCharacters.append(character)
                }
                self.characters = organizedCharacters
                completion(nil, self.characters)
            } catch {
                NSLog("Error decoding ALL houses from JSON: \(error)")
            }
            Group.dispatchGroup.leave()
        }.resume()
    }
}
