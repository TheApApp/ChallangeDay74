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

    override func viewDidLoad() {
        super.viewDidLoad()

        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        navigationItem.rightBarButtonItems = [shareItem, deleteItem]
        bodyText?.text = details

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

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

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            bodyText.contentInset = .zero
        } else {
            bodyText.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        bodyText.scrollIndicatorInsets = bodyText.contentInset

        let selectedRange = bodyText.selectedRange
        bodyText.scrollRangeToVisible(selectedRange)
    }
}
