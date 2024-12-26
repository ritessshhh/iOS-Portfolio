//
//  RegiserUI.swift
//  FlashChat-UIKit-iOS16
//
//  Created by ritessshhh on 09/05/2023.
//

import UIKit

class RegiserUI {
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.roundedTextFieldWithShadow(cornerRadius: 30.0)
        tf.placeholder = "Email"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBackground
        tf.roundedTextFieldWithShadow(cornerRadius: 30.0)
        tf.placeholder = "Password"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 25, weight: .regular)
//        tf.isSecureTextEntry = true
        return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(named: Constants.BrandColors.blue), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return button
    }()
}
