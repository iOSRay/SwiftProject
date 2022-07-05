//
//  PullToRefresh.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import Foundation
import UIKit

class PullToRefresh: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource = Array<Date>()
    let refresh = UIRefreshControl()
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewElementToArray()
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.frame.origin.y = 44
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        refresh.attributedTitle = NSAttributedString(string: "拉什么拉！？再拉朕就要碎了")
        refresh.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        tableView.addSubview(refresh)
        tableView.reloadData()
    }
    
    func addNewElementToArray() {
        dataSource.insert(NSDate() as Date, at: 0)
    }
    
    @objc func pullToRefreshAction() {
        addNewElementToArray()
        refresh.endRefreshing()
        tableView.reloadData()
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日/HH时mm分ss秒"
        cell.textLabel?.text = dateFormatter.string(from: dataSource[indexPath.row])
        return cell
    }
}
