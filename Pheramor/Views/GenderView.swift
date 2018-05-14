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

class GenderView: UIView, MoveForwardAndBack {
    weak var companyNameLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var rightButton: UIButton!
    weak var leftButton: UIButton!
    weak var genderLabel: UILabel!
    weak var dobLabel: UILabel!
    weak var genderButton: UIButton!
    weak var dobButton: UIButton!
    weak var genderPickerView: UIPickerView!
    weak var dobDatePicker: UIDatePicker!
    
    var genderValid = false
    var dobValid = false
    
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
        layoutGenderLabel()
        layoutDobLabel()
        layoutGenderButton()
        layoutDobButton()
        layoutGenderPickerView()
        layoutDobDatePicker()
    }
    
    // MARK: Set up SubViews
    private func setupSubViews() {
        setupCompanyNameLabel()
        setupDescriptionLabel()
        setupRightButton()
        setupLeftButton()
        setupGenderLabel()
        setupDobLabel()
        setupGenderButton()
        setupDobButton()
        setupGenderPickerView()
        setupDobDatePicker()
    }
    
    private func setupGenderLabel() {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.genderLabel = label
        self.addSubview(label)
    }
    
    private func setupDobLabel() {
        let label = UILabel()
        label.text = "DOB"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.dobLabel = label
        self.addSubview(label)
    }
    
    private func setupGenderButton() {
        let button = UIButton(type: .system)
        button.setTitle("Unselected", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        self.genderButton = button
        self.addSubview(button)
    }
    
    private func setupDobButton() {
        let button = UIButton(type: .system)
        button.setTitle("Unselected", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        self.dobButton = button
        self.addSubview(button)
    }
    
    private func setupGenderPickerView() {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        self.genderPickerView = pickerView
        self.addSubview(pickerView)
    }
    
    private func setupDobDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.isHidden = true
        datePicker.datePickerMode = .date
        let miniumDateInSeconds: TimeInterval = 150*12*30*24*3600
        datePicker.minimumDate = Date(timeIntervalSinceNow: -miniumDateInSeconds)
        datePicker.maximumDate = Date()
        self.dobDatePicker = datePicker
        self.addSubview(datePicker)
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
    
    // MARK: Layout Subviews
    private func layoutGenderLabel() {
        self.genderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY).offset(-140)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutDobLabel() {
        self.dobLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genderPickerView.snp.bottom).offset(10)
            make.right.equalTo(dobButton.snp.left).offset(-10)
        }
    }
    
    private func layoutGenderButton() {
        self.genderButton.snp.makeConstraints { (make) in
            make.left.equalTo(genderLabel.snp.right).offset(10)
            make.top.equalTo(genderLabel.snp.top).offset(-3)
            make.bottom.equalTo(genderLabel.snp.bottom)
            make.width.equalTo(200)
        }
    }
    
    private func layoutDobButton() {
        self.dobButton.snp.makeConstraints { (make) in
            make.left.equalTo(genderButton.snp.left)
            make.top.equalTo(dobLabel.snp.top).offset(-3)
            make.bottom.equalTo(dobLabel.snp.bottom)
            make.width.equalTo(200)
        }
    }
    
    private func layoutGenderPickerView() {
        self.genderPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(genderLabel.snp.bottom).offset(10)
            make.left.equalTo(genderLabel.snp.left)
            make.height.equalTo(120)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    private func layoutDobDatePicker() {
        self.dobDatePicker.snp.makeConstraints { (make) in
            make.top.equalTo(dobLabel.snp.bottom).offset(10)
            make.left.equalTo(dobLabel.snp.left)
            make.bottom.equalTo(leftButton.snp.top).offset(-10)
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
}














