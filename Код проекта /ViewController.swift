//
//  ViewController.swift
//  iterQR
//
//  Created by Игорь Островский on 12.10.2022.
//

import UIKit

class ViewController: UIViewController {
    let labelInter:UILabel = {
        var label = UILabel()
        label.text = "Inter"
        label.textColor = UIColor(cgColor: #colorLiteral(red: 0.7129633427, green: 0.7166470885, blue: 0.7233940959, alpha: 1))
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label 
    }()
    let labelQR:UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 48, height: 16))
        label.text = "QR"
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        var gradient = CAGradientLayer()
        gradient.frame = label.bounds
        var firstColor = UIColor(cgColor: #colorLiteral(red: 0, green: 0.3470697999, blue: 0.6150612831, alpha: 1))
        var secondColor = UIColor(cgColor: #colorLiteral(red: 0, green: 0.632548213, blue: 0.861237824, alpha: 1))
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        label.textColor = UIColor(patternImage: image!)
        return label
    }()
    let labelWelcome:UILabel = {
        var label = UILabel()
        label.text = "Welcome"
        label.font = .boldSystemFont(ofSize: 35)
        label.font = UIFont(name: "Sk-Modernist-Bold", size: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let settingButton:UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "gearshape")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(cgColor: #colorLiteral(red: 0.1694790423, green: 0.08085501939, blue: 0.256159991, alpha: 1))), for: .normal)
        button.layer.cornerRadius = 13
        //button.backgroundColor = .red
        button.layer.borderColor = CGColor(#colorLiteral(red: 0.7278399467, green: 0.7278399467, blue: 0.7278399467, alpha: 1))
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var homeImage:UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "Home")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var sectionHeaderLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "sk-modernist", size: 25)
        label.font = .boldSystemFont(ofSize: 25)
        label.text = "My doors"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dataSource: UICollectionViewDiffableDataSource<ModelSection, ItemModel>? = nil
    var sections = Bundle.main.decode([ModelSection].self, from: "model.json")
    var collectionView:UICollectionView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraintsLabel()
        setConstreintsButton()
        setConstraintsLabelWelcome()
        setConstraintsHomeImageView()
        createCollectionView()
        createDataSource()
        relodeData()
        setLabelSectionHeader()
    }
    
    

}
//MARK: - set and create CollectrionView
extension ViewController{
    func createCollectionView(){
        collectionView = UICollectionView(frame: CGRect(x: 16, y: 400, width: 355, height: 503), collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.reuseId)
        //collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reusedCell)
        view.addSubview(collectionView)
        
    }
}
//MARK: - createDataSorce
extension ViewController{
    func createDataSource(){
        dataSource = UICollectionViewDiffableDataSource<ModelSection, ItemModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            var section = self.sections[indexPath.section].type
            switch section{
            default:
                var cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reuseId, for: indexPath) as? CustomCollectionViewCell
                //cell?.backgroundColor = .black
                cell?.layer.cornerRadius = 15
                cell?.layer.borderWidth = 1
                cell?.layer.borderColor = CGColor(#colorLiteral(red: 0.8901960784, green: 0.9176470588, blue: 0.9176470588, alpha: 1))
                cell?.configure(with: model)
                return cell
            }
        })
        /*dataSource?.supplementaryViewProvider = {collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reusedCell, for: indexPath) as? SectionHeader else {return nil}
            guard let item = self.dataSource?.itemIdentifier(for: indexPath) else {return nil}
            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: item)
            else {return nil}
            if section.title.isEmpty {return nil}
            sectionHeader.title.text = section.title
            return sectionHeader
                    
        }*/
    }
}
//MARK: - RelodeData
extension ViewController{
    func relodeData(){
        var snapshot = NSDiffableDataSourceSnapshot<ModelSection, ItemModel>()
        snapshot.appendSections(sections)
        for section in sections{
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
    
}
//MARK: - createCompositionalLayout
extension ViewController{
    func createCompositionalLayout() -> UICollectionViewLayout{
        var layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            var section = self.sections[sectionIndex].type
            switch section{
            default: return self.createLayoutSection()
            }
        }
        return layout
    }
}
//MARK: - createSectionHeader
/*extension ViewController{
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        var sectionSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
        var sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
}*/
//MARK: - createLayoutSection
extension ViewController{
    func createLayoutSection() -> NSCollectionLayoutSection{
        var itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        var item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)
        var groupSize = NSCollectionLayoutSize(widthDimension: .estimated(355), heightDimension: .estimated(140))
        var group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        var section = NSCollectionLayoutSection(group: group)
        //var header = createSectionHeader()
        //section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 29, leading: 0, bottom: 0, trailing: 0)
        return section
        
    }
}
//MARK: - Set Constraints
extension ViewController{
    func setConstraintsLabel(){
        var labelStackView = UIStackView(arrangedSubviews: [labelInter,labelQR])
        labelStackView.axis = .horizontal
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27.3),
            labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelStackView.widthAnchor.constraint(equalToConstant: 48.65 + 33.25 + 6),
            labelStackView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    func setConstreintsButton(){
        view.addSubview(settingButton)
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7.3),
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            settingButton.widthAnchor.constraint(equalToConstant: 45),
            settingButton.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    }
    func setConstraintsLabelWelcome(){
        view.addSubview(labelWelcome)
        NSLayoutConstraint.activate([
            labelWelcome.topAnchor.constraint(equalTo: labelInter.bottomAnchor, constant: 62.99),
            labelWelcome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelWelcome.widthAnchor.constraint(equalToConstant: 148),
            labelWelcome.heightAnchor.constraint(equalToConstant: 92)
        ])
    }
    func setConstraintsHomeImageView(){
        view.addSubview(homeImage)
        NSLayoutConstraint.activate([
            homeImage.topAnchor.constraint(equalTo: settingButton.bottomAnchor, constant: 19.94),
            homeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            homeImage.heightAnchor.constraint(equalToConstant: 168),
            homeImage.widthAnchor.constraint(equalToConstant: 189)
        ])
    }
    func setLabelSectionHeader(){
        view.addSubview(sectionHeaderLabel)
        NSLayoutConstraint.activate([
            sectionHeaderLabel.topAnchor.constraint(equalTo: homeImage.bottomAnchor, constant: 31),
            sectionHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            sectionHeaderLabel.widthAnchor.constraint(equalToConstant: 150),
            sectionHeaderLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
}
import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let listVC = ViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListProvider.ContainterView>) -> ViewController {
            return listVC
        }
        
        func updateUIViewController(_ uiViewController: ListProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListProvider.ContainterView>) {
            
        }
        
    }
    
}



