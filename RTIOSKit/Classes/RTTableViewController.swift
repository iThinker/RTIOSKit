//
//  RTTableViewController.swift
//  Pods
//
//  Created by Roman Temchenko on 2017-09-03.
//
//

import Foundation
import UIKit

class RTTableViewControllerSectionModel: NSObject {
    
    let cellModels: [RTTableViewControllerCellModel]
    let tableView: UITableView
    
    required init(_ tableView: UITableView, _ cellModels: [RTTableViewControllerCellModel]) {
        self.tableView = tableView
        self.cellModels = cellModels
    }
    
    var numberOfRows: Int {
        return self.cellModels.count
    }
    
}

class RTTableViewControllerCellModel: NSObject {
    
    @objc(RTTableViewControllerCellModelDeselectionBehaviour)
    class DeselectionBehaviour: NSObject {
        
        class func animated() -> DeselectionBehaviour {
            return self.init(animated: true)
        }
        
        class func notAnimated() -> DeselectionBehaviour {
            return self.init(animated: false)
        }
        
        let animatedDeselection: Bool
        
        required init(animated: Bool) {
            self.animatedDeselection = animated
            super.init()
        }
        
        func perform(_ tableView: UITableView, _ indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: self.animatedDeselection)
        }
        
    }
    
    let tableView: UITableView
    var deselectionBehaviour: DeselectionBehaviour?
    var onDidSelectCell: (() -> Void)?
    
    internal let cellClass = UITableViewCell.self
    internal var reuseidentifier: String {
        return cellClass.defaultReuseIdentifier()
    }
    
    required init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.registerCell()
    }
    
    internal func registerCell() {
        self.tableView.register(self.cellClass, forCellReuseIdentifier: self.reuseidentifier)
    }
    
    func dequeueCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: self.reuseidentifier, for: indexPath)
        
        // configure cell here
        
        return cell
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        self.onDidSelectCell?()
        self.deselectionBehaviour?.perform(self.tableView, indexPath)
    }
    
}

class RTTableViewController: NSObject {
    
    let tableView: UITableView
    internal(set) var sectionModels: [RTTableViewControllerSectionModel]
    
    required init(_ tableView: UITableView, _ sectionModels: [RTTableViewControllerSectionModel]) {
        self.tableView = tableView
        self.sectionModels = sectionModels
        super.init()
    }
    
    func replace(_ sectionModels: [RTTableViewControllerSectionModel]) {
        self.sectionModels = sectionModels
        self.tableView.reloadData()
    }
    
    internal func cellModel(at indexPath: IndexPath) -> RTTableViewControllerCellModel {
        return self.sectionModels[indexPath.section].cellModels[indexPath.row]
    }
    
}

extension RTTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionModels[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cellModel(at: indexPath).dequeueCell(for: indexPath)
    }
    
}

extension RTTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellModel(at: indexPath).didSelectRow(at: indexPath)
    }
    
}
