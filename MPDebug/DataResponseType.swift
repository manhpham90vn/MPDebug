//
//  DataResponseType.swift
//  MPDebug
//
//  Created by Manh Pham on 4/6/20.
//

import UIKit

enum DataResponseType {
    case json(value: String)
    case image(value: UIImage)
    case html(value: NSMutableAttributedString)
    case string(value: String)
}

extension DataResponseType {
        
    var description: String {
        switch self {
        case .json(let value):
            return value
        case .image(let value):
            return "Image Width = \(value.size.width) Height = \(value.size.height)"
        case .html(let value):
            return "Html Count = \(value.string.count)"
        case .string(let value):
            return value
        }
    }
    
}
