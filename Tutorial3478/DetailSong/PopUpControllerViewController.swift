//
//  PopUpControllerViewController.swift
//  Tutorial3478
//
//  Created by Duy Thái on 16/12/2022.
//

import UIKit

final class PopUpControllerViewController: UIViewController {
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var popUpView: UIView!
    @IBOutlet private weak var noticeLabel: UILabel!
    
    private var newNotice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        self.showAnimate()
    }
    
    private func configView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popUpView.layer.cornerRadius = 12
        noticeLabel.text = newNotice
    }
    
    func setNotice(notice: String) {
        self.newNotice = notice
    }
    
    private func showAnimate() {
    self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    self.view.alpha = 0.0;
    UIView.animate(withDuration: 0.25, animations: {
        self.view.alpha = 1.0
        self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    });
    }
    
    @IBAction private func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    private func removeAnimate() {
    UIView.animate(withDuration: 0.25, animations: {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        
    }, completion:{(finished : Bool)  in
        if (finished)
        {
            self.view.removeFromSuperview()
        }
    });
    }
    
}
