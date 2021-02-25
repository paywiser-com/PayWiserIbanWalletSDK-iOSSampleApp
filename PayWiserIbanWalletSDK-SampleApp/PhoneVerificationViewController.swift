//
//  PhoneVerificationViewController.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 23/02/2021.
//

import UIKit
import PayWiserIbanWalletSDK


class PhoneVerificationViewController : UIViewController {
    
    
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var ErrorText: UILabel!
    @IBOutlet weak var PhoneNumberButton: UIButton!
    
    var length: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ErrorText.textColor = .systemRed
        ErrorText.isHidden = true
        PhoneNumber.becomeFirstResponder()
    }
    
    
    @IBAction func onCheckPhoneNumber(_ sender: Any) {
        
        let number: String = PhoneNumber.text!
        
        PayWiserIbanWallet.loginUserSendVerificationCode(phoneNumber: number, { [self] data, error in

            if let otpData = data {
                length = otpData
                performSegue(withIdentifier: "confirmationCode", sender: nil)
            }
            else {
                ErrorText.text = error!.StatusDescription
                ErrorText.isHidden = false
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ConfirmVerificationViewController else { return }
        vc.phoneNumber = PhoneNumber.text?.trim()
        vc.length = length
    }
    
    
    
}
