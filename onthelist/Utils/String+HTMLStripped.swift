//
//  String+HTMLStripped.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import Foundation

extension String {
    var htmlStripped: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributed.string
        }

        return self
    }
}
