//
//  File.swift
//  
//
//  Created by Matt Bonney on 12/17/22.
//

import Foundation

public extension String {
    /// Generates a random alphanumeric string of a given length.
    static func randomAlphaNumeric(length: Int) -> String {
        let digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String(
            Array(0..<length).map { _ in
                digits.randomElement()!
            }
        )
    }
}

public extension String {
    static let lorem =  """
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        quis nostrud exercitation ullamco laboris.
                        """

    static func lorem(paragraphs: Int) -> String {
        var stringBuilder = ""
        for _ in (0..<paragraphs) {
            stringBuilder.append(contentsOf: String.lorem)
            if paragraphs > 1 {
                stringBuilder.append(contentsOf: "\n")
                stringBuilder.append(contentsOf: "\n")
            }
        }
        return stringBuilder
    }
}

public extension String {

    //    func hashtags(andRemoveHashtag: Bool) -> [String] {
    //        if let regex = try? NSRegularExpression(pattern: "#[a-z0-9]+", options: .caseInsensitive)
    //        {
    //            let string = self as NSString
    //
    //            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
    //                string.substring(with: $0.range).replacingOccurrences(of: "#", with: "").lowercased()
    //            }
    //        }
    //
    //        return []
    //    }

    /// Extracts hashtags from a string, with an option to keep the hashmark character or not.
///
/// - Parameter maintainingHashmark: A Boolean indicating if the hashmark character should be included in the extracted hashtags.
///
/// - Returns: An array of strings, each representing a hashtag extracted from the string.
func hashtags(maintainingHashmark: Bool = true) -> [String] {
    if let regex = try? NSRegularExpression(pattern: "#[a-z0-9]+", options: .caseInsensitive) {
        let string = self as NSString

        return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
            let sub = string.substring(with: $0.range)
            if maintainingHashmark {
                return sub.lowercased()
            } else {
                return sub.replacingOccurrences(of: "#", with: "").lowercased()
            }
        }
    }
    return []
}

}
