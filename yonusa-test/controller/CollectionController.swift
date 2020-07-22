//
//  ViewController.swift
//  yonusa-test
//
//  Created by Carlos Ponce on 22/07/20.
//  Copyright © 2020 Carlos Ponce. All rights reserved.
//

import UIKit
import Alamofire

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var simpsonsCollection: UICollectionView!
    
    var charactersSimpsons = [CharacterStruct]()
    var isLandscape = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isLandscape = UIDevice.current.orientation.isLandscape
        getCharacters(["count": isLandscape ? 20 : 10])
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
    
    func getCharacters(_ params: [String: Any]?) {
        let url = "https://thesimpsonsquoteapi.glitch.me/quotes"
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == charactersSimpsons.count-1 && charactersSimpsons.count >= 10 {
            if charactersSimpsons.count < 60 {
                if (charactersSimpsons.count + 20) <= 60 && isLandscape {
                    getCharacters(["count": 20])
                }else if (charactersSimpsons.count + 10) <= 60 && !isLandscape {
                    getCharacters(["count": 10])
                }else {
                    getCharacters(["count": (60 - charactersSimpsons.count)])
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "character", for: indexPath) as! CharacterCollectionCell
        cell.characterImageView.loadImage("https://i.pinimg.com/564x/c9/77/c4/c977c4a74ccff1b2a0588fff7e6b433f.jpg")
        cell.printName("\(indexPath.row): " + charactersSimpsons[indexPath.row].character!)
        cell.characterButton.tag = indexPath.row
        cell.characterButton.addTarget(self, action: #selector(characterDescriptionSegues(_:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func characterDescriptionSegues(_ sender: UIButton) {
        character = charactersSimpsons[sender.tag]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "description") as! DescriptionController
        navigationController?.pushViewController(vc, animated: true)
    }
}

