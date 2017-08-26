//
//  ListCell.swift
//  GITList
//
//  Created by Brandon Holderman on 8/22/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var numItemsLabel: UILabel!

    var list: List! {
        didSet {
            self.previewLabel.text = list.items.reduce("", { (firstItem, secondItem) -> String in
                print(firstItem + "" + secondItem)
                if let createdAt = list.createdAtDate {
                titleLabel.text = DateFormatter.localizedString(from: createdAt, dateStyle:
                    DateFormatter.Style.full, timeStyle: DateFormatter.Style.none)
                }
                numItemsLabel.text = "\(list.items.count) items"
                layer.borderWidth = 2.0
                layer.borderColor = UIColor.white.cgColor
                return "" + firstItem + secondItem + ", "
            })
        }
    }
}
