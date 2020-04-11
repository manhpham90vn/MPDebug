//
//  MPDataResponseType.swift
//  MPDebug
//
//  Created by Manh Pham on 4/6/20.
//

import UIKit

enum MPDataResponseType {
    case json(value: String)
    case image(value: UIImage)
    case html(value: NSMutableAttributedString)
    case string(value: String)
    case unknown
}

extension MPDataResponseType {
        
    var description: String {
        switch self {
        case .json(let value):
            return value
        case .image(let value):
            return "Image Count = \(value.jpegData(compressionQuality: 1)?.count ?? 0) Width = \(value.size.width) Height = \(value.size.height)"
        case .html(let value):
            return value.string
        case .string(let value):
            return value
        case .unknown:
            return ""
        }
    }
    
}
