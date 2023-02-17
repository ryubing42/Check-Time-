//
//  EditViewController.swift
//  ReadingProject
//
//  

import UIKit
import Anchorage
import Vision
import VisionKit

protocol EditViewDelegate: AnyObject {
    func refreshModel(_ model:HomeModel)
}
class EditViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, VNDocumentCameraViewControllerDelegate,ResultViewDelegate {

    weak var delegate : EditViewDelegate?
    
    var model : HomeModel!
    
    var index : NSInteger!
    //照片变量
    let imgBtn : UIButton = UIButton.init(frame: CGRectMake(wid(40),topHeight+SCREEN_HEIGHT/2.0+wid(30),wid(80),wid(100)))
    let imgView : UIImageView = creatImgView(rect:CGRectMake((wid(80)-wid(25))/2.0,(wid(100)-wid(25))/2.0, wid(25),wid(25)), named: "写真")
    let textView : UITextView = UITextView.init(frame: CGRectMake(wid(130),topHeight+SCREEN_HEIGHT/2.0+wid(30),SCREEN_WIDTH-wid(130)-wid(40),wid(100)))
    
    var textRecognitionRequest = VNRecognizeTextRequest()
    
    var resultViewController: (ResultViewController & RecognizedTextDataSource)?
    
    var filedArr : Array = Array<UITextField>.init()
    
    var type : Int = 0
    
