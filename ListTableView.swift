//
//  ListTableView.swift
//  BlueMoonLight
//
//  Created by Frank Tellez on 7/21/16.
//  Copyright © 2016 Frank Tellez. All rights reserved.
//

import UIKit
import Firebase


class ListTableView: UITableViewController, UISearchBarDelegate{//, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {
    

    var filteredFriends = [Employee]()
    var people = [Employee]()
    var isSearchActive: Bool = false
    var filtered = [Employee]()
    
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let profileRef = Firebase(url: "https://rentmyhouse.firebaseio.com/profiles")
    
    //var people = [Employee]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.people = [Employee]()
        loadDataFromFirebase()
        self.tableView2.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            return self.filteredFriends.count
        }
        else{
        return self.people.count
        }
    }

    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
//        let employeeList = people[indexPath.row]
//        cellCheckBox(cell, isDev: employeeList.developer)
//        configureCell(cell, indexPath: indexPath)
//        return cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath) as UITableViewCell
        
        var friend: Employee
        
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            let employeeList = people[indexPath.row]
            cellCheckBox(cell, isDev: employeeList.developer)
            configureCell(cell, indexPath: indexPath)
            friend = self.filteredFriends [indexPath.row]
        }
        else{
            let employeeList = people[indexPath.row]
            cellCheckBox(cell, isDev: employeeList.developer)
            configureCell(cell, indexPath: indexPath)
            friend = self.people[indexPath.row]
        }
        cell.textLabel!.text = friend.name
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        
        var friend : Employee
        
        if (tableView == self.searchDisplayController!.searchResultsTableView){
            let employeeList = people[indexPath.row]
            cellCheckBox(cell, isDev: employeeList.developer)
            configureCell(cell, indexPath: indexPath)
            friend = self.filteredFriends[indexPath.row]
        }
        else{
            let employeeList = people[indexPath.row]
            cellCheckBox(cell, isDev: employeeList.developer)
            configureCell(cell, indexPath: indexPath)
            friend = self.people[indexPath.row]
        }
        print(friend.name)
    }
    
    
    func filterContentForSearchText(searchText: String, scope: String = "Title"){
        self.filteredFriends = self.people .filter({(friend: Employee) -> Bool in
            let categoryMatch = (scope == "Title")
            let stringMatch = friend.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    
    func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        self.filterContentForSearchText(searchString!, scope: "Title")
        return true
    }
    
    
    func searchDisplayController(controller: UISearchController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!, scope: "Title")
        return true
    }
    
    
    func refresh(sender:AnyObject) {
        self.isSearchActive = false
        self.tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered.removeAll()
        
        for caseSensitive in people {
            if caseSensitive.name.rangeOfString(self.searchBar.text!, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil {
                filtered.append(caseSensitive)
            }
        }
        
        if searchText == " " {
            isSearchActive = false
            self.searchBar.endEditing(true)
        }
        else {
            isSearchActive = true
        }
        tableView.reloadData()
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let employeeList = people[indexPath.row]
            employeeList.ref?.removeValue()
            people.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)!
//        
//        let employeeList = people[indexPath.row]
//        
//        let toogle = !employeeList.developer
//        
//        cellCheckBox(cell, isDev: toogle)
//        
//        employeeList.developer = toogle
//        
//        people[indexPath.row] = employeeList
//        
//        employeeList.ref?.updateChildValues(["developer": toogle])
//        
//        tableView.reloadData()
//    }
    
    
    
    //  Mark -- Configure Cell
    
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath){
        let employeeList = people[indexPath.row]
        cell.textLabel?.text = employeeList.name
        let dobTimeInterval = employeeList.dob as NSTimeInterval
        populateTimeInterval(cell, timeInterval: dobTimeInterval)
        let base64String = employeeList.photo
        populateImage(cell, imageString: base64String)
    }
    
    func cellCheckBox(cell: UITableViewCell, isDev: Bool){
        if !isDev{
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.textColor = UIColor.blueColor()
            cell.detailTextLabel?.textColor = UIColor.blueColor()
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.detailTextLabel?.textColor = UIColor.grayColor()
        }
    }
    
    // Mark-- Populate Time Interval and Image
    
    func populateTimeInterval(cell: UITableViewCell, timeInterval: NSTimeInterval){
        let date = NSDate(timeIntervalSinceNow: timeInterval)
        let dateString = formatDate(date)
        cell.detailTextLabel?.text = dateString
    }

    func populateImage(cell: UITableViewCell, imageString: String){
        let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedData!)
        cell.imageView!.image = decodedImage
    }
    
    // Mark -- Load Data from firebase
    
    func loadDataFromFirebase(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        profileRef.observeEventType(FEventType.Value, withBlock: { (snaphot) in
            var newEmployee = [Employee]()
            for list in snaphot.children{
                let employeeList = Employee(snapshot: list as! FDataSnapshot)
                newEmployee.append(employeeList)
            }
            self.people = newEmployee
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    
     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CellIDJob"{
            if let cell = sender as? UITableViewCell{
                let indexPath = self.tableView.indexPathForCell(cell)!
                let destination = segue.destinationViewController as! DetailsTableVC
                destination.company = self.people [indexPath.row]
            }else{
                print("good two")
            }
        }
    }
        
    
    @IBAction func unwindToListTableView(sender: UIStoryboardSegue){
    }
}
