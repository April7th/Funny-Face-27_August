//
//  ImageHighlightUIViewController.swift
//  funnyface2222
//
//  Created by Lê Duy Tân on 26/8/24.
//

import UIKit
import Kingfisher

class ImageHighlightUIViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!

    
    
    var dataList: String = ""
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setTitle("", for: .normal)
        saveButton.setCustomFontForAllState(name: quicksandLight, size: 14)
        
        let url = URL(string: urlString)
        
        
        titleLabel.text = dataList
        print("dataList is: \(dataList)")
        print("url: \(url)")
        
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "hoapro"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
 
}
