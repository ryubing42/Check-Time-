//
//  Zxy_Tool.swift
//  ReadingProject
//
//  Created by 曾霄逸 on 2023/1/11.
//

import UIKit
import AVFoundation
import Photos

let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.size.height

let ISIphoneX : Bool = ((UIScreen().bounds.size.height/UIScreen().bounds.size.width)>=2.16)

let StatusBarHeight : CGFloat = (ISIphoneX ? 44.0 : 20.0)

let tabbarHeight : CGFloat = (ISIphoneX ? 83.0 : 49.0)

let topHeight : CGFloat = (SCREEN_HEIGHT >= 812.0 ? 88 : 64)

func getModelArrName(_ name:String) -> NSArray{
    var filePath : String =  NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).last!
    filePath = filePath.appendingFormat("/%@",name)
    var arrayData : NSData
    do{
        if FileManager.default.fileExists(atPath:filePath){
            arrayData = try! NSData.init(contentsOfFile: filePath)
        }else{
            return []
        }
    }catch{
        return []
    }
    return NSKeyedUnarchiver.unarchiveObject(with: arrayData as Data) as! NSArray

    
}
func setModelArrName(_ array:NSMutableArray,andKeyname name:String){
    var filePath : String =  NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).last!
    filePath = filePath.appendingFormat("/%@",name)
    let arrayData : NSData = NSKeyedArchiver.archivedData(withRootObject: array) as NSData
    arrayData.write(toFile: filePath, atomically: true)
}
func saveImage(_ name:String) -> String{
    var filePath : String =  NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).last!
    filePath = filePath.appendingFormat("/%@.png",name)
    return filePath
}
func showHintInfoWithString(_ infoStr:String){
    var view : UIView
    if keyWindow().viewWithTag(20200) != nil {
        view = keyWindow().viewWithTag(20200)!
        view.layer.removeAllAnimations()
        view.removeFromSuperview()
    }
    view = UIView.init(frame:CGRectMake(0,-topHeight,SCREEN_WIDTH,topHeight))
    view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    view.tag = 20200
    let label : UILabel = UILabel.init(frame: CGRectMake(wid(25),0,SCREEN_WIDTH-wid(25)*2,topHeight))
    label.font = FontSize(12)
    label.textColor = UIColor.white
    label.numberOfLines = 0
    label.text = infoStr
    label.textAlignment = .center
    label.sizeToFit()
    view.addSubview(label)
    view.frame = CGRectMake((SCREEN_WIDTH-(label.width+wid(25)*2))/2.0,(SCREEN_HEIGHT-(label.height+hig(25)))/2.0,label.width+wid(25)*2, label.height+hig(30))
    label.frame = view.bounds
    view.layer.masksToBounds = true
    view.layer.cornerRadius = hig(10)
    view.alpha = 1
    keyWindow().addSubview(view)
    UIView.animate(withDuration: 3, delay: 0) {
        view.alpha = 0
    }completion: { finished in
        if(finished)
        {
            if view != nil{
                view.subviews.forEach{ subview in
                    subview.removeFromSuperview()
                }
                view.layer.removeAllAnimations()
                view.removeFromSuperview()
            }
        }
    }
//    view = UIView.init(frame: CGRectMake(0,, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>))
}
func keyWindow() -> UIWindow{
    var foundWindow : UIWindow = UIWindow.init()
    let windows : Array = UIApplication.shared.windows
    for i:Int in 0..<windows.count{
        let window = windows[i]
        if window.isKeyWindow{
            foundWindow = window
            break
        }
    }
    return foundWindow
}
func haveCameraPermissions() -> Bool{
    let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    if authStatus == .denied || authStatus == .restricted{
        return false
    }else{
        return true
    }
}
func havePhotoPermission() -> Bool{
    let library : PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    if library == .denied || library == .restricted{
        return false
    }else{
        return true
    }
}


