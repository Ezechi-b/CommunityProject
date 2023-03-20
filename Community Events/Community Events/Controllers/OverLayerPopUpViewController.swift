//
//  OverLayerPopUpViewController.swift
//  Community Events
//
//  Created by Blake Ezechi on 16/03/2023.
//

import UIKit

class OverLayerPopUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var subTitleTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func doneAction(_ sender: UIButton) {
        hide()
    }
    
    init() {
        super.init(nibName: "OverLayerPopUpViewController", bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subTitleTextField.delegate = self
        titleTextField.delegate = self
        configView()
    }


    func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(titleTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.text = ""
        subTitleTextField.text = ""
    }

}
