//
//  CountryViewController.swift
//  Countries
//
//  Created by Олег Федоров on 27.11.2021.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    var country: (name: String, population: Int)?
    var countryTextColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLabels()
    }
    
    private func setupView() {
        
        view.backgroundColor = .black
        
    }
    
    private func setupLabels() {
        
        nameLabel.text = country?.name
        populationLabel.text = "Population 🌎 \(country?.population ?? 0)"
        
        nameLabel.textColor = countryTextColor
        populationLabel.textColor = .white
    }
    
}
