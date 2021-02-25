//
//  ConfirmVerificationViewController.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 23/02/2021.
//

import UIKit
import PayWiserIbanWalletSDK


class ConfirmVerificationViewController : UIViewController, UITextFieldDelegate {
    
    var phoneNumber: String!
    var length: Int!
    
    @IBOutlet weak var InstructionsText: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var ConfirmationCode: UITextField!
    @IBOutlet weak var ErrorText: UILabel!
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var ResendButton: UIButton!
    
    @IBOutlet weak var Counter: UILabel!
    

    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfirmationCode.delegate = self
        
//        ConfirmButton.isEnabled = false
        ResendButton.isEnabled = false
        ErrorText.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        InstructionsText.text = "Enter the " + length.description + "-digit code we sent to"
        PhoneNumber.text = phoneNumber
        Counter.text = 20.description
        
        ErrorText.textColor = .systemRed
        
        ConfirmationCode.becomeFirstResponder()
        
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hideLoading(vc: self)
    }
    
    
    func startTimer() {
        
        Counter.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        if Counter.text == 1.description {
            cancelTimer()
        }
        else {
            Counter.text = (Int16(Counter.text!)! - 1).description
        }
    }
    
    func cancelTimer() {
        timer.invalidate()
        Counter.isHidden = true
        Counter.text = 20.description
        ResendButton.isEnabled = true
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        ErrorText.isHidden = true
        
//        if sender.text!.trim().count == length {
//            ConfirmButton.isEnabled = true
//        }
//        else {
//            ConfirmButton.isEnabled = false
//        }
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let currentText = textField.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//
//        return updatedText.count <= length
//    }
    
    
    @IBAction func onConfirmCode(_ sender: UIButton) {
        
        showLoading(vc: self)
        let code = ConfirmationCode.text?.trim() ?? ""
        ConfirmationCode.resignFirstResponder()
        
        PayWiserIbanWallet.loginUserConfirmVerificationCode(verificationCode: code, { [self] error in
            if let err = error {
                ErrorText.text = err.StatusDescription
                ErrorText.isHidden = false
            }
            else {
                performSegue(withIdentifier: "walletData", sender: nil)
            }
            hideLoading(vc: self)
        })
    }
    
    
    
    @IBAction func onResendCode(_ sender: UIButton) {
        
        showLoading(vc: self)
        ResendButton.isEnabled = false
        Counter.isHidden = false
        ConfirmationCode.text = ""
        ErrorText.isHidden = true
        
        PayWiserIbanWallet.loginUserSendVerificationCode(phoneNumber: phoneNumber, { [self] data, error in

            if let otpLength = data {
                length = otpLength
                startTimer()
                ConfirmationCode.becomeFirstResponder()
            }
            else {
                ErrorText.text = error!.StatusDescription
                ErrorText.isHidden = false
            }
            hideLoading(vc: self)
        })
    }
    
    
}
