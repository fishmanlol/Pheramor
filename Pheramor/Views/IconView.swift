//
//  EmailView.swift
//  Pheramor
//
//  Created by tongyi on 2018/5/11.
//  Copyright © 2018年 tongyi. All rights reserved.
//

import UIKit
import SnapKit

class IconView: UIView, MoveForwardAndBack {
    weak var rightButton: UIButton!
    
    weak var leftButton: UIButton!
    
    func setupRightButton() {
        let b = UIButton()
        rightButton = b
        rightButton.isHidden = true
        self.addSubview(b)
    }
    
    func setupLeftButton() {
        let b = UIButton()
        leftButton = b
        leftButton.isHidden = true
        self.addSubview(b)
    }
    
    func layoutRightButton() {
        
    }
    
    func layoutLeftButton() {
        
    }
    
    weak var companyNameLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var iconImageView: UIImageView!
    weak var completeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutCompanyNameLabel()
        layoutDescriptionLabel()
        layoutIconImageView()
        layoutCompleteButton()
    }
    
    // MARK: Set up SubViews
    private func setupSubViews() {
        setupCompanyNameLabel()
        setupDescriptionLabel()
        setupIconImageView()
        setupCompleteButton()
        setupRightButton()
        setupLeftButton()
    }
    
    private func setupIconImageView() {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "defaultIcon")
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        self.iconImageView = imageView
        self.addSubview(imageView)
    }
    
    private func setupCompleteButton() {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        let attrStringNormal = NSAttributedString(string: "Review", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 32)])
        let attrStringHighlighted = NSAttributedString(string: "Review", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 32)])
        button.setAttributedTitle(attrStringNormal, for: .normal)
        button.setAttributedTitle(attrStringHighlighted, for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "completeButtonBg"), for: .highlighted)
        self.completeButton = button
        self.addSubview(button)
    }
    
    private func setupCompanyNameLabel() {
        let label = UILabel()
        label.text = "Pheram💖r"
        label.font = UIFont.systemFont(ofSize: 36)
        self.companyNameLabel = label
        self.addSubview(label)
    }
    
    private func setupDescriptionLabel() {
        let label = UILabel()
        // FIXME: - description
        label.text = "Let's start building your account"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.lightGray
        self.descriptionLabel = label
        self.addSubview(label)
    }
    
    // MARK: Layout Subviews
    private func layoutIconImageView() {
        self.iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(iconImageView.snp.width)
        }
    }
    
    private func layoutCompleteButton() {
        self.completeButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
    }
    
    private func layoutCompanyNameLabel() {
        self.companyNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(30)
        }
    }
    
    private func layoutDescriptionLabel() {
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
   
}














