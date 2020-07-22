//
//  CharacterCollectionCell.swift
//  yonusa-test
//
//  Created by Carlos Ponce on 22/07/20.
//  Copyright © 2020 Carlos Ponce. All rights reserved.
//

import UIKit
import Nuke

class CharacterCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func printName(_ name: String) {
        characterNameLabel.text = name
    }
    func loadImage(_ image: String) {
        let img = image.split(separator: "?")
        if let urlSafe = image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let url = URL(string: urlSafe) {
                
                Nuke.loadImage(with: url, into: characterImageView)
            }
        }
    }
    override func draw(_ rect: CGRect) {
        characterImageView.layer.cornerRadius = characterImageView.frame.height/2
    }
}
