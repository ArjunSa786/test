//
//  LanguageCell.swift
//  SearchLang
//


import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var descriptionFieldLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(result: SearchResult) {
        nameLbl.text = result.name
        loginLbl.text = result.owner.login
        descriptionFieldLbl.sizeToFit()
        descriptionFieldLbl.text = result.descriptionField
    
        }


}

