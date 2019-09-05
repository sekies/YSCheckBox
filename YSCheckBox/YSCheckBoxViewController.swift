//
//  YSRadioButtonViewController.swift
//  YSRadioButton
//
//  Created by 関　洋輔 on 2019/09/02.
//  Copyright © 2019 関　洋輔. All rights reserved.
//

import UIKit

public protocol YSCheckBoxViewControllerDelegate {
    func didYSCeckBoxSelect(checks:[Bool])
}


public class YSCheckBoxViewController: UIViewController {
    public var delegate:YSCheckBoxViewControllerDelegate?
    public var labelColor:UIColor = .black
    public var font = UIFont.systemFont(ofSize: 18)
    public var checkBoxSelectedFill:UIColor = .red
    public var checkBoxStroke:UIColor = .red
    public var checkBoxSelectedFillSize:CGFloat = 1
    public var checkBoxMargin:CGFloat = 5
    public var checkBoxBGFill:UIColor = .clear
    public var checkBoxCheckStroke:UIColor = .white
    public var checkBoxCorner:CGFloat = 4
    public var labelMargin:CGFloat = 5
    public var lineWidth:CGFloat = 1
    private var btnLabels:[String]!
    private var btns:[YSCheckBox] = []
    public init(labels: [String]) {
        super.init(nibName: nil, bundle: nil)
        btnLabels = labels
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        layoutButtons()
    }
    
    private func layoutButtons(){
        var metricsDictionary:Dictionary = [String:CGFloat]()
        var viewsDictionary:Dictionary = [String:UIView]()
        for (index, _) in btnLabels.enumerated() {
            if(index != 0){
                let spacerView = UIView()
                spacerView.backgroundColor = UIColor(white: 7.0/8.0, alpha: 1.0)
                spacerView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(spacerView)
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
            btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
            btn.titleLabel?.font = font
            btn.titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: btn.frame.size.height+labelMargin,
                bottom: 0,
                right: 0
            )
            self.view.addSubview(btn)
            
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
        self.view.addConstraints(constraints)
    }
    
    @objc func btnTapped(_ sender: YSCheckBox) {
        if(sender.isSelected){
            sender.clearSelectedCircle()
        }else{
            sender.drawSelectedCircle()
        }
        sender.isSelected = !sender.isSelected
        
        delegate?.didYSCeckBoxSelect(checks: isCheckArr())
    }
    
    private func isCheckArr()->[Bool]{
        var checks:[Bool] = []
        for btn in btns {
            checks.append(btn.isSelected)
        }
        return checks
    }
}
