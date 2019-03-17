//
//  ViewController.swift
//  06-WebScrapping
//
//  Created by Walter gomez on 2/27/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UICollectionViewController {
    //specific name, because is probable use URL for more variables
    let urlName = "https://www.apple.com/itunes/charts/songs/"//"http://juangabrielgomila.com/"
    var factory : SongsFactory!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Use the factory
        //subcribe a notificacion
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadItemsInCollectionView), name: NSNotification.Name("songsUpdated"), object: nil)
        factory = SongsFactory(songsUrl: urlName)
        
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return factory.songs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "songCell", for: indexPath) as! SongCell
        cell.labelSong.text = factory.songs[indexPath.row].title
        cell.labelAuthor.text = factory.songs[indexPath.row].authorName
        cell.imageViewSong.downloadedFrom(link: factory.songs[indexPath.row].imgUrl)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: factory.songs[indexPath.row].imgUrl){
            //MASTER METHOD for IOS Devices
            UIApplication.shared.open(url, options: [:]) { (success) in
                print("Hemos ido a la cancion \(factory.songs[indexPath.row].title)")
            }
        }
    }
    //@objc obligatory for notifications.
    @objc func reloadItemsInCollectionView() {
        //variable unique in UICollectionViewController
        self.collectionView.reloadData()
    }
}

