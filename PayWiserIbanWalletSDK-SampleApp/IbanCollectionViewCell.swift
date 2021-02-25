//
//  IbanCollectionViewCell.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 23/02/2021.
//

import UIKit
import PayWiserIbanWalletSDK


class IbanCollectionViewCell: UICollectionViewCell {

    class var reuseIdentifier: String {
        return nibName
    }
    class var nibName: String {
        return "IbanCollectionViewCell"
    }
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var Iban: UILabel!
    @IBOutlet weak var Balance: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Status: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContentView.backgroundColor = .clear
        cardView.layer.cornerRadius = 15
        cardView.layer.borderColor = UIColor.systemGray5.cgColor
        cardView.layer.borderWidth = 3
    }
    
    
    func configure(iban: PWIban) {
        
        Iban.text = iban.Iban
        Balance.text = formatCurrency(value: iban.Balance)
        Description.text = iban.Description
        Status.text = iban.StatusDescription
        
    }

}
