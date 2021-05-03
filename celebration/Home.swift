//
//  Home.swift
//  celebration
//
//  Created by Elizabeth Travnik on 3/19/21.
//

import UIKit
import Contacts
import MaterialComponents
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialCards_Theming

//import MDCCardCollectionCell


class Home: UIViewController {
    
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    let contact = CNMutableContact();
    let store = CNContactStore();
    var loaded = false;
    
    @IBOutlet weak var contactNameOne: UILabel!
    @IBOutlet weak var contactNameTwo: UILabel!
    @IBOutlet weak var contactNameThree: UILabel!
    @IBOutlet weak var birthdayOne: UILabel!
    @IBOutlet weak var birthdayTwo: UILabel!
    @IBOutlet weak var birthdayThree: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            /*let predicateTwo = CNContact.predicateForContacts(matchingName: "Kuse");
            /let keysToFetchTwo = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactBirthdayKey as CNKeyDescriptor];
            let contactsTwo = try store.unifiedContacts(matching: predicateTwo, keysToFetch: keysToFetchTwo);
            let firstMatchTwo = contactsTwo[0];
            
            print("Fetched contacts: \(firstMatchTwo)");
            let fullNameTwo = CNContactFormatter.string(from: firstMatchTwo, style: .fullName);
            
            contactNameTwo.text = fullNameTwo;
            */
            
            // get all contacts from phone and store in array
            var big_contacts = [CNContact]();
            let big_keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactBirthdayKey as CNKeyDescriptor];
            let big_request = CNContactFetchRequest(keysToFetch: big_keys)
            
            try store.enumerateContacts(with: big_request) {
                (contact, stop) in
                big_contacts.append(contact)
            }
            
            // filter array of contacts based on who has a birthday
            var bday_contacts = big_contacts.filter { $0.birthday?.day != nil }
            
            let currentDate = Date()
            let calendar = Calendar.current
            
            /*print(calendar.component(.year, from: currentDate))
            print(calendar.component(.month, from: currentDate))
            print(calendar.component(.day, from: currentDate))*/
            
            
            // sort contacts by birthday in order, ignoring year (should work)
            bday_contacts.sort { ($0.birthday?.day)! < ($1.birthday?.day)! }
            bday_contacts.sort { ($0.birthday?.month)! < ($1.birthday?.month)! }
            
            for contact in bday_contacts {
                print("oh boy here we go: \(String(describing: contact.familyName)) \(String(describing: contact.birthday?.year))");
            }
            
            print("-------------------")
            
            // filter birthdays that have already passed
            bday_contacts = bday_contacts.filter {
                (($0.birthday?.month)! > calendar.component(.month, from: currentDate)) || (($0.birthday?.month)! == calendar.component(.month, from: currentDate) && ($0.birthday?.day)! >= calendar.component(.day, from: currentDate))
            }
            
            for contact in bday_contacts {
                print("oh boy here we go: \(String(describing: contact.familyName)) \(String(describing: contact.birthday?.year))");
            }
            //let fullNameTwo = CNContactFormatter.string(from: firstMatchTwo, style: .fullName);
            
            if bday_contacts.count > 0 {
                let curr_contact = bday_contacts[0]
                contactNameOne.text = CNContactFormatter.string(from: curr_contact, style: .fullName)
                birthdayOne.text = Months[(curr_contact.birthday?.month)! - 1] + " \((curr_contact.birthday?.day)!)"
            }
            
            if bday_contacts.count > 1 {
                let curr_contact = bday_contacts[1]
                contactNameTwo.text = CNContactFormatter.string(from: curr_contact, style: .fullName)
                birthdayTwo.text = Months[(curr_contact.birthday?.month)! - 1] + " \((curr_contact.birthday?.day)!)"
            }
            
            if bday_contacts.count > 2 {
                let curr_contact = bday_contacts[2]
                contactNameThree.text = CNContactFormatter.string(from: curr_contact, style: .fullName)
                birthdayThree.text = Months[(curr_contact.birthday?.month)! - 1] + " \((curr_contact.birthday?.day)!)"
            }
            
        } catch {
            print("Failed to fetch contact, error: \(error)");
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/

}
