//
//  SearchController.swift
//  TVMaze
//
//  Created by Shariar Razm1 on 2018-05-03.
//  Copyright © 2018 Shariar Razm. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private var series = [Series]()
    private var filteredSeries = [Series]()

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter text here"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        sb.delegate = self
        return sb
    }()


    let cellId = "cellId"
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super .viewDidLoad()

        collectionView?.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.safeAreaLayoutGuide.topAnchor, leading: navBar?.safeAreaLayoutGuide.leadingAnchor, bottom: navBar?.safeAreaLayoutGuide.bottomAnchor, trailing: navBar?.safeAreaLayoutGuide.trailingAnchor)
        

        collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: cellId)

        parseJson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false
        collectionView?.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredSeries = series
        } else {
            filteredSeries = self.series.filter({ (serie) -> Bool in
                return (serie.name?.lowercased().contains(searchText.lowercased()))!
            })
        }
        self.collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filteredSeries.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.backgroundColor = UIColor.rgb(red: 240, green: 248, blue: 255)
        cell.series = filteredSeries[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = DetailController()
        detailController.series = self.filteredSeries[indexPath.row]
        let navController = UINavigationController(rootViewController: detailController)
        present(navController, animated: true, completion: nil)
    }


    func parseJson() {
        
        let jsonUrlString = "http://api.tvmaze.com/shows"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                self.series = try JSONDecoder().decode([Series].self, from: data)
            } catch let error {
                print("Failed to parse json", error)
            }
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
            
        }.resume()
    }
}
