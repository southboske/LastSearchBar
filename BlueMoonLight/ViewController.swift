//
//  ViewController.swift
//  BlueMoonLight
//
//  Created by Frank Tellez on 7/17/16.
//  Copyright © 2016 Frank Tellez. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    let firebase = Firebase(url:"https://rentmyhouse.firebaseio.com/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        firebase.setValue("Hello, I am Frank, and I am working here")
        firebase.setValue(["name": "Frank","developer" : true])
        
        let dict = ["developer" : false]
        firebase.updateChildValues(dict)
        
//        let itemsRef = Firebase(url: "https://rentmyhouse.firebaseio.com/items")
//        let itemsRef = Firebase(url: "https://rentmyhouse.firebaseio.com/items/item1")
//
//        let itemsR = firebase.childByAppendingPath("items")
//        let item1R = firebase.childByAppendingPath("items").childByAppendingPath("item1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

