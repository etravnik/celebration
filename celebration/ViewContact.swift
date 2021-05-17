//
//  ViewContact.swift
//  celebration
//
//  Created by Elizabeth Travnik on 3/19/21.
//

import UIKit
import Contacts

class ViewContact: UIViewController {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var giftIdeasLabel: UILabel!
    @IBOutlet weak var pastGiftsLabel: UILabel!
    
    var contact = CNContact()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contactName.text = CNContactFormatter.string(from: contact, style: .fullName)
        
        var bdayString = "\((contact.birthday?.month)!)/\((contact.birthday?.day)!)"
        if (contact.birthday?.year) != nil {
            bdayString += "/\((contact.birthday?.year)!)"
        }
        
        birthdayLabel.text = bdayString
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
