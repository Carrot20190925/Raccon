//
//  BaseContryCodeVC.swift
//  RaccoonDog
//
//  Created by carrot on 23/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit
protocol RDContryCodeVCDelegate : AnyObject{
    func selectedCountryCode(_ countryCode : String)
}
class RDContryCodeVC: BaseTableController {
    let searchBar = UISearchBar.init()
    weak var delegate : RDContryCodeVCDelegate?
    var contryCodes : [String] = []
    let disposeBag = DisposeBag.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSearchBar()
        self.initNavigationBar()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib.init(nibName: "RDCountryCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 44;
        self.contryCodes = PhoneNumberUtil.countryCodes(forSearchTerm:nil)
        
    }
    
    func initNavigationBar() {
        let leftItem = UIBarButtonItem.init(image: UIImage.init(named: ""), style: .plain, target: nil, action: nil)
        leftItem.rx.tap.subscribe {[weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        self.navigationItem.leftBarButtonItem = leftItem
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.contryCodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RDCountryCell
        let countryCode = self.contryCodes[indexPath.row]
        let countryName = PhoneNumberUtil.countryName(fromCountryCode: countryCode)
        let countryCall = PhoneNumberUtil.callingCode(fromCountryCode: countryCode)
        cell.callCodeLabel.text = countryCall
        cell.countryNameLabel.text = countryName

        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCountryCode(self.contryCodes[indexPath.row])
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}



extension RDContryCodeVC:UISearchBarDelegate{
    func initSearchBar() {
//        searchBar.barTintColor = UIColor.white
//        searchBar.tintColor = UIColor.lightGray
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "请输入国家"
        searchBar.delegate = self
        searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchBar
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.contryCodes  = PhoneNumberUtil.countryCodes(forSearchTerm: searchText)
        self.tableView.reloadData()
    }
}
