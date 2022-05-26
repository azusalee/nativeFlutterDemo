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
    
    let flutterEngine = FlutterEngine(name: "zeek_flutter_engine")
    
    var channelHandler: KSFlutterChannelHandler?
    
    //let engineGroup = FlutterEngineGroup(name: "zeek_engine_group", project: nil)
    
    /// 初始化
    func setup() {
        // 测试 初始化要 5秒多(初始化完成前，跳到flutter页面会黑屏，而且通道的传送的数据也是无效的)
        KSFlutterManager.sharedInstance.flutterEngine.run()
        // 必须要run了才可以设置channel
        self.channelHandler = KSFlutterChannelHandler.init(engine: flutterEngine)
        
    }
    
    /// 跳转FlutterViewController时注意不要连续跳转多次，有可能会出问题
    func createFlutterViewController(route: KSFlutterPageRouteName) -> UIViewController {
        let vc = KSFlutterContainerViewController.init(routeName: route)
        return vc
    }
    
}
