//
//  DataResponseParser.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

import Foundation

enum DataResponseParser {
    
    static func parse(data: Data?) -> DataResponseType? {
        guard let data = data else { return nil }
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    return .json(value: jsonString)
                }
            }
        } else if let image = UIImage(data: data) {
            return .image(value: image)
        } else if let htmlString = try? NSMutableAttributedString(data: data,
                                                                  options: [.documentType: NSMutableAttributedString.DocumentType.html, // swiftlint:disable:this line_length
                                                                            .characterEncoding: String.Encoding.utf8.rawValue], // swiftlint:disable:this line_length
                                                                  documentAttributes: nil) {
            return .html(value: htmlString)
        }
        return nil
    }
    
}
