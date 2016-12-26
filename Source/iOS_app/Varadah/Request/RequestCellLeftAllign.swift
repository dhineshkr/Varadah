//
//  NonCurrentUserCell.swift
//  RequestCellLeftAllign
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher


class RequestCellLeftAllign: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var trucksText: UILabel!
    @IBOutlet weak var treesText: UILabel!
    @IBOutlet weak var sponsorName: UILabel!
    @IBOutlet weak var sponsorCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getRandomPic() -> String {
        let ran = Int(arc4random_uniform(UInt32(5)))
        switch ran {
        case 0:
            return "https://storage.googleapis.com/7a27923890654b249cd80abec7999920/cd363556-8b87-46d7-9ec8-ed2b130676f0/dishPhoto.jpeg"
        case 1:
            return "https://storage.googleapis.com/7a27923890654b249cd80abec7999920/579eb11c-9eb8-4572-8e01-ccce75156b62/dishPhoto.jpeg"
        case 2:
            return "https://storage.googleapis.com/7a27923890654b249cd80abec7999920/714dbfe8-269a-472f-8fdf-e8a4cdc81eea/dishPhoto.jpeg"
        case 3:
            return "http://storage.googleapis.com/7a27923890654b249cd80abec7999920/onthego/1475847055060.png"
        case 4:
            return "https://storage.googleapis.com/7a27923890654b249cd80abec7999920/26d7be21-b06d-4146-b7f5-583572e36b16/dishPhoto.jpeg"
        case 5:
            return "https://storage.googleapis.com/7a27923890654b249cd80abec7999920/d2412f64-95c0-4788-ab25-ed536aab39da/dishPhoto.jpeg"
        default:
            return "http://storage.googleapis.com/7a27923890654b249cd80abec7999920/onthego/1475847055060.png"
        }
    }
    
    func initCellWithData(data: RequestModel) {
        var picPath: String = ""
        if data.photoPath.characters.count > 0 {
            picPath = data.photoPath
        } else {
            picPath = self.getRandomPic()
        }
        if let url = NSURL(string: picPath) {
            self.photo.kf_showIndicatorWhenLoading = true
            self.photo.kf_setImageWithURL(url)
        }
        self.treesText.text = String(format:"Trees: %@", data.treesCount)
        self.trucksText.text = String(format:"Trucks: %@", data.trucksRequired)
        self.sponsorName.text = data.sponsorName
        self.sponsorCell.text = data.sponsorCell
    }
    
}
