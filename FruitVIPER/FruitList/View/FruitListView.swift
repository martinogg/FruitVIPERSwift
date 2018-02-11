//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

class FruitListView: UITableViewController
{
    var presenter: FruitListPresenterProtocol?
    var fruit: [Fruit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let viewToShow = segue.destination as? FruitDetailView,
            let fruit = presenter?.selectedFruit,
            let startTime = presenter?.startTime
        {
            FruitDetailWireFrame.attachVIPERClasses(to: viewToShow, with: fruit, startTime: startTime)
        }
    }
    
    @objc func refreshData(_ sender: Any) {
        presenter?.refreshData()
    }
}

// MARK - UITableViewDatasource / UITableViewDelegate

extension FruitListView {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selected(fruit: fruit[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.fruit.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell.init(style: .value1, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = fruit[indexPath.row].fruitname
        return cell
    }
}

extension FruitListView: FruitListViewProtocol {
    func pushFruitDetailsView(for fruit: Fruit) {
        presenter?.selectedFruit = fruit
        presenter?.startTime = Date.init().timeIntervalSince1970
        self.performSegue(withIdentifier: "fruitdetails", sender: self)
    }
    
    func show(fruit: [Fruit]) {
        tableView.refreshControl?.endRefreshing()
        self.fruit = fruit
        tableView.reloadData()
    }
    
    func show(error: Error) {
        self.tableView.refreshControl?.endRefreshing()
        // show no error
    }

}
