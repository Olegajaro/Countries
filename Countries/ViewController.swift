//
//  ViewController.swift
//  Countries
//
//  Created by Олег Федоров on 24.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var countriesList: [(name: String, population: Int)] = [
        ("USA", 329093110),("UK", 66959016),("Italy", 59216525),
        ("Russia", 143895551),("Spain", 46441049),("Canada", 37279811),
        ("Australia", 25088636),("Finland", 5561389)
    ]

    let labelFooter = UILabel(frame: CGRect(x: 16, y: 18, width: 200, height: 20))
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUITableView()
    }
    
    // MARK: - Table Appearance
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
        
        labelFooter.textColor = .white
        labelFooter.textAlignment = .left
        labelFooter.text = "Countries count: \(self.countriesList.count)"
        tableView.tableFooterView?.addSubview(labelFooter )
        
    }
    
    // MARK: - Sharing text
    func shareText(text: String) {
        
        let activityVC = UIActivityViewController(activityItems: [text],
                                                  applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [
            .addToReadingList, .airDrop, .openInIBooks,
            .print, .saveToCameraRoll, .postToVimeo,
            .postToWeibo, .postToFlickr, .markupAsPDF
        ]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            guard
                let popOver = activityVC.popoverPresentationController
            else { return }
            
            popOver.sourceView = self.view
            popOver.sourceRect = CGRect(
                origin: CGPoint(x: view.frame.width / 2, y: 0),
                size: CGSize.zero
            )
            
            present(activityVC, animated: true)
            
        } else {
            
            present(activityVC, animated: true)
            
        }
            
    }
    
    // MARK: - Alert
    func showAlertWithText(vc: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel")
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true)
        
    }
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        countriesList.count
        
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let country = countriesList[indexPath.row]
        
        if country.name == "USA" {
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
        
        cell.mainLabel.text = countriesList[indexPath.row].name
        
        configureCell(cell: cell)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("row selected ")
        
        DispatchQueue.main.async {
            
            self.showAlertWithText(
                vc: self,
                title: self.countriesList[indexPath.row].name,
                message: "Population: \(self.countriesList[indexPath.row].population)"
            )
            
        }
    }
    
    // MARK: - Trailing Swipe Actions Configuration
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
            
            print("trailing happened")
            
            if !countriesList.isEmpty {
                
                /// Delete action
                let deleteAction = UIContextualAction(
                    style: .destructive,
                    title: "") { _, _, isDone in
                        
                        self.countriesList.remove(at: indexPath.row)
                        print("delete action")
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        
                        DispatchQueue.main.async {
                            self.labelFooter.text = "Countries count: \(self.countriesList.count)"
                        }
                        
                        isDone(true)
                        
                    }
                
                deleteAction.image = #imageLiteral(resourceName: "trash")
                
                /// Share text Action
                let copyAction = UIContextualAction(
                    style: .normal,
                    title: "Copy") { _, _, _ in
                        
                        self.shareText(text: "\(self.countriesList[indexPath.row].name)\nPopulation \(self.countriesList[indexPath.row].population)")
                        
                        self.tableView.isEditing = false
                        
                    }
                
                copyAction.backgroundColor = .gray
                
                /// Move action
                let moveAction =  UIContextualAction(
                    style: .normal,
                    title: "Move") { _, _, _ in
                        
                        print("Move action code")
                        
                        self.tableView.isEditing = false // hiding actions
                        self.tableView.isEditing = true // enabling the editing mode
                        
                    }
                
                moveAction.backgroundColor = .black
                
                let swipeActionConfiguration = UISwipeActionsConfiguration(
                    actions: [deleteAction, copyAction, moveAction]
                )
                
                return swipeActionConfiguration
                
            } else {
                
                return nil
                
            }
        }
    
    // MARK: - Leading swipe Actions Congfiguration
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        print("leading happened")
        
        let showPopulationAction = UIContextualAction(
            style: .normal,
            title: "👨‍👦‍👦") { _, _, _ in
                
                DispatchQueue.main.async {
                    
                    self.showAlertWithText(
                        vc: self,
                        title: self.countriesList[indexPath.row].name,
                        message: "Population: \(self.countriesList[indexPath.row].population)"
                    )
                    
                }
                
                self.tableView.isEditing = false
            }
        
        showPopulationAction.backgroundColor = .green
        
        let swipeActionConfiguration = UISwipeActionsConfiguration(
            actions: [showPopulationAction]
        )
        
        return swipeActionConfiguration
    }
    
    // MARK: - Move Row At
    func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        
        let moveObject = countriesList[sourceIndexPath.row]
        countriesList.remove(at: sourceIndexPath.row)
        countriesList.insert(moveObject, at: destinationIndexPath.row)
        tableView.isEditing = false
        
    }
    
    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        
        return .none
        
    }
    
    func tableView(
        _ tableView: UITableView,
        shouldIndentWhileEditingRowAt indexPath: IndexPath
    ) -> Bool {
            
        return false
    
    }
    
    
    // MARK: - Configure Cell
    private func configureCell(cell: UITableViewCell) {
        
        cell.backgroundColor = .blue
        cell.selectionStyle = .none
//        cell.accessoryType = .checkmark
//        cell.tintColor = .red
        
        if let countriesCell = cell as?CountriesListTableViewCell {
            countriesCell.mainLabel.textColor = .white
        }
        
    }
}
