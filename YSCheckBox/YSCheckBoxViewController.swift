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


public class YSCheckBoxViewController: UIViewController,YSCheckBoxModelDelegate {
    public var delegate:YSCheckBoxViewControllerDelegate?
    private var checkBoxGroupView:YSCheckBoxGroupView = YSCheckBoxGroupView()
    private var model:YSCheckBoxModel = YSCheckBoxModel()
    public var labelColor:UIColor {
        get{ return checkBoxGroupView.labelColor }
        set{ checkBoxGroupView.labelColor = newValue }
    }
    public var font:UIFont {
        get{ return checkBoxGroupView.font }
        set{ checkBoxGroupView.font = newValue }
    }
    public var checkBoxSelectedFill:UIColor {
        get{ return checkBoxGroupView.checkBoxSelectedFill }
        set{ checkBoxGroupView.checkBoxSelectedFill = newValue }
    }
    public var checkBoxStroke:UIColor {
        get{ return checkBoxGroupView.checkBoxStroke }
        set{ checkBoxGroupView.checkBoxStroke = newValue }
    }
    public var checkBoxSelectedFillSize:CGFloat {
        get{ return checkBoxGroupView.checkBoxSelectedFillSize }
        set{ checkBoxGroupView.checkBoxSelectedFillSize = newValue }
    }
    public var checkBoxMargin:CGFloat {
        get{ return checkBoxGroupView.checkBoxMargin }
        set{ checkBoxGroupView.checkBoxMargin = newValue }
    }
    public var checkBoxBGFill:UIColor {
        get{ return checkBoxGroupView.checkBoxBGFill }
        set{ checkBoxGroupView.checkBoxBGFill = newValue }
    }
    public var checkBoxCheckStroke:UIColor {
        get{ return checkBoxGroupView.checkBoxCheckStroke }
        set{ checkBoxGroupView.checkBoxCheckStroke = newValue }
    }
    public var checkBoxCorner:CGFloat {
        get{ return checkBoxGroupView.checkBoxCorner }
        set{ checkBoxGroupView.checkBoxCorner = newValue }
    }
    public var labelMargin:CGFloat {
        get{ return checkBoxGroupView.labelMargin }
        set{ checkBoxGroupView.labelMargin = newValue }
    }
    public var lineWidth:CGFloat {
        get{ return checkBoxGroupView.lineWidth }
        set{ checkBoxGroupView.lineWidth = newValue }
    }
    private var btns:[YSCheckBox] = []

    
    public init(labels: [String]) {
        super.init(nibName: nil, bundle: nil)
        checkBoxGroupView.btnLabels = labels
        model.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func loadView() {
        super.loadView()
        self.view = checkBoxGroupView
        checkBoxGroupView.layoutButtons()
        for (i,btn) in checkBoxGroupView.btns.enumerated() {
            model.append(val: false)
            btn.tag = i
            btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func btnTapped(_ sender: YSCheckBox) {
        if(sender.isSelected){
            sender.clearSelectedCircle()
        }else{
            sender.drawSelectedCircle()
        }
        sender.isSelected = !sender.isSelected
        model.set(val: sender.isSelected, idx: sender.tag)
    }
    
    func ysCheckBoxModelDidSet(selectedArr: [Bool]) {
        delegate?.didYSCeckBoxSelect(checks: selectedArr)
    }
}
