//
//  MasterTableViewController.swift
//  GapApp
//
//  Created by NAMAN GARG on 6/17/21.
//

import UIKit

protocol chapterDelegate {
    //func selectChapter(_ chapter: Chapters, _ index: Int)
    func selectChapter(_ url: String, _ name: String)
}

class MasterTableViewController: UITableViewController {
    var username = ""
    let chapter = Chapters()
    var chapterPlist = [[String:String]]()
    var delegate:chapterDelegate?
    
    let comment = Comment()
    var comments = [JournalElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterPlist = chapter.getChapters()
        navigationItem.backButtonTitle = ""
        navigationItem.title = ""
        getComments()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getComments(){
        let journal = Comment()
        journal.showComment(username){ [weak self] result in
            self?.comments = result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chapterPlist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! TableViewCell
        
        cell.chapterLabel.text = chapterPlist[indexPath.row]["name"]!
        if indexPath.row <= comments.count{
            cell.chapterLabel.tintColor = UIColor.red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUrl = chapterPlist[indexPath.row]["url"]!
        let selectedName = chapterPlist[indexPath.row]["name"]!
        let journal = Comment()
        journal.showComment(username){ [weak self] result in
            self?.comments = result
            DispatchQueue.main.async { [self] in
                self?.tableView.reloadData()
                if (self?.comments.count)! >= indexPath.row {
                    self?.delegate?.selectChapter(selectedUrl, selectedName)
                    if let detailVC = self?.delegate as? DetailViewController,
                       let NavVC = detailVC.navigationController{
                        self?.splitViewController?.showDetailViewController(NavVC, sender: nil)
                    }
                }
                else{
                    tableView.deselectRow(at: indexPath, animated: true)
                    self?.showAlert()
                }
            }
        }
        
   }
    
    func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "Cannot watch next Video", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "Ok", style: .default, handler: {action -> Void in
            
        })
        
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
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