    var lastImg : UIImage!
    //追加页面的基础
    var singleStyleViewCallback: Block?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let returnBtn = UIButton.init(frame: CGRectMake(wid(20), navy(wid(20)),wid(20)*1.27,wid(20)))
        returnBtn.setBackgroundImage(UIImage.init(named: "return"), for: .normal)
        returnBtn.addTarget(self, action: #selector(returnBtnAction), for: .touchUpInside)
        self.view.addSubview(returnBtn)
        creatCentView()
        let closeBtn = UIButton.init(frame: CGRectMake(wid(40),SCREEN_HEIGHT-tabbarHeight-wid(50),wid(50), wid(50)))
        closeBtn.setBackgroundImage(UIImage.init(named: "lastClose"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        view.addSubview(closeBtn)
        let lastBtn = UIButton.init(frame: CGRectMake(SCREEN_WIDTH-wid(40)-wid(100),closeBtn.y,wid(100),wid(50)))
        lastBtn.backgroundColor = RBG(208,208,208)
        lastBtn.titleLabel?.font = BoladFontSize(20)
        lastBtn.setTitleColor(.black, for: .normal)
        lastBtn.layer.cornerRadius = wid(5)
        lastBtn.addTarget(self, action:#selector(lastBtnAction), for: .touchUpInside)
        view.addSubview(lastBtn)
        if self.type == 0{
            closeBtn.alpha = 0
            lastBtn.setTitle("追加", for: .normal)
        }else {
            uploadUI()
            lastBtn.setTitle("編集完了", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    func uploadUI(){
        self.filedArr[0].text = model.name
        self.filedArr[1].text = model.kind
        self.filedArr[2].text = model.count
        self.filedArr[3].text = model.type
        self.filedArr[4].text = model.deadline
        self.filedArr[5].text = model.time
        self.imgView.alpha = 0
        self.imgBtn.setBackgroundImage(UIImage(contentsOfFile:saveImage(model.imgStr)), for: .normal)
        self.textView.text = model.remark
        self.lastImg = UIImage(contentsOfFile: saveImage(model.imgStr))
    }
    func creatCentView(){
        let centView = UIView.init(frame: CGRectMake(wid(40),topHeight+wid(20),SCREEN_WIDTH-wid(80),SCREEN_HEIGHT/2.0))
        centView.layer.borderColor = RBG(96, 81,81).cgColor
        centView.layer.borderWidth = 2
        centView.layer.cornerRadius = wid(5)
        view.addSubview(centView)
        let textArr = ["名前(写真で自動認識します)","種類","数量","備考 例:肉","賞味期限  例:01/01","買った日にち 例:01/01"]
        let height = (centView.height-(CGFloat(textArr.count)+2)*wid(10))/CGFloat(textArr.count)
        for i:Int in 0..<textArr.count{
            let view = UIView.init(frame: CGRectMake(wid(20),wid(10)+CGFloat(i)*(wid(10)+height)+wid(10),centView.width-wid(40),height))
            view.backgroundColor = RBG(208,208,208)
            view.layer.cornerRadius = wid(5)
            let imgHeight = view.height-wid(7)*2

            let filed = UITextField.init(frame: CGRectMake(wid(10),0,view.width-wid(20)-imgHeight-wid(5),view.height))
            filed.placeholder = textArr[i]
            filed.font = BoladFontSize(15)
            filed.textColor = .black
            view.addSubview(filed)
            centView.addSubview(view)
            if i==4{
                let imgView = UIImageView.init(frame: CGRectMake(view.width-imgHeight-wid(5),wid(7),imgHeight,imgHeight))
                imgView.image = UIImage.init(named: "日期")
                view.addSubview(imgView)
            }
            self.filedArr.append(filed)
        }
        imgBtn.layer.cornerRadius = wid(5)
        imgBtn.layer.borderWidth = 1.5
        imgBtn.layer.borderColor = RBGA(96,81,81,0.5).cgColor
        imgBtn.addSubview(imgView)
        imgBtn.addTarget(self, action: #selector(imgBtnAction), for: .touchUpInside)
        view.addSubview(imgBtn)
        textView.textColor = RBG(96,81,81)
        textView.font = FontSize(15)
        textView.layer.cornerRadius = wid(5)
        textView.layer.borderColor = RBGA(96,81,81,0.5).cgColor
        let plachLabel = UILabel.init()
        plachLabel.text = "メモー"
        plachLabel.font = FontSize(15)
        plachLabel.textColor = RBGA(96,81,81,0.5)
        plachLabel.sizeToFit()
        textView.addSubview(plachLabel)
        textView.setValue(plachLabel, forKey: "_placeholderLabel")
        textView.textContainerInset = UIEdgeInsets(top:5, left:0, bottom: 0, right:0)
        textView.layer.borderWidth = 1.5
        view.addSubview(textView)
    }
    @objc func returnBtnAction(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func imgBtnAction(){
        let alert = UIAlertController.init(title: "写真を選択してください", message: "", preferredStyle: .actionSheet)
        let photo = UIAlertAction.init(title: "写真", style: .default) { action in
            self.photoAction()
        }
        let take = UIAlertAction.init(title: "カメラ", style: .default) { action in
            self.takeAction()
        }
        let cancel = UIAlertAction.init(title: "キャンセル", style: .cancel)
        alert.addAction(photo)
        alert.addAction(take)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    func photoAction(){
        if havePhotoPermission(){
            let imagePickController : UIImagePickerController = UIImagePickerController()
            imagePickController.delegate = self
            imagePickController.allowsEditing = false
            imagePickController.sourceType = .photoLibrary
//            UIImagePickerControllerSourceTypePhotoLibrary
            self.present(imagePickController, animated:true)
        }else{
            doNoperMission("去开启访问相册权限?")
        }
    }
    func takeAction(){
        if haveCameraPermissions(){
            self.configCallback()
            self.configRequest()
//            let documentCameraViewController = VNDocumentCameraViewController()
//            documentCameraViewController.delegate = self
//            self.present(documentCameraViewController, animated: true)
        }else{
            doNoperMission("去开启照相机权限?")
        }
    }
    func doNoperMission(_ titleStr:String){
        let alertController = UIAlertController.init(title: titleStr, message: nil, preferredStyle:.alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel)
        let okAction = UIAlertAction.init(title: "確定", style: .default) { action in
            let url : URL = URL.init(string: UIApplication.openSettingsURLString)!
            if UIApplication.shared.canOpenURL(url ){
                UIApplication.shared.open(url,options: [:],completionHandler: nil)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true)
        let img : UIImage = info[.originalImage] as! UIImage
        lastImg = img
        imgBtn.setBackgroundImage(img, for: .normal)
        imgView.alpha = 0
        self.configRequest()
        self.resultViewController = ResultViewController()
        self.processImage(cgImage: img.cgImage!)
        DispatchQueue.main.async {
            if let resultVC = self.resultViewController {
                resultVC.delegate = self
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
        }
    }
    func saveName(_ text: String) {
        let filed : UITextField = self.filedArr[0]
        filed.text = text
        print(text)
    }
    private func configCallback() {
        gStyle = .single
        self.callCamera()
//        self.singleStyleViewCallback = { [weak self] in
//            guard let self = self else { return }
//            gStyle = .single
//            self.callCamera()
//        }
    }
    private func callCamera() {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        self.present(documentCameraViewController, animated: true)
    }
    private func processImage(cgImage: CGImage) {
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }

    private func configRequest() {
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
            guard let resultViewController = self.resultViewController else {
                print("resultViewController is not set")
                return
            }
            if let results = request.results, !results.isEmpty {
                print(results)
                if let requestResults = request.results as? [VNRecognizedTextObservation] {
                    DispatchQueue.main.async {
                        resultViewController.addRecognizedText(recognizedText: requestResults)
                    }
                }
            }
        })
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = false
        textRecognitionRequest.recognitionLanguages = ["zh-Hans"]
    }
    
    @objc func lastBtnAction(){
        
        let model : HomeModel = HomeModel.init()
        model.name = self.filedArr[0].text!
        model.kind = self.filedArr[1].text!
        model.count = self.filedArr[2].text!
        model.type = self.filedArr[3].text!
        model.deadline = self.filedArr[4].text!
        model.time = self.filedArr[5].text!
        if lastImg != nil {
            let data : NSData = lastImg.jpegData(compressionQuality: 0.1)! as NSData
            let dateStr = String.init(format: "%.01f",NSDate.now.timeIntervalSince1970)
            model.imgStr = dateStr
            let str : String = saveImage(model.imgStr)
            data.write(toFile: str, atomically: true)
        }
        model.remark = self.textView.text
        if model.name.count == 0 || model.kind.count == 0 || model.count.count == 0  || model.deadline.count == 0 || model.time.count == 0 || model.imgStr.count == 0 {
            showHintInfoWithString("データを入力してください！！")
            return
        }
        if type == 0 {
            let modelArray : NSArray = getModelArrName("homeModelArr")
            let array : NSMutableArray = NSMutableArray.init()
            array.add(model)
            array.addObjects(from: modelArray as! [Any])
            setModelArrName(array , andKeyname: "homeModelArr")
            print(array)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.delegate?.refreshModel(model)
            self.navigationController?.popViewController(animated: true)
        }
//        var imgStr : String = ""
    }
    @objc func closeBtnAction(){
        uploadUI()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        self.resultViewController = ResultViewController()
        controller.dismiss(animated: true) {
            DispatchQueue.global(qos: .userInitiated).async {
                    self.configImage(scan: scan)
            }
        }
    }
    
    private func configImage(scan: VNDocumentCameraScan) {
        for pageNumber in 0 ..< scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            itemImage = image
            self.processImage(cgImage: image.cgImage!)
            
            
        }
        DispatchQueue.main.async {
            self.lastImg = itemImage
            self.imgBtn.setBackgroundImage(self.lastImg, for: .normal)
            self.imgView.alpha = 0

            if let resultVC = self.resultViewController {
                resultVC.delegate = self
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
        }
    }

}
//extension StyleViewController: VNDocumentCameraViewControllerDelegate {
//
//}
