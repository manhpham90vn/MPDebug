//
//  MPDebugLog.swift
//  MyApp
//
//  Created by Manh Pham on 4/5/20.
//

import Foundation
import MPDebugPrivate

public final class MPDebugLog: NSObject {
        
    public static let share = MPDebugLog()
    
    private var urlSessionInjector: URLSessionInjector?
    private var urlConnectionInjector: URLConnectionInjector?
    private let serialQueue = DispatchQueue(label: "com.manhpham.MPDebug")
    
    public func start() {
        urlSessionInjector = URLSessionInjector(delegate: self)
        urlConnectionInjector = URLConnectionInjector(delegate: self)
    }
    
    public func run(completion: @escaping () -> Void) {
        serialQueue.async {
            completion()
        }
    }
    
}

extension MPDebugLog: URLSessionInjectorDelegate {
    public func urlSessionInjector(_ injector: URLSessionInjector!, didStart dataTask: URLSessionDataTask!) {
        run {
            print("URLSessionInjectorDelegate didStart")
            print(dataTask.currentRequest?.url ?? "")
            print(dataTask.currentRequest?.httpBody ?? "")
            print(dataTask.currentRequest?.httpMethod ?? "")
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveResponse dataTask: URLSessionDataTask!, response: URLResponse!) {
        run {
            print("URLSessionInjectorDelegate didReceiveResponse")
            print(response ?? "")
        }
        
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didReceiveData dataTask: URLSessionDataTask!, data: Data!) {
        run {
            print("URLSessionInjectorDelegate didReceiveData")
            print(DataResponseParser.parse(data: data)?.type ?? "")
        }
    }
    
    public func urlSessionInjector(_ injector: URLSessionInjector!, didFinishWithError dataTask: URLSessionDataTask!, error: Error!) {
        run {
            print("URLSessionInjectorDelegate didFinishWithError")
            print(error ?? "")
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
