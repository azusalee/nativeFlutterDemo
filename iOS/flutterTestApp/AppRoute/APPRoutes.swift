//
//  APPRoutes.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/26.
//

import Foundation
import UIKit

/// app内部的路由枚举
enum AppRoutes: String {
    // app主页
    case home = "/app/home"
    
    func viewControllerClass() -> UIViewController.Type? {
        
        return ViewController.self
    }
}
