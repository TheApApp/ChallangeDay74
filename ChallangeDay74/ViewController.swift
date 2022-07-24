//
//  ViewController.swift
//  ChallangeDay74
//
//  Created by Michael Rowe on 7/22/22.
//

import UIKit
import UserNotifications

class ViewController: UITableViewController, UNUserNotificationCenterDelegate {
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        title = "MR Notes"

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(deleteNotificationReceived(_:)), name: Notification.Name("DeleteNote"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveNotificationReceived(_:)), name: Notification.Name("SaveNote"), object: nil)
        let defaults = UserDefaults.standard

        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            if let decodedNotes = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedNotes) as? [Note] {
                notes = decodedNotes
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = String(note.details.prefix(60))
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // add content
            let note = notes[indexPath.row]
            vc.details = note.details
            vc.row = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
            self.tableView.reloadData()
        }
    }

    @objc func addNote() {
        let note = Note(details: "")
        notes.append(note)
        save()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // add content
            vc.details = ""
            vc.row = notes.count-1
            navigationController?.pushViewController(vc, animated: true)
            self.tableView.reloadData()
        }
    }

    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: notes, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        }
    }

    func delete(at row: Int) {
        notes.remove(at: row)
        save()
        self.tableView.reloadData()
    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let save = UNNotificationAction(identifier: "save", title: "Tell me more…", options: .foreground)
        let delete = UNNotificationAction(identifier: "delete", title: "Tell me more…", options: .foreground)
        let category = UNNotificationCategory(identifier: "note", actions: [save, delete], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }

    @objc func deleteNotificationReceived(_ notification: Notification) {
        guard let row = notification.userInfo?["row"] as? String else { return }
        print(row)
        delete(at: Int(row)!)

    }

    @objc func saveNotificationReceived(_ notification: Notification) {
        guard let row  = notification.userInfo?["row"] as? Int else { return }
        guard let details = notification.userInfo?["details"] as? String else { return }
        print("row = \(row) details = \(details)")
        notes[row].details = details
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: notes, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        }
        self.tableView.reloadData()

    }

}

