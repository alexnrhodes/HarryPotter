//
//  CharacterController.swift
//  HarryPotter
//
//  Created by Alex Rhodes on 12/4/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation


class HouseController  {
    
    var house: RandomHouse?
    var houses: [House]?
    
    let baseURL = URL(string: "https://www.potterapi.com/v1/")!
    
    let keyQuery = URLQueryItem(name: "key", value: "$2a$10$ZXBuTf7U3LY0xTqo1J5JS.rPiLvyfek9Qs3ReFVYijgWKuGTARtEi")
    
    func getRandomHouse(completion: @escaping (Error?, String?) -> Void) {
        
        let url = baseURL.appendingPathComponent("sortingHat")
        
        Group.dispatchGroup.enter()
        URLSession.shared.dataTask(with: url)  { data,_,error in
            
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
    
    
    func getAllHouses(completion: @escaping (Error?, [House]?) -> Void) {
        
        var url = baseURL.appendingPathComponent("houses")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [keyQuery]
        url = components.url!
        print(url)
        
        
        Group.dispatchGroup.enter()
        URLSession.shared.dataTask(with: url) {data,_,error in
            
            if let error = error {
                NSLog("Error retrieving ALL houses: \(error)")
                completion(error,nil)
            }
            
            guard let data = data else {
                NSLog("Retrieved bad data")
                return
            }
            
            do {
                let houses = try JSONDecoder().decode([House].self, from: data)
                self.houses = houses
                completion(nil, houses)
            } catch {
                NSLog("Error decoding ALL houses from JSON: \(error)")
            }
            Group.dispatchGroup.leave()
        }.resume()
    }
}
