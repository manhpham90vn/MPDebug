//
//  MPDataResponseType.swift
//  MPDebug
//
//  Created by Manh Pham on 4/6/20.
//

import UIKit

enum MPDataResponseType {
    case json(value: String)
    case html(value: NSMutableAttributedString)
    case string(value: String)
    case unknown
}

extension MPDataResponseType {
        
    var description: String {
        switch self {
        case .json(let value):
            return value
        case .html(let value):
            return value.string
        case .string(let value):
            return value
        case .unknown:
            return ""
        }
    }
    
}
