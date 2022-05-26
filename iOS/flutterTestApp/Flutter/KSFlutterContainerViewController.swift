//
//  KSFlutterContainerViewController.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/26.
//

import UIKit
import Flutter
import AZLExtendSwift

/// flutter页的容器页
class KSFlutterContainerViewController: UIViewController {
    /// 要显示的路由
    var flutterRouteName: KSFlutterPageRouteName = .home
    /// flutter页
    var flutterVC: FlutterViewController?
    
    /// 页面的截图视图(为了当flutterViewController移走时，页面还能有东西显示)
    private var snapView: UIView?
    
    /// 是否正在检测需要变更路由
    private var isCheckingChangeRoute = false
    
    /// 初始化
    init(routeName: KSFlutterPageRouteName) {
        super.init(nibName: nil, bundle: nil)
        self.flutterRouteName = routeName
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.changeRootRouteIfNeed()
    }
    
    /// 显示截图
    private func showSnapView() {
        if let snapView = self.view.snapshotView(afterScreenUpdates: false) {
            self.snapView = snapView
            self.view.addSubview(snapView)
        }
    }
    
    /// 隐藏截图
    private func hideSnapView() {
        self.snapView?.removeFromSuperview()
    }
    
    /// 尝试变更根路由
    private func changeRootRouteIfNeed() {
        if self.isCheckingChangeRoute == true {
            return
        }
        self.isCheckingChangeRoute = true
        if KSFlutterManager.sharedInstance.channelHandler?.isChannelCanUse() == true {
            self.changeRootRoute()
            self.isCheckingChangeRoute = false
        } else {
            KSFlutterManager.sharedInstance.channelHandler?.channelSetupCallback = { [weak self] in
                self?.changeRootRoute()
                self?.isCheckingChangeRoute = false
            }
        }
    }
    
    /// 变更根路由
    private func changeRootRoute() {
        if self.flutterVC != nil {
            return
        }
        KSFlutterManager.sharedInstance.channelHandler?.changeRootRoute(routeName: self.flutterRouteName)
        
        let vc = FlutterViewController(engine: KSFlutterManager.sharedInstance.flutterEngine, nibName: nil, bundle: nil)
        vc.view.frame = self.view.bounds
        self.addChild(vc)
        self.view.addSubview(vc.view)
        self.flutterVC = vc
        self.hideSnapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.changeRootRouteIfNeed()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.showSnapView()
        if let flutterVC = self.flutterVC {
            flutterVC.view.removeFromSuperview()
            flutterVC.removeFromParent()
            self.flutterVC = nil
        }
        
    }
    
}
