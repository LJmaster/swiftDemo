//
//  User.swift
//  dommmm
//
//  Created by 杰刘 on 2017/6/2.
//  Copyright © 2017年 刘杰. All rights reserved.
//

import UIKit

class User: NSObject,NSCoding{
    var name:String
    var age:String
    var six:String
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey: "name")
        aCoder.encode(age,forKey: "age")
        aCoder.encode(six,forKey: "six")
    }
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        age = aDecoder.decodeObject(forKey: "age") as? String ?? ""
        six = aDecoder.decodeObject(forKey: "six") as? String ?? ""
    }
    required init (name:String = "",age:String = "", six:String = ""){
        self.name = name
        self.age = age
        self.six = six
    }
}
