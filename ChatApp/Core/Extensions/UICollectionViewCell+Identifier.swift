//
//  UICollectionViewCell+Identifier.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 01.06.2023.
//
import UIKit

extension UIView  {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
