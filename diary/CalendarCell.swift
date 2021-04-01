//
//  CastomCell.swift
//  diary
//
//  Created by Oleg on 3/31/21.
//

import UIKit
import FSCalendar

class CalendarCell: UITableViewCell {
    
    let calendar = FSCalendar()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(calendar)


        calendar.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 1, paddingLeft: 1, paddingBottom: 1, paddingRight: 1, width: frame.size.width / 2, height: 0, enableInsets: false)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
