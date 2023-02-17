//
//  HomeTableViewCell.swift
//  ReadingProject
//
// 
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    lazy var timeLabel : UILabel = {
        let label = UILabel.init(frame: CGRectMake(wid(10),wid(10),wid(70),wid(70)))
        label.textColor = .white
        label.font = BoladFontSize(20)
        label.numberOfLines = 2
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    lazy var backView : UIView = {
        let view = UIView.init(frame: CGRectMake(wid(100),wid(10),SCREEN_WIDTH-wid(110),wid(70)))
        view.layer.borderColor = RBG(96,81,81).cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = wid(5)
        self.contentView.addSubview(view)
        return view
    }()
    lazy var nameLabel : UILabel = {
        let nameLabel = UILabel.init()
        nameLabel.font = FontSize(15)
        nameLabel.text = " "
        nameLabel.sizeToFit()
        nameLabel.textColor = .black
        nameLabel.frame = CGRectMake(wid(5),(backView.height-nameLabel.height)/2.0,backView.width-wid(10),nameLabel.height)
        self.backView.addSubview(nameLabel)
        return nameLabel
    }()
    lazy var typeLabel : UILabel = {
        let typeLabel = UILabel.init()
        typeLabel.font = FontSize(12)
        typeLabel.text = " "
        typeLabel.sizeToFit()
        typeLabel.textColor = .black
        typeLabel.backgroundColor = RBG(208,208,208)
        typeLabel.textAlignment = .center
        typeLabel.sizeToFit()
        self.backView.addSubview(typeLabel)
        return typeLabel
    }()
    func initCell(_ model:HomeModel,_ index : NSInteger){
        timeLabel.text = model.deadline
        backView.alpha = 1
        nameLabel.text = model.name
        let jx = (backView.height-(nameLabel.height + typeLabel.height+hig(5)))/3.0
            
        var y = (model.type.count == 0 ? (backView.height-nameLabel.height)/2.0 : jx)
        nameLabel.frame = CGRectMake(wid(5),y,backView.width-wid(10)-wid(70),nameLabel.height)
       
        if model.type.count > 0{
            y = jx + nameLabel.height + jx
            typeLabel.alpha = 1
            typeLabel.text = model.type

            typeLabel.sizeToFit()
            var width = typeLabel.width+wid(15)
            if typeLabel.width>backView.width-wid(20)-wid(70){
                width = backView.width-wid(20)-wid(70)
            }
            typeLabel.frame = CGRectMake(wid(5),y,width,typeLabel.height+wid(5))

        }else{
            typeLabel.alpha = 0
        }
//        if model.type.count==0
//        {
//
//        }else{
//
//        }
        model.printAll()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
