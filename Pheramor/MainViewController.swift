//
//  ViewController.swift
//  Pheramor
//
//  Created by tongyi on 2018/5/11.
//  Copyright © 2018年 tongyi. All rights reserved.
//

import UIKit
import Foundation
import TYTextField
import MultiSlider

class MainViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var emailView: EmailView!
    weak var passwordView: PasswordView!
    weak var fullNameView: FullNameView!
    weak var genderView: GenderView!
    weak var interestView: InterestView!
    weak var raceView: RaceView!
    weak var iconView: IconView!
    
    var user = User()
    var dragStartPage = 0
    var genders = ["Female", "Male", "Secret"]
    var races = ["Race A", "Race B", "Race C", "Race D", "Race E", "Refuse to say"]
    var religions = ["Religion A", "Religion B", "Religion C", "Religion D", "Religion E", "Refuse to say"]
    
    var views: [MoveForwardAndBack] = []
    var currentPage = 0
    var canMoveForward: Bool = false {
        didSet {
            let currentView = views[currentPage]
            if canMoveForward {
                currentView.rightButtonEnable()
            } else {
                currentView.rightButtonDisable()
            }
        }
    }
    
    var canMoveBack: Bool = false {
        didSet {
            let currentView = views[currentPage]
            if canMoveBack {
                currentView.leftButtonEnable()
            } else {
                currentView.leftButtonDisable()
            }
        }
    }
    var pages = 7
    
    lazy var screenWidth: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    lazy var screenHeight: CGFloat = {
        return UIScreen.main.bounds.height
    }()

    lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        sv.contentSize = CGSize(width: CGFloat(pages) * screenWidth, height: 0)
        sv.isPagingEnabled = true
        sv.bounces = false
        sv.delegate = self
        return sv
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = scrollView

        setupSubViews()
