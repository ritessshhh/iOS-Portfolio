//
//  BigTitleNavigationBar.swift
//  Todoey-UIKit-iOS16
//
//  Created by ritessshhh on 23/06/2023.
//

import UIKit

extension UIViewController {
    func BigTitleNavigationBar (title:String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
