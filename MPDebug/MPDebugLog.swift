//
//  MPDebugLog.swift
//  MyApp
//
//  Created by Manh Pham on 4/5/20.
//

import Foundation
import MPDebugPrivate

public final class MPDebugLog {
        
    public static let share = MPDebugLog()
    init() { }
    
    var urlSessionInjector: URLSessionInjector!
    var urlConnectionInjector: URLConnectionInjector!
    var socketIOManager: SocketIOManager!
    let serialQueue = DispatchQueue(label: "com.manhpham.MPDebug")
    var datas = [DataResponse]()
    
    public func start(ip: String) {
        urlSessionInjector = URLSessionInjector(delegate: self)
        urlConnectionInjector = URLConnectionInjector(delegate: self)
        socketIOManager = SocketIOManager(ip: ip)
        socketIOManager.connect()
    }
    
    public func start() {
        urlSessionInjector = URLSessionInjector(delegate: self)
        urlConnectionInjector = URLConnectionInjector(delegate: self)
        socketIOManager = SocketIOManager()
        socketIOManager.connect()
    }
    
    func sendData(data: DataResponse) {
        if socketIOManager.isSocketConnected() {
            socketIOManager.send(data: data.getJsonData())
            datas.removeAll(where: { $0.taskIdentifier == data.taskIdentifier })
        }
    }
    
}

extension MPDebugLog: URLSessionInjectorDelegate {
    public func urlSessionInjector(_ injector: URLSessionInjector!, didStart dataTask: URLSessionDataTask!) {
        let dataResponse = DataResponse(taskIdentifier: dataTask.taskIdentifier)
        dataResponse.response.url = dataTask.currentRequest?.url?.absoluteString
        dataResponse.response.method = dataTask.currentRequest?.httpMethod
        dataResponse.response.userAgent = dataTask.currentRequest?.allHTTPHeaderFields?["User-Agent"]
        dataResponse.response.authorize = dataTask.currentRequest?.allHTTPHeaderFields?["Authorization"]
        dataResponse.response.httpBody =  DataResponseParser.parse(data: dataTask.currentRequest?.httpBody)?.description
        
        if !self.datas.contains(dataResponse) {
            self.datas.append(dataResponse)
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveResponse dataTask: URLSessionDataTask!, response: URLResponse!) {
        if let response = response as? HTTPURLResponse {
            self.datas.filter({ $0.taskIdentifier == dataTask.taskIdentifier }).forEach({ $0.response.statusCode = response.statusCode })
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveData dataTask: URLSessionDataTask!, data: Data!) {
        self.datas.filter({ $0.taskIdentifier == dataTask.taskIdentifier }).forEach({ $0.response.data = DataResponseParser.parse(data: data)?.description })
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didFinishWithError dataTask: URLSessionDataTask!, error: Error!) {
        guard let data = self.datas.filter({ $0.taskIdentifier == dataTask.taskIdentifier }).first else { return }
        self.sendData(data: data)
    }
}

extension MPDebugLog: URLConnectionInjectorDelegate {
    public func urlConnectionInjector(_ injector: URLConnectionInjector!, didReceiveResponse urlConnection: NSURLConnection!, response: URLResponse!) {

    }
    
    public func urlConnectionInjector(_ injector: URLConnectionInjector!, didReceiveData urlConnection: NSURLConnection!, data: Data!) {

    }
    
    public func urlConnectionInjector(_ injector: URLConnectionInjector!, didFailWithError urlConnection: NSURLConnection!, error: Error!) {

    }
    
    public func urlConnectionInjector(_ injector: URLConnectionInjector!, didFinishLoading urlConnection: NSURLConnection!) {

    }
}
