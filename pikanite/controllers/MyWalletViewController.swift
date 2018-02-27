//
//  MyWalletViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/19/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class MyWalletViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CardsTableViewCell", bundle: nil), forCellReuseIdentifier: "CardsTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func paymentMethodsButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "PaymentMethodViewController")
    }
    
    @IBAction func rewardsButtonPressed(_ sender: Any) {
        self.pushViewController(viewController: "RewardsViewController")
    }
    
    
}

extension MyWalletViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsTableViewCell", for: indexPath) as! CardsTableViewCell
        cell.selectionStyle = .none
        let value = (indexPath.row % 3)
        switch value {
        case 0:
            cell.cardImage.image = #imageLiteral(resourceName: "icon_cards_visa")
        case 1:
            cell.cardImage.image = #imageLiteral(resourceName: "icon_cards_master")
        case 2:
            cell.cardImage.image = #imageLiteral(resourceName: "icon_cards_americanXpress")
        default:
            cell.cardImage.image = #imageLiteral(resourceName: "icon_cards_visa")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Card selected at : \(indexPath.row)")
    }
}


