//
//  ViewController.swift
//  Countries
//
//  Created by Олег Федоров on 24.11.2021.
//

import UIKit

enum ViewMode {
    
    case simple
    case extended
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var countriesList: [(name: String, population: Int)] = [
        ("Afghanistan",37209007),("Albania",2938428),("Algeria",42679018),
        ("Andorra",77072),("Angola",31787566),("Antigua and Barbuda",104084),
        ("Argentina",45101781),("Armenia",2936706),("Australia",25088636),
        ("Austria",8766201),("Azerbaijan",10014575),("Bahamas",403095),
        ("Bahrain",1637896),("Bangladesh",168065920),("Barbados",28701),
        ("Belarus",9433874),("Belgium",11562784),("Belize",390231),
        ("Benin",11801595),("Bhutan",826229),("Bolivia",11379861),
        ("Bosnia and Herzegovina",3501774),("Botswana",2374636),
        ("Brazil",212392717),("Brunei",439336),("Bulgaria",6988739),
        ("Burkina Faso",20321560),("Burundi",11575964),("Côte d Ivoire",25531083),
        ("Cabo Verde",560349),("Cambodia",16482646),("Cameroon",25312993),
        ("Canada",37279811),("Central African Republic",4825711),("Chad",15814345),
        ("Chile",18336653),("China",1420062022),("Colombia",49849818),
        ("Comoros",85091),("Congo (Congo-Brazzaville)",5542197),("Costa Rica",4999384),
        ("Croatia",4140148),("Cuba",11492046),("Cyprus",1198427),
        ("Czechia",10630589),("Democratic Republic of the Congo",86727573),("Denmark",5775224),
        ("Djibouti",98569),("Dominica",74679),("Dominican Republic",10996774),
        ("Ecuador",17100444),("Egypt",101168745),("El Salvador",6445405),
        ("Equatorial Guinea",1360104),("Eritrea",5309659),("Estonia",1303798),
        ("Ethiopia",110135635),("Fiji",918757),("Finland",5561389),
        ("France",65480710),("Gabon",2109099),("Gambia",2228075),
        ("Georgia",3904204),("Germany",82438639),("Ghana",30096970),
        ("Greece",11124603),("Grenada",108825),("Guatemala",17577842),
        ("Guinea",13398180),("Guinea-Bissau",1953723),("Guyana",786508),
        ("Haiti",11242856),("Holy See",799),("Honduras",9568688),
        ("Hungary",9655361),("Iceland",340566),("India",1368737513),
        ("Indonesia",269536482),("Iran",82820766),("Iraq",40412299),
        ("Ireland",40412299),("Israel",8583916),("Italy",18592970),
        ("Jamaica",2906339),("Japan",126854745),("Jordan",10069794),
        ("Kazakhstan",52214791),("Kenya",52214791),("Kiribati",120428),
        ("Kuwait",4248974),("Kyrgyzstan",6218616),("Laos",7064242),
        ("Latvia",1911108),("Lebanon",6065922),("Lesotho",2292682),
        ("Liberia",4977720),("Libya",6569864),("Liechtenstein",38404),
        ("Lithuania",2864459),("Luxembourg",596992),("Madagascar",26969642),
        ("Malawi",19718743),("Malaysia",32454455),("Maldives",451738),
        ("Mali",19689140),("Malta",433245),("Marshall Islands",53211),
        ("Mauritania",4661149),("Mauritius",1271368),("Mexico",132328035),
        ("Micronesia",536579),("Moldova",4029750),("Monaco",39102),
        ("Mongolia",3166244),("Montenegro",629355),("Morocco",36635156),
        ("Mozambique",31408823),("Myanmar (formerly Burma)",54336138),("Namibia",2641996),
        ("Nauru",1126),("Nepal",29942018),("Netherlands",17132908),
        ("New Zealand",4792409),("Nicaragua",6351157),("Niger",23176691),
        ("Nigeria",200962417),("North Korea",25727408),("North Macedonia",2086720),
        ("Norway",5400916),("Oman",5001875),("Pakistan",204596442),
        ("Palau",22206),("Palestine State",5186790),("Panama",4226197),
        ("Papua New Guinea",8586525),("Paraguay",6981981),("Peru",32933835),
        ("Philippines",108106310),("Poland",38028278),("Portugal",10254666),
        ("Qatar",2743901),("Romania",19483360),("Russia",143895551),
        ("Rwanda",12794412),("Saint Kitts and Nevis",56345),("Saint Lucia",180454),
        ("Saint Vincent and the Grenadines",110488),("Samoa",198909),("San Marino",33683),
        ("Sao Tome and Principe",213379),("Saudi Arabia",34140662),("Senegal",16743859),
        ("Serbia",8733407),("Seychelles",95702),("Sierra Leone",7883123),
        ("Singapore",5868104),("Slovakia",5450987),("Slovenia",2081900),
        ("Solomon Islands",635254),("Somalia",15636171),("South Africa",58065097),
        ("South Korea",51339238),("South Sudan",13263184),("Spain",46441049),
        ("Sri Lanka",21018859),("Sudan",42514094),("Suriname",573085),
        ("Swaziland",1415414),("Sweden",10053135),("Switzerland",8608259),
        ("Syria",18499181),("Tajikistan",9292000),("Tanzania",60913557),
        ("Thailand",69306160),("Timor-Leste",1352360),("Togo",8186384),
        ("Tonga",110041),("Trinidad and Tobago",1375443),("Tunisia",11783168),
        ("Turkey",82961805),("Turkmenistan",5942561),("Tuvalu",11393),
        ("Uganda",45711874),("Ukraine",43795220),("United Arab Emirates",9682088),
        ("UK",66959016),("USA",329093110),("Uruguay",3482156),
        ("Uzbekistan",32807368),("Vanuatu",288017),("Venezuela",32779868),
        ("Vietnam",97429061),("Yemen",29579986),("Zambia",18137369),("Zimbabwe",17297495)
    ]
    
    let labelFooter = UILabel(frame: CGRect(x: 16, y: 18, width: 200, height: 20))
    
    private var currentViewModeValue: ViewMode = .simple
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUITableView()
    }
    
    @IBAction func switchModesTapped(_ sender: UIBarButtonItem) {
        
        // switching modes
        switch currentViewModeValue {
        case .simple:
            currentViewModeValue = .extended
        case .extended:
            currentViewModeValue = .simple
        }
        
        print("Switch mode tapped: \(currentViewModeValue)")
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
