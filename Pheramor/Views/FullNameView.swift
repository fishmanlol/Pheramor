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

class FullNameView: UIView, MoveForwardAndBack {
    
    // MARK: - Vars
    weak var companyNameLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var fullNameLabel: UILabel!
    weak var zipCodeLabel: UILabel!
    weak var heightLabel: UILabel!
    weak var fullNameTextField: TYTextField!
    weak var zipCodeTextField: TYTextField!
    weak var rightButton: UIButton!
    weak var leftButton: UIButton!
    weak var fullNameErrorLabel: UILabel!
    weak var zipCodeErrorLabel: UILabel!
    weak var heightPickerView: UIPickerView!
    weak var heightPickButton: UIButton!
    
    var fullNameValid = false
    var zipCodeValid = false
    var heightValid = false
    
    let heightRange = 100...200
    
    // MARK: - Init function
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
        layoutFullNameLabel()
        layoutZipCodeLabel()
        layoutHeightLabel()
        layoutFullNameTextField()
        layoutZipCodeTextField()
        layoutFullNameErrorLabel()
        layoutZipCodeErrorLabel()
        layoutHeightPickerView()
        layoutHeightPickButton()
    }
    
    // MARK: - Set up SubViews
    private func setupSubViews() {
        setupCompanyNameLabel()
        setupDescriptionLabel()
        setupRightButton()
        setupLeftButton()
        setupFullNameLabel()
        setupZipCodeLabel()
        setupHeightLabel()
        setupFullNameTextField()
        setupZipCodeTextField()
        setupFullNameErrorLabel()
        setupZipCodeErrorLabel()
        setupHeightPickerView()
        setupHeightPickButton()
    }
    
    private func setupHeightPickButton() {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Unselected", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(showPickerView), for: .touchUpInside)
        self.heightPickButton = button
        self.addSubview(button)
    }
    
    private func setupHeightPickerView() {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        self.heightPickerView = pickerView
        self.addSubview(pickerView)
    }
    
    private func setupFullNameErrorLabel() {
        let label = UILabel()
        label.text = "* Full name can not be empty"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightRed
        label.isHidden = true
        self.fullNameErrorLabel = label
        self.addSubview(label)
    }
    
    private func setupZipCodeErrorLabel() {
        let label = UILabel()
        label.text = "* Invalid zip code. eg: 12345 or 12345-4567"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightRed
        label.isHidden = true
        self.zipCodeErrorLabel = label
        self.addSubview(label)
    }
    
    private func setupFullNameLabel() {
        let label = UILabel()
        label.text = "Full Name"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.fullNameLabel = label
        self.addSubview(label)
    }
    
    private func setupZipCodeLabel() {
        let label = UILabel()
        label.text = "Zip Code"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.zipCodeLabel = label
        self.addSubview(label)
    }
    
    private func setupHeightLabel() {
        let label = UILabel()
        label.text = "Height"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.heightLabel = label
        self.addSubview(label)
    }
    
    private func setupFullNameTextField() {
        let tf = TYTextField()
        self.fullNameTextField = tf
        tf.returnKeyType = .done
        self.addSubview(tf)
    }
    
    private func setupZipCodeTextField() {
        let tf = TYTextField()
        self.zipCodeTextField = tf
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
        label.text = "Let's start building your account"
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
    
    // MARK: - Layout Subviews
    private func layoutHeightPickButton() {
        self.heightPickButton.snp.makeConstraints { (make) in
            make.left.equalTo(heightLabel.snp.right).offset(20)
            make.bottom.equalTo(heightLabel.snp.bottom)
            make.top.equalTo(heightLabel.snp.top).offset(3)
            make.width.equalTo(200)
        }
    }
    
    private func layoutHeightPickerView() {
        self.heightPickerView.snp.makeConstraints { (make) in
            make.left.equalTo(companyNameLabel.snp.left)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(heightLabel.snp.bottom).offset(10)
            make.bottom.equalTo(rightButton.snp.top).offset(-10)
        }
    }
    
    private func layoutFullNameErrorLabel() {
        self.fullNameErrorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameTextField.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutZipCodeErrorLabel() {
        self.zipCodeErrorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(zipCodeTextField.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutFullNameLabel() {
        self.fullNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY).offset(-150)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutZipCodeLabel() {
        self.zipCodeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameTextField.snp.bottom).offset(30)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutHeightLabel() {
        self.heightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(zipCodeTextField.snp.bottom).offset(30)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutFullNameTextField() {
        self.fullNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(10)
            make.left.equalTo(companyNameLabel.snp.left)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    private func layoutZipCodeTextField() {
        self.zipCodeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(zipCodeLabel.snp.bottom).offset(10)
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
    
    // MARK: - Others
    
    @objc func showPickerView() {
        heightPickerView.isHidden = !heightPickerView.isHidden
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}















