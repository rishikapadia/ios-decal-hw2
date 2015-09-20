//
//  KeyboardViewController.swift
//  CalKeyboard
//
//  Created by Gene Yoo on 9/15/15.
//  Copyright © 2015 iOS Decal. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var deleteKeyboardButton: UIButton!
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var returnKeyboardButton: UIButton!
    @IBOutlet var imagesKeyboardButtons: Array<UIButton>!
    
    var keyboardView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

    func loadInterface() {
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        keyboardView.frame = view.frame
        view.addSubview(keyboardView)
        view.backgroundColor = keyboardView.backgroundColor
        
        //control buttons
        deleteKeyboardButton.addTarget(self, action: "deleteChar", forControlEvents: .TouchUpInside)
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside) // advanceToNextInputMode is already defined in template
        returnKeyboardButton.addTarget(self, action: "returnChar", forControlEvents: .TouchUpInside)
        
        //add image buttons
        for img in imagesKeyboardButtons {
            img.addTarget(self, action: "keyTapped", forControlEvents: .TouchUpInside)
        }
    }
    
    func deleteChar(sender: AnyObject?) {
        textDocumentProxy.deleteBackward()
        //(textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    func returnChar(sender: AnyObject?) {
        textDocumentProxy.insertText("\n")
    }
    
    func keyTapped(sender: UIButton!) {
        (self.textDocumentProxy as UIKeyInput).insertText("Needs full access")
        return
        
        if (isOpenAccessGranted() == false) {
            // Prompt user to allow full access here.
            textDocumentProxy.insertText("Needs full access")
        }
        else {
            let file = "image\(sender.tag)"
            let image = UIImage(named:file as String)
            let data = NSData(data: UIImagePNGRepresentation(image!)!)
            UIPasteboard.generalPasteboard().setData(data, forPasteboardType: "public.png")
        }
    }

    func isOpenAccessGranted() -> Bool {
        return UIPasteboard.generalPasteboard().isKindOfClass(UIPasteboard)
    }


}
