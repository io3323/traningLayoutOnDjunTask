//
//  SectionHeader.swift
//  iterQR
//
//  Created by Игорь Островский on 12.10.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static var reusedCell:String = "cellSectionHeader"
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        customiseLabel()
        setConstraints()
    }
    func customiseLabel(){
        title.font = UIFont(name: "sk-modernist", size: 25)
        title.font = .boldSystemFont(ofSize: 25)
        title.translatesAutoresizingMaskIntoConstraints = false
    }
    func setConstraints(){
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
