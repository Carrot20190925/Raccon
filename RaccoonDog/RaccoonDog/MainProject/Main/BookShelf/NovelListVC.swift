//
//  NovelListVC.swift
//  RaccoonDog
//
//  Created by carrot on 25/12/2019.
//  Copyright © 2019 carrot. All rights reserved.
//

import UIKit

class NovelListVC: BaseTableController {

    var bookItem : BookShelfModel?
    var readModel : ReadModel?
    var seletedChapter : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.register(BaseTableCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 44;
        self.loadData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return readModel?.listModels.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BaseTableCell
        cell.textLabel?.text = readModel?.listModels[indexPath.row].chapter_title
        if readModel?.currentReadModel.index.intValue == indexPath.row {
            cell.textLabel?.textColor = TXTheme.secondColor()
        }else{
            cell.textLabel?.textColor = TXTheme.fifthColor()

        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let readModel = self.readModel else {
            return
        }
        if indexPath.row != readModel.currentReadModel.index.intValue {
            if var read = readModel.listModels[readModel.currentReadModel.index.intValue] as? NovelChapterModel{
                read.isCurrentRead = false
                read.save()
                read = readModel.listModels[indexPath.row]
                read.isCurrentRead = true
                read.isRead = true
                read.save()
                let currentModel = ParserReadModel.getModel(url: read.chapter_content, chapter_no: read.chapter_no, novel_id: read.novel_id, title: read.chapter_title)
                currentModel.index = NSNumber.init(value: indexPath.row) 
                readModel.currentReadModel =  currentModel

            }
        }
        
        
        if let _ = self.bookItem {
            if readModel.currentReadModel.pageModels.count > 0 {
                let readvc = ReadVC.init()
                readvc.readModel = readModel
                self.navigationController?.pushViewController(readvc, animated: true)
            }else{
                
                if let urlString = self.readModel?.currentReadModel.url{
                    RDBookNetManager.novelChapterContentNetWork(url:RD_Content_Server + urlString, success: {[weak self] (response) in
                        if let content = response as? String{
                            let readvc = ReadVC.init()
                            readvc.readModel = readModel
                            self?.readModel?.currentReadModel.setFullText(fullText: content)
                            self?.navigationController?.pushViewController(readvc, animated: true)
                        }
                        MyLog(response)
                        
                    }) { (error) in
                        MyLog(error)
                    }
                }
            }

        }else{
            
                 ///来自阅读器
            if readModel.currentReadModel.pageModels.count > 0 {
                self.seletedChapter?()
            }else{
                
                if let urlString = self.readModel?.currentReadModel.url{
                    RDBookNetManager.novelChapterContentNetWork(url:RD_Content_Server + urlString, success: {[weak self] (response) in
                        if let content = response as? String{
                            self?.readModel?.currentReadModel.setFullText(fullText: content)
                            self?.seletedChapter?()
                        }
                        MyLog(response)
                        
                    }) { (error) in
                        MyLog(error)
                    }
                }
            }
       
    
            
        }
        

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






extension NovelListVC{
    
    func loadData() {
        if self.readModel != nil{
            self.tableView.reloadData()
            return
        }
        guard let item = self.bookItem else {
            return
        }
        readModel = ReadModel.init(book_uuid: item.book_uuid)
        readModel?.bookName = self.bookItem?.title
        readModel?.bookAuthor = self.bookItem?.author
        if let items = RD_DBManager.getSyncNovelList(novel_id: item.book_uuid),items.count > 0{
            self.setupData(data: items)
        }else{
            
            RDBookNetManager.novelChapterNetWork(novel_id: item.book_uuid, success: {[weak self] (response) in
                guard let weakSelf = self else{
                    return
                }
                if let model = BaseModel.getModel(data: response),model.code == 200,let item = model.data as? Dictionary<String,Any>{
                    let datas = item["data"]
                    weakSelf.setupData(data: datas)
                    RD_DBManager.share.updateNovelList(data: datas)
                }
                MyLog(response)

            }) { (error) in
                MyLog(error)
            }

        }
//        RD_DBManager.getNovelList(novel_id: item.id) {[weak self] (data) in
//            guard let weakSelf = self else{
//                return
//            }
//
//            if let items = data as? Array<Any>{
//                weakSelf.setupData(data: items)
//            }else{
//            }
//        }
    }
    
    
    func setupData(data : Any?) {
        var models : [NovelChapterModel] = []
        if let items = data as? Array<Any> {
            for item in items {
                guard let model = NovelChapterModel.getModel(data: item)  else {
                    continue
                }
                models.append(model)
            }
            readModel?.setListModels(models: models)
            self.tableView.reloadData()
        }

    }

}
