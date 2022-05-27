//
//  KSFlutterContainerViewController.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/26.
//

import UIKit
import Flutter
import AZLExtendSwift
import flutter_boost

/// flutter页的容器页
class KSFlutterContainerViewController: FBFlutterViewContainer {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
