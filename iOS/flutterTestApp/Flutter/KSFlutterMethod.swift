//
//  KSFlutterMethod.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/24.
//

import Foundation

/// 从flutter发过来的方法名 枚举
struct KSFlutterMethod: RawRepresentable, Equatable {
    /// 获取本地化名字
    /// 带参数String，对应本地化的key
    /// 返回本地化文字String
    static let getLocalizeName = KSFlutterMethod(rawValue: "getLocalizeName")
    
    /// 请求消息列表
    /// 带字典参数，page, page_size
    /// 返回数据数组(字符串形式)
    static let requestMessageList = KSFlutterMethod(rawValue: "requestMessageList")
    
    /// 原始值
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
