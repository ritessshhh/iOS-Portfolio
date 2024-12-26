//
//  LoginUI.swift
//  FlashChat-UIKit-iOS16
//
//  Created by ritessshhh on 09/05/2023.
//

import UIKit

class LoginUI {
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.roundedTextFieldWithShadow(cornerRadius: 30.0)
        tf.placeholder = "Email"
        tf.textAlignment = .center
        tf.textColor = UIColor(named: Constants.BrandColors.blue)
        tf.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        tf.text = "1@2.com"
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.roundedTextFieldWithShadow(cornerRadius: 30.0)
        tf.placeholder = "Password"
        tf.textAlignment = .center
        tf.textColor = UIColor(named: Constants.BrandColors.blue)
        tf.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        tf.isSecureTextEntry = true
        tf.text = "123456"
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor(named: Constants.BrandColors.lighBlue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return button
    }()
}
