//
//  Employee.swift
//  BlueMoonLight
//
//  Created by Frank Tellez on 7/22/16.
//  Copyright © 2016 Frank Tellez. All rights reserved.
//

import Foundation
import Firebase

class Employee {

    let name: String!
    let dob: Double!
    let photo: String!
    let developer: Bool!
    
    let email: String!
    let firstName: String!
    let lastName: String!
    let phoneNumber: String!
    
    let ref: Firebase?
    
    init(snapshot: FDataSnapshot){
        
        self.name = snapshot.value["name"] as! String
        self.dob = snapshot.value["dob"] as! Double
        self.photo = snapshot.value["photo"] as! String
        self.developer = snapshot.value["developer"] as! Bool
        
        self.email = snapshot.value["email"] as! String
        self.firstName = snapshot.value["firstName"] as! String
        self.lastName = snapshot.value["lastName"] as! String
        self.phoneNumber = snapshot.value["phoneNumber"] as! String

        self.ref = snapshot.ref
    }    
}

//        let newEmployee: NSDictionary = ["name": name!, "dob": dateOfBirthTimeInterval, "photo": base64String, "developer": isDev, "email": email!, "firstName": firstName!, "lastName":  lastName!, "phoneNumber": phoneNumber!]