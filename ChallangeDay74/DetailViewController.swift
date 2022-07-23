//
//  DetaillViewController.swift
//  ChallangeDay74
//
//  Created by Michael Rowe on 7/22/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var bodyText: UITextView!
    var details: String!
    var row: Int?
    var noteDictionary:[String: Any] = ["row": 0, "details":""]

    /// to do:
    /// Add keyboard is shown or hidden insets logic

    override func viewDidLoad() {
        super.viewDidLoad()

        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        navigationItem.rightBarButtonItems = [shareItem, deleteItem]
        bodyText?.text = details
    }

    override func viewWillDisappear(_ animated: Bool) {
        // save the changes
        let notificationCenter = NotificationCenter.default
        noteDictionary = ["row": row!, "details": bodyText.text!]
        notificationCenter.post(name: NSNotification.Name(rawValue: "SaveNote"), object: nil, userInfo: noteDictionary)
        print("Posted Save")
    }

    @objc func deleteNote() {
        let ac = UIAlertController(title: "Delete Note", message: "Are you sure?", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            let notificationCenter = NotificationCenter.default
            self.noteDictionary = ["row": self.row!, "details": self.bodyText!.text!]
            notificationCenter.post(name: NSNotification.Name(rawValue: "DeleteNote"), object: nil, userInfo: self.noteDictionary)
            print("Posted Delete")
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(okayAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }

    @objc func shareNote() {
        guard let details = bodyText.text else { return }

        let vc = UIActivityViewController(activityItems: [details], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
