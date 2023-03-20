//
//  FilterViewController.swift
//  Community Events
//
//  Created by Blake Ezechi on 15/03/2023.
//

import UIKit
import MapKit
import CoreLocation

protocol SearchDelegate: AnyObject {
    func filterViewController(_ vc: FilterViewController,
                              didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}
class FilterViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
   
    
    weak var delegate: SearchDelegate?
    var searchController = UISearchController()
    
     var label: UILabel = {
        let label = UILabel()
        label.text = "What event are you looking for?"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var locations = [Constants]()
    var filtered = [Constants]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        initList()
        searchController = UISearchController(searchResultsController: nil)
                tableView.tableHeaderView = searchController.searchBar
                searchController.searchResultsUpdater = self
                searchController.obscuresBackgroundDuringPresentation = false

                // Search Bar options
                searchController.searchBar.placeholder = "Search for name of event"
                
                // Search Bar Disappears when tapped, hence the code line is needed
                searchController.hidesNavigationBarDuringPresentation = false
                // Adds a colour border for the search bar
                searchController.searchBar.tintColor = UIColor.orange
        initSearchController()
        
        for filter in locations {
            filtered.append(filter)
        }
        
    }
    
    func initList() {
        let volleyball = Constants(title: "Volleyball",
                                   date: "20/06/2023",
                                   location: "Northlands Park",
                                   coordinate: CLLocationCoordinate2D(latitude: 51.5758803344746,
                                                                      longitude: 0.4976933254567531),
                                   expired: false)
        locations.append(volleyball)
        
        let footballMatch = Constants(title: "Football Match",
                                      date: "18/06/2023",
                                      location: "Gloucester Park",
                                      coordinate: CLLocationCoordinate2D(latitude: 51.57766533668046,
                                                                         longitude: 0.45268855614121045),
                                      expired: false)
        locations.append(footballMatch)
        
        let fivekRun = Constants(title: "5k Run",
                                 date: "07/07/2023",
                                 location: "Northlands Park",
                                 coordinate: CLLocationCoordinate2D(latitude: 51.549550035616925,
                                                                    longitude: 0.4467800877064759),
                                 expired: false)
        locations.append(fivekRun)
        
        let swimming = Constants(title: "Swimming",
                                 date: "10/05/2023" ,
                                 location: "Wickford Memorial Park",
                                 coordinate: CLLocationCoordinate2D(latitude: 51.61996778323418,
                                                                    longitude: 0.5338082277940184),
                                 expired: false)
        locations.append(swimming)
        
        let baking = Constants(title: "Baking",
                               date: "01/01/2023",
                               location: "Festival Leisure Park",
                               coordinate: CLLocationCoordinate2D(latitude: 51.58612590734672,
                                                                  longitude: 0.462283037324271),
                               expired: true)
        locations.append(baking)
    }
    
    func initSearchController() {

        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["events List"]
        searchController.searchBar.delegate = self
        
   }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 10, y: 10, width: label.frame.size.width, height: label.frame.size.height)
        let tableY: CGFloat = label.frame.origin.y + label.frame.size.height + 5
        tableView.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height - tableY)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive) {
            return filtered.count
        }
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let thisLocation: Constants!
        
        if(searchController.isActive) {
            thisLocation = filtered[indexPath.row]
        } else {
            thisLocation = locations[indexPath.row]
        }
        
        cell?.textLabel?.text = thisLocation.title
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Notify map controller to remove pin at selected filter
        let coordinate = filtered[indexPath.row].coordinate
        
        delegate?.filterViewController(self,
                                       didSelectLocationWith: coordinate)
    }
    
    func filterContentForSearchText(_ searchText: String) {
            filtered = locations.filter({ (constant:Constants) -> Bool in
                let titleMatch = constant.title.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                let dateMatch = constant.date.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                let locationMatch = constant.location.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return titleMatch != nil || dateMatch != nil || locationMatch != nil}
            )
        } // end func filterContent
        
        func updateSearchResults(for searchController: UISearchController) {
            if let searchText = searchController.searchBar.text {
                filterContentForSearchText(searchText)
                tableView.reloadData()  // replace current table view with search results table view
            }
        }
}
