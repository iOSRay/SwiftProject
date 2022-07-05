//
//  ViewController.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataSource = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "30day-swift-projects"
        dataSource = ["CustomFont",
                      "Watch Demo",
                      "Find My Position",
                      "Limit Input Text Field",
                      "Pull To Refresh",
                      "Video Player",
                      "Simple Photo Browser",
                      "Color Gradient",
                      "Swipeable Cell",
                      "Stretchy Header"]
        setupTableView()
    }

    func setupTableView() {
        let tableView = UITableView.init(frame: self.view.bounds)
        tableView.frame.origin.y = 44
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellIdentifier")
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var className: String = dataSource[indexPath.row]
        className = className.replacingOccurrences(of: " ", with: "")
        let anyClass = getClassFromString(className) as! UIViewController.Type
        let vc = anyClass.init()
        vc.title = className
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func getClassFromString(_ classString: String) -> AnyClass? {
        guard let bundleName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            return nil
        }
        
        var anyClass: AnyClass? = NSClassFromString(bundleName + "." + classString)
        if anyClass == nil {
            anyClass = NSClassFromString(classString)
        }
        return anyClass
    }
}

