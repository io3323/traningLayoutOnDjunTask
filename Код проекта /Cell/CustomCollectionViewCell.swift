//
//  CustomCollectionViewCell.swift
//  iterQR
//
//  Created by Игорь Островский on 12.10.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell, CellProtocol {
    static var reuseId: String = "customCellId"
    var subTitleLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "sk-modernist", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var titleLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Sk-Modernist-Bold", size: 16)
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var statusLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var firstImage:UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var secondImage:UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    func configure(with moddel: ItemModel) {
        titleLabel.text = moddel.titleLabel
        subTitleLabel.text = moddel.subTitleLabel
        statusLabel.text = moddel.statusLabel
        firstImage.image = UIImage(named: moddel.firstImage)
        secondImage.image = UIImage(named: moddel.secondImage)
       
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension CustomCollectionViewCell{
    func createConstraints(){
        contentView.addSubview(firstImage)
        NSLayoutConstraint.activate([
            firstImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 18),
            firstImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            firstImage.heightAnchor.constraint(equalToConstant: 41),
            firstImage.widthAnchor.constraint(equalToConstant: 41)
        ])
        var stackLabelView = UIStackView(arrangedSubviews: [titleLabel,subTitleLabel])
        stackLabelView.axis = .vertical
        stackLabelView.spacing = 5
        stackLabelView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackLabelView)
        NSLayoutConstraint.activate([
            stackLabelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            stackLabelView.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: 13.8),
            stackLabelView.heightAnchor.constraint(equalToConstant: 36),
            stackLabelView.widthAnchor.constraint(equalToConstant: 80.76)
        ])
        contentView.addSubview(secondImage)
        NSLayoutConstraint.activate([
            secondImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            secondImage.leadingAnchor.constraint(equalTo: stackLabelView.trailingAnchor, constant: 107.44),
            secondImage.heightAnchor.constraint(equalToConstant: 45),
            secondImage.widthAnchor.constraint(equalToConstant: 40.65)
        ])
        contentView.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: stackLabelView.bottomAnchor, constant: 27),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 144.73),
            statusLabel.widthAnchor.constraint(equalToConstant: 100),
            statusLabel.heightAnchor.constraint(equalToConstant: 16.63)
        ])
    }
}
