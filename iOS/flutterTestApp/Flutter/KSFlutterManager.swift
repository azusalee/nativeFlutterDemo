//
//  KSFlutterManager.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/25.
//

import Foundation
import Flutter
import flutter_boost

/// flutter的管理器
class KSFlutterManager {
    static let sharedInstance = KSFlutterManager()
    
    var flutterEngine: FlutterEngine?
    
    var channelHandler: KSFlutterChannelHandler?
    
    //let engineGroup = FlutterEngineGroup(name: "zeek_engine_group", project: nil)
    
    /// 初始化
    func setup(engine: FlutterEngine) {
        // 测试 初始化要 5秒多(初始化完成前，跳到flutter页面会黑屏，而且通道的传送的数据也是无效的)
        self.flutterEngine = engine
        //KSFlutterManager.sharedInstance.flutterEngine.run()
        // 必须要run了才可以设置channel
        self.channelHandler = KSFlutterChannelHandler.init(engine: engine)
        
    }
    
    /// 跳转FlutterViewController时注意不要连续跳转多次，有可能会出问题
//    func createFlutterViewController(route: KSFlutterPageRouteName) -> UIViewController {
//        let vc = KSFlutterContainerViewController.init(routeName: route)
//        return vc
//    }
    
    // 打开flutter页
    func pushFlutterPage(route: KSFlutterPageRouteName, arguments: [String: String], isAnimated: Bool = true) {
        let options = FlutterBoostRouteOptions()
        options.pageName = route.rawValue
        
        // 组合参数
        var params: [String: Any] = [
        "isPresent": false,
        "isAnimated": isAnimated
        ]
        
        for (key, value) in arguments {
            params[key] = value
        }
        
        options.arguments = params
        
        options.opaque = true
        //这个是push操作完成的回调，而不是页面关闭的回调！！！！
        options.completion = { completion in
            print("open operation is completed")
        }
        
        //这个是页面关闭并且返回数据的回调，回调实际需要根据您的Delegate中的popRoute来调用
        options.onPageFinished = { dic in
            print(dic)
        }
        
        FlutterBoost.instance().open(options)
    }
}
