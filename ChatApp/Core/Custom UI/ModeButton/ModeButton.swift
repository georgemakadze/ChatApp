//
//  ModeButton.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 05.05.2023.
//

import Foundation
import UIKit

class ModeButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setImage(Constants.Button.darkImage, for: .normal)
    }
}

extension ModeButtonView {
    enum Constants {
        enum Button {
            static let darkImage = UIImage(named: "darkmode")
            static let lightImage = UIImage(named: "lightmode")
        }
    }
}

