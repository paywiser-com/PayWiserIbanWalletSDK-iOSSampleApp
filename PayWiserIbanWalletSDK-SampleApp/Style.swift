//
//  Style.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 23/02/2021.
//

import UIKit



class Button: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .systemTeal
        self.tintColor = .white
        self.layer.cornerRadius = 5
    }
}
class ButtonInverted: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.tintColor = .systemTeal
    }
}
