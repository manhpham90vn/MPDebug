//
//  SocketIOManager.swift
//  MPDebug
//
//  Created by Manh Pham on 4/6/20.
//

import SocketIO

class SocketIOManager {
    
    static let share = SocketIOManager()
    private var manager: SocketManager
    private var socket: SocketIOClient
        
    private init() {
        manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .reconnects(true), .compress])
        socket = manager.defaultSocket
    }
    
    func connect() {
        socket.connect()
    }
    
    func send(data: String) {
        socket.emit("on", data)
    }
    
    func isSocketConnected() -> Bool {
        return socket.status == .connected
    }
    
}
