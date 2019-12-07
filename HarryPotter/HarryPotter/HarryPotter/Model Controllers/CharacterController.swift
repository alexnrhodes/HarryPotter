//
//  CharacterController.swift
//  HarryPotter
//
//  Created by Alex Rhodes on 12/4/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation


class CharacterController  {
    
    
    var house: RandomHouse?
    
    let baseURL = URL(string: "https://www.potterapi.com/v1/")!
    
    func getRandomHouse(completion: @escaping (Error?, String?) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("sortingHat")
        
        Group.dispatchGroup.enter()
        URLSession.shared.dataTask(with: requestURL)  { data,_,error in
            
            if let error = error {
                NSLog("Error retrieving random house: \(error)")
                completion(error,nil)
            }
            
            guard let data = data else {
                NSLog("Retrieved bad data")
                return
            }
            
            do {
                let houseName = try JSONDecoder().decode(String.self, from: data)
                let house = RandomHouse(name: houseName)
                self.house = house
                completion(nil, houseName)
            } catch {
                NSLog("Error decoding house from JSON: \(error)")
            }
            Group.dispatchGroup.leave()
        }.resume()
    } 
}
