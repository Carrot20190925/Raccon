//
//  BookDetailHeadView.swift
//  RaccoonDog
//
//  Created by carrot on 30/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BookDetailHeadView: BaseReusableView {

    @IBOutlet var actionBtns: [UIButton]!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var subjectLabels: [UILabel]!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var showBtn: UIButton!
    
    var item : BookShelfModel?
    
    
    
    func setBookModel(bookModel : BookShelfModel?)  {
        
        guard let model = bookModel else {
            return
        }
        if let url = model.face {
            self.imageView.setImage(urlString: url)
        }


        
        if let bookName = model.title {
            self.bookNameLabel.text = bookName
        }
        if let bookAuthor = model.author {
            self.bookAuthorLabel.text = "\(bookAuthor) 著作"
        }
        if let desc = model.description {
            self.descLabel.text = desc
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 9.0
        paragraphStyle.alignment = .center
        for (index,label) in self.subjectLabels.enumerated() {
            
            var string : String!
            var append : String!
            switch index {
            case 0:
                string = String.init(format: "%.1lf\n", model.score ?? 0)
                append = "评分"
                break
            case 1:
                string = String.init(format: "%d\n", model.favorite_num )
                append = "收藏"

                break
            case 2:
                string = String.init(format: "%d\n", model.download_num )
                append = "下载"

                break
            default:
                string = String.init(format: "%d\n", model.read_num ?? 0)
                append = "阅读"

                
            }
            
            
            let attri = NSMutableAttributedString.init(string: string, attributes: [NSAttributedString.Key.font : TXTheme.thirdTitleFont(size: 14),NSAttributedString.Key.foregroundColor : TXTheme.categoryTitleColor(),NSAttributedString.Key.paragraphStyle:paragraphStyle])
            
            let appendStr = NSAttributedString.init(string: append, attributes: [NSAttributedString.Key.foregroundColor : TXTheme.tenthColor(),NSAttributedString.Key.font: TXTheme.thirdTitleFont(size: 11)])
            attri.append(appendStr)
            label.attributedText = attri

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
        // Initialization code
    }
    
    private func initUI(){
        let layColor = TXTheme.twelfthColor()
        let titleColor = TXTheme.thirteenthColor()
        let font = TXTheme.thirdTitleFont(size: 14)
        
        
        for btn in self.actionBtns {
            btn.titleLabel?.font = font
            btn.layer.cornerRadius = 5
            btn.clipsToBounds = true
            if btn.tag != 1 {
                btn.layer.borderColor = layColor.cgColor
                btn.layer.borderWidth = 0.5
                btn.setTitleColor(titleColor, for: .normal)
            }else{
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = TXTheme.themeColor()
            }
        }
        self.showBtn.setTitleColor(TXTheme.themeColor(), for: .normal)
        self.showBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 12)
        
        self.descLabel.textColor = TXTheme.placeHoderColor()
        self.descLabel.font = TXTheme.thirdTitleFont(size: 14)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 9.0
        paragraphStyle.alignment = .center
        for label in self.subjectLabels {
            label.numberOfLines = 0
            let attri = NSMutableAttributedString.init(string: "8.0\n", attributes: [NSAttributedString.Key.font : TXTheme.thirdTitleFont(size: 14),NSAttributedString.Key.foregroundColor : TXTheme.categoryTitleColor(),NSAttributedString.Key.paragraphStyle:paragraphStyle])
            let appendStr = NSAttributedString.init(string: "评分", attributes: [NSAttributedString.Key.foregroundColor : TXTheme.tenthColor(),NSAttributedString.Key.font: TXTheme.thirdTitleFont(size: 11)])

            attri.append(appendStr)
            label.attributedText = attri
        }
        
    }
    
    @IBAction func showAction(_ sender: UIButton) {
    }
    @IBAction func actions(_ sender: UIButton) {
    }
}
