//
//  VideoVC.swift
//  PartyRockApp
//
//  Created by Maury on 7/05/22.
//

import UIKit

class VideoVC: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var titleLabelInVideo: UILabel!
    private var partyRockVideo: PartyRock!
    
    var partyRockV: PartyRock {
        get {
            return partyRockVideo
        } set {
            partyRockVideo = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabelInVideo.text = partyRockVideo.videoTitle1
        webView.loadHTMLString(partyRockVideo.videoURL1, baseURL: nil)
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
