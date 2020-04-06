//
//  DataResponseParser.swift
//  MPDebug
//
//  Created by Manh Pham on 4/5/20.
//

class DataResponse {
    
    var type: DataResponseType?
    var data: Data?
    var urlResponse: URLResponse?
    var urlSessionDataTask: URLSessionDataTask
        
    init(urlSessionDataTask: URLSessionDataTask) {
        self.urlSessionDataTask = urlSessionDataTask
    }
    
}

extension DataResponse: CustomStringConvertible {
    
    var description: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd-MM-yyyy"
        let dateString = dateFormatter.string(from: Date())
        let url = (urlSessionDataTask.currentRequest?.url?.absoluteString ?? "")
        let httpMethod = (urlSessionDataTask.currentRequest?.httpMethod ?? "")
        let typeDescription = (type?.description ?? "")
        return dateString + " " + url + " " + httpMethod + " " + typeDescription
    }
    
}
