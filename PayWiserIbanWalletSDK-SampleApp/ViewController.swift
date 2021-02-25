//
//  ViewController.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 18/02/2021.
//

import UIKit
import PayWiserIbanWalletSDK


class ViewController: UIViewController {

    
    @IBAction func onLogin(_ sender: Any) {
        
        PayWiserIbanWallet.isUserLoggedIn({ status, error in
            if let isLoggedIn = status {
                isLoggedIn ? performSegue(withIdentifier: "walletData", sender: nil) : performSegue(withIdentifier: "loginScreen", sender: nil)
            }
            else {
                // error
            }
        })
        
        
        
    }
    
    

}

