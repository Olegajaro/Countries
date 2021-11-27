//
//  CountriesListTableViewCell.swift
//  Countries
//
//  Created by Олег Федоров on 24.11.2021.
//

import UIKit

protocol CountriesListTableViewCellDelegate: AnyObject {
    
    func didPressCheckMarkButtonInCell(_ button: UIButton, cell: UITableViewCell)
    
}

class CountriesListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    weak var cellDelegate: CountriesListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func checkMarkButtonTapped(_ sender: UIButton) {
        
        cellDelegate?.didPressCheckMarkButtonInCell(sender, cell: self)
        
    }
    
}
