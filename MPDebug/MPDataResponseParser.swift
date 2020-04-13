//
//  MPDataResponseParser.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

import UIKit

enum MPDataResponseParser {
    
    static func parse(data: Data?) -> MPDataResponseType {
        guard let data = data else { return .unknown }
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    return .json(value: jsonString)
                }
            }
        } else if let dataString = String(data: data, encoding: .utf8) {
            return .string(value: dataString)
        } else if let htmlString = try? NSMutableAttributedString(data: data,
                                                                  options: [:],
                                                                  documentAttributes: nil) {
            return .html(value: htmlString)
        }
        return .unknown
    }
    
}
