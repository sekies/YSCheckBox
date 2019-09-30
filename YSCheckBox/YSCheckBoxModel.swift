//
//  YSCheckBoxModel.swift
//  Demo
//
//  Created by 関　洋輔 on 2019/09/30.
//  Copyright © 2019 関　洋輔. All rights reserved.
//

import Foundation

protocol YSCheckBoxModelDelegate {
    func ysCheckBoxModelDidSet(selectedArr:[Bool])
}

class YSCheckBoxModel {
    var delegate:YSCheckBoxModelDelegate?
    private var selectedArr:[Bool] = []
    
    func append(val:Bool){
        selectedArr.append(val)
    }
    
    func set(val:Bool, idx:Int){
        selectedArr[idx] = val
        delegate?.ysCheckBoxModelDidSet(selectedArr: selectedArr)
    }
}
