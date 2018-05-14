//
//  EmailView.swift
//  Pheramor
//
//  Created by tongyi on 2018/5/11.
//  Copyright © 2018年 tongyi. All rights reserved.
//

import UIKit
import TYTextField
import SnapKit

protocol MoveForwardAndBack {
    var rightButton: UIButton! { get set }
    var leftButton: UIButton! { get set }
    func setupRightButton()
    func setupLeftButton()
    func layoutRightButton()
    func layoutLeftButton()
}

extension MoveForwardAndBack {
    func rightButtonEnable() {
        rightButton.isEnabled = true
        rightButton.setBackgroundImage(#imageLiteral(resourceName: "rightArrowFilled"), for: .normal)
    }
    
    func leftButtonEnable() {
        leftButton.isEnabled = true
        leftButton.setBackgroundImage(#imageLiteral(resourceName: "leftArrowFilled"), for: .normal)
    }
    
    func rightButtonDisable() {
        rightButton.isEnabled = false
        rightButton.setBackgroundImage(#imageLiteral(resourceName: "rightArrowEmpty"), for: .normal)
    }
    
    func leftButtonDisable() {
        leftButton.isEnabled = false
        leftButton.setBackgroundImage(#imageLiteral(resourceName: "leftArrowEmpty"), for: .normal)
    }
}

class EmailView: UIView, MoveForwardAndBack {
    weak var companyNameLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var emailLabel: UILabel!
    weak var emailTextField: TYTextField!
    weak var errorLabel: UILabel!
    weak var rightButton: UIButton!
    weak var leftButton: UIButton!
    var emailValid = false
    
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
        layoutEmailLabel()
        layoutEmailTextField()
        layoutErrorLabel()
        layoutRightButton()
        layoutLeftButton()
    }

    // MARK: Set up SubViews
    private func setupSubViews() {
        setupCompanyNameLabel()
        setupDescriptionLabel()
        setupEmailLabel()
        setupEmailTextField()
        setupErrorLabel()
        setupRightButton()
        setupLeftButton()
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
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.lightGray
        self.descriptionLabel = label
        self.addSubview(label)
    }
    
    private func setupEmailLabel() {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.emailLabel = label
        self.addSubview(label)
    }
    
    private func setupEmailTextField() {
        let tf = TYTextField()
        self.emailTextField = tf
        self.addSubview(tf)
    }
    
    private func setupErrorLabel() {
        let label = UILabel()
        label.text = "* Invalid email format, please input again"
        label.textColor = UIColor.lightRed
        label.font = UIFont.systemFont(ofSize: 16)
        label.isHidden = true
        self.errorLabel = label
        self.addSubview(label)
    }
    
    internal func setupRightButton() {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "rightArrowEmpty"), for: .normal)
        button.isEnabled = false
        self.rightButton = button
        self.addSubview(button)
    }
    
    internal func setupLeftButton() {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "leftArrowEmpty"), for: .normal)
        button.isEnabled = false
        self.leftButton = button
        self.addSubview(button)
    }
    
    // MARK: Layout Subviews
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
    
    private func layoutEmailLabel() {
        self.emailLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY).offset(-70)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutEmailTextField() {
        self.emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    private func layoutErrorLabel() {
        self.errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    internal func layoutRightButton() {
        self.rightButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(58)
            make.height.equalTo(62)
        }
    }
    
    internal func layoutLeftButton() {
        self.leftButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(58)
            make.height.equalTo(62)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}














