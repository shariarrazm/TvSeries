//
//  DetailController.swift
//  TVMaze
//
//  Created by Shariar Razm1 on 2018-05-06.
//  Copyright © 2018 Shariar Razm. All rights reserved.
//

import UIKit


class DetailController: UIViewController {
    
    var series: Series? = nil
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .yellow
        return iv
    }()
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let summaryTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = .white
        return tv
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let genresLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow"), style: .plain, target: self, action: #selector(handleBack))
        navigationItem.title = series?.name
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        handleConstraints()
       
        nameLabel.text = series?.name
        statusLabel.text = "Status: " + (series?.status)!

        guard let runtime = series?.runtime else {return}
        runtimeLabel.text = String("Runtime: \(runtime)")
        if let geners = series?.genres.map({$0})?.joined(separator:", "){
            genresLabel.text = "Genres: \(geners)"
        }
        
        guard let rating = series?.rating?.average else {return}
        ratingLabel.text = String("Rating: \(rating)")

        guard let attributedText = series?.summary?.convertHtml() else {return}
        summaryTextView.attributedText = attributedText

        guard let url = series?.image?.original else {return}
        imageView.downloadedFrom(link: url)
    }
    
    func handleConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, statusLabel, runtimeLabel, genresLabel, ratingLabel, summaryTextView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.setCustomSpacing(10, after: ratingLabel)
        
        [imageView, containerView].forEach {view.addSubview($0)}
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 2, left: 2, bottom: 2, right: 2), size: .init(width: 0, height: 350))
        
        containerView.anchor(top: imageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: -10, left: 20, bottom: -50, right: 20))

        containerView.addSubview(stackView)
        stackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = containerView.bounds
        containerView.addSubview(blurredEffectView)
    }
    
    @objc func handleBack() {
        dismiss(animated: true, completion: nil)
    }
}

























