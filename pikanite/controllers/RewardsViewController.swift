//
//  RewardsViewController.swift
//  pikanite
//
//  Created by Rakshitha Muranga Rodrigo on 2/19/18.
//  Copyright © 2018 Rakshitha Muranga Rodrigo. All rights reserved.
//

import UIKit

class RewardsViewController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "BookNowTableViewCell", bundle: nil), forCellReuseIdentifier: "BookNowTableViewCell")
        self.tableView.register(UINib(nibName: "InviteFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "InviteFriendsTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
  
}


extension RewardsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let switchValue = (indexPath.row%2)
        
        switch switchValue {
        case 0:
            let cellType_0 = tableView.dequeueReusableCell(withIdentifier: "BookNowTableViewCell", for: indexPath) as! BookNowTableViewCell
            cellType_0.pressedAction = {
                self.navigationController?.popToRootViewController(animated: true)
                self.appDelegate.loginHandler()
            }
            cell = cellType_0
        case 1:
            let cellType_1 = tableView.dequeueReusableCell(withIdentifier: "InviteFriendsTableViewCell", for: indexPath) as! InviteFriendsTableViewCell
            cellType_1.pressedAction = {
                self.pushViewController(viewController: "InviteFriendsViewController")
            }
            cell = cellType_1
        default:
            let cellType_1 = tableView.dequeueReusableCell(withIdentifier: "InviteFriendsTableViewCell", for: indexPath) as! InviteFriendsTableViewCell
            cellType_1.pressedAction = {
                self.pushViewController(viewController: "InviteFriendsViewController")
            }
            cell = cellType_1
        }
        cell.selectionStyle = .none
        return cell
    }
}
