//
//  ViewController.swift
//  Countries
//
//  Created by Олег Федоров on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let countryList = ["USA", "UK", "Italy",
                       "Russia", "Spain", "Canada",
                       "Australia", "Finland"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "CountriesListTableViewCell", bundle: nil),
            forCellReuseIdentifier: "countryCell"
        )
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        countryList.count
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "countryCell",
            for: indexPath
        ) as! CountriesListTableViewCell
        
        cell.mainLabel.text = countryList[indexPath.row]
        
        return cell
        
    }
}
