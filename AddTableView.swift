//
//  AddTableView.swift
//  BlueMoonLight
//
//  Created by Frank Tellez on 7/21/16.
//  Copyright © 2016 Frank Tellez. All rights reserved.
//

import UIKit
import Firebase

class AddTableView: UITableViewController {

    let profileRef = Firebase(url: "https://rentmyhouse.firebaseio.com/profiles")

    @IBOutlet weak var careerTextField: UITextField!
    @IBOutlet weak var hiringDateTextField: UITextField!
    @IBOutlet weak var workerImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var isOldToWork: UISwitch!
    @IBOutlet weak var emailTextFiel: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var isDev = false
    var dateOfBirthTimeInterval: NSTimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func isDevSwitch(){
        if isOldToWork.on{
            isDev = true
        }
        else{
            isDev = false
        }
    }

    @IBAction func saveEmployee(sender: AnyObject){
        
        let name = careerTextField.text
        let email = emailTextFiel.text
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let phoneNumber = phoneNumberTextField.text
        
        var data: NSData = NSData()
        if let image = workerImageView.image{
        data = UIImageJPEGRepresentation(image, 0.1)!
        }
        
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let newEmployee: NSDictionary = ["name": name!, "dob": dateOfBirthTimeInterval, "photo": base64String, "developer": isDev, "email": email!, "firstName": firstName!, "lastName":  lastName!, "phoneNumber": phoneNumber!]
        
        // Mark:  Add Firebase child node
        
        let profile = profileRef.ref.childByAppendingPath(name!)
        
        // Mark: write data to Firebase
        
        profile.setValue(newEmployee)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func datePicked(sender: AnyObject){
        dateOfBirthTimeInterval = datePicker.date.timeIntervalSinceNow
        hiringDateTextField.text = formatDate(datePicker.date)
    }
}

