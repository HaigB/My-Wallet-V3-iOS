//
//  SecondPasswordViewController.swift
//  Blockchain
//
//  Created by Sjors Provoost on 18-06-15.
//  Copyright (c) 2015 Qkos Services Ltd. All rights reserved.
//

import UIKit

protocol SecondPasswordDelegate {
    func didGetSecondPassword(String)
}

class SecondPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar?
    @IBOutlet weak var password: UITextField?
    @IBOutlet weak var wrongPassword: UILabel?
    
    var wallet : Wallet?

    
    var delegate : SecondPasswordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar!.backgroundColor = UIColor.blueColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done(sender: UIButton) {
        checkSecondPassword()
    }
    
    @IBAction func close(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("unwindSecondPasswordCancel", sender: self)
    }
    
    func checkSecondPassword() {
        let secondPassword = password!.text
        if wallet!.validateSecondPassword(secondPassword) {
            delegate?.didGetSecondPassword(secondPassword)
            self.performSegueWithIdentifier("unwindSecondPasswordSuccess", sender: self)
        } else {
            wrongPassword?.hidden = false
        }
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        wrongPassword?.hidden = true
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        checkSecondPassword()
        return true
    }
    
}