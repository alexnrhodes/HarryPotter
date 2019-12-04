//
//  HouseViewController.swift
//  HarryPotter
//
//  Created by Alex Rhodes on 12/4/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController {
    
    @IBOutlet weak var getRandomHouseButton: UIButton!
    @IBOutlet weak var houseNameLabel: UILabel!
    
    let characterController = CharacterController()
    
    var house: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    @IBAction func getRandomHouseButtonTapped(_ sender: UIButton) {
        characterController.getRandomHouse { (error, house) in
            if let error = error {
                NSLog("Error getting random house: \(error)")
            }
            
            guard let house = house else {return}
            self.house = house
            self.setViews()
        }
    }
    
    private func setViews() {
        guard let house = house else {return}
        DispatchQueue.main.async {
            self.houseNameLabel.text = house
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
