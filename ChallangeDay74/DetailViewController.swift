//
//  DetaillViewController.swift
//  ChallangeDay74
//
//  Created by Michael Rowe on 7/22/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    var summary: String?
    var body: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Compose", style: .plain, target: self, action: #selector(compose))
        summaryLabel?.text = summary
        bodyText?.text = body
        // Do any additional setup after loading the view.
    }
    

    @objc func compose() {

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
