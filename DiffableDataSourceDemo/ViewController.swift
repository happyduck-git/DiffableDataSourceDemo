//
//  ViewController.swift
//  DiffableDataSourceDemo
//
//  Created by HappyDuck on 10/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var addButton: UIButton!
    private var number: Int = 4
    
    private var model: [String] = []
    
    private let table: UITableView = {
  
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.delegate = self
        self.table.dataSource = self
        self.view.addSubview(self.table)
        self.table.frame = view.bounds
        self.makeModel {
            self.table.reloadData()
        }

        
    }

    @IBAction func addData(_ sender: Any) {
        self.model.append("Data no. \(self.number)")
        self.number += 1
        self.table.reloadData()
    }
    
}

extension ViewController {
    private func makeModel(completion: @escaping () -> Void) {
        for i in 0...3 {
            model.append("Data no. \(i)")
        }
        completion()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError()
        }
        var config = cell.defaultContentConfiguration()
        config.text = self.model[indexPath.row]
        cell.contentConfiguration = config
        
        return cell
    }
}
