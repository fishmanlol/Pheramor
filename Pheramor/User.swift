//
//  User.swift
//  Pheramor
//
//  Created by tongyi on 2018/5/11.
//  Copyright © 2018年 tongyi. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var email: String!
    var password: String!
    var fullName: String!
    var zipCode: String!
    var height: String!
    var gender: String = "Male"
    var dob: Date!
    var interestGender: String!
    var interestAge: [Int]!
    var race = "Refuse to say"
    var religion = "Refuse to say"
    var icon: UIImage!
}
