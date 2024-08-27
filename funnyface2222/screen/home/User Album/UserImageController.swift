//
//  UserImageController.swift
//  funnyface2222
//
//  Created by Lê Duy Tân on 27/8/24.
//


import UIKit
import Kingfisher

class UserImageController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var listData:[ListVideoModal] = [ListVideoModal]()
    
    override func viewDidLoad() {
        
        setupUI()
    }
    
    private func setupUI() {
        backButton.setTitle("", for: .normal)
        moreButton.setTitle("", for: .normal)
        imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
    }
    
    @IBAction func backApp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func listCate(){
        let refreshAlert = UIAlertController(title: "Choose list video", message: "", preferredStyle: .alert)

        // Tùy chỉnh nền và màu sắc chữ
        if let alertView = refreshAlert.view.subviews.first?.subviews.first {
            alertView.backgroundColor = UIColor.black

            // Tìm các label trong alertView và đặt màu chữ là trắng
            for subview in alertView.subviews {
                if let label = subview as? UILabel {
                    label.textColor = UIColor.white
                }
            }
        }
        for index in 1...10 {
            refreshAlert.addAction(UIAlertAction(title: "album \(index)", style: .default, handler: { (action: UIAlertAction!) in
                
                APIService.shared.GetListImages(albuum:"\(index + 1)"){ response,error in
                    self.listData = response!
                    self.imageCollectionView.reloadData()
                }
            }))
        }
       

        present(refreshAlert, animated: true, completion: nil)

    }
    
    
}

extension UserImageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
        return listData.count
     
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewMainImage") as! ViewMainImage
        vc.modalPresentationStyle = .fullScreen
        print("lisssss dataa")
        print(self.listData)
        APIService.shared.GetListImages(albuum:"\(indexPath.row + 1)") { (response, error) in
            if let listData2 = response{
              
              
                DispatchQueue.main.async {
                    print(listData2)
                    vc.listData = listData2
                    print(vc.listData)
                    self.present(vc, animated: true, completion: nil)
                   
                }
            }
            
        }
      print("vc. list")
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        cell.titleLabel.text = listData[indexPath.row].thongtin
        let url = URL(string: self.listData[indexPath.row].image ?? "")
        let processor = DownsamplingImageProcessor(size: cell.imageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(
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
        

        
        collectionView.reloadData()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension UserImageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: (UIScreen.main.bounds.width)/3.2 - 20, height: 400)
        }
    return CGSize(width: (UIScreen.main.bounds.width)/2.5-10, height: 200)
       
    }
}






