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
    private init() { }
    
    private var urlSessionInjector: URLSessionInjector?
    private var urlConnectionInjector: URLConnectionInjector?
    private let serialQueue = DispatchQueue(label: "com.manhpham.MPDebug")
    
    private var datas = [DataResponse]()
    
    public func start() {
        urlSessionInjector = URLSessionInjector(delegate: self)
        urlConnectionInjector = URLConnectionInjector(delegate: self)
        SocketIOManager.share.connect()
    }
    
    func run(completion: @escaping () -> Void) {
        serialQueue.async {
            completion()
        }
    }
        
    func sendData(data: DataResponse) {
        if SocketIOManager.share.isSocketConnected() {
            SocketIOManager.share.send(data: data.description)
            datas.removeAll(where: { $0.urlSessionDataTask == data.urlSessionDataTask })
        }
    }
    
}

extension MPDebugLog: URLSessionInjectorDelegate {
    public func urlSessionInjector(_ injector: URLSessionInjector!, didStart dataTask: URLSessionDataTask!) {
        run {
            self.datas.append(DataResponse(urlSessionDataTask: dataTask))
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveResponse dataTask: URLSessionDataTask!, response: URLResponse!) {
        run {
            self.datas.filter({ $0.urlSessionDataTask == dataTask }).forEach({ $0.urlResponse = response })
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveData dataTask: URLSessionDataTask!, data: Data!) {
        run {
            self.datas.filter({ $0.urlSessionDataTask == dataTask }).forEach({ $0.data = data; $0.type = DataResponseParser.parse(data: data) })
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didFinishWithError dataTask: URLSessionDataTask!, error: Error!) {
        run {
            guard let data = self.datas.filter({ $0.urlSessionDataTask == dataTask }).first else { return }
            self.sendData(data: data)
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
