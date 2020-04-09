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
    var datas = [MPRequestData]()
    
    let serialQueue = DispatchQueue(label: "com.manhpham.MPDebug")
    
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
    
    func run(completion: @escaping () -> Void) {
        serialQueue.async {
            completion()
        }
    }
        
    func sendData(data: MPRequestData) {
        if socketIOManager.isSocketConnected() {
            socketIOManager.send(data: data.getJsonData())
        }
    }
    
}

extension MPDebugLog: URLSessionInjectorDelegate {
    public func urlSessionInjector(_ injector: URLSessionInjector!, didStart dataTask: URLSessionDataTask!) {
        run {
            let dataResponse = MPRequestData(urlSessionDataTask: dataTask)
            if !self.datas.contains(dataResponse) {
                self.datas.append(dataResponse)
            } else {
                self.datas.filter({ $0 == dataResponse }).forEach({ $0.urlSessionDataTask = dataTask })
            }
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveResponse dataTask: URLSessionDataTask!, response: URLResponse!) {
        run {
            guard let dataResponse = self.datas.filter({ $0.urlSessionDataTask == dataTask }).first else { return }
            dataResponse.response = response
            self.sendData(data: dataResponse)
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveData dataTask: URLSessionDataTask!, data: Data!) {
        run {
            guard let dataResponse = self.datas.filter({ $0.urlSessionDataTask == dataTask }).first else { return }
            dataResponse.appendData(newData: data)
            self.sendData(data: dataResponse)
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didFinishWithError dataTask: URLSessionDataTask!, error: Error!) {
        run {
            guard let dataResponse = self.datas.filter({ $0.urlSessionDataTask == dataTask }).first else { return }
            self.sendData(data: dataResponse)
        }
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
