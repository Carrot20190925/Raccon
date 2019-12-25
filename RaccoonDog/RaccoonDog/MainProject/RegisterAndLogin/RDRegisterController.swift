//
//  RDRegisterController.swift
//  RaccoonDog
//
//  Created by carrot on 22/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit
class RDRegisterController: BaseController {
    @IBOutlet var topConstraint: NSLayoutConstraint!
    
    @IBOutlet var logoImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var backViews: [UIView]!
    
    
    @IBOutlet var subjectLabels: [UILabel]!
    
    @IBOutlet var inputTFs: [UITextField]!
    
    @IBOutlet var commitBtn: UIButton!
    
    @IBOutlet var protocolLabel: UILabel!
    ///倒计时时间
    var seconds = 60
    
    var timer : Timer?
    
    var seletedCountryCode = "CN"
    var disposeBag = DisposeBag.init()
    let countryCallCodeBtn = UIButton.init()
    let verifityBtn = UIButton.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()

        // Do any additional setup after loading the view.
    }
    
    
    
    func initUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.logoImageView.layer.cornerRadius = 25
        self.logoImageView.clipsToBounds = true
        for subjectLabel in self.subjectLabels {
            subjectLabel.textColor = TXTheme.secondColor()
            subjectLabel.font = TXTheme.thirdTitleFont(size: 18)
        }
        
        let attri = NSMutableAttributedString.init(string:RD_localized("欢迎来到小狸阅读\n", ""), attributes: [NSAttributedString.Key.foregroundColor:TXTheme.secondColor(),NSAttributedString.Key.font:TXTheme.thirdTitleFont(size: 23)])
        
        let appendStr = NSAttributedString.init(string: RD_localized("输入手机号码，开始阅读的世界", ""), attributes:[ NSAttributedString.Key.foregroundColor:TXTheme.placeHoderColor(),NSAttributedString.Key.font:TXTheme.thirdTitleFont(size: 15)])
        attri.append(appendStr)
        self.titleLabel.attributedText = attri
        let firstTF = self.inputTFs[0]
        let callCode = PhoneNumberUtil.callingCode(fromCountryCode: self.seletedCountryCode)
        countryCallCodeBtn.setTitle(callCode, for: UIControl.State.normal)
        countryCallCodeBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 14)
        countryCallCodeBtn.setTitleColor(TXTheme.secondColor(), for: .normal)
        countryCallCodeBtn.sizeToFit()

        firstTF.leftView = countryCallCodeBtn
        firstTF.leftViewMode = .always
        firstTF.rx.text.orEmpty.subscribe { (event) in
            MyLog(event)
        }.disposed(by: disposeBag)
        
        
        let secondTF = self.inputTFs[1]
        verifityBtn.setTitle("获取验证码", for: UIControl.State.normal)
        verifityBtn.titleLabel?.font = TXTheme.thirdTitleFont(size: 14)
        verifityBtn.setTitleColor(TXTheme.titleColor(), for: .normal)
        verifityBtn.sizeToFit()

        secondTF.rightView = verifityBtn
        secondTF.rightViewMode = .always
        
        let placeHoders = ["请输入电话号码","请输入短信验证码","请输入邀请码（非必填）"]
        for (index,textField) in self.inputTFs.enumerated() {
            textField.attributedPlaceholder = NSAttributedString.init(string: placeHoders[index], attributes: [NSAttributedString.Key.foregroundColor : TXTheme.placeHoderColor(),NSAttributedString.Key.font:TXTheme.thirdTitleFont(size: 14)])
        }
        
        
        self.addAction()
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func addAction()  {
        countryCallCodeBtn.rx.tap.subscribe({ [weak self](_) in
            MyLog("选取国家号")
            self?.toCountryVC()
        }).disposed(by: disposeBag)
        
        verifityBtn.rx.tap.subscribe { [weak self](_) in
            MyLog("获取验证码")
            self?.sendSMS()
        }.disposed(by: disposeBag)
        
        
        commitBtn.rx.tap.subscribe {[weak self] (_) in
            self?.registerAction()
        }.disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(.init(UIResponder.keyboardWillShowNotification)).subscribe {[weak self ] (event) in
            UIView.animate(withDuration: 0.25) {
                self?.topConstraint.constant = 20 - 100;
            }
//            MyLog(notification.element)
        }.disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(.init(UIResponder.keyboardWillHideNotification)).subscribe {[weak self] (notification) in
            UIView.animate(withDuration: 0.25) {
                self?.topConstraint.constant = 20
            }
            MyLog(notification)
        }.disposed(by: disposeBag)
        
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.endTimer()

    }
    

    deinit {
        
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



extension RDRegisterController:RDContryCodeVCDelegate{
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
    
    //MARK:-  获取验证码
    func sendSMS() {
        self.view.endEditing(true)
        guard let phoneNumber = self.inputTFs[0].text?.trimmingCharacters(in: .whitespaces),phoneNumber.count <= 14,phoneNumber.count >= 7 else{
            self.view.makeToast(RD_localized("请输入正确手机号", ""))
            return
        }
        
        let E164 = PhoneNumberUtil.callingCode(fromCountryCode: self.seletedCountryCode).replacingOccurrences(of: "+", with: "")
        RDAccountManager.SendSMSNetWork(phoneNumber: phoneNumber, E164: E164, success: {[weak self] (response) in
            guard let view = self?.view else{
                return
            }
            
            if let model = BaseModel.getModel(data: response){
                if model.code == 200 {
                    self?.beginTimer()
                    view.makeToast(RD_localized("发送成功", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)
                }else{
                    view.makeToast(RD_localized("发送失败", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: "\(model.code)", image: nil, style: ToastStyle.init(), completion: nil)
                }
            }else{
                view.makeToast(RD_localized("发送失败", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)
            }

            MyLog(response)
        }) {[weak self] (error) in
            guard let view = self?.view else{
                return
            }

            let ensureError = error as! NSError
            view.makeToast(RD_localized("发送失败", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: "\(ensureError.code)", image: nil, style: ToastStyle.init(), completion: nil)
            MyLog(error)
            
        }
    
    }
    
    //MARK:-  注册请求
    func registerAction() {
        self.view.endEditing(true)
        guard let phoneNumber = self.inputTFs[0].text?.trimmingCharacters(in: .whitespaces),phoneNumber.count <= 14,phoneNumber.count >= 7 else{
            self.view.makeToast(RD_localized("请输入正确手机号", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)

            return
        }
        guard let code = self.inputTFs[1].text?.trimmingCharacters(in: .whitespaces) else {
            self.view.makeToast(RD_localized("请输入验证码", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)
            return
        }
        let E164 = PhoneNumberUtil.callingCode(fromCountryCode: self.seletedCountryCode).replacingOccurrences(of: "+", with: "")
        RDAccountManager.registerNetWork(phoneNumber: phoneNumber, code: code, E164: E164, password: "1111111", success: {[weak self] (response) in
            guard let view = self?.view else{
                return
            }
            if let model = BaseModel.getModel(data: response){
                if model.code == 200 {
                    view.makeToast(RD_localized("注册成功", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)
                }else{
                    view.makeToast(RD_localized("注册失败", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: "\(model.code)", image: nil, style: ToastStyle.init(), completion: nil)
                }
            }else{
                view.makeToast(RD_localized("注册失败", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: nil, image: nil, style: ToastStyle.init(), completion: nil)
            }
            MyLog(response)
        }) {[weak self] (error) in
            guard let view = self?.view else{
                return
            }
            let ensureError = error as? NSError
            view.makeToast(RD_localized("发送失败", ""), duration: 1.0, point: CGPoint.init(x: rScreenWidth * 0.5, y: rScreenHeight*0.5), title: "\(ensureError?.code)", image: nil, style: ToastStyle.init(), completion: nil)
            MyLog(error)        }
    }
    
    
    
    
}


extension RDRegisterController {
    func beginTimer() {
        self.endTimer()
        self.seconds = 60
        self.verifityBtn.isUserInteractionEnabled = false
        let timer = Timer.init(timeInterval: 1.0, repeats: true, block: {[weak self] (timer) in
            guard let weakSelf = self else{
                timer.invalidate()
                return
            }
            weakSelf.seconds -= 1
            let text = "\(weakSelf.seconds) S"
            weakSelf.verifityBtn.titleLabel?.text = text
            weakSelf.verifityBtn.setTitle(text, for: .normal)
            if weakSelf.seconds == 0{
                weakSelf.endTimer()

            }
        })
        self.timer = timer
        RunLoop.current.add(timer, forMode: .common)
        self.timer?.fire()

    }
    
    func endTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.verifityBtn.setTitle("重新获取", for: .normal)
        self.verifityBtn.isUserInteractionEnabled = true
    }
}
