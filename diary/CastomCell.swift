//
//  CastomCell.swift
//  diary
//
//  Created by Oleg on 3/31/21.
//

import UIKit

class CastomCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let dateStartLabel: UILabel = {
        let dataStartLabel = UILabel()
        dataStartLabel.font = .systemFont(ofSize: 11, weight: .light)
        return dataStartLabel
    }()
    let dateFinishLabel: UILabel = {
        let dateFinishLabel = UILabel()
        dateFinishLabel.font = .systemFont(ofSize: 11, weight: .light)
        return dateFinishLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateStartLabel)
        contentView.addSubview(dateFinishLabel)

        nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: frame.size.height/2, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        dateStartLabel.anchor(top: topAnchor, left: nameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        dateFinishLabel.anchor(top: dateStartLabel.bottomAnchor, left: nameLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