func creatImgView(rect:CGRect,named:String) -> UIImageView{
    let img = UIImageView.init(frame: rect)
    img.image = UIImage.init(named: named)
    return img
}
func getNowTime() -> String{
    let date = NSDate.now
    let formatter = DateFormatter.init()
    formatter.dateFormat = "dd\nMM月"
    return formatter.string(from: date)
    
}
func creatLabel(text:String,fontSize:CGFloat,color:UIColor,isMore:Bool) -> UILabel{
   let label = UILabel.init()
    label.text = text
    label.font = FontSize(fontSize)
    label.textColor = color
    label.numberOfLines = (isMore ? 0 : 1)
    label.sizeToFit()
    return label
}
func navy(_ y:CGFloat) -> CGFloat{
    return StatusBarHeight+(topHeight-StatusBarHeight-y)/2.0
}
func wid(_ x:CGFloat) -> CGFloat{
    return (x*(SCREEN_WIDTH/375.0))
}
func hig(_ y:CGFloat) -> CGFloat{
    return (y*(SCREEN_HEIGHT/812.0))
}
func RBG(_ r:CGFloat,_ b:CGFloat,_ g:CGFloat) -> UIColor{
    return RBGA(r,b,g,1)
}
func RBGA(_ r:CGFloat,_ b:CGFloat,_ g:CGFloat,_ a:CFloat) -> UIColor{
    return UIColor.init(red: r/255.0, green: b/255.0, blue: g/255.0, alpha: CGFloat(a))
}
func RBG_Text(_ str:String) -> UIColor {
    return RBG_TextA(str,1);
}
func RBG_TextA(_ str:String,_ alp:CGFloat) -> UIColor {
    var colorString = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    if colorString.count < 6 {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    if colorString.hasPrefix("0x") || colorString.hasPrefix("0X"){
        colorString = (colorString as NSString).substring(from: 2)
    }
    if colorString.hasPrefix("#") {
        colorString = (colorString as NSString).substring(from: 1)
    }
    if colorString.count < 6 {
        return UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    var rang = NSRange()
    rang.location = 0
    rang.length = 2
    if colorString.count == 6 {
        let rString = (colorString as NSString).substring(with: rang)
        rang.location = 2
        let gString = (colorString as NSString).substring(with: rang)
        rang.location = 4
        let bString = (colorString as NSString).substring(with: rang)

        var r:UInt64 = 0, g:UInt64 = 0,b: UInt64 = 0
        
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: alp)
    } else{
        let aString = (colorString as NSString).substring(with: rang)
        rang.location = 2
        let rString = (colorString as NSString).substring(with: rang)
        rang.location = 4
        let gString = (colorString as NSString).substring(with: rang)
        rang.location = 6
        let bString = (colorString as NSString).substring(with: rang)
        
        var r:UInt64 = 0, g:UInt64 = 0,b: UInt64 = 0, a: UInt64 = 0
                  
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)

        Scanner(string: aString).scanHexInt64(&a)
                  
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        let alp = CGFloat(a) / 255.0
       return  UIColor.init(red: red, green: green, blue: blue, alpha: alp)
    }
}
func FontSize(_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.systemFont(ofSize: x)
}
func FontSize(_ name:String,_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.init(name: name, size: x) ?? UIFont.systemFont(ofSize: x)
}
func BoladFontSize(_ size:CGFloat) -> UIFont{
    let x = (size*(SCREEN_WIDTH > 375.0 ? 1.05 : (SCREEN_WIDTH < 375.0 ? 0.9 : 1)))
    return UIFont.boldSystemFont(ofSize: x)
}
extension UIView{
    
    var origin:CGPoint{
        get{
            return self.frame.origin
        }
        set(newValue){
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }
    }
    var size:CGSize {
        get {
            return self.frame.size
        }
        set(newValue) {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    var width:CGFloat{
        get{
            return self.frame.size.width
        }
        set(newValue) {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    var height:CGFloat{
        get{
            return self.frame.size.height
        }
        set(newValue){
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    var right:CGFloat {
        get {
            return (self.frame.origin.x + self.frame.size.width)
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.x = (newValue - self.frame.size.width)
            self.frame = rect
        }
    }
    
    var bottom:CGFloat {
        get {
            return (self.frame.origin.y + self.frame.size.height)
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = (newValue - self.frame.size.height)
            self.frame = rect
        }
    }
    
    
    //圆角边框
    func layer(radius:CGFloat, borderWidth:CGFloat, borderColor:UIColor) -> Void
    {
        if (0.0 < radius)
        {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
        if (0.0 < borderWidth)
        {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
    }
}
//class Zxy_Tool: NSObject {
//     
//}
