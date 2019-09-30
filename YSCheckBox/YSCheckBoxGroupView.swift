//
//  YSCheckBoxGroupView.swift
//  Demo
//
//  Created by 関　洋輔 on 2019/09/17.
//  Copyright © 2019 関　洋輔. All rights reserved.
//

import UIKit

class YSCheckBoxGroupView: UIView {

    var labelColor:UIColor = .black
    var font = UIFont.systemFont(ofSize: 18)
    var checkBoxSelectedFill:UIColor = .red
    var checkBoxStroke:UIColor = .red
    var checkBoxSelectedFillSize:CGFloat = 1
    var checkBoxMargin:CGFloat = 5
    var checkBoxBGFill:UIColor = .clear
    var checkBoxCheckStroke:UIColor = .white
    var checkBoxCorner:CGFloat = 4
    var labelMargin:CGFloat = 5
    var lineWidth:CGFloat = 1
    var btnLabels:[String] = []
    var btns:[YSCheckBox] = []
    
    
    func layoutButtons(){
        var metricsDictionary:Dictionary = [String:CGFloat]()
        var viewsDictionary:Dictionary = [String:UIView]()
        for (index, _) in btnLabels.enumerated() {
            if(index != 0){
                let spacerView = UIView()
                spacerView.backgroundColor = UIColor(white: 7.0/8.0, alpha: 1.0)
                spacerView.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(spacerView)
                viewsDictionary["spacerView"+index.description] = spacerView
            }
        }
        for (index, label) in btnLabels.enumerated() {
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let btn = YSCheckBox(frame: rect)
            btn.fillColor = checkBoxSelectedFill
            btn.lineWidth = lineWidth
            btn.strokeColor = checkBoxStroke
            btn.fillSize = checkBoxSelectedFillSize
            btn.margin = checkBoxMargin
            btn.bgColor = checkBoxBGFill
            btn.checkColor = checkBoxCheckStroke
            btn.corner = checkBoxCorner
            btn.titleLabel?.font = font
            btn.tag = index
            btn.setTitle(label, for: .normal)
            btn.setTitleColor(labelColor, for: .normal)
            btn.sizeToFit()
            btn.titleLabel?.font = font
            btn.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: btn.frame.size.height+labelMargin,
                bottom: 0,
                right: 0
            )
            self.addSubview(btn)
            
            btns.append(btn)
            metricsDictionary["height"] = btn.frame.size.height
            btn.translatesAutoresizingMaskIntoConstraints = false
            let objects = ["btn":btn]
            btn.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:[btn(==\(btn.frame.size.width+btn.frame.size.height+labelMargin))]",
                    options: .alignAllTop,
                    metrics: nil,
                    views: objects
                )
            )
            btn.drawCircle()
            viewsDictionary["btn"+index.description] = btn
        }
        
        var formatStr = "V:|-"
        for (index, _) in btnLabels.enumerated() {
            if(index == btnLabels.count-1){
                formatStr += "[btn\(index)(height)]"
            }else if(index == 0){
                formatStr += "[btn\(index)(height)][spacerView\(index+1)]"
            }else{
                formatStr += "[btn\(index)(height)][spacerView\(index+1)(==spacerView\(index))]"
            }
        }
        formatStr += "-|"
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat:formatStr,
            options: .alignAllLeft,
            metrics: metricsDictionary,
            views: viewsDictionary
        )
        self.addConstraints(constraints)
    }
    
}
