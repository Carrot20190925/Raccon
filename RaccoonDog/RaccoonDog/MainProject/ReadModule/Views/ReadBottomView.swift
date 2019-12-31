//
//  DZMRMFuncView.swift
//  DZMeBookRead
//
//  Created by dengzemiao on 2019/4/19.
//  Copyright © 2019年 DZM. All rights reserved.
//

import UIKit

class ReadBottomView: BaseView {

    weak var delegate : ReadMenuProtocol?
    /// 目录
    private var catalogue:UIButton!
    
    /// 设置
    private var setting:UIButton!
    
    /// 日夜间切换 (Day and Night)
    private var dn:UIButton!
    
    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func addSubviews() {
        
        super.addSubviews()
        
        backgroundColor = UIColor.clear
        
        // 目录
        catalogue = UIButton(type:.custom)
        catalogue.setImage(UIImage(named:"bar_0")?.withRenderingMode(.alwaysTemplate), for: .normal)
        catalogue.addTarget(self, action: #selector(clickCatalogue), for: .touchUpInside)
        addSubview(catalogue)
        
        // 日夜间
        dn = UIButton(type:.custom)
        dn.setImage(UIImage(named:"bar_2")!.withRenderingMode(.alwaysTemplate), for: .normal)
        dn.addTarget(self, action: #selector(clickDN(_:)), for: .touchUpInside)
        dn.isSelected = DZMUserDefaults.bool(DZM_READ_KEY_MODE_DAY_NIGHT)
        addSubview(dn)
        updateDNButton()
        
        // 设置
        setting = UIButton(type: .custom)
        setting.setImage(UIImage(named:"bar_1")!.withRenderingMode(.alwaysTemplate), for: .normal)
        setting.addTarget(self, action: #selector(clickSetting), for: .touchUpInside)
//        setting.tintColor = DZM_READ_COLOR_MENU_COLOR
        addSubview(setting)
    }
    
    /// 点击目录
    @objc private func clickCatalogue() {
        self.delegate?.showList()
//        readMenu?.delegate?.readMenuClickCatalogue?(readMenu: readMenu)
    }
    
    /// 点击日夜间
    @objc private func clickDN(_ button:UIButton) {
        
        button.isSelected = !button.isSelected
        self.delegate?.changeDayNight()
        // 切换日夜间
//        readMenu.cover.alpha = CGFloat(NSNumber(value: button.isSelected).floatValue)
        
        // 刷新显示
        updateDNButton()
        
        // 记录日夜间状态
        DZMUserDefaults.setBool(button.isSelected, DZM_READ_KEY_MODE_DAY_NIGHT)
        
    }
    
    /// 点击设置
    @objc private func clickSetting() {
        self.delegate?.showSet()
    }
    
    /// 刷新日夜间按钮显示状态
    func updateDNButton() {
        
//        if dn.isSelected { dn.tintColor = DZM_READ_COLOR_MAIN
//
//        }else{ dn.tintColor = DZM_READ_COLOR_MENU_COLOR }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let wh = frame.size.height
        
        catalogue.frame = CGRect(x: 0, y: DZM_SPACE_SA_3, width: wh, height: wh)
        
        dn.frame = CGRect(x: (frame.size.width - wh)/2, y: DZM_SPACE_SA_3, width: wh, height: wh)
        
        setting.frame = CGRect(x: frame.size.width - wh, y: DZM_SPACE_SA_3, width: wh, height: wh)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
