//
//  YogaListVC.swift
//  YogaPose
//
//  Created by Harsh on 03/10/22.
//

import UIKit
import PassioPlatformSDK

final class YogaListVC: SuperVC {

    //MARK: - Outltes -
    @IBOutlet weak var tblViewYogaList: UITableView!
    @IBOutlet weak var searchYogaNames: UISearchBar!
    
    //MARK: - Global variables -
    private var yogaList : [YogaList] = [] {
        didSet {
            tblViewYogaList.reloadData()
        }
    }
    private var allData : [YogaList] = []
    
    //MARK: - View life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        registerNib()
        self.fetchYogaList()
    }
    // MARK: - Fetch Yoga List
    private func fetchYogaList() {
        if AppDelegate.allYogas.count != 0 {
            yogaList = AppDelegate.allYogas
            allData = AppDelegate.allYogas
        } else {
            guard let yogas = [YogaList].parse(jsonFile: yogaListJson) else {
                return
            }
            yogaList = yogas
            allData = yogas
        }
    }
    //MARK: - Config functions -
    private func configUI(){
        self.navigationItem.title = mindFulYogaTitle
        self.view.backgroundColor = .viewBgColor
        tblViewYogaList.delegate = self
        tblViewYogaList.dataSource = self
        self.tblViewYogaList.rowHeight = UITableView.automaticDimension
        self.tblViewYogaList.estimatedRowHeight = 110;
        searchYogaNames.backgroundImage = UIImage()
        searchYogaNames.delegate = self
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "ic_scan_nav")?.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: self,
                                             action: #selector(btnScanTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchYogaNames.resignFirstResponder()
    }
    private func registerNib(){
        tblViewYogaList.register(UINib(nibName: "YogaListCell", bundle: nil), forCellReuseIdentifier: "YogaListCell")
    }
}

//MARK: - Button actions -
extension YogaListVC{
    
    @objc func btnScanTapped(_ sender:UIButton){
        self.dismiss(animated: true)
    }
    
    @objc func buttonMoreTapped(_ sender: UIButton){
        yogaList[sender.tag].isExpanded = !(yogaList[sender.tag].isExpanded ?? false)
        DispatchQueue.main.async {
            self.tblViewYogaList.reloadData()
        }
    }
}

//MARK: - Table view delegate & data source methods -
extension YogaListVC: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yogaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YogaListCell", for: indexPath) as? YogaListCell
        cell?.configCell(yoga: yogaList[indexPath.row])
        cell?.buttonMore.tag = indexPath.row
        cell?.buttonMore.addTarget(self, action: #selector(buttonMoreTapped(_:)), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchYogaNames.resignFirstResponder()

        let vc = storyboard?.instantiateViewController(withIdentifier: "YogaBenefitsVC") as! YogaBenefitsVC
        vc.passioId = yogaList[indexPath.row].passioID ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

typealias searchBarDelegate = YogaListVC
extension searchBarDelegate: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            yogaList = allData
        } else {
            let searchData = yogaList.filter{$0.name!.lowercased().contains(searchText.lowercased())}
            yogaList = searchData
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchYogaNames.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchYogaNames.resignFirstResponder()
    }
}
