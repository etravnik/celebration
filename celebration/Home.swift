//
//  Home.swift
//  celebration
//
//  Created by Elizabeth Travnik on 3/19/21.
//

import UIKit
import Contacts

class Home: UIViewController {

    let contact = CNMutableContact();
    let store = CNContactStore();
    var loaded = false;
    
    @IBOutlet weak var contactNameOne: UILabel!
    @IBOutlet weak var contactNameTwo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*contact.givenName = "Connor";
        contact.familyName = "Kuse";
        
        var birthday = DateComponents();
        birthday.day = 20;
        birthday.month = 8;
        birthday.year = 1999;
        contact.birthday = birthday;
        
        // save contact via request
        let saveRequest = CNSaveRequest();
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        
        do {
            try store.execute(saveRequest);
            loaded = true;
        } catch {
            print("Saving contact failed, error: \(error)");
        }*/
        
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
