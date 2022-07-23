//
//  ViewController.swift
//  ChallangeDay74
//
//  Created by Michael Rowe on 7/22/22.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        navigationItem.title = "Notes"
        // Do any additional setup after loading the view.
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
        cell.textLabel?.text = note.summary
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // add content
            let note = notes[indexPath.row]
            vc.body = note.body
            vc.summary = note.summary

            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func addNote() {
        let note = Note(summary: "Test", body: "A whole bunch more stuff")
        notes.append(note)
    }

}

