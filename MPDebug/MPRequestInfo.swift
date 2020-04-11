//
//  MPRequestInfo.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

class MPRequestInfo: Codable {
    
    var id: String
    var date: String
    var url: String
    var statusCode: Int
    var method: String
    var userAgent: String
    var authorize: String
    var httpBody: String
    var data: String
    var deviceInfo: String = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion) \(UIDevice.current.name)"
    var deviceIdentifier: String = "\(UIDevice.current.identifierForVendor?.uuidString ?? "")"
        
    init(id: String, date: String) {
        self.id = id
        self.date = date
        self.url = ""
        self.statusCode = 0
        self.method = ""
        self.userAgent = ""
        self.authorize = ""
        self.httpBody = ""
        self.data = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case url = "url"
        case statusCode = "status_code"
        case method = "method"
        case userAgent = "user_agent"
        case authorize = "authorize"
        case httpBody = "http_body"
        case data = "data"
        case deviceInfo = "device_info"
        case deviceIdentifier = "device_identifier"
    }
    
}
