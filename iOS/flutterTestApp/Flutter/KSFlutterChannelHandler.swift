//
//  KSFlutterChannelHandler.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/24.
//

import Foundation
import Flutter

/// 处理与flutter通信的类
class KSFlutterChannelHandler {
    
    /// 消息通道
    let messageChannel: FlutterBasicMessageChannel
    /// 方法通道
    let methodChannel: FlutterMethodChannel
    
    /// 是否已经收到flutter传来的第一条信息(用于确认通道是否已经初始化完成)
    private var _isGetFirstMessage: Bool = false
    
    /// 创建
    init(engine: FlutterEngine) {
        let messageChannel = FlutterBasicMessageChannel(name: "/app/message", binaryMessenger: engine.binaryMessenger)
        
        self.messageChannel = messageChannel
        
        // 用于给flutter调用方法的通道
        let methodChannel = FlutterMethodChannel(name: "/app/method", binaryMessenger: engine.binaryMessenger)
        self.methodChannel = methodChannel
        
        self.setup()
    }
    
    /// 通道是否能用了
    func isChannelCanUse() -> Bool {
        return _isGetFirstMessage
    }
    
    func setup() {
        // 消息回调监听
        self.messageChannel.setMessageHandler { [weak self] message, result in
            print("收到flutter信息: \(String(describing: message))")
            self?._isGetFirstMessage = true
            result("native已收到")
        }
        
        // 方法回调监听
        self.methodChannel.setMethodCallHandler { call, result in
            print("\(call.method)")
            print("\(String(describing: call.arguments))")
            let method = KSFlutterMethod.init(rawValue: call.method)
            if method == .getLocalizeName {
                if let localizeKey: String = call.arguments as? String {
                    result(NSLocalizedString(localizeKey, comment: ""))
                }
            } else if method == .requestMessageList {
                if let dict = call.arguments as? [String: Any], let page = dict["page"] as? Int, 
                    let pageSize = dict["page_size"] as? Int {
                    result(self.requestMessageList(page: page, pageSize: pageSize))
                }
            } else {
                // 没实现对应方法
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
}

// 消息发送的方法
extension KSFlutterChannelHandler {
    
    /// 创建信息字符串
    private func createMessageString(message: KSToFlutterMessageName, data: Any) -> String {
        let dict = [
        "message": message.rawValue,
        "data": data
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []), let string = String.init(data: jsonData, encoding: .utf8) {
            return string
        }
        return ""
    }
    
    /// 更换flutter根页面
    func changeRootRoute(routeName: KSFlutterPageRouteName) {
        let message = self.createMessageString(message: .changeRootRoute, data: routeName.rawValue)
    
        self.messageChannel.sendMessage(message) { reply in
            // 来自flutter的返回信息
        }
    }
}

// 给flutter调用的方法
extension KSFlutterChannelHandler {
    
    /// 请求消息列表
    func requestMessageList(page: Int, pageSize: Int) -> String {
        var list: [[String: String]] = []
        // 生成假数据
        for i in 0..<pageSize {
            list.append([
            "title": "标题 \(i+page*pageSize)",
            "time": "2022-05-01 08:08:08"
            ])
        }
        var result = ""
        if let data = try? JSONSerialization.data(withJSONObject: list, options: []), let string = String.init(data: data, encoding: .utf8) {
            result = string
        }
        
        return result
    }
}
