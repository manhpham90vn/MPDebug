//
//  DataResponseParser.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

struct Response: Codable {
    
    var date: String
    var url: String
    var method: String
    var userAgent: String
    var request: String
    var response: String
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case url = "url"
        case method = "method"
        case userAgent = "user_agent"
        case request = "request"
        case response = "response"
    }
    
}

class DataResponse {
    
    var type: DataResponseType?
    var data: Data?
    var urlResponse: URLResponse?
    var urlSessionDataTask: URLSessionDataTask
        
    init(urlSessionDataTask: URLSessionDataTask) {
        self.urlSessionDataTask = urlSessionDataTask
    }
    
    var description: [String: Any] {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd-MM-yyyy"
        let dateString = dateFormatter.string(from: Date())
        let url = urlSessionDataTask.currentRequest?.url?.absoluteString ?? ""
        let httpMethod = urlSessionDataTask.currentRequest?.httpMethod ?? ""
        let userAgent = urlSessionDataTask.currentRequest?.allHTTPHeaderFields?["User-Agent"] ?? ""
        let httpBody = DataResponseParser.parse(data: urlSessionDataTask.currentRequest?.httpBody)?.value ?? ""
        let httpResponse = DataResponseParser.parse(data: data)?.value ?? ""
        let response = Response(date: dateString, url: url, method: httpMethod, userAgent: userAgent, request: httpBody, response: httpResponse)
        guard let data = try? JSONEncoder().encode(response) else { return [:] }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        guard let json = jsonObject as? [String: Any] else { return [:] }
        return json
    }
    
}

