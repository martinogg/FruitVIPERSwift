//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

class FruitDetailView: UIViewController, FruitDetailViewProtocol
{
    var presenter: FruitDetailPresenterProtocol?
    
    @IBOutlet weak var fruitDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func show(fruit: Fruit) {
        let fruitText = "Fruit: \(fruit.fruitname)\nPrice: \(fruit.price)\nWeight: \(fruit.weight)"
        fruitDescription.text = fruitText
    }
}
