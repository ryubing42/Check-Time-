//
//  AddViewController.swift
//  ReadingProject
//
//  
//

import UIKit

class AddViewController: UIViewController,EditViewDelegate {

    var model : HomeModel!
    
    var index : NSInteger!
    let nameFiled : UITextField = UITextField.init(frame: CGRectMake(wid(10),0,SCREEN_WIDTH-wid(110)-wid(60),wid(60)))
    
    let timeLabel : UILabel = creatLabel(text: getNowTime(), fontSize: 20, color: .white, isMore: true)

    let imgBtn : UIButton = UIButton.init()
    
    let residueLabel : UILabel = creatLabel(text: "剩余10日", fontSize: 17, color: RBG(96,81,81), isMore: false)
    let describeLabel : UILabel = creatLabel(text: "1\n2\n3", fontSize: 14, color: .black, isMore: true)

    let boxBtn : UIButton = UIButton.init(frame: CGRectMake(SCREEN_WIDTH-wid(100),SCREEN_HEIGHT-tabbarHeight-wid(60),wid(80),wid(80)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxBtn.setBackgroundImage(UIImage.init(named: "box"), for: .normal)
        let leftView = UIView.init(frame: CGRectMake(0,0,wid(90),SCREEN_HEIGHT))
        leftView.backgroundColor = RBG(96,81,81)
        view.addSubview(leftView)
        view.backgroundColor = UIColor.white
        creatLeftView()
        creatAddView()
        creatFootView()
        view.addSubview(boxBtn)
        boxBtn.addTarget(self, action:#selector(boxBtnAction), for: .touchUpInside)
        upLoadUI()
        // Do any additional setup after loading the view.
    }
    func upLoadUI(){
        timeLabel.text = model.time
        nameFiled.text = model.name
        imgBtn.setBackgroundImage(UIImage.init(contentsOfFile: saveImage(model.imgStr)), for: .normal)
        residueLabel.text = model.deadline
        describeLabel.text = String("\""+model.remark+"\"")
    }
    func creatLeftView(){
        let btn = UIButton.init(frame: CGRectMake(0,0,wid(90),topHeight))
        btn.backgroundColor = RBG(96,81,81)
        let btnImg = UIImageView.init(frame: CGRectMake((wid(90)-wid(25))/2.0,navy(wid(25)),wid(25),wid(25)))
        btnImg.image = UIImage.init(named:"Home_Top")
        btn.addSubview(btnImg)
        view.addSubview(btn)
        
        let label = creatLabel(text: "|\n|\n|\n|\n|\n|\n|\n|\n", fontSize: 17, color: RBG(140,130,130), isMore: true)
        label.frame = CGRectMake((btn.width-label.width)/2.0,btn.bottom+wid(20),label.width,label.height)
        view.addSubview(label)
        
        timeLabel.frame = CGRectMake(0,label.bottom+wid(10),wid(90),timeLabel.height)
        timeLabel.textAlignment = .center
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.baselineAdjustment = .alignCenters
        view.addSubview(timeLabel)

        let label1 = creatLabel(text: "|\n|\n|\n|\n|\n|\n|\n|\n", fontSize: 17, color: RBG(140,130,130), isMore: true)
        label1.frame = CGRectMake((btn.width-label1.width)/2.0,timeLabel.bottom+wid(20),label1.width,label1.height)
        view.addSubview(label1)
    }
    func creatAddView(){
        let topView = UIView.init(frame: CGRectMake(wid(100),SCREEN_HEIGHT/4.0-wid(60),SCREEN_WIDTH-wid(110),SCREEN_HEIGHT/2.0))
        topView.layer.cornerRadius = wid(20)
        topView.layer.borderWidth = 3
        topView.layer.borderColor  = RBG(96,81,81).cgColor
        view.addSubview(topView)
        let closeBtn = UIButton.init(frame: CGRectMake(topView.width-wid(10)-wid(30),(wid(60)-wid(30))/2.0,wid(30),wid(30)))
        closeBtn.setBackgroundImage(UIImage.init(named: "close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        topView.addSubview(closeBtn)
        let lineView = UIView.init(frame: CGRectMake(0,wid(60),topView.width,3))
        lineView.backgroundColor = RBG(96,81,81)
        topView.addSubview(lineView)
//        let attSring = NSAttributedString.init(string: "请输入名称或者扫描获取",attributes: [.foregroundColor:RBGA(96,81,81,0.5),
//             .font:FontSize(14)
//            ])
//        nameFiled.attributedPlaceholder = attSring
        nameFiled.textColor = RBG(96,81,81)
        nameFiled.font = BoladFontSize(14)
        nameFiled.isUserInteractionEnabled = false
        topView.addSubview(nameFiled)
        imgBtn.frame = CGRectMake(wid(20),wid(80),wid(80),wid(80))
        imgBtn.backgroundColor = RBG(208,208,208)
        topView.addSubview(imgBtn)
        residueLabel.frame = CGRectMake(wid(20),imgBtn.bottom+wid(20),topView.width-wid(40),residueLabel.height)
        residueLabel.adjustsFontSizeToFitWidth = true
        residueLabel.baselineAdjustment = .alignCenters
        topView.addSubview(residueLabel)
        describeLabel.frame = CGRectMake(wid(20),residueLabel.bottom+wid(20),topView.width-wid(40),describeLabel.height)
        topView.addSubview(describeLabel)
    }
    func creatFootView(){
        let textArr = ["確定","編集","削除"]
        let y = SCREEN_HEIGHT/2.0+SCREEN_HEIGHT/4.0+wid(10)-wid(60)
        let width = (SCREEN_WIDTH-wid(110))/3.0
        for i:Int in 0..<textArr.count{
            
            let btnLabel = creatLabel(text: textArr[i], fontSize: 15, color:RBG(96,81,81), isMore: false)
            let btn = UIButton.init(frame:CGRectMake(width*CGFloat(i)+wid(100),y,width,btnLabel.height+wid(30)))
            let btnImg = UIImageView.init(frame: CGRectMake((btn.width-wid(25))/2.0,0,wid(25),wid(25)))
            btnImg.image = UIImage.init(named: textArr[i])
            btnLabel.frame = CGRectMake(0,btnImg.bottom+wid(5),btn.width,btnLabel.height)
            btnLabel.textAlignment = .center
            btn.addSubview(btnImg)
            btn.addSubview(btnLabel)
            btn.tag = 100+i
            btn.addTarget(self, action:#selector(btnAction(_ :)), for: .touchUpInside)
            view.addSubview(btn)
        }
    }
    @objc func btnAction(_ sender:UIButton){
        if sender.tag == 100{
            let modelArray : NSArray = getModelArrName("homeModelArr")
            let array : NSMutableArray = NSMutableArray.init()
            array.addObjects(from: modelArray as! [Any])
            array.replaceObject(at: index, with: model as Any)
            setModelArrName(array , andKeyname: "homeModelArr")
            self.navigationController?.popViewController(animated: true)
        }else if sender.tag == 101{
            let eidt = EditViewController.init()
            eidt.model = model
            eidt.type = 1
            eidt.index = self.index
            eidt.delegate = self
            self.navigationController?.pushViewController(eidt, animated: true)
        }else if sender.tag == 102{
            let modelArray : NSArray = getModelArrName("homeModelArr")
            let array : NSMutableArray = NSMutableArray.init()
            array.addObjects(from: modelArray as! [Any])
            array.removeObject(at: index)
            setModelArrName(array , andKeyname: "homeModelArr")
            self.navigationController?.popViewController(animated: true)
        }
    }
    func refreshModel(_ model: HomeModel) {
        self.model = model
        upLoadUI()
    }
    @objc func boxBtnAction(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func closeBtnAction(){
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
