//
//  TableViewController.swift
//  Example
//
//  Created by y.marui on 2020/10/18.
//

import UIKit
import TDTabView

class TableViewController: TDTabChildViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func didTapRightButton(_ sender: Any) {
        exitFullScreen()
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.setup(title: "\(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "next", sender: nil)
    }
}

class CustomCell: UITableViewCell  {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(title: String){
        titleLabel.text = title
    }
}
