//
//  YSRadioButton.swift
//  YSRadioButton
//
//  Created by 関　洋輔 on 2019/09/02.
//  Copyright © 2019 関　洋輔. All rights reserved.
//

import UIKit

class YSCheckBox: UIButton {
    var corner:CGFloat = 6
    var margin:CGFloat = 5
    var fillSize:CGFloat = 0.6
    var lineWidth:CGFloat = 1.0
    var strokeColor:UIColor = UIColor.init(
        red: 112.0/255.0,
        green: 112.0/255.0,
        blue: 112.0/255.0,
        alpha: 1
    )
    var fillColor:UIColor = UIColor.init(
        red: 87.0/255.0,
        green: 203.0/255.0,
        blue: 149.0/255.0,
        alpha: 1
    )
    var checkColor:UIColor = .white
    var bgColor:UIColor = .red
    private let fillLayer = CAShapeLayer()
    private let lineLayer = CAShapeLayer()


    
    /// チェックボックスを生成
    func drawCircle() {
        drawLine()
        let size:CGFloat = circleSize()
        let rect = CGRect(x: margin, y: margin, width: size, height: size)
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: corner)
        let edgeLayer = CAShapeLayer()
        edgeLayer.path = roundedRect.cgPath
        edgeLayer.lineWidth = lineWidth
        edgeLayer.strokeColor = strokeColor.cgColor
        edgeLayer.fillColor = UIColor.clear.cgColor
        self.layer.insertSublayer(edgeLayer, at: 0)
        makeFillLayer()
        let bgLayer = CAShapeLayer()
        bgLayer.path = roundedRect.cgPath
        bgLayer.lineWidth = lineWidth
        bgLayer.strokeColor = UIColor.clear.cgColor
        bgLayer.fillColor = bgColor.cgColor
        self.layer.insertSublayer(bgLayer, at: 0)
        
    }

    
    /// チェックボックスの塗り部分のレイヤーの生成
    private func makeFillLayer(){
        fillLayer.lineWidth = 0.0
        fillLayer.strokeColor = UIColor.clear.cgColor
        fillLayer.fillColor = fillColor.cgColor
        self.layer.insertSublayer(fillLayer, at: 0)
    }
    
    
    /// チェックラインを生成
    func drawLine() {
        lineLayer.lineWidth = 3.0
        lineLayer.strokeColor = checkColor.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
//        lineLayer.lineCap = .round
//        lineLayer.lineJoin = .round
        self.layer.insertSublayer(lineLayer, at: 0)
    }
    
    /// チェックボックスのサイズの生成
    ///
    /// - Returns: 高さからマージンを引いた半径を返す
    private func circleSize() -> CGFloat{
        return (self.frame.size.height-margin*2)
    }
    
    /// チェックボックスを選択状態にする
    func drawSelectedCircle() {
        let minPath = fillMinPath()
        let maxPath = fillMaxPath()
        fillLayer.path = minPath.cgPath
        let anim = makeAnim(fromPath: fillLayer.path!,toPath: maxPath.cgPath)
        fillLayer.add(anim, forKey: anim.keyPath)
        
        let checkMinPath = checkLineMinPath()
        let checkMaxPath = checkLineMaxPath()
        lineLayer.path = checkMinPath.cgPath
        let animLine = makeAnim(fromPath: lineLayer.path!,toPath: checkMaxPath.cgPath, delay: 0.1)
        lineLayer.add(animLine, forKey: anim.keyPath)
    }
    
    /// チェックボックスを非選択状態にする
    func clearSelectedCircle() {
        let minPath = fillMinPath()
        let maxPath = fillMaxPath()
        fillLayer.path = maxPath.cgPath
        let anim = makeAnim(fromPath: fillLayer.path!,toPath: minPath.cgPath, delay: 0.1)
        fillLayer.add(anim, forKey: anim.keyPath)
        
        let checkMinPath = checkLineMinPath()
        let checkMaxPath = checkLineMaxPath()
        lineLayer.path = checkMaxPath.cgPath
        let animLine = makeAnim(fromPath: lineLayer.path!,toPath: checkMinPath.cgPath)
        lineLayer.add(animLine, forKey: anim.keyPath)
    }
    
    /// パスのアニメーション
    ///
    /// - Parameters:
    ///   - fromPath: アニメーション開始時のパス
    ///   - toPath: アニメーション終了時のパス
    /// - Returns: 生成されたアニメーション
    private func makeAnim(fromPath:CGPath,toPath:CGPath, delay:CFTimeInterval=0.0) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.2
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.fromValue = fromPath
        animation.toValue = toPath
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    /// チェックボックスの選択状態のpath(塗り)
    ///
    /// - Returns: 指定サイズ半径のUIBezierPathを返す
    private func fillMaxPath() -> UIBezierPath{
        let size = circleSize()*fillSize
        let position = margin+(circleSize()-size)*0.5
        let rect = CGRect(x: position, y: position, width: size, height: size)
        return UIBezierPath(roundedRect: rect, cornerRadius: corner)
    }
    
    
    /// チェックボックスの非選択状態のpath(塗り)
    ///
    /// - Returns: 半径0のUIBezierPathを返す
    private func fillMinPath() -> UIBezierPath{
        let position = margin+circleSize()*0.5
        let rect = CGRect(x: position, y: position, width: 0, height: 0)
        return UIBezierPath(roundedRect: rect, cornerRadius: corner)
    }
    
    /// チェックボックスの選択状態のpath(塗り)
    ///
    /// - Returns: 指定サイズ半径のUIBezierPathを返す
    private func checkLineMaxPath() -> UIBezierPath{
        let size = circleSize()
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(
            x: size*0.2+margin,
            y: size*0.45+margin
        ))
        bezierPath.addLine(to: CGPoint(
            x: size*0.43+margin,
            y: size*0.7+margin
        ))
        bezierPath.addLine(to: CGPoint(
            x: size*0.8+margin,
            y: size*0.3+margin
        ))
        bezierPath.stroke()
        return bezierPath
    }
    
    
    /// チェックボックスの非選択状態のpath(塗り)
    ///
    /// - Returns: 半径0のUIBezierPathを返す
    private func checkLineMinPath() -> UIBezierPath{
        let size = circleSize()
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(
            x: size*0.5+margin,
            y: size*0.5+margin
        ))
        bezierPath.addLine(to: CGPoint(
            x: size*0.5+margin,
            y: size*0.5+margin
        ))
        bezierPath.addLine(to: CGPoint(
            x: size*0.5+margin,
            y: size*0.5+margin
        ))
        bezierPath.stroke()
        return bezierPath
    }
}
