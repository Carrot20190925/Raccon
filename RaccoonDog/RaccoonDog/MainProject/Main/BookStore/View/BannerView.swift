//
//  BannerView.swift
//  RaccoonDog
//
//  Created by carrot on 28/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

protocol BannerViewDelegate:NSObjectProtocol {
    func modelsCount() -> Int;
    
    func currentIndex(index : Int,imageView:BannerImageView) -> Void;
    
    func clickImageAction(index:Int) -> Void;
}
//extension BannerViewDelegate{
//    func modelsCount() -> Int{}
//}


class BannerView: BaseView {
    
    weak var delegate : BannerViewDelegate!

    var pageControll : UIPageControl!
    let scrollView  = UIScrollView.init()
    var leftImageView : BannerImageView!
    var centerImageView : BannerImageView!
    var rightImageView : BannerImageView!
    var currentIndex = 0
//    var models : [String]  = ["xxx","ccc"]{
//        didSet{
//            if models.count < 1{
//                self.scrollView.isScrollEnabled = false
//                return
//            }
//
//            if models.count == 1{
//                self.scrollView.isScrollEnabled = false
//            }else{
//                self.scrollView.isScrollEnabled = true
//            }
//
//            self.resetAction()
//
//        }
//    }
    
    
    
    func resetAction()  {
        
        guard let count  = self.delegate?.modelsCount() else{
            return
        }
        
        if count < 1{
            self.scrollView.isScrollEnabled = false
            return
        }
        
        if count == 1{
            self.scrollView.isScrollEnabled = false
        }else{
            self.scrollView.isScrollEnabled = true
        }
        
        
        self.pageControll.numberOfPages = count
        self.pageControll.sizeToFit()
        self.pageControll.mj_x = (self.mj_w - self.pageControll.mj_w) * 0.5
        self.pageControll.currentPage = 0
        self.currentIndex = 0
        self.scrollView.setContentOffset(CGPoint.init(x: self.scrollView.mj_w, y: 0), animated: false)
        self.delegate?.currentIndex(index: count - 1, imageView: self.leftImageView)

        
        if (1) < count {
            self.delegate?.currentIndex(index: 1, imageView: self.rightImageView)
        }
        self.delegate?.currentIndex(index: self.currentIndex, imageView: self.centerImageView)
        self.centerImageView.tag = self.currentIndex
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
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))

        self.leftImageView = BannerImageView.init(frame:self.bounds)
        self.centerImageView = BannerImageView.init(frame: CGRect.init(x: width, y: 0, width: width, height: height))
        self.centerImageView.addGestureRecognizer(tap)
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
    @objc
    func tapAction()  {
        let index = self.centerImageView.tag
        self.delegate.clickImageAction(index: index)
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
            let count = self.delegate.modelsCount()
            if count == 0 {
                return
            }
            if index < count  {
                self.delegate.currentIndex(index: index, imageView: self.centerImageView)
                
            }else{
                index = 0
                self.delegate.currentIndex(index: index, imageView: self.centerImageView)

            }
            
            if self.currentIndex < count{
                self.delegate.currentIndex(index: self.currentIndex, imageView: self.leftImageView)
            }else{
                self.delegate.currentIndex(index: 0, imageView: self.leftImageView)
            }
            if (index + 1) < count {
                self.delegate.currentIndex(index: (index + 1), imageView: self.rightImageView)

            }else{
                self.delegate.currentIndex(index: 0, imageView: self.rightImageView)

            }
            self.currentIndex = index
        }else if offsetx < width * 0.5 {//向左
            var index  = 0
            let count = self.delegate.modelsCount()
            if count == 0 {
                return
            }
            if self.currentIndex > 0 {
                index = self.currentIndex - 1;
            }else{
                index = count - 1
            }
            if index >= count  {
                index = 0
            }
            
            self.delegate.currentIndex(index: index, imageView: self.centerImageView)

            
            if self.currentIndex < count {
                self.delegate.currentIndex(index: self.currentIndex, imageView: self.rightImageView)
            }else{
                self.delegate.currentIndex(index: 0, imageView: self.rightImageView)
            }
            if (index - 1) >= 0,(index - 1) <  count {
                self.delegate.currentIndex(index: index - 1, imageView: self.leftImageView)
            }else{
                self.delegate.currentIndex(index: count - 1, imageView: self.leftImageView)
            }
            self.currentIndex = index
            
            
        }
        self.centerImageView.tag = self.currentIndex

        self.pageControll.currentPage = self.currentIndex
        self.scrollView.setContentOffset(CGPoint.init(x: width, y: 0), animated: false)

    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
}
