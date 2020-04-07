//
//  DataResponseParser.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

struct Response: Codable {
    
    var date: String
    var url: String?
    var statusCode: Int?
    var method: String?
    var userAgent: String?
    var authorize: String?
    var httpBody: String?
    var data: String?
    
    init(date: String) {
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case url = "url"
        case statusCode = "status_code"
        case method = "method"
        case userAgent = "user_agent"
        case authorize = "authorize"
        case httpBody = "http_body"
        case data = "data"
    }
    
}

class DataResponse {
    
    let taskIdentifier: Int
    var response: Response
        
    init(taskIdentifier: Int) {
        self.taskIdentifier = taskIdentifier
        self.response = Response(date: DataResponse.getDate())
    }
    
    func getJsonData() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(response) else { return [:] }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        guard let json = jsonObject as? [String: Any] else { return [:] }
        return json
    }
    
    static func getDate() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
        
}

extension DataResponse: Equatable {
    static func ==(lhs: DataResponse, rhs: DataResponse) -> Bool {
        return lhs.taskIdentifier == rhs.taskIdentifier
    }
}
