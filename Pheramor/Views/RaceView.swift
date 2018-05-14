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

class RaceView: UIView, MoveForwardAndBack {
    weak var companyNameLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var rightButton: UIButton!
    weak var leftButton: UIButton!
    weak var raceLabel: UILabel!
    weak var religionLabel: UILabel!
    weak var raceButton: UIButton!
    weak var religionButton: UIButton!
    weak var racePickerView: UIPickerView!
    weak var religionPickerView: UIPickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        layoutCompanyNameLabel()
        layoutDescriptionLabel()
        layoutRightButton()
        layoutLeftButton()
        layoutRaceLabel()
        layoutReligionLabel()
        layoutRaceButton()
        layoutReligionButton()
        layoutRacePickerView()
        layoutReligionPickerView()
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        

    }

    // MARK: Set up SubViews
    private func setupSubViews() {
        setupCompanyNameLabel()
        setupDescriptionLabel()
        setupRightButton()
        setupLeftButton()
        setupRaceLabel()
        setupReligionLabel()
        setupRaceButton()
        setupReligionButton()
        setupRacePickerView()
        setupReligionPickerView()
    }
    
    private func setupRaceLabel() {
        let label = UILabel()
        label.text = "Race(Optional)"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.raceLabel = label
        self.addSubview(label)
    }
    
    private func setupReligionLabel() {
        let label = UILabel()
        label.text = "Religion(Optional)"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.religionLabel = label
        self.addSubview(label)
    }
    
    private func setupRaceButton() {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        let attrStringNormal = NSAttributedString(string: "Unselected", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
        button.setAttributedTitle(attrStringNormal, for: .normal)
        self.raceButton = button
        self.addSubview(button)
    }
    
    private func setupReligionButton() {
        let button = UIButton(type: .system)
        let attrStringNormal = NSAttributedString(string: "Unselected", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
        button.setAttributedTitle(attrStringNormal, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        self.religionButton = button
        self.addSubview(button)
    }
    
    private func setupRacePickerView() {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        self.racePickerView = pickerView
        self.addSubview(pickerView)
    }
    
    private func setupReligionPickerView() {
        let pickerView = UIPickerView()
        pickerView.isHidden = true
        self.religionPickerView = pickerView
        self.addSubview(pickerView)
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

    private func layoutRaceLabel() {
        self.raceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY).offset(-140)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutReligionLabel() {
        self.religionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(racePickerView.snp.bottom).offset(10)
            make.left.equalTo(raceLabel.snp.left)
        }
    }
    
    private func layoutRaceButton() {
        self.raceButton.snp.makeConstraints { (make) in
            make.left.equalTo(raceLabel)
            make.top.equalTo(raceLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    private func layoutReligionButton() {
        self.religionButton.snp.makeConstraints { (make) in
            make.left.equalTo(religionLabel)
            make.top.equalTo(religionLabel.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    private func layoutRacePickerView() {
        self.racePickerView.snp.remakeConstraints { (make) in
            make.top.equalTo(raceButton.snp.bottom).offset(10)
            make.left.equalTo(raceLabel.snp.left)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(0)
        }
    }
    
    private func layoutReligionPickerView() {
        self.religionPickerView.snp.remakeConstraints { (make) in
            make.top.equalTo(religionButton.snp.bottom).offset(10)
            make.left.equalTo(religionLabel.snp.left)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(0)
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
    
    func toggleRacePickerView() {
        if !religionPickerView.isHidden {
            toggleReligionPickerView()
        }
        racePickerView.isHidden = !racePickerView.isHidden
        if racePickerView.bounds.height == 0 {
            racePickerView.snp.updateConstraints { (make) in
                make.height.equalTo(100)
            }
        } else {
            racePickerView.snp.updateConstraints { (make) in
                make.height.equalTo(0)
            }
        }
        
        UIView.animate(withDuration: 0.35) {
            self.layoutIfNeeded()
        }
    }
    
    func toggleReligionPickerView() {
        if !racePickerView.isHidden {
            toggleRacePickerView()
        }
        religionPickerView.isHidden = !religionPickerView.isHidden
        let distance = leftButton.frame.minY - religionButton.frame.maxY - 20
        if religionPickerView.bounds.height == 0 {
            religionPickerView.snp.updateConstraints { (make) in
                
                make.height.equalTo(distance)
            }
        } else {
            religionPickerView.snp.updateConstraints { (make) in
                make.height.equalTo(0)
            }
        }
        
        UIView.animate(withDuration: 0.35) {
            self.layoutIfNeeded()
        }
    }
}














