//
//  ViewController.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 18/02/2021.
//

import UIKit
import PayWiserIbanWalletSDK


class ViewController: UIViewController {

    @IBOutlet weak var SdkVersion: UILabel!
    
    
    var latestSdkVerion: String = "v1.0.0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SdkVersion.text = latestSdkVerion
    }
    
    
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

