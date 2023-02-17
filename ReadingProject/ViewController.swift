//
//  ViewController.swift
//  ReadingProject
//
//
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let tableView : UITableView = UITableView.init(frame: CGRectMake(0,topHeight,SCREEN_WIDTH,SCREEN_HEIGHT-topHeight), style: .plain)
    
    var dataSource : NSArray = []
    
    let addBtn : UIButton = UIButton.init(frame: CGRectMake(wid(90)+wid(20),SCREEN_HEIGHT-tabbarHeight-wid(70),wid(60),wid(60)))
    
    let boxBtn : UIButton = UIButton.init(frame: CGRectMake(SCREEN_WIDTH-wid(100)-wid(20),SCREEN_HEIGHT-tabbarHeight-wid(80),wid(100),wid(100)))
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let topView = UIView.init(frame: CGRectMake(0,0,SCREEN_WIDTH,topHeight))
        topView.backgroundColor = .white
        view.addSubview(topView)
        let leftView = UIView.init(frame: CGRectMake(0,0,wid(90),SCREEN_HEIGHT))
        leftView.backgroundColor = RBG(96,81,81)
        view.addSubview(leftView)

        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        tableView.tableFooterView = UIView.init(frame: CGRectZero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier:NSStringFromClass(HomeTableViewCell.self))
        tableView.reloadData()
        view.addSubview(tableView)
        view.backgroundColor = .white
        creatHeaderView()
        view.addSubview(addBtn)
        view.addSubview(boxBtn)
        addBtn.setBackgroundImage(UIImage.init(named: "add"), for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        boxBtn.setBackgroundImage(UIImage.init(named: "box"), for: .normal)
        getData()
    }
    func getData(){
        dataSource = getModelArrName("homeModelArr")
        tableView.reloadData()
    }
    func creatHeaderView(){
        let btn = UIButton.init(frame: CGRectMake(0,0,wid(90),topHeight))
        btn.backgroundColor = RBG(96,81,81)
        let btnImg = UIImageView.init(frame: CGRectMake((wid(90)-wid(25))/2.0,navy(wid(25)),wid(25),wid(25)))
        btnImg.image = UIImage.init(named:"Home_Top")
        btn.addSubview(btnImg)
        view.addSubview(btn)
        let allBtn = UIButton.init(frame: CGRectMake(wid(90),0,(SCREEN_WIDTH-wid(90))/2.0,topHeight))
        let allBtnImg = UIImageView.init(frame: CGRectMake(wid(20),navy(wid(25)),wid(25),wid(25)))
        allBtnImg.image = UIImage.init(named: "All")
        allBtn.addSubview(allBtnImg)
        let allLabel = creatLabel(text: "全部", fontSize: 20, color: UIColor.black, isMore: true)
        allLabel.frame = CGRectMake(allBtnImg.right+wid(20),allBtnImg.y+(allBtnImg.height-allLabel.height)/2.0,allLabel.width,allLabel.height)
        allBtn.addSubview(allLabel)
        view.addSubview(allBtn)
        let searchBtn = UIButton.init(frame: CGRectMake(allBtn.right,0,SCREEN_WIDTH-allBtn.right,topHeight))
//        let searchImg = creatImgView(rect:CGRectMake(searchBtn.width-wid(50),navy(wid(25)),wid(25),wid(25)), named:"搜索")
//        searchBtn.addSubview(searchImg)
        
        //暂退
    
        view.addSubview(searchBtn)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return wid(90);
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier:NSStringFromClass(HomeTableViewCell.self)) as! HomeTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        cell.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        cell.initCell(self.dataSource[indexPath.row] as! HomeModel, indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let add = AddViewController.init()
        add.hidesBottomBarWhenPushed = true
        add.model = self.dataSource[indexPath.row] as! HomeModel 
        add.index = indexPath.row
        self.navigationController?.pushViewController(add, animated:true)
    }
    
    @objc func addBtnAction(){
        let edit = EditViewController.init()
        edit.type = 0
        self.navigationController?.pushViewController(edit, animated: true)
    }

}

