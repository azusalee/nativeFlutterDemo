//
//  ViewController.swift
//  flutterTestApp
//
//  Created by lizihong on 2022/5/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // 加一个flutter的入口按钮
        let button = UIButton.init(frame: CGRect.init(origin: CGPoint.init(x: 100, y: 100), size: CGSize.init(width: 150, height: 50)))
        button.setTitle("flutter页面", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(flutterButtonDidTap(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc
    func flutterButtonDidTap(_ sender: UIButton) {
        KSFlutterManager.sharedInstance.pushFlutterPage(route: .message, arguments: ["name": "message"])
        //let vc = KSFlutterManager.sharedInstance.createFlutterViewController(route: .message)
        //self.navigationController?.pushViewController(vc, animated: true)
    }

}

