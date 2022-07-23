//
//  Note.swift
//  ChallangeDay74
//
//  Created by Michael Rowe on 7/22/22.
//

import UIKit

class Note: NSObject, NSCoding {
    var summary: String
    var body: String

    init(summary: String, body: String) {
        self.summary = summary
        self.body = body
    }

    required init?(coder aDecoder: NSCoder) {
        summary = aDecoder.decodeObject(forKey: "summary") as? String ?? ""
        body = aDecoder.decodeObject(forKey: "body") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(summary, forKey: "summary")
        aCoder.encode(body, forKey: "body")
    }
}
