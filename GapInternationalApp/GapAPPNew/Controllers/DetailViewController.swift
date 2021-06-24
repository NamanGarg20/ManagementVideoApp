//
//  DetailViewController.swift
//  GapApp
//
//  Created by NAMAN GARG on 6/18/21.
//

import UIKit
import AVKit


class DetailViewController: UIViewController {
    var login = true
    var username = ""
    var comment = Comment()
    var completion:Completion?
//    var comments = [JournalElement]()
    @IBOutlet var playerView: UIView!
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    var currentTime = String()
    
    @IBOutlet var chapterLabel: UILabel!
    
    var Name: String?{
        didSet{
            configureVideo()
        }
    }
    
    var nUrl: String?{
        didSet{
            configureVideo()
        }
    }
    
    var chapterPlist = [[String:String]]()
    
    func configureVideo(){
        
        if let url = nUrl, let name = Name{
            chapterLabel.text = name
            setPlayer(url)
        }
    }
    
    func setPlayer(_ url: String){
        let videoUrl = URL(string: url)
        player = AVPlayer(url: videoUrl!)
        playerViewController = AVPlayerViewController()
        playerViewController.showsPlaybackControls = true
        playerViewController.player = player
        playerViewController.view.frame = playerView.bounds
        playerViewController.view.frame.size.height = playerView.frame.size.height
        playerViewController.view.frame.size.width = playerView.frame.size.width
        
        
        playerView.addSubview(playerViewController.view)
    }
    
    func showAlert(){
        let res = "\(completion?.result! ?? "None")"
        if res.contains("Success"){
            let alert = UIAlertController(title: "Success", message: "Saved to Journal", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) {
                action -> Void in
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: res, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) {
                action -> Void in
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func videoDidEnd(){
        let alert = UIAlertController(title: "Comment", message: "Enter Comment", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textfield) in})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in
            let savedAlert = (alert.textFields?.first)! as UITextField
            self.comment.addComment(self.username, self.Name!, savedAlert.text!){ [weak self] result in
                self?.completion = result
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureVideo()
        navigationItem.leftBarButtonItem?.title = ""
        navigationItem.backButtonTitle = ""
        let chapter = Chapters()
        chapterPlist = chapter.getChapters()
        Name = chapterPlist[0]["name"]
        nUrl = chapterPlist[0]["url"]
        setPlayer(nUrl!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name:
        NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.backButtonTitle = ""
        configureVideo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let commentView = segue.destination as! CommentTableViewController
        commentView.user = username
    }
    
    @IBAction func showJournal(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showJournal", sender: self)
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        let scene = self.view.window?.windowScene?.delegate as? SceneDelegate
        scene?.openLoginView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DetailViewController: chapterDelegate{
    
    func selectChapter(_ url: String, _ name: String) {
        nUrl = url
        Name = name
    }
}
