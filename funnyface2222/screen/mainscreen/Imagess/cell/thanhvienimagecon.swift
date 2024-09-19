//
//  thanhvienimagecon.swift
//  funnyface2222
//
//  Created by quocanhppp on 16/01/2024.
//

import UIKit

class thanhvienimagecon: UICollectionViewCell {
    @IBOutlet weak var imageVideo: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTimeRun: UILabel!
    @IBOutlet weak var labelTuoi: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        labelName.textColor = .white
        labelTuoi.textColor = .white
        labelTimeRun.textColor = .white
        
        labelName.font = .quickSandLight(size: 14)
        labelTuoi.font = .quickSandLight(size: 14)
        labelTimeRun.font = .quickSandLight(size: 14)
    }
}
