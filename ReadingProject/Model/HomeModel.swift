//
//  HomeModel.swift
//  ReadingProject
//
//  Created by Ryu on 2023/1/14.
//

import UIKit

class HomeModel: NSObject,NSCoding,NSSecureCoding{
    
    var name : String = ""
    var kind : String = ""
    var count : String = ""
    var type : String = ""
    var deadline : String = ""
    var time : String = ""
    var imgStr : String = ""
    var remark : String = ""
    
    static var supportsSecureCoding: Bool{
        return true
    }
    override init() {
        super.init()
    }
    required init?(coder: NSCoder) {
        super.init()
        self.name = coder.decodeObject(forKey: "name") as! String
        self.kind = coder.decodeObject(forKey: "kind") as! String
        self.count = coder.decodeObject(forKey: "count") as! String
        self.type = coder.decodeObject(forKey: "type") as! String
        self.deadline = coder.decodeObject(forKey: "deadline") as! String
        self.time = coder.decodeObject(forKey: "time") as! String
        self.imgStr = coder.decodeObject(forKey: "imgStr") as! String
        self.remark = coder.decodeObject(forKey: "remark") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(kind, forKey: "kind")
        coder.encode(count, forKey: "count")
        coder.encode(type, forKey: "type")
        coder.encode(deadline, forKey: "deadline")
        coder.encode(time, forKey: "time")
        coder.encode(imgStr, forKey: "imgStr")
        coder.encode(remark, forKey: "remark")
    }
    func printAll(){
        print(name)
        print(kind)
        print(count)
        print(type)
        print(deadline)
        print(time)
        print(imgStr)
        print(remark)
    }
}

    
