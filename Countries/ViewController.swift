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
        
        setupUITableView()
    }
    
    func setupUITableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "CountriesListTableViewCell", bundle: nil),
            forCellReuseIdentifier: "countryCell"
        )
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .lightGray
        
        // MARK: - TableHeaderView
        tableView.tableHeaderView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: tableView.bounds.width,
            height: 60
        ))
        tableView.tableHeaderView?.backgroundColor = .gray
        
        let labelHeader = UILabel(frame: CGRect(x: 16, y: 18, width: 200, height: 20))
        labelHeader.textColor = .white
        labelHeader.textAlignment = .left
        labelHeader.text = "Countries".uppercased()
        tableView.tableHeaderView?.addSubview(labelHeader)
        
        // MARK: - TableFooterView
        tableView.tableFooterView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: tableView.bounds.width,
            height: 60
        ))
        tableView.tableFooterView?.backgroundColor = .black
        
        let labelFooter = UILabel(frame: CGRect(x: 16, y: 18, width: 200, height: 20))
        labelFooter.textColor = .white
        labelFooter.textAlignment = .left
        labelFooter.text = "Countries count: \(countryList.count)"
        tableView.tableFooterView?.addSubview(labelFooter )
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        countryList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let country = countryList[indexPath.row]
        
        if country == "USA" {
            return 80
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "countryCell",
            for: indexPath
        ) as! CountriesListTableViewCell
        
        cell.mainLabel.text = countryList[indexPath.row]
        
        configureCell(cell: cell)
        
        return cell
        
    }
    
    private func configureCell(cell: UITableViewCell) {
        
        cell.backgroundColor = .blue
//        cell.accessoryType = .checkmark
//        cell.tintColor = .red
        
        if let countriesCell = cell as?CountriesListTableViewCell {
            countriesCell.mainLabel.textColor = .white
        }
        
    }
}
