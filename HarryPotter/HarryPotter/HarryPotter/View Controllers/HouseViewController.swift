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
    @IBOutlet weak var housesTableView: UITableView!
    
    let houseController = HouseController()
    
    var house: String? {
        didSet {
            setViews()
        }
    }
    
    var houses: [House]? {
        didSet {
            housesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        housesTableView.delegate = self
        housesTableView.dataSource = self
        setViews()
        getAllHouses()
    }
    
    @IBAction func getRandomHouseButtonTapped(_ sender: UIButton) {
        
        houseController.getRandomHouse { (error, house) in
            if let error = error {
                NSLog("Error getting random house: \(error)")
            }
            
            guard let house = house else {return}
            self.house = house
        }
    }
    
    private func setViews() {
        guard let house = house else {return}
        DispatchQueue.main.async {
            self.houseNameLabel.text = house
        }
    }
    
    private func getAllHouses() {
        houseController.getAllHouses { (error, houses) in
            if let error = error {
                NSLog("Error getting ALL houses: \(error)")
            }
            
            guard let houses = houses else {return}
            self.houses = houses
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

extension HouseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return houses?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath)
        
        let house = houses?[indexPath.row]
        
        cell.textLabel?.text = house?.name
        cell.detailTextLabel?.text = house?.founder
        
        return cell
    }
    
    
}
