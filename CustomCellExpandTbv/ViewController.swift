//
//  ViewController.swift
//  CustomCellExpandTbv
//
//  Created by macbookpro on 06/07/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tbv: UITableView!
    
    var models: [Model] = []
    var expandedCells:[IndexPath: Bool] = [:]
    var expandedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }

}

extension ViewController {
    private func setupUI() {
        configTbv()
    }
    
    private func setupData() {
        models = getModel()
    }
    
    private func configTbv() {
        tbv.register(DetailCell.self, forCellReuseIdentifier: "DetailCell")
        tbv.delegate = self
        tbv.dataSource = self
    }
    
    private func getModel() -> [Model] {
        let model1 = Model(image: UIImage(named: "pk1" )!, name: "Model 1", details: "This Pokémon is small in stature ")
        let model2 = Model(image: UIImage(named: "pk2")!, name: "Model 2", details: "A new Pokémon has been revealed in a spoof presentation released on the Japanese Pokémon website. Purporting to be a meeting of the World Pokémon Ecological Society,")
        let model3 = Model(image: UIImage(named: "pk3")!, name: "Model 3", details: "Various footage from the Paldea region in Scarlet/Violet was shown. At the end a new white worm Pokémon was seen.")

        let models = [model1, model2, model3]
        return models
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == expandedIndexPath {
            return 160
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        
        let model = models[indexPath.row]
        cell.image.image = model.image
        cell.lbName.text = model.name
        cell.lbDetail.text = model.details
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailCell else {
            return
        }
        
        let expand = !(expandedCells[indexPath] ?? false)
        
        tableView.beginUpdates()
        
        UIView.animate(withDuration: 0.3) {
            if let expandedIndexPath = self.expandedIndexPath {
                if expandedIndexPath == indexPath {
                    self.expandedIndexPath = nil
                    cell.expanded = false
                } else {
                    let pre = tableView.cellForRow(at: expandedIndexPath) as? DetailCell
                    pre?.expanded = false
                    self.expandedIndexPath = indexPath
                    cell.expanded = true
                }
                
            } else {
                self.expandedIndexPath = indexPath
                cell.expanded = true
            }

        }
        
        tableView.endUpdates()
        expandedCells[indexPath] = expand
    }
    
    
}


