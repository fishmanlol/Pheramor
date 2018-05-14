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

class PasswordView: UIView, MoveForwardAndBack {
    weak var companyNameLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var passwordLabel: UILabel!
    weak var confirmLabel: UILabel!
    weak var passwordTextField: TYTextField!
    weak var confirmTextField: TYTextField!
    weak var rightButton: UIButton!
    weak var leftButton: UIButton!
    weak var passwordErrorLabel: UILabel!
    weak var confirmErrorLabel: UILabel!
    var passwordValid = false
    var confirmValid = false
    
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
        layoutRightButton()
        layoutLeftButton()
        layoutPasswordLabel()
        layoutConfirmLabel()
        layoutPasswordTextField()
        layoutConfirmTextField()
        layoutPasswordErrorLabel()
        layoutConfirmErrorLabel()
    }
    
    // MARK: Set up SubViews
    private func setupSubViews() {
        setupCompanyNameLabel()
        setupDescriptionLabel()
        setupRightButton()
        setupLeftButton()
        setupPasswordLabel()
        setupConfirmLabel()
        setupPasswordTextField()
        setupConfirmTextField()
        setupPasswordErrorLabel()
        setupConfirmErrorLabel()
    }
    
    private func setupPasswordErrorLabel() {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "* At least 6 characters.\n*Should contain both letters and numbers"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightRed
        label.isHidden = true
        self.passwordErrorLabel = label
        self.addSubview(label)
    }
    
    private func setupConfirmErrorLabel() {
        let label = UILabel()
        label.text = "* Two password input is not consistent"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightRed
        label.isHidden = true
        self.confirmErrorLabel = label
        self.addSubview(label)
    }
    
    private func setupPasswordLabel() {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.passwordLabel = label
        self.addSubview(label)
    }
    
    private func setupConfirmLabel() {
        let label = UILabel()
        label.text = "Confirm"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.confirmLabel = label
        self.addSubview(label)
    }
    
    private func setupPasswordTextField() {
        let tf = TYTextField()
        self.passwordTextField = tf
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        self.addSubview(tf)
    }
    
    private func setupConfirmTextField() {
        let tf = TYTextField()
        self.confirmTextField = tf
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        self.addSubview(tf)
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
        label.text = "Input your account password"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.lightGray
        self.descriptionLabel = label
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
    private func layoutPasswordErrorLabel() {
        self.passwordErrorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutConfirmErrorLabel() {
        self.confirmErrorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(confirmTextField.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutPasswordLabel() {
        self.passwordLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY).offset(-120)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutConfirmLabel() {
        self.confirmLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordErrorLabel.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutPasswordTextField() {
        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    private func layoutConfirmTextField() {
        self.confirmTextField.snp.makeConstraints { (make) in
            make.top.equalTo(confirmLabel.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-30)
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














