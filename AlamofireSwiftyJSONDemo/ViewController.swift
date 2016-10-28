//
//  ViewController.swift
//  AlamofireSwiftyJSONDemo
//
//  Created by cyper on 28/10/2016.
//  Copyright © 2016 cyper tech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contacts = [[String: AnyObject]]() // Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON {
            (res) in
            
            guard let resultValue = res.result.value else {
                return
            }
            
            let swiftyJsonVar = JSON(resultValue)
            if let resData = swiftyJsonVar["contacts"].arrayObject {
                self.contacts = resData as! [[String: AnyObject]]
            }
            
            if self.contacts.count > 0 {
                self.contactsTableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact["name"] as? String
        cell.detailTextLabel?.text = contact["email"] as? String
        
        return cell
    }
    
}

