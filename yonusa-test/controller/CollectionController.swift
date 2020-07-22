//
//  ViewController.swift
//  yonusa-test
//
//  Created by Carlos Ponce on 22/07/20.
//  Copyright © 2020 Carlos Ponce. All rights reserved.
//

import UIKit
import Alamofire

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var simpsonsCollection: UICollectionView!
    
    var charactersSimpsons = [CharacterStruct]()
    var isLandscape = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isLandscape = UIDevice.current.orientation.isLandscape
        getCharacters(url: "https://thesimpsonsquoteapi.glitch.me/quotes", ["count": isLandscape ? 20 : 10])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            isLandscape = true
            print("Landscape: \(isLandscape)")
        }else {
            isLandscape = false
            print("Landscape: \(isLandscape)")
        }
    }
    
    func getCharacters(url: String,_ params: [String: Any]?) {
        guard let urlSafe = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            print("url ilegible")
            return
        }
        guard let urlAPI = URL(string: urlSafe) else {
            print("No interpretable")
            return
        }
        AF.request(urlAPI, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.data else {
                print("Problemas para obtener información")
                return
            }
            do {
                let characters = try JSONDecoder().decode([CharacterStruct].self, from: json)
                self.appendToCharacterArray(characters: characters)
            }catch {
                print("Error:")
            }
        }
    }
    
    func appendToCharacterArray(characters: [CharacterStruct]) {
        for character in characters {
            charactersSimpsons.append(character)
        }
        self.simpsonsCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersSimpsons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "character", for: indexPath) as! CharacterCollectionCell
        cell.loadImage(charactersSimpsons[indexPath.row].image!)
        cell.printName(charactersSimpsons[indexPath.row].character!)
        return cell
    }
}

