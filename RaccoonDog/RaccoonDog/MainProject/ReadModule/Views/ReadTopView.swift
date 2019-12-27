//
//  ReadTopView.swift
//  RaccoonDog
//
//  Created by carrot on 27/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit



class ReadTopView: BaseView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    weak var delegate : ReadMenuProtocol?
    /// 返回
    private var back:UIButton!
    
    /// 书签
    private var mark:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        
        
        // 返回
        back = UIButton(type:.custom)
        back.setImage(UIImage(named:"back")!.withRenderingMode(.alwaysTemplate), for: .normal)
        back.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
//        back.tintColor = DZM_READ_COLOR_MENU_COLOR
        addSubview(back)
        
        // 书签
        mark = UIButton(type:.custom)
        mark.contentMode = .center
//        mark.setImage(UIImage(named:"mark")!.withRenderingMode(.alwaysTemplate), for: .normal)
        mark.addTarget(self, action: #selector(clickMark(_:)), for: .touchUpInside)
//        mark.tintColor = DZM_READ_COLOR_MENU_COLOR
        addSubview(mark)
//        updateMarkButton()
    }
    
    /// 点击返回
    @objc private func clickBack() {
        self.delegate?.backAction()
//        readMenu?.delegate?.readMenuClickBack?(readMenu: readMenu)
    }
    
    /// 点击书签
    @objc private func clickMark(_ button:UIButton) {
        
//        readMenu?.delegate?.readMenuClickMark?(readMenu: readMenu, topView: self, markButton: button)
    }
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let y = StatusBarHeight
        
        let wh = NavgationBarHeight - y
        
        back.frame = CGRect(x: 0, y: y, width: wh, height: wh)
        
        mark.frame = CGRect(x: frame.size.width - wh, y: y, width: wh, height: wh)
    }

}
