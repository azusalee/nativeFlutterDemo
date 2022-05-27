//
//  KSFlutterMessageName.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/25.
//

import Foundation

/**
 向Flutter发送Message的名字枚举
 
 所有消息都按以下的格式发送
 {
 "message": "changeRootRoute",
 "data": String
 }
 */
enum KSToFlutterMessageName: String {
    /// 更换flutter的根页面(已经不用了)
    /// 带参数String，更换的页面的Route Key
    case changeRootRoute
    
}

/// 由flutter发过来的消息
enum KSFromFlutterMessageName: String {
    /// 说明初始化完成
    case channelSetup
}
