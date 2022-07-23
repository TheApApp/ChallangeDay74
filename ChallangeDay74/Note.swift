//
//  Note.swift
//  ChallangeDay74
//
//  Created by Michael Rowe on 7/22/22.
//

import UIKit

class Note: NSObject, NSCoding {
    var details: String

    init(details: String) {
        self.details = details
    }

    required init?(coder aDecoder: NSCoder) {
        details = aDecoder.decodeObject(forKey: "details") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(details, forKey: "details")
    }
}
