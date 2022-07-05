//
//  LimitInputTextField.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import Foundation
import UIKit

class LimitInputTextField: UIViewController, UITextViewDelegate {
    
    var limitedTextView: UITextView!
    var allowInputNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.initNavigationBar()
        self.initInputField()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: LimitInputTextField.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func initNavigationBar() {
        let rightItem = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: nil)
        rightItem.tintColor = .gray
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func initInputField() {
        let naviFrame = self.navigationController?.navigationBar.frame
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let avatarImgView = UIImageView(frame: CGRect(x: 0, y: (naviFrame?.height)! + statusBarFrame.height + 10, width: 70, height: 70))
        avatarImgView.image = UIImage(named: "avatar.jpg")
        self.view.addSubview(avatarImgView)
        
        limitedTextView = UITextView(frame: CGRect(x: 0, y: avatarImgView.frame.height + avatarImgView.frame.origin.y, width: self.view.frame.width - 70 - 20, height: 300))
        limitedTextView.backgroundColor = .gray
        limitedTextView.delegate = self
        limitedTextView.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(limitedTextView)
        
        allowInputNumberLabel = UILabel(frame: CGRect(x: self.view.frame.width - 50, y: self.view.frame.height - 40, width: 50, height: 40))
        allowInputNumberLabel.text = "140"
        allowInputNumberLabel.textAlignment = .right
        self.view.addSubview(allowInputNumberLabel)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        let currentCharactorCount = (textView.text?.count)!
        if currentCharactorCount >= 140 {
            limitedTextView.resignFirstResponder()
        }
        allowInputNumberLabel.text = "\(140 - currentCharactorCount)"
    }
    
    @objc func keyboardWillChangeFrame(note: NSNotification) {
        let duration = note.userInfo?[LimitInputTextField.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let endFrame = (note.userInfo?[LimitInputTextField.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        
        let margin = UIScreen.main.bounds.height - y
        UIView.animate(withDuration: duration) {
            if margin > 0 {
                self.allowInputNumberLabel.frame.origin.y -= margin
            } else {
                self.allowInputNumberLabel.frame.origin.y = self.view.frame.height - 40
            }
        }
    }
}
