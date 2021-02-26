//
//  WalletDataViewController.swift
//  PayWiserIbanWalletSDK-SampleApp
//
//  Created by tjasa on 19/02/2021.
//

import UIKit
import PayWiserIbanWalletSDK


class WalletDataViewController : UIViewController {
    
    
    @IBOutlet weak var ibansCollectionView: UICollectionView!
    @IBOutlet weak var NoIbansText: UILabel!
    
    var ibans: [PWIban] = [PWIban]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Logout", comment: ""), style: .plain, target: self, action: #selector(onLogout))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Close", comment: ""), style: .plain, target: self, action: #selector(onClose))
        
        NoIbansText.isHidden = true
        
        showLoading(vc: self)
        setCollectionViews()
        getWalletData()
        
    }
    
    
    
    func getWalletData() {
        
        PayWiserIbanWallet.listIbans({ [self] data, error in
            if let ibansList = data {
                ibans = ibansList
                NoIbansText.isHidden = ibans.count > 0
                ibansCollectionView.reloadData()
            }
            else {
                debugPrint(error!.StatusDescription)
            }
            hideLoading(vc: self)
        })
    }
    
    
    @objc func onLogout(_ sender: Any) {
        PayWiserIbanWallet.logoutUser({ error in

            if error == nil {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }
    
    @objc func onClose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}



extension WalletDataViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ibansCollectionView {
            return ibans.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ibansCollectionView, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IbanCollectionViewCell.reuseIdentifier, for: indexPath) as? IbanCollectionViewCell {
            let iban = ibans[indexPath.row]
            cell.configure(iban: iban)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == ibansCollectionView {
            guard let cell: IbanCollectionViewCell = Bundle.main.loadNibNamed(IbanCollectionViewCell.nibName, owner: self, options: nil)?.first as? IbanCollectionViewCell else {
                return CGSize.zero
            }
            cell.configure(iban: ibans[indexPath.row])
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return CGSize(width: self.ibansCollectionView.frame.size.width, height: cell.frame.size.height)
        }
        return CGSize.zero
    }
    
    
    func setCollectionViews() {
        ibansCollectionView.delegate = self
        ibansCollectionView.dataSource = self
        ibansCollectionView.register(UINib(nibName: IbanCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: IbanCollectionViewCell.nibName)
        if let ibansFlowLayout = ibansCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            ibansFlowLayout.minimumLineSpacing = 0
            ibansFlowLayout.minimumInteritemSpacing = 0
        }
        ibansCollectionView.backgroundColor = .clear
    }
}
