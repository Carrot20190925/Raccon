//
//  RDLoginController.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class RDLoginController: BaseController {
    let disposeBag = DisposeBag.init()
    var seletedCountryCode = "CN"
    let countryCallCodeBtn = UIButton.init()
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet var subjectLabels: [UILabel]!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var inputTFs: [UITextField]!
    
    @IBOutlet weak var commitBtn: UIButton!
    @IBOutlet var actionBtns: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    func initUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.logoImageView.layer.cornerRadius = 25
        self.logoImageView.clipsToBounds = true
        for subjectLabel in self.subjectLabels {
            subjectLabel.textColor = TXTheme.secondColor()
            subjectLabel.font = TXTheme.thirdTitleFont(size: 18)
        }
        self.commitBtn.backgroundColor = TXTheme.themeColor()
        self.commitBtn.layer.cornerRadius = 25.0
        self.commitBtn.clipsToBounds = true
        self.commitBtn.setTitleColor(UIColor.white, for: .normal)
        
        let attri = NSMutableAttributedString.init(string:RD_localized("欢迎来到小狸阅读\n", ""), attributes: [NSAttributedString.Key.foregroundColor:TXTheme.secondColor(),NSAttributedString.Key.font:TXTheme.thirdTitleFont(size: 23)])
        
        let appendStr = NSAttributedString.init(string: RD_localized("输入手机号码，开始阅读的世界", ""), attributes:[ NSAttributedString.Key.foregroundColor:TXTheme.placeHoderColor(),NSAttributedString.Key.font:TXTheme.thirdTitleFont(size: 15)])
        attri.append(appendStr)
        self.titleLabel.attributedText = attri
        let firstTF = self.inputTFs[0]
        firstTF.text = "12345678910"
        let callCode = PhoneNumberUtil.callingCode(fromCountryCode: self.seletedCountryCode)
        countryCallCodeBtn.setTitle("+899", for: UIControl.State.normal)
        countryCallCodeBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 14)
        countryCallCodeBtn.setTitleColor(TXTheme.secondColor(), for: .normal)
        countryCallCodeBtn.sizeToFit()
        firstTF.leftView = countryCallCodeBtn
        firstTF.leftViewMode = .always
        countryCallCodeBtn.setTitle(callCode, for: UIControl.State.normal)
        let secondTF = self.inputTFs[1]
        secondTF.text = "12341234"
        

        

        
        let placeHoders = ["请输入电话号码","请输入密码"]
        for (index,textField) in self.inputTFs.enumerated() {
            textField.attributedPlaceholder = NSAttributedString.init(string: placeHoders[index], attributes: [NSAttributedString.Key.foregroundColor : TXTheme.placeHoderColor(),NSAttributedString.Key.font:TXTheme.thirdTitleFont(size: 14)])
        }
        
        countryCallCodeBtn.rx.tap.subscribe({ [weak self](_) in
            MyLog("选取国家号")
            self?.toCountryVC()
        }).disposed(by: disposeBag)
        

    }
    //MARK:-   登录
    @IBAction func commitAction(_ sender: UIButton) {
        guard let phoneNumber = self.inputTFs[0].text, phoneNumber.count >= 7, phoneNumber.count <= 14 else {
            self.view.makeToast(RD_localized("请输入正确手机号", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)

            return
        }
        guard let password = self.inputTFs[1].text,password.count >= 6 else {
            self.view.makeToast(RD_localized("请输入正确密码", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)
            return
        }
        
        let E164 = PhoneNumberUtil.callingCode(fromCountryCode: self.seletedCountryCode).replacingOccurrences(of: "+", with: "")
        RDAccountManager.loginNetWork(phoneNumber: phoneNumber, E164: E164, password: password, success: {[weak self] (response) in
            guard let weakSelf = self else{
                return
            }
            var toastStyle = ToastStyle.init()
            toastStyle.titleAlignment = NSTextAlignment.center
            toastStyle.messageAlignment = NSTextAlignment.center
            if let model = BaseModel.getModel(data: response){

                if model.code == 200 {
                    if  let account = RDAccount.getAccount(data: model.data){
                        RDAccountManager.share.saveCurrentAccount(account: account)
                    }
                    weakSelf.view.makeToast(RD_localized("登录成功", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: toastStyle, completion: nil)
                    if let widown = UIApplication.shared.keyWindow {
                        widown.rootViewController = BaseTabBarController.init()
                        widown.makeKeyAndVisible()
                        return
                    }

                }else{
                    weakSelf.view.makeToast(model.message, duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: RD_localized("登录失败", ""), image: nil, style: toastStyle, completion: nil)

                }
                MyLog(response)
            }
        }) {[weak self] (error) in
            MyLog(error)
            guard let weakSelf = self else{
                return
            }
            var toastStyle = ToastStyle.init()
            toastStyle.titleAlignment = NSTextAlignment.center
            toastStyle.messageAlignment = NSTextAlignment.center
            weakSelf.view.makeToast(RD_localized("登录失败", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: error.localizedDescription, image: nil, style: toastStyle, completion: nil)

        }
 
    }
    

    @IBAction func toSetPasswordAction(_ sender: UIButton) {
    }
    
    @IBAction func toRegisterAction(_ sender: UIButton) {
        let registerVC =  RDRegisterController.init()
        self.navigationController?.pushViewController(registerVC, animated: true)
    
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

extension RDLoginController:RDContryCodeVCDelegate{
    //MARK:-  设置选择国家
    private func toCountryVC(){
        let countryVC = RDContryCodeVC.init()
        countryVC.delegate = self
        let nav = BaseNavigationController.init(rootViewController: countryVC)
        self.present(nav, animated: true, completion: nil)
        

    }
    //MARK:-  RDContryCodeVCDelegate
    func selectedCountryCode(_ countryCode: String) {
        self.seletedCountryCode = countryCode
        let callCode = PhoneNumberUtil.callingCode(fromCountryCode: countryCode)
        self.countryCallCodeBtn.setTitle(callCode, for: .normal)
        self.countryCallCodeBtn.sizeToFit()
        let tf = self.inputTFs[0]
        tf.leftView = self.countryCallCodeBtn
    }
}
