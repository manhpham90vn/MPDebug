//
//  MPRequestData.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

class MPRequestData {
    
    let id: String = UUID().uuidString
    var urlSessionDataTask: URLSessionDataTask
    var response = URLResponse()
    var data = Data()
    
    init(urlSessionDataTask: URLSessionDataTask) {
        self.urlSessionDataTask = urlSessionDataTask
    }
        
    func appendData(newData: Data) {
        data.append(newData)
    }
    
    func getJsonData() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(getResponse()) else { return [:] }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return [:] }
        guard let json = jsonObject as? [String: Any] else { return [:] }
        return json
    }
    
    func getResponse() -> MPRequestInfo {
        let dataResponse = MPRequestInfo(id: id, date: MPRequestData.getDate())
        dataResponse.url = urlSessionDataTask.originalRequest?.url?.absoluteString ?? ""
        if let httpURLResponse = response as? HTTPURLResponse {
            dataResponse.statusCode = httpURLResponse.statusCode
        }
        dataResponse.userAgent = urlSessionDataTask.currentRequest?.allHTTPHeaderFields?["User-Agent"] ?? ""
        dataResponse.authorize = urlSessionDataTask.currentRequest?.allHTTPHeaderFields?["Authorization"] ?? ""
        dataResponse.method = urlSessionDataTask.originalRequest?.httpMethod ?? ""
        dataResponse.httpBody =  MPDataResponseParser.parse(data: urlSessionDataTask.originalRequest?.httpBody).description
        dataResponse.data = MPDataResponseParser.parse(data: data).description
        return dataResponse
    }
    
    static func getDate() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
        
}

extension MPRequestData: Equatable {
    static func ==(lhs: MPRequestData, rhs: MPRequestData) -> Bool {
        return lhs.urlSessionDataTask == rhs.urlSessionDataTask
    }
}
