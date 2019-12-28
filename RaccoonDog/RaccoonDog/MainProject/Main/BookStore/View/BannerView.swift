//
//  BannerView.swift
//  RaccoonDog
//
//  Created by carrot on 28/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class BannerView: BaseView {

    var pageControll : UIPageControl!
    let scrollView  = UIScrollView.init()
    var leftImageView : BannerImageView!
    var centerImageView : BannerImageView!
    var rightImageView : BannerImageView!
    var currentIndex = 0
    var models : [String]  = ["xxx","ccc"]{
        didSet{
            if models.count < 1{
                self.scrollView.isScrollEnabled = false
                return
            }
            
            if models.count == 1{
                self.scrollView.isScrollEnabled = false
            }else{
                self.scrollView.isScrollEnabled = true
            }
            
            self.resetAction()

        }
    }
    
    
    
    func resetAction()  {
        self.pageControll.numberOfPages = models.count
        self.pageControll.sizeToFit()
        self.pageControll.mj_x = (self.mj_w - self.pageControll.mj_w) * 0.5
        self.pageControll.currentPage = 0
        self.currentIndex = 0
        self.scrollView.setContentOffset(CGPoint.init(x: self.scrollView.mj_w, y: 0), animated: false)
        let count = models.count
        if let  string = models[count - 1]  as String?  {
            self.leftImageView.label.text = string
        }
        if (1) < count,let string = models[1] as String? {
            self.rightImageView.label.text = string
        }
        self.centerImageView.label.text = models[self.currentIndex]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func addSubviews() {
        super.addSubviews()
        let width = self.mj_w
        let height = self.mj_h
        self.scrollView.frame = self.bounds
        self.leftImageView = BannerImageView.init(frame:self.bounds)
        self.centerImageView = BannerImageView.init(frame: CGRect.init(x: width, y: 0, width: width, height: height))
        self.rightImageView = BannerImageView.init(frame: CGRect.init(x: width * 2, y: 0, width: width, height: height))
        self.scrollView.contentSize = CGSize.init(width: width * 3, height: height)
        self.addSubview(self.scrollView)
        self.scrollView.isPagingEnabled = true
        self.scrollView.addSubview(self.leftImageView)
        self.scrollView.addSubview(self.centerImageView)
        self.scrollView.addSubview(self.rightImageView)
        self.scrollView.setContentOffset(CGPoint.init(x: width, y: 0), animated: false)
        self.setScroll()
        self.setupPageControl()
        
        
        
    }
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension BannerView : UIScrollViewDelegate{
    func setScroll() {

        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
    }
    func setupPageControl()  {
        let pageCotroll =  UIPageControl.init(frame: CGRect.init(x: 0, y: self.mj_h - 40, width:0 , height: 10))
//        pageCotroll.center = CGPoint.init(x: self.mj_w * 0.5, y: self.mj_h - 30)
        pageCotroll.pageIndicatorTintColor = UIColor.lightGray
        pageCotroll.currentPageIndicatorTintColor = UIColor.red
        self.pageControll = pageCotroll
        self.addSubview(pageCotroll)
    }
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetx = scrollView.contentOffset.x;
        if  offsetx > scrollView.mj_w {// 向右
            
        }else{ //向左
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetx = scrollView.contentOffset.x;
        let width = scrollView.mj_w
        if offsetx > (width  + width * 0.5) {//z向右
            var index = self.currentIndex + 1;
            let count = self.models.count
            if index < count ,let string = self.models[index] as String? {
                self.centerImageView.label.text = string
                
            }else{
                index = 0
                if let string = self.models[index] as String? {
                    self.centerImageView.label.text = string
                }
            }
            
            if self.currentIndex < count,let string = self.models[index] as String? {
                self.leftImageView.label.text = string
            }else{
                self.leftImageView.label.text = self.models[0]
            }
            if (index + 1) < count,let string = self.models[index + 1] as String? {
                self.rightImageView.label.text = string
            }else{
                self.rightImageView.label.text = self.models[0]
            }
            self.currentIndex = index
        }else if offsetx < width * 0.5 {//向左
            var index  = 0
            let count = self.models.count
            if self.currentIndex > 0 {
                index = self.currentIndex - 1;
            }else{
                index = count - 1
            }
            if index < count ,let string = self.models[index] as String? {
                self.centerImageView.label.text = string
                
            }else{
                index = 0
                if let string = self.models[index] as String? {
                    self.centerImageView.label.text = string
                }
            }
            
            if self.currentIndex < count,let string = self.models[index] as String? {
                self.rightImageView.label.text = string
            }else{
                self.rightImageView.label.text = self.models[0]
            }
            if (index - 1) > 0,(index - 1) <  count,let string = self.models[index - 1] as String? {
                self.leftImageView.label.text = string
            }else{
                self.leftImageView.label.text = self.models[count - 1]
            }
            self.currentIndex = index
            
            
        }
        self.pageControll.currentPage = self.currentIndex
        self.scrollView.setContentOffset(CGPoint.init(x: width, y: 0), animated: false)

    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
}
