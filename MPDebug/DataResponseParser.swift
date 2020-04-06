//
//  DataResponseParser.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

import Foundation
import UIKit
import MPDebugPrivate

public enum DataResponseType {
    case json(value: String)
    case image(value: UIImage)
    case html(value: NSAttributedString)
}

public struct DataResponse {
    
    var originalData: Data?
    var type: DataResponseType!
    
    init(data: Data) {
        self.originalData = data
    }
}

public enum DataResponseParser {
    
    static func parse(data: Data) -> DataResponse? {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    var jsonData = DataResponse(data: data)
                    jsonData.type = .json(value: jsonString)
                    return jsonData
                }
            }
        } else if let image = UIImage(data: data) {
            var imageData = DataResponse(data: data)
            imageData.type = .image(value: image)
            return imageData
        } else if let htmlString = try? NSMutableAttributedString(data: data,
                                                                  options: [.documentType: NSMutableAttributedString.DocumentType.html, // swiftlint:disable:this line_length
                                                                            .characterEncoding: String.Encoding.utf8.rawValue], // swiftlint:disable:this line_length
                                                                  documentAttributes: nil) {
            var textData = DataResponse(data: data)
            textData.type = .html(value: htmlString)
            return textData
        }
        return nil
    }
    
}
