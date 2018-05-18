//
//  SearchCell.swift
//  TVMaze
//
//  Created by Shariar Razm1 on 2018-05-04.
//  Copyright © 2018 Shariar Razm. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    var series: Series? {
        didSet {
            nameLabel.text = series?.name
            guard let imageUrl = series?.image?.medium else { return }
            imageView.downloadedFrom(link: imageUrl)
            
            guard let rating = series?.rating?.average else {return}
            ratingLabel.text = String(rating)
        }
    }
    
    
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.contentsScale = 5
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Label"
        label.font = UIFont.italicSystemFont(ofSize: 20)
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "rating Label"
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContainerView()
    }
    
    func setupContainerView() {
        
        [imageView, containerView].forEach { addSubview($0)}
        
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 100, height: 100))
        
        containerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: imageView.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 5))
        
        [nameLabel, separatorView, ratingLabel].forEach {containerView.addSubview($0)}
        
        nameLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        separatorView.anchor(top: nameLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 0), size: .init(width: 0, height: 1))
        
        ratingLabel.anchor(top: separatorView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