//        moveTo(page: 6)
    }
    
    private func moveTo(page: CGFloat) {
        scrollView.setContentOffset(CGPoint(x: page*screenWidth, y: 0), animated: true)
    }
    
    func setupSubViews() {
        for page in 0..<pages {
            let x = CGFloat(page) * screenWidth
            switch page {
            case 0: setupEmailView(with: x)
            case 1: setupPasswordView(with: x)
            case 2: setupFullNameView(with: x)
            case 3: setupGenderView(with: x)
            case 4: setupInterestView(with: x)
            case 5: setupRaceView(with: x)
            case 6: setupIconView(with: x)
            default: do {
                let v = EmailView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
                v.backgroundColor = UIColor.white
                self.view.addSubview(v)
                views.append(v)
                }
            }
        }
    }
    
    @objc func valueChanged(sender: TYTextField) {
        if sender.text == "" {
            sender.clearHint()
            canMoveForward = false
            return
        }
        
        if sender === emailView.emailTextField {
            verifyEmail(with: sender)
        } else if sender === passwordView.passwordTextField {
            verifyPassword(with: sender)
            passwordView.confirmTextField.text = ""
            passwordView.confirmTextField.clearHint()
            passwordView.confirmErrorLabel.isHidden = true
        } else if sender === passwordView.confirmTextField {
            verifyConfirm(with: sender)
        } else if sender === fullNameView.fullNameTextField {
            verifyFullName(with: sender)
        } else if sender === fullNameView.zipCodeTextField {
            verifyZipCode(with: sender)
        }
    }
    
    // MARK: - Icon View part
    func setupIconView(with x: CGFloat) {
        let v = IconView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
        self.iconView = v
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectIcon))
        v.iconImageView.addGestureRecognizer(tap)
        v.completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        v.backgroundColor = .white
        views.append(v)
        self.view.addSubview(v)
    }
    
    @objc func selectIcon() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        iconView.iconImageView.image = image.withRenderingMode(.alwaysOriginal)
        iconView.iconImageView.contentMode = .scaleAspectFill
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func completeButtonClicked() {
        
        guard emailView.emailValid && passwordView.passwordValid && passwordView.confirmValid && fullNameView.fullNameValid && fullNameView.zipCodeValid && fullNameView.heightValid && genderView.genderValid && genderView.dobValid else {
            let alertVc = UIAlertController(title: "Error", message: "You miss something important!", preferredStyle: .alert)
            alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVc, animated: true, completion: nil)
            return
        }
        user.email = emailView.emailTextField.text
        user.password = passwordView.passwordTextField.text
        user.fullName = fullNameView.fullNameTextField.text
        user.zipCode = fullNameView.zipCodeTextField.text
        user.height = fullNameView.heightPickButton.title(for: .normal) ?? ""
        let number = interestView.showMeSlider.value.first!
        if number == 1 {
            user.interestGender = "Female"
        } else if number == 50 {
            user.interestGender = "Male"
        } else {
            user.interestGender = "Both"
        }
        let minAge = Int(interestView.ageSelectSlider.value.first!) + 18
        let maxAge = Int(interestView.ageSelectSlider.value.last!) + 18
        user.interestAge = [minAge, maxAge]
        user.race = raceView.raceButton.attributedTitle(for: .normal)?.string ?? "Refuse to say"
        user.religion = raceView.religionButton.attributedTitle(for: .normal)?.string ?? "Refuse to say"
        user.icon = iconView.iconImageView.image ?? #imageLiteral(resourceName: "defaultIcon")
        let reviewVc = ReviewViewController(nibName: "ReviewViewController", bundle: nil)
        reviewVc.user = user
        present(reviewVc, animated: true, completion: nil)
    }
    
    // MARK: - Race part
    func setupRaceView(with x: CGFloat) {
        let v = RaceView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
        v.leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        v.rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
        self.raceView = v
        v.racePickerView.delegate = self
        v.religionPickerView.delegate = self
        v.racePickerView.dataSource = self
        v.religionPickerView.dataSource = self
        v.raceButton.addTarget(self, action: #selector(raceSelected), for: .touchUpInside)
        v.religionButton.addTarget(self, action: #selector(religionSelected), for: .touchUpInside)
        v.religionPickerView.selectRow(religions.count/2, inComponent: 0, animated: false)
        v.racePickerView.selectRow(races.count/2, inComponent: 0, animated: false)
        v.backgroundColor = UIColor.white
        self.view.addSubview(v)
        views.append(v)
    }
    
    // MARK: - Show Me part
    func setupInterestView(with x: CGFloat) {
        let v = InterestView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
        v.leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        v.rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
        interestView = v
        v.backgroundColor = UIColor.white
        self.view.addSubview(v)
        views.append(v)
    }
    
    // MARK: - Gender Dob part
    func setupGenderView(with x: CGFloat) {
        let v = GenderView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
        v.leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        v.rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
        self.genderView = v
        v.dobDatePicker.addTarget(self, action: #selector(dobSelected), for: .valueChanged)
        v.genderPickerView.delegate = self
        v.genderPickerView.dataSource = self
        v.genderPickerView.selectRow(1, inComponent: 0, animated: false)
        v.genderButton.addTarget(self, action: #selector(genderSelected), for: .touchUpInside)
        v.dobButton.addTarget(self, action: #selector(dobButtonClicked), for: .touchUpInside)
        v.backgroundColor = UIColor.white
        self.view.addSubview(v)
        views.append(v)
    }
    
    // MARK: Full Name part
    func setupFullNameView(with x: CGFloat) {
        let v = FullNameView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
        v.leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        v.rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
        self.fullNameView = v
        v.fullNameTextField.delegate = self
        v.zipCodeTextField.delegate = self
        v.heightPickerView.delegate = self
        v.fullNameTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        v.zipCodeTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        v.backgroundColor = UIColor.white
        self.view.addSubview(v)
        views.append(v)
    }
    
    func verifyFullName(with textField: TYTextField) {
        let text = textField.text
        let isValid = text?.replacingOccurrences(of: " ", with: "") != ""
        fullNameView.fullNameValid = isValid
        if isValid {
            textField.showCorrectHint()
            fullNameView.fullNameErrorLabel.isHidden = true
            if fullNameView.zipCodeValid && fullNameView.heightValid {
                canMoveForward = true
            }
        } else {
            textField.showErrorHint()
            fullNameView.fullNameErrorLabel.isHidden = true
            canMoveForward = false
        }
    }
    
    func verifyZipCode(with textField: TYTextField) {
        let text = textField.text
        let zipCodeRegex: String  = "\\b\\d{5}(?:[ -]\\d{4})?\\b"
        let zipCodeTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", zipCodeRegex)
        let isValid = zipCodeTest.evaluate(with: text)
        fullNameView.zipCodeValid = isValid
        if isValid {
            textField.showCorrectHint()
            fullNameView.zipCodeErrorLabel.isHidden = true
            if fullNameView.fullNameValid && fullNameView.heightValid {
                canMoveForward = true
            }
        } else {
            textField.showErrorHint()
            fullNameView.zipCodeErrorLabel.isHidden = true
            canMoveForward = false
        }
    }
    
    // MARK: Email part
    func verifyEmail(with textField: TYTextField) {
        let text = textField.text
        let emailRegex: String  = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailTest.evaluate(with: text)
        emailView.emailValid = isValid
        if isValid {
            textField.showCorrectHint()
            emailView.errorLabel.isHidden = true
            canMoveForward = true
        } else {
            textField.showErrorHint()
            emailView.errorLabel.isHidden = false
            canMoveForward = false
        }
    }
    
    func setupEmailView(with x: CGFloat) {
        let v = EmailView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
        v.leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        v.rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
        self.emailView = v
        v.emailTextField.delegate = self
        v.emailTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        v.backgroundColor = UIColor.white
        self.view.addSubview(v)
        views.append(v)
    }
    
    // MARK: Password part
    func verifyPassword(with textField: TYTextField) {
        let text = textField.text
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isValid = pred.evaluate(with: text)
        passwordView.passwordValid = isValid
        if isValid {
            textField.showCorrectHint()
            passwordView.passwordErrorLabel.isHidden = true
            if passwordView.confirmValid {
                canMoveForward = true
            }
        } else {
            textField.showErrorHint()
            passwordView.passwordErrorLabel.isHidden = false
            canMoveForward = false
        }
    }
    
    func verifyConfirm(with textField: TYTextField) {
        let confirmText = textField.text
        let passwordText = passwordView.passwordTextField.text
        let isValid = (confirmText == passwordText && passwordView.passwordValid)
        passwordView.confirmValid = isValid
        if isValid {
            textField.showCorrectHint()
            passwordView.confirmErrorLabel.isHidden = true
            if passwordView.passwordValid {
                canMoveForward = true
            }
        } else {
            textField.showErrorHint()
            passwordView.confirmErrorLabel.isHidden = false
            canMoveForward = false
        }
    }
    
    func setupPasswordView(with x: CGFloat) {
        let v = PasswordView(frame: CGRect(x: x, y: 0, width: screenWidth, height: screenHeight))
        v.leftButton.addTarget(self, action: #selector(left), for: .touchUpInside)
        v.rightButton.addTarget(self, action: #selector(right), for: .touchUpInside)
        passwordView = v
        v.passwordTextField.delegate = self
        v.confirmTextField.delegate = self
        v.passwordTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        v.confirmTextField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        v.backgroundColor = UIColor.white
        self.view.addSubview(v)
        views.append(v)
    }
    
    @objc func genderSelected(sender: UIButton) {
        genderView.genderPickerView.isHidden = !genderView.genderPickerView.isHidden
        let selectedRow = genderView.genderPickerView.selectedRow(inComponent: 0)
        let title = pickerView(genderView.genderPickerView, titleForRow: selectedRow, forComponent: 0)
        sender.setTitle(title, for: .normal)
        genderView.genderValid = true
        canMoveForward = genderView.dobValid
    }
    
    @objc func dobSelected(sender: UIDatePicker) {
        user.dob = sender.date
        let dateString = dateFormatter.string(from: sender.date)
        guard let currentView = views[currentPage] as? GenderView else { return }
        currentView.dobButton.setTitle(dateString, for: .normal)
        genderView.dobValid = true
        canMoveForward = genderView.genderValid
    }
    
    @objc func raceSelected() {
        raceView.toggleRacePickerView()
    }
    
    @objc func religionSelected(sender: UIButton) {
        raceView.toggleReligionPickerView()
    }
    
    @objc func dobButtonClicked() {
        genderView.dobDatePicker.isHidden = !genderView.dobDatePicker.isHidden
    }
    
    @objc func left() {
        let offset = CGPoint(x: scrollView.contentOffset.x - screenWidth, y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    @objc func right() {
        let offset = CGPoint(x: scrollView.contentOffset.x + screenWidth, y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
    
}

// MARK: - ScrollView Delegate
extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let currentView = views[currentPage] as! UIView
        let currentViewOffsetX = currentView.frame.origin.x
        
        if !canMoveForward && scrollView.isTracking {
            if offset.x > currentViewOffsetX && dragStartPage == currentPage {
                scrollView.contentOffset = CGPoint(x: currentViewOffsetX, y: 0)
            }
        }

        switch offset.x {
        case -0.5*screenWidth..<0.5*screenWidth: currentPage = 0
        case 0.5*screenWidth..<1.5*screenWidth: currentPage = 1
        case 1.5*screenWidth..<2.5*screenWidth: currentPage = 2
        case 2.5*screenWidth..<3.5*screenWidth: currentPage = 3
        case 3.5*screenWidth..<4.5*screenWidth: currentPage = 4
        case 4.5*screenWidth..<5.5*screenWidth: currentPage = 5
        case 5.5*screenWidth..<6.5*screenWidth: currentPage = 6
        default: currentPage = 0
        }

        if currentPage == 0 {
            canMoveBack = false
        } else {
            canMoveBack = true
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        switch currentPage {
        case 0: canMoveForward = emailView.emailValid
        case 1: canMoveForward = passwordView.passwordValid && passwordView.confirmValid
        case 2: canMoveForward = fullNameView.fullNameValid && fullNameView.zipCodeValid && fullNameView.heightValid
        case 3: canMoveForward = genderView.genderValid && genderView.dobValid
        case 4: canMoveForward = true
        case 5: canMoveForward = true
        case 6: canMoveForward = true
        default:
            return
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        dragStartPage = currentPage
    }
}

// MARK: - PickerView DataSource and Delegate
extension MainViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === fullNameView.heightPickerView {
            return 80
        } else if pickerView === genderView.genderPickerView {
            return genders.count
        } else if pickerView === raceView.racePickerView {
            return races.count
        } else if pickerView === raceView.religionPickerView {
            return religions.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === fullNameView.heightPickerView {
            return "\(140+row)cm"
        } else if pickerView === genderView.genderPickerView {
            return genders[row]
        } else if pickerView === raceView.racePickerView {
            return races[row]
        } else if pickerView === raceView.religionPickerView {
            return religions[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        if pickerView === fullNameView.heightPickerView {
            fullNameView.heightValid = true
            canMoveForward = fullNameView.fullNameValid && fullNameView.zipCodeValid
            fullNameView.heightPickButton.setTitle(title, for: .normal)
        } else if pickerView === genderView.genderPickerView {
            user.gender = genders[row]
            genderView.genderValid = true
            canMoveForward = genderView.dobValid
            genderView.genderButton.setTitle(title, for: .normal)
        } else if pickerView === raceView.racePickerView {
            let attrStringNormal = NSAttributedString(string: title!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
            raceView.raceButton.setAttributedTitle(attrStringNormal, for: .normal)
        } else if pickerView === raceView.religionPickerView {
            let attrStringNormal = NSAttributedString(string: title!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
            raceView.religionButton.setAttributedTitle(attrStringNormal, for: .normal)
        }
    }
    
    // MARK: - Update Constraints

}

// MARK: - UITextFiled delegate
extension MainViewController {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        fullNameView.heightPickerView.isHidden = true
        return true
    }
}

extension UIColor {
    class func randomColor() -> UIColor {
       return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1)
    }
    
    static var lightBlack: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
    }
    
    static var lightRed: UIColor {
        return UIColor(red: 227/255.0, green: 91/255.0, blue: 91/255.0, alpha: 1)
    }
    
    static var lightBlue: UIColor {
        return UIColor(red: 68/255.0, green: 192/255.0, blue: 255/255.0, alpha: 1)
    }
}

