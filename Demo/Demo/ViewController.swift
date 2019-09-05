//
//  ViewController.swift
//  Demo
//
//  Created by 関　洋輔 on 2019/09/05.
//  Copyright © 2019 関　洋輔. All rights reserved.
//

import UIKit

class ViewController: UIViewController,YSCheckBoxViewControllerDelegate {
    
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let checkBox = YSCheckBoxViewController(labels: ["Orange","GrapeFruits","Banana","Apple"])
        checkBox.delegate = self
        checkBox.font = UIFont.systemFont(ofSize: 18)
        checkBox.labelColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
        checkBox.labelMargin = 0
        checkBox.lineWidth = 1
        checkBox.checkBoxSelectedFillSize = 1
        checkBox.checkBoxMargin = 6
        checkBox.checkBoxCorner = 7
        checkBox.checkBoxStroke = .lightGray
        checkBox.checkBoxCheckStroke = .white
        checkBox.checkBoxSelectedFill = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
        checkBox.checkBoxBGFill = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        addChild(checkBox)
        checkBox.view.frame = container.bounds
        container.addSubview(checkBox.view)
        checkBox.didMove(toParent: self)
    }
    
    func didYSCeckBoxSelect(checks: [Bool]) {
        print(checks)
    }
    
}

