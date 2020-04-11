//
//  MPRequestData.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

extension Notification.Name {
    static let requestTimeOut = Notification.Name("requestTimeOut")
}

class MPRequestData {
    
    let id: String = UUID().uuidString
    var urlSessionDataTask: URLSessionDataTask
    var timer = Timer()
    var response = URLResponse()
    var data = Data()
    var defaultTimeOut = 5
    
    init(urlSessionDataTask: URLSessionDataTask) {
        self.urlSessionDataTask = urlSessionDataTask
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
        
    @objc func handleTimer() {
        if defaultTimeOut > 0 {
            defaultTimeOut -= 1
        } else {
            timer.invalidate()
            NotificationCenter.default.post(name: .requestTimeOut, object: self)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        let dataResponse = MPRequestInfo(id: id, date: getDate())
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
    
    func getDate() -> String {
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
