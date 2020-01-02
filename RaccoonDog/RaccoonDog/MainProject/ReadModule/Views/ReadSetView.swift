//
//  ReadSetView.swift
//  RaccoonDog
//
//  Created by carrot on 27/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class ReadSetView: BaseView {

    weak var delegate : ReadSetProtocol?
    let progressView = UIView.init()
    let fontSizeView = UIView.init()
    let effectView = UIView.init()
    let fontView = UIView.init()
    let backView = UIView.init()
    let spaceView = UIView.init()
    weak var fontSizeLabel : UILabel?
    weak var selectedEffectBtn : UIButton?
    weak var selectedFontBtn : UIButton?
    weak var selectedBackgroundBtn : UIButton?
    weak var selectedSpaceBtn : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func addSubviews() {
        super.addSubviews()
        self.backgroundColor = ReadConfigModel.shared().menuBackgroudColor()
        self.initFrame()
        self.setProgressView()
        self.setFontSizeView()
        self.setEffectView()
        self.setFontView()
        self.setBackView()
        self.setSpaceView()
        self.addSubview(self.progressView)
        self.addSubview(self.fontSizeView)
        self.addSubview(self.effectView)
        self.addSubview(self.fontView)
        self.addSubview(self.backView)
        self.addSubview(spaceView)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension ReadSetView{
    
    func initFrame() {
        let x : CGFloat = 0
        var y : CGFloat = 0
        let width = self.mj_w
        let height : CGFloat = 40
        self.progressView.frame = CGRect.init(x: x, y: y, width: width, height: height)
        y = y + height + 10
        self.fontSizeView.frame = CGRect.init(x: x, y: y, width: width, height: height)
        y = y + height + 10
        self.effectView.frame = CGRect.init(x: x, y: y, width: width, height: height)
        y = y + height + 10
        self.fontView.frame = CGRect.init(x: x, y: y, width: width, height: height)
        y = y + height + 10
        self.backView.frame = CGRect.init(x: x, y: y, width: width, height: height)
        y = y + height + 10
        self.spaceView.frame = CGRect.init(x: x, y: y, width: width, height: height)
        self.mj_h = y + height + 10 + TabBarHeight - 49
    }
    
    //MARK:-  设置progressView
    func setProgressView() {
        let firstImage = UIImageView.init()
        firstImage.image = UIImage.init(named: "light_0")?.withRenderingMode(.alwaysOriginal)

        let secondImage = UIImageView.init()
        secondImage.image = UIImage.init(named: "light_1")?.withRenderingMode(.alwaysOriginal)

        let slider = UISlider.init()
        slider.setThumbImage(UIImage.init(named: "slider")?.withRenderingMode(.alwaysOriginal), for: .normal)
        slider.addTarget(self, action: #selector(sliderAction(sender:)), for: .valueChanged)
        self.progressView.addSubview(firstImage)
        self.progressView.addSubview(secondImage)
        self.progressView.addSubview(slider)
        let space : CGFloat = 15.0
        firstImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(space)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(30)
        }
        secondImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-space)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        slider.snp.makeConstraints { (make) in
            make.right.equalTo(secondImage.snp.left).offset(-space)
            make.left.equalTo(firstImage.snp.right).offset(space)
            make.centerY.equalTo(firstImage.snp.centerY)
        }
        
    }
    //MARK:-  设置 FontSizeView
    func setFontSizeView() {
        let addBtn = self.getCustomBtn()
        addBtn.tag = 0
        let subtractBtn = self.getCustomBtn()
        subtractBtn.tag = 1
        let showLabel = UILabel.init()
        addBtn.setTitle("A+", for: .normal)
        subtractBtn.setTitle("A-", for: .normal)
        showLabel.text = "\(ReadConfigModel.shared().fontSize)"
        showLabel.textColor = UIColor.white
        showLabel.textAlignment = .center
        self.fontSizeView.addSubview(addBtn)
        self.fontSizeView.addSubview(subtractBtn)
        self.fontSizeView.addSubview(showLabel)
        self.fontSizeLabel = showLabel
        let space : CGFloat = 15.0

        subtractBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(space)
            make.bottom.equalToSuperview()
            make.right.equalTo(showLabel.snp.left)
            make.height.equalTo(30)
        }
        
        addBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-space)
            make.bottom.equalToSuperview()
            make.left.equalTo(showLabel.snp.right)
            make.height.equalTo(30)
            make.width.equalTo(subtractBtn.snp.width)
        }
        
        showLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(addBtn.snp.centerY)
            make.width.equalTo(80)
                
        }
        
        addBtn.addTarget(self, action: #selector(addOrSubstractFontSize(sender:)), for: .touchUpInside)
        subtractBtn.addTarget(self, action: #selector(addOrSubstractFontSize(sender:)), for: .touchUpInside)

    }
    @objc
    private func addOrSubstractFontSize(sender:UIButton){
        let min = 12
        let max = 55
        if sender.tag == 0 {//加
            if  ReadConfigModel.shared().fontSize >= max{
                return
            }
            ReadConfigModel.shared().fontSize += 1
        }else{//减
            if ReadConfigModel.shared().fontSize <= min {
                return
            }
            ReadConfigModel.shared().fontSize -= 1
        }
        ReadConfigModel.shared().save()
        self.fontSizeLabel?.text = "\(ReadConfigModel.shared().fontSize)"
        self.delegate?.setFontSize()
    }
    
    
    //MARK:-  设置翻页view
    private func setEffectView(){
        let effects =  ["仿真","平移","滚动","无效果"]
        let space : CGFloat = 20
        var x : CGFloat = 15
        let y : CGFloat = 10
        let width = (self.effectView.mj_w - 2 * x - CGFloat.init(effects.count - 1) * space)/CGFloat.init(effects.count)
        let height : CGFloat = 30
        let seletedIndex = ReadConfigModel.shared().effectType.rawValue
        

        for (index,effect) in effects.enumerated() {
            let button = self.getCustomBtn()
            if index == seletedIndex {
                button.isSelected = true
                button.layer.borderColor = TXTheme.readSetColor().cgColor
                self.selectedEffectBtn = button
                
            }
            button.tag = index
            button.setTitle(effect, for: .normal)
            button.frame = CGRect.init(x: x, y: y, width: width, height: height)
            button.addTarget(self, action: #selector(setEffectModel(sender:)), for: .touchUpInside)
            self.effectView.addSubview(button)
            x = x + width + space
        }
        
    }
    
    //MARK:-  设置翻页模式
    @objc
    private func setEffectModel(sender : UIButton){
        if sender == self.selectedEffectBtn {
            return
        }
        self.selectedEffectBtn?.isSelected = false
        self.selectedEffectBtn?.layer.borderColor = UIColor.white.cgColor
        sender.isSelected = true
        sender.layer.borderColor = TXTheme.readSetColor().cgColor
        self.selectedEffectBtn = sender
        switch sender.tag {
        case 0://仿真
            ReadConfigModel.shared().effectType = .simulation
            break
        case 1:
            ReadConfigModel.shared().effectType = .translation

            break
        case 2:
            ReadConfigModel.shared().effectType = .scroll
            break
        default:
            ReadConfigModel.shared().effectType = .no

            break
            
        }
        
        ReadConfigModel.shared().save()
        self.delegate?.setEffect()
    }
    
    
    
    
    //MARK:-  设置字体view
    func setFontView()  {
        let fonts =  ["系统","黑体","楷体","宋体"]
        let space : CGFloat = 20
        var x : CGFloat = 15
        let y : CGFloat = 10
        let width = (self.effectView.mj_w - 2 * x - CGFloat.init(fonts.count - 1) * space)/CGFloat.init(fonts.count)
        let height : CGFloat = 30
        let seletedIndex = ReadConfigModel.shared().fontType.rawValue

        for (index,font) in fonts.enumerated() {
            let button = self.getCustomBtn()
            if seletedIndex == index {
                button.isSelected = true
                button.layer.borderColor = TXTheme.readSetColor().cgColor
                self.selectedFontBtn = button
            }
            button.tag = index
            button.setTitle(font, for: .normal)
            button.frame = CGRect.init(x: x, y: y, width: width, height: height)
            button.addTarget(self, action: #selector(setFontModel(sender:)), for: .touchUpInside)
            self.fontView.addSubview(button)
            x = x + width + space
        }
    }
    
    //MARK:-  设置字体
    @objc
    private func setFontModel(sender : UIButton){
        if sender == self.selectedFontBtn {
            return
        }
        self.selectedFontBtn?.isSelected = false
        self.selectedFontBtn?.layer.borderColor = UIColor.white.cgColor
        sender.isSelected = true
        sender.layer.borderColor = TXTheme.readSetColor().cgColor
        self.selectedFontBtn = sender
        switch sender.tag {
        case 0://系统
            ReadConfigModel.shared().fontType = RDFontType.system
            break
        case 1:
            ReadConfigModel.shared().fontType = RDFontType.one
            break
        case 2:
            ReadConfigModel.shared().fontType = RDFontType.two
            break

        default:
            ReadConfigModel.shared().fontType = RDFontType.three
            break
            
        }
        ReadConfigModel.shared().save()
        
        self.delegate?.setFont()

    }
    
    //MARK:-  设置背景view
    func setBackView()  {
        let colors = [TXTheme.rgbColor(255, 255, 255),
                      TXTheme.rgbColor(236, 224, 204),
                      TXTheme.rgbColor(212, 237, 208),
                      TXTheme.rgbColor(243, 226, 175),
                      TXTheme.rgbColor(211, 232, 240)
                    ]
        let space : CGFloat = 20
        var x : CGFloat = 15
        let y : CGFloat = 10
        let width = (self.effectView.mj_w - 2 * x - CGFloat.init(colors.count - 1) * space)/CGFloat.init(colors.count)
        
        let height : CGFloat = 30
        let seletedIndex = ReadConfigModel.shared().backgroudType.rawValue
        for (index,color) in colors.enumerated() {
            let button = self.getCustomBtn()
            if index == seletedIndex {
                button.isSelected = true
                self.selectedBackgroundBtn = button
            }else{
                button.layer.borderWidth = 0

            }
            button.tag = index
            button.layer.borderColor = TXTheme.readSetColor().cgColor
            
            button.backgroundColor = color
            button.frame = CGRect.init(x: x, y: y, width: width, height: height)
            button.addTarget(self, action: #selector(setBackgroudColor(sender:)), for: .touchUpInside)
            self.backView.addSubview(button)
            x = x + width + space
        }
        
    }
    //MARK:-  设置背景色
    @objc
    private func setBackgroudColor(sender : UIButton){
        if sender == self.selectedBackgroundBtn {
            return
        }
        self.selectedBackgroundBtn?.isSelected = false
        self.selectedBackgroundBtn?.layer.borderWidth = 0
        sender.isSelected = true
        sender.layer.borderWidth = 1
        self.selectedBackgroundBtn = sender
        switch sender.tag {
        case 0:
            ReadConfigModel.shared().backgroudType = .zero
        case 1:
            ReadConfigModel.shared().backgroudType = .one

        case 2:
            ReadConfigModel.shared().backgroudType = .two

        case 3:
            ReadConfigModel.shared().backgroudType = .three

        default:
            ReadConfigModel.shared().backgroudType = .four
            break
        }
        ReadConfigModel.shared().save()
        self.delegate?.setBackgroud()
        
    }
    
    
    //MARK:-  设置字体格式
    func setSpaceView()  {
        let fonts =  ["紧凑","适中","松散"]
        let space : CGFloat = 20
        var x : CGFloat = 15
        let y : CGFloat = 10
        let width = (self.effectView.mj_w - 2 * x - CGFloat.init(fonts.count - 1) * space)/CGFloat.init(fonts.count)
        let height : CGFloat = 30
        let seletedIndex = ReadConfigModel.shared().spacingType.rawValue

        for (index,font) in fonts.enumerated() {
            let button = self.getCustomBtn()
            if index == seletedIndex {
                button.layer.borderColor = TXTheme.readSetColor().cgColor
                button.isSelected = true
                self.selectedSpaceBtn = button
            }
            button.tag = index
            button.setTitle(font, for: .normal)
            button.frame = CGRect.init(x: x, y: y, width: width, height: height)
            button.addTarget(self, action: #selector(setSpaceAction(sender:)), for: .touchUpInside)
            self.spaceView.addSubview(button)
            x = x + width + space
        }
    }
    
    
    //MARK:-  设置间距
    @objc
    private func setSpaceAction(sender : UIButton){
        if sender == self.selectedSpaceBtn {
            return
        }
        self.selectedSpaceBtn?.isSelected = false
        self.selectedSpaceBtn?.layer.borderColor = UIColor.white.cgColor
        sender.isSelected = true
        sender.layer.borderColor = TXTheme.readSetColor().cgColor
        self.selectedSpaceBtn = sender
        switch sender.tag {
        case 0:
            ReadConfigModel.shared().spacingType = .small
        case 1:
            ReadConfigModel.shared().spacingType = .middle

        case 2:
            ReadConfigModel.shared().spacingType = .big
        default:
            break
        }
        ReadConfigModel.shared().save()
        self.delegate?.setSpace()
    }

    
    
    
    
    private func getCustomBtn() -> UIButton
    {
        let customBtn = UIButton.init(type: .custom)
        customBtn.setTitleColor(UIColor.white, for: .normal)
        customBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 12)
        customBtn.setTitleColor(TXTheme.readSetColor(), for: .selected)
        customBtn.layer.cornerRadius = 5
        customBtn.clipsToBounds = true
        customBtn.layer.borderColor = UIColor.white.cgColor
        customBtn.layer.borderWidth = 1
        return customBtn
    }
    
    
    
    
    //MARK:-  调整亮度
    @objc
    private func sliderAction(sender:UISlider){

        self.delegate?.setLightProgerss()
        
        
    }
    
    
}
