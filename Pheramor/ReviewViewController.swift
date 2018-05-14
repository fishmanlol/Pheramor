//
//  ReviewViewController.swift
//  Pheramor
//
//  Created by tongyi on 2018/5/14.
//  Copyright © 2018年 tongyi. All rights reserved.
//

import UIKit
import Alamofire

class ReviewViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var interestGenderLabel: UILabel!
    @IBOutlet weak var interestAgeLabel: UILabel!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var religionLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()
    
    var user: User!
    
    @IBAction func submit() {
        let emailData = user.email.data(using: String.Encoding.utf8)!
        let genderData = user.gender.data(using: String.Encoding.utf8)!
        let fullNameData = user.fullName.data(using: String.Encoding.utf8)!
        let interesGenderData = user.interestGender.data(using: String.Encoding.utf8)!
        let raceData = user.race.data(using: String.Encoding.utf8)!
        let religionData = user.religion.data(using: String.Encoding.utf8)!
        let heightData = user.height.data(using: String.Encoding.utf8)!
        let zipCodeData = user.zipCode.data(using: String.Encoding.utf8)!
        let iconData = UIImagePNGRepresentation(user.icon)!
        let dobData = String(user.dob.timeIntervalSince1970).data(using: String.Encoding.utf8)!
//        let interestAgeData = "\(user.interestAge.first!)-\(user.interestAge.last!)"
        let interestAge = user.interestAge.map { String($0) }
        do {
            let intersetAgeData = try JSONSerialization.data(withJSONObject: interestAge)
        
            Alamofire.upload(
                multipartFormData: { multipartFormData in

                    multipartFormData.append(emailData, withName: "email")
                    multipartFormData.append(genderData, withName: "gender")
                    multipartFormData.append(fullNameData, withName: "fullName")
                    multipartFormData.append(dobData, withName: "dob")
                    multipartFormData.append(interesGenderData, withName: "interesGender")
                    multipartFormData.append(intersetAgeData, withName: "intersetAge")
                    multipartFormData.append(raceData, withName: "race")
                    multipartFormData.append(religionData, withName: "religion")
                    multipartFormData.append(heightData, withName: "height")
                    multipartFormData.append(zipCodeData, withName: "zipCode")
                    multipartFormData.append(iconData, withName: "icon")
                    
            },
                to: "https://jobs.pheramor.com/assessment/iOS",
                encodingCompletion: { encodingResult in
                    
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseString { response in
                            let alertVc = UIAlertController(title: "Success", message: "Thanks for registration!", preferredStyle: .alert)
                            alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alertVc, animated: true, completion: nil)
                        }
                    case .failure( _):
                        let alertVc = UIAlertController(title: "Failed", message: "Something wrong  here", preferredStyle: .alert)
                        alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alertVc, animated: true, completion: nil)
                    }
            }
            )
        } catch {
            print(error)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupIconImageView()
        setupSubmitButton()
        fillUI()
    }
    
    func setupSubmitButton() {
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.lightGray.cgColor
        submitButton.layer.cornerRadius = 7
        submitButton.layer.masksToBounds = true
    }
    
    func setupIconImageView() {
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.white.cgColor
        iconImageView.layer.cornerRadius = 8
        iconImageView.layer.masksToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
    }
    
    func fillUI() {
        emailLabel.text = user.email
        genderLabel.text = user.gender
        fullNameLabel.text = user.fullName
        dobLabel.text = dateFormatter.string(from: user.dob)
        interestGenderLabel.text = user.interestGender
        interestAgeLabel.text = "\(user.interestAge.first!)-\(user.interestAge.last!)"
        raceLabel.text = user.race
        religionLabel.text = user.religion
        heightLabel.text = user.height
        iconImageView.image = user.icon
        zipCodeLabel.text = user.zipCode
    }
}
