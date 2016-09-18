//
//  Singleton.swift
//  Accordion
//
//  Created by vitaro on 2016/09/18.
//  Copyright © 2016年 vitaro. All rights reserved.
//

import Foundation
// ADD:
class Singleton: NSObject {
    
    static let shared = Singleton()
    
    var title: String?
    var detail: String?
    
    private override init(){
        super.init()
    }
    
    func clear(){
        title = nil
        detail = nil
    }
}
