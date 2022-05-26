//
//  KSFlutterManager.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/25.
//

import Foundation
import Flutter

/// flutter的管理器
class KSFlutterManager {
    static let sharedInstance = KSFlutterManager()
    
    let flutterEngine = FlutterEngine(name: "zeek flutter engine")
    
    var channelHandler: KSFlutterChannelHandler?
    
    func setup() {
        // 测试 初始化要 5秒多(初始化完成前，跳到flutter页面会黑屏，而且通道的传送的数据也是无效的)
        KSFlutterManager.sharedInstance.flutterEngine.run()
        self.channelHandler = KSFlutterChannelHandler.init(engine: flutterEngine)
    }
    
    /// 跳转FlutterViewController时注意不要连续跳转多次，有可能会出问题
    /// 通道不可用时(未初始化完成)，返回nil
    func createFlutterViewController(route: KSFlutterPageRouteName) -> UIViewController? {
        if self.channelHandler?.isChannelCanUse() != true {
            // 通道不可用，不跳转
            return nil
        }
        KSFlutterManager.sharedInstance.channelHandler?.changeRootRoute(routeName: route)
        
        let vc = FlutterViewController(engine: KSFlutterManager.sharedInstance.flutterEngine, nibName: nil, bundle: nil)
        return vc
    }
    
}
