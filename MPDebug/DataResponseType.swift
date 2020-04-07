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

extension DataResponseType {
        
    var value: String {
        switch self {
        case .json(let value):
            return value
        case .image:
            return "Image"
        case .html:
            return "Html"
        }
    }
    
}
