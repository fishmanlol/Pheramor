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
import MultiSlider

class InterestView: UIView, MoveForwardAndBack {
    weak var companyNameLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var rightButton: UIButton!
    weak var leftButton: UIButton!
    weak var showMeLabel: UILabel!
    weak var ageSelectLabel: UILabel!
    weak var showMeSlider: MultiSlider!
    weak var ageSelectSlider: MultiSlider!
    weak var showMeSliderContainer: UIView!
    weak var ageSelectSliderContainer: UIView!
    weak var maleLabel: UILabel!
    weak var femaleLabel: UILabel!
    weak var bothLabel: UILabel!
    
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
        layoutShowMeLabel()
        layoutAgeSelectLabel()
        layoutShowMeSlider()
        layoutAgeSelectSlilder()
        layoutShowMeSliderContainer()
        layoutAgeSelectSliderContainer()
        layoutMaleLabel()
        layoutFemaleLabel()
        layoutBothLabel()
    }
    
    // MARK: Set up SubViews
    private func setupSubViews() {
        setupCompanyNameLabel()
        setupDescriptionLabel()
        setupRightButton()
        setupLeftButton()
        setupShowMeLabel()
        setupShowMeSliderContainer()
        setupAgeSelectSliderContainer()
        setupShowMeSlider()
        setupAgeSelectLabel()
        setupAgeSelectSlider()
        setupMaleLabel()
        setupFemaleLabel()
        setupBothLabel()
    }
    
    private func setupFemaleLabel() {
        let label = UILabel()
        label.text = "Female"
        label.textColor = UIColor.lightBlue
        label.font = UIFont.systemFont(ofSize: 24)
        self.femaleLabel = label
        self.addSubview(label)
    }
    
    private func setupMaleLabel() {
        let label = UILabel()
        label.text = "Male"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 24)
        self.maleLabel = label
        self.addSubview(label)
    }
    
    private func setupBothLabel() {
        let label = UILabel()
        label.text = "Both"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 24)
        self.bothLabel = label
        self.addSubview(label)
    }
    
    private func setupShowMeSliderContainer() {
        let view = UIView()
        let pan = UIPanGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(pan)
        self.showMeSliderContainer = view
        self.addSubview(view)
    }
    
    private func setupAgeSelectSliderContainer() {
        let view = UIView()
        let pan = UIPanGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(pan)
        self.ageSelectSliderContainer = view
        self.addSubview(view)
    }
    
    private func setupShowMeLabel() {
        let label = UILabel()
        label.text = "Show Me"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.showMeLabel = label
        self.addSubview(label)
    }
    
    private func setupAgeSelectLabel() {
        let label = UILabel()
        label.text = "Select Age From 18 to 60"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.lightGray
        self.ageSelectLabel = label
        self.addSubview(label)
    }
    
    private func setupShowMeSlider() {
        let slider = MultiSlider()
        slider.tintColor = UIColor.lightBlue
        slider.orientation = .horizontal
        slider.thumbCount = 1
        slider.trackWidth = 8
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.snapStepSize = 1
        slider.addTarget(self, action: #selector(dragShowMeSlider), for: .valueChanged)
        self.addSubview(slider)
        self.showMeSlider = slider
    }
    
    @objc func dragShowMeSlider() {
        let value = showMeSlider.value.first!
            switch value {
            case 0...25: do {
                self.femaleLabel.textColor = UIColor.lightBlue
                self.maleLabel.textColor = UIColor.lightGray
                self.bothLabel.textColor = UIColor.lightGray
                showMeSlider.value = [1]
                }
            case 25...75: do {
                self.femaleLabel.textColor = UIColor.lightGray
                self.maleLabel.textColor = UIColor.lightBlue
                self.bothLabel.textColor = UIColor.lightGray
                showMeSlider.value = [50]
                }
            default: do {
                self.femaleLabel.textColor = UIColor.lightGray
                self.maleLabel.textColor = UIColor.lightGray
                self.bothLabel.textColor = UIColor.lightBlue
                showMeSlider.value = [100]
                }
            }
    }
    
    private func setupAgeSelectSlider() {
        let slider = MultiSlider()
        slider.tintColor = UIColor.lightBlue
        slider.orientation = .horizontal
        slider.thumbCount = 2
        slider.trackWidth = 8
        slider.minimumValue = 0
        slider.maximumValue = 42
        slider.snapStepSize = 1
        slider.value = [0, 42]
        slider.addTarget(self, action: #selector(dragAgeSelectSlider), for: .valueChanged)
        self.addSubview(slider)
        self.ageSelectSlider = slider
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
    private func layoutAgeSelectSliderContainer() {
        self.ageSelectSliderContainer.snp.makeConstraints { (make) in
            make.top.equalTo(ageSelectLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    private func layoutFemaleLabel() {
        self.femaleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(showMeSlider)
            make.top.equalTo(showMeSlider.snp.bottom)
        }
    }
    
    private func layoutMaleLabel() {
        self.maleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(showMeSlider.snp.centerX)
            make.top.equalTo(showMeSlider.snp.bottom)
        }
    }
    
    private func layoutBothLabel() {
        self.bothLabel.snp.makeConstraints { (make) in
            make.right.equalTo(showMeSlider)
            make.top.equalTo(showMeSlider.snp.bottom)
        }
    }
    
    private func layoutShowMeSliderContainer() {
        self.showMeSliderContainer.snp.makeConstraints { (make) in
            make.top.equalTo(showMeLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    private func layoutShowMeLabel() {
        self.showMeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY).offset(-160)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutAgeSelectLabel() {
        self.ageSelectLabel.snp.makeConstraints { (make) in
            make.top.equalTo(showMeSliderContainer.snp.bottom).offset(50)
            make.left.equalTo(companyNameLabel.snp.left)
        }
    }
    
    private func layoutShowMeSlider() {
        self.showMeSlider.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(showMeSliderContainer)
            make.left.equalTo(showMeSliderContainer.snp.left).offset(30)
            make.right.equalTo(showMeSliderContainer.snp.right).offset(-30)
        }
    }

    private func layoutAgeSelectSlilder() {
        self.ageSelectSlider.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(ageSelectSliderContainer)
            make.left.equalTo(ageSelectSliderContainer).offset(30)
            make.right.equalTo(ageSelectSliderContainer).offset(-30)
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
    
    @objc func dragAgeSelectSlider(sender: MultiSlider) {
        let value = sender.value.map { Int($0)+18 }
        ageSelectLabel.text = "Select Age From \(value.first!) to \(value.last!)"
    }
    
}

extension MultiSlider {}














