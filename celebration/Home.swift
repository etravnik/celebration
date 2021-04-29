//
//  Home.swift
//  celebration
//
//  Created by Elizabeth Travnik on 3/19/21.
//

import UIKit
import Contacts
import CoreData

class Home: UIViewController {
    
    var container: NSPersistentContainer!

    let contact = CNMutableContact();
    let store = CNContactStore();
    var loaded = false;
    
    @IBOutlet weak var contactNameOne: UILabel!
    @IBOutlet weak var contactNameTwo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
        
        do {
            let predicate = CNContact.predicateForContacts(matchingName: "Travnik");
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactBirthdayKey as CNKeyDescriptor];
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch);
            let firstMatch = contacts[0];
            
            print("Fetched contacts: \(firstMatch)");
            let fullNameOne = CNContactFormatter.string(from: firstMatch, style: .fullName);
            
            contactNameOne.text = fullNameOne;
            
            let predicateTwo = CNContact.predicateForContacts(matchingName: "Kuse");
            let keysToFetchTwo = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactBirthdayKey as CNKeyDescriptor];
            let contactsTwo = try store.unifiedContacts(matching: predicateTwo, keysToFetch: keysToFetchTwo);
            let firstMatchTwo = contactsTwo[0];
            
            print("Fetched contacts: \(firstMatchTwo)");
            let fullNameTwo = CNContactFormatter.string(from: firstMatchTwo, style: .fullName);
            
            contactNameTwo.text = fullNameTwo;
            
            // get all contacts from phone and store in array
            var big_contacts = [CNContact]();
            let big_keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactBirthdayKey as CNKeyDescriptor];
            let big_request = CNContactFetchRequest(keysToFetch: big_keys)
            
            try store.enumerateContacts(with: big_request) {
                (contact, stop) in
                big_contacts.append(contact)
            }
            
            // filter array of contacts based on who has a birthday
            let bday_contacts = big_contacts.filter { $0.birthday?.day != nil }
            for contact in bday_contacts {
                print("oh boy here we go: \(String(describing: contact.familyName)) \(String(describing: contact.birthday?.year))");
            }
            
            //print("oh boy here we go: \(String(describing: contactsTwo[0].familyName)) \(String(describing: contactsTwo[0].birthday?.year))");
            
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
    }
    */

}
