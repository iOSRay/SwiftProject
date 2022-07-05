//
//  WatchDemo.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import Foundation
import UIKit
import SnapKit

class WatchDemo: UIViewController {
    
    var result: UILabel!
    var timer: Timer!
    var lableNumber: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        result = UILabel()
        result.text = "0"
        result.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(result)
        result.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(25)
            make.top.equalTo(100)
        }
        
        let startView = UIView()
        startView.backgroundColor = UIColor.init(red: 1, green: 101/255.0, blue: 27/255.0, alpha: 1)
        self.view.addSubview(startView)
        startView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(300)
            make.left.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.width.equalTo(self.view.frame.width / 2)
        }
        
        let endView = UIView()
        endView.backgroundColor = UIColor.init(red: 98/255.0, green: 242/255.0, blue: 23/255.0, alpha: 1)
        self.view.addSubview(endView)
        endView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(300)
            make.right.equalTo(self.view)
            make.width.equalTo(self.view.frame.width / 2)
            make.bottom.equalTo(self.view)
        }
        
        let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startHandler), for: .touchUpInside)
        self.view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.edges.equalTo(startView)
        }
        
        let endButton = UIButton()
        endButton.setTitle("End", for: .normal)
        endButton.addTarget(self, action: #selector(stopHandler), for: .touchUpInside)
        self.view.addSubview(endButton)
        endButton.snp.makeConstraints { make in
            make.edges.equalTo(endView)
        }
        
        let resultButton = UIButton()
        resultButton.setTitle("Reset", for: .normal)
        resultButton.addTarget(self, action: #selector(resetHandler), for: .touchUpInside)
        self.view.addSubview(resultButton)
        resultButton.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(startView.snp_top)
        }
    }
    
    @objc func startHandler() {
        if self.timer != nil {
            self.stopHandler()
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { Timer in
            self.lableNumber = self.lableNumber + 0.1
            self.result.text = String(format: "%.1f", self.lableNumber)
        })
        self.timer.fire()
    }
    
    @objc func stopHandler() {
        guard let timerForDistory = self.timer else {
            return
        }
        timerForDistory.invalidate()
    }
    
    @objc func resetHandler() {
        self.lableNumber = 0
        self.result.text = "0"
    }
}
