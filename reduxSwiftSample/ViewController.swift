//
//  ViewController.swift
//  reduxSwiftSample
//
//  Created by Takeshi Kawai on 2015/12/06.
//  Copyright © 2015年 Takeshi Kawai. All rights reserved.
//

import UIKit
import SwiftRedux
import RxSwift

private let store = AppStore.sharedInstance

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var disposable: Disposable? = nil
    var countries:[String] = [] {
        didSet {
            print("reload \(countries)")
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        disposable = store.subscribe { (state: State) in
            if let state = state as? AppState {
                self.countLabel.text = "\(state.counter)"
                self.totalCount.text = "\(state.countries.count)"
                self.countries = state.countries
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func incrementAction(sender: AnyObject) {
        store.dispatch(IncrementAction())
    }
    
    @IBAction func addRowAction(sender: AnyObject) {
        store.dispatch(AddRowAction(payload: AddRowAction.Country(name:"Japan")))
    }
    
    // MARK: UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = countries[indexPath.row]
        return cell
    }
}

