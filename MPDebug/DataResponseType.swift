//
//  DataResponseType.swift
//  MPDebug
//
//  Created by Manh Pham on 4/6/20.
//

enum DataResponseType {
    case json(value: String)
    case image(value: UIImage)
    case html(value: NSAttributedString)
}

extension DataResponseType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .json(let value):
            return "json \(value)"
        case .image:
            return "image"
        case .html:
            return "html"
        }
    }
    
}
