//
//  CustomFont.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import Foundation
import UIKit
import SnapKit

class CustomFont: UIViewController {
    
    let label = UILabel()
    let changeButton = UIButton()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        label.text = "I am the king of the world"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalTo(self.view)
        }

        changeButton.setTitle("Change Font Family", for: .normal)
        changeButton.setTitleColor(.blue, for: .normal)
        changeButton.addTarget(self, action: #selector(changeFontFamily), for: .touchUpInside)
        changeButton.layer.borderColor = UIColor.blue.cgColor
        changeButton.layer.borderWidth = 1
        changeButton.layer.cornerRadius = 5
        self.view.addSubview(changeButton)
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(500)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
        }
        
        printAllSupportedFontNames()
    }
    
    @objc func changeFontFamily() {
        let familyNames = UIFont.familyNames
        if index < familyNames.count {
            let familyName = familyNames[index]
            label.font = UIFont(name: familyName, size: 30)
            index += 1
            changeButton.setTitle(familyName, for: .normal)
            return
        }
        index = 0
    }
    
    func printAllSupportedFontNames() {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            print("********** \(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print(" --------- \(fontName)")
            }
        }
    }
}
