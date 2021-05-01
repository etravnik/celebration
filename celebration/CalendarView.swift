//
//  CalendarView.swift
//  celebration
//
//  Created by Elizabeth Travnik on 3/19/21.
//

import UIKit
import FSCalendar
import Contacts

class CalendarView: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendarMain: FSCalendar!
    
    
    @IBAction func homeButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    let store = CNContactStore();
    var formatter = DateFormatter()
    var contact_list = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contact_list = getContacts()
        calendarMain.delegate = self
        calendarMain.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - FS Calendar DataSource
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let calendar = Calendar.current
        
        /*print(calendar.component(.year, from: currentDate))
        print(calendar.component(.month, from: currentDate))
        print(calendar.component(.day, from: currentDate))*/
        
        for contact in contact_list {
            if (contact.birthday?.day)! == calendar.component(.day, from: date) && (contact.birthday?.month)! == calendar.component(.month, from: date) {
                return 1
            }
        }
        
        return 0
    }
    
    // MARK: - Contact Data
    func getContacts() -> [CNContact] {
        do {
            var big_contacts = [CNContact]();
            let big_keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactBirthdayKey as CNKeyDescriptor];
            let big_request = CNContactFetchRequest(keysToFetch: big_keys)
            
            try store.enumerateContacts(with: big_request) {
                (contact, stop) in
                big_contacts.append(contact)
            }
            
            // filter array of contacts based on who has a birthday
            var bday_contacts = big_contacts.filter { $0.birthday?.day != nil }
            
            // sort contacts by birthday in order, ignoring year (should work)
            bday_contacts.sort { ($0.birthday?.day)! < ($1.birthday?.day)! }
            bday_contacts.sort { ($0.birthday?.month)! < ($1.birthday?.month)! }
            
            return bday_contacts
        } catch {
            print("Failed to fetch contact, error: \(error)");
        }
        return []
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToCalendar (_ sender: UIStoryboardSegue) {
        contact_list = getContacts()
        calendarMain.reloadData()
    }

}
