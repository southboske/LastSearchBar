//
//  ForDate.swift
//  BlueMoonLight
//
//  Created by Frank Tellez on 7/18/16.
//  Copyright © 2016 Frank Tellez. All rights reserved.
//

import Foundation


func formatDate(date: NSDate) -> String{
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    let dateString = dateFormatter.stringFromDate(date)
    return dateString
    
}