//
//  DescriptionController.swift
//  yonusa-test
//
//  Created by Carlos Ponce on 22/07/20.
//  Copyright © 2020 Carlos Ponce. All rights reserved.
//

import UIKit
import Nuke

var character: CharacterStruct?

class DescriptionController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterImageView.layer.cornerRadius = characterImageView.frame.height/2
        characterNameLabel.text = character?.character ?? ""
        characterDescriptionLabel.text = character?.quote ?? ""
        characterImageView.loadImage("https://i.pinimg.com/564x/c9/77/c4/c977c4a74ccff1b2a0588fff7e6b433f.jpg")
    }
    
}
