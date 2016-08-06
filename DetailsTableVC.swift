//
//  DetailsTableVC.swift
//  BlueMoonLight
//
//  Created by Frank Tellez on 7/23/16.
//  Copyright © 2016 Frank Tellez. All rights reserved.
//

import UIKit

class DetailsTableVC: UITableViewController {

    var company: Employee!
    
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.careerLabel.text = self.company.name
        self.emailLabel.text = self.company.email
        self.firstNameLabel.text = self.company.firstName
        self.lastNameLabel.text = self.company.lastName
        self.phoneNumber.text = self.company.phoneNumber
    }
}
