//
//  Note.swift
//  ChallangeDay74
//
//  Created by Michael Rowe on 7/22/22.
//

import UIKit

class Note: NSObject, NSCoding {
    var summary: String
    var details: String

    init(summary: String, details: String) {
        self.summary = summary
        self.details = details
    }

    required init?(coder aDecoder: NSCoder) {
        summary = aDecoder.decodeObject(forKey: "summary") as? String ?? ""
        details = aDecoder.decodeObject(forKey: "details") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(summary, forKey: "summary")
        aCoder.encode(details, forKey: "details")
    }
}
