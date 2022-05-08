//
//  ViewController.swift
//  PartyRockApp
//
//  Created by Maury on 7/05/22.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var partyRock = [PartyRock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 = PartyRock(imageURL1: "https://lastfm.freetls.fastly.net/i/u/770x0/2d79a7a7b1ab3005bfa75cd1bbcd9066.jpg", videoURL1: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/SkTt9k4Y-a8\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>", videoTitle1: "LMFAO - Sorry For Party Rocking")
        let p2 = PartyRock(imageURL1: "https://static.wikia.nocookie.net/electropedia/images/b/b7/Redfoo-Let%27s-Get-Ridiculous.jpg/revision/latest?cb=20170621132513&path-prefix=es", videoURL1: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/CdLhdrNgGu4\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>", videoTitle1: "Redfoo - Let's Get Ridiculous")
        let p3 = PartyRock(imageURL1: "https://www.lahiguera.net/musicalia/artistas/varios/disco/6650/tema/8306/redfoo_new_thang-portada.jpg", videoURL1: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/xGiBiHocSZM\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>", videoTitle1: "Redfoo - New Thang")
        let p4 = PartyRock(imageURL1: "https://static.wikia.nocookie.net/electropedia/images/f/f6/Party_Rock_Anthem.jpg/revision/latest?cb=20170608002548&path-prefix=es", videoURL1: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/KQ6zr6kCPj8\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>", videoTitle1: "LMFAO - Party Rock Anthem")
        let p5 = PartyRock(imageURL1: "https://m.media-amazon.com/images/I/71Ao6QIbvRL._SX522_.jpg", videoURL1: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/wyx6JDQCslE\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>", videoTitle1: "LMFAO - Sexy and I Know It")
        
        partyRock.append(p1)
        partyRock.append(p2)
        partyRock.append(p3)
        partyRock.append(p4)
        partyRock.append(p5)
        
        // Delegacion de TableView al MainVC
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    // Funciones obligatorias UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyCell {
            let partyRock = partyRock[indexPath.row]
            cell.updateUI(partyRock: partyRock)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRock.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let partyRock = partyRock[indexPath.row]
        
        performSegue(withIdentifier: "VideoVC", sender: partyRock)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoVC {
            if let party = sender as? PartyRock {
                destination.partyRockV = party
            }
        }
    }

}

