//
//  Helpers.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 23/02/2021.
//

import UIKit



func formatCurrency(value: Int) -> String {
    let val = Double(value) / 100
    return NumberFormatter.localizedString(from: NSNumber(value: val), number: .currency)
}

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIViewController {
    
    func showLoading(vc: UIViewController) {
        
        let activityView = UIActivityIndicatorView()
        activityView.style = .medium
        activityView.color = .black
        activityView.center = vc.view.center
        activityView.tag = 0123
        vc.view.addSubview(activityView)
        
        vc.view.isUserInteractionEnabled = false
    }
    func hideLoading(vc: UIViewController) {
        if let activityView = vc.view.viewWithTag(0123) {
            activityView.removeFromSuperview()
        }
        vc.view.isUserInteractionEnabled = true
    }
}
