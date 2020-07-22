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
    @IBOutlet weak var characterButton: UIButton!
    
    func printName(_ name: String) {
        characterNameLabel.text = name
    }
    
    override func draw(_ rect: CGRect) {
        characterImageView.layer.cornerRadius = characterImageView.frame.height/2
    }
}
