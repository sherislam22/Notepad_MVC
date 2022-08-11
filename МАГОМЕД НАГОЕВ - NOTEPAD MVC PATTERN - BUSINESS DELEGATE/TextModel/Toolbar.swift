import UIKit
class Toolbar: UIViewController {
    
    var goToRight: Bool = false
    
    func toolbar(textview: UITextView) {
        //print(goToRight)
        let toolBarWidth = view.frame.size.width
        let toolBarHeight = view.frame.size.height * 0.06
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: toolBarWidth, height: toolBarHeight))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        if goToRight == false {
            toolBar.items?.removeAll()
            let undo = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.backward.circle"), style: .plain, target: self, action: nil)
            let redo = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.forward.circle"), style: .plain, target: self, action: nil)
            let remove = UIBarButtonItem(image: UIImage(systemName: "trash.slash.circle"), style: .plain, target: self, action: nil)
            let replace = UIBarButtonItem(image: UIImage(systemName: "repeat.circle"), style: .plain, target: self, action: nil)
            let copy = UIBarButtonItem(image: UIImage(systemName: "doc.on.doc"), style: .plain, target: self, action: nil)
            let cut = UIBarButtonItem(image: UIImage(systemName: "scissors"), style: .plain, target: self, action: nil)
            let rightArrow = UIBarButtonItem(image: UIImage(systemName: "arrow.right.to.line"), style: .plain, target: self, action: #selector(rightArrowTapped))
            
            toolBar.items = [cut, flexibleSpace, remove, flexibleSpace, undo, flexibleSpace, redo, flexibleSpace, replace, flexibleSpace, copy, flexibleSpace, rightArrow]
            toolBar.layoutIfNeeded()
        } else {
            toolBar.items?.removeAll()
            let leftArrow = UIBarButtonItem(image: UIImage(systemName: "arrow.left.to.line"), style: .plain, target: self, action: #selector(leftArrowTapped))
            let find = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
            let goTo = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .plain, target: self, action: nil)
            let selectAll = UIBarButtonItem(image: UIImage(systemName: "rectangle.fill.badge.checkmark"), style: .plain, target: self, action: nil)
            let timeAndDate = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: nil)
            
            toolBar.items = [leftArrow, flexibleSpace, find, flexibleSpace, goTo, flexibleSpace, selectAll, flexibleSpace, timeAndDate, flexibleSpace]
            toolBar.layoutIfNeeded()

        }
        
        toolBar.sizeToFit()
        textview.inputAccessoryView = toolBar
    }
    
    @objc func rightArrowTapped(_ sender: UIButton) {
        goToRight = true
        print(goToRight)
        //toolbar(textview: TextViewer().textView)
    }
    
    @objc func leftArrowTapped(_ sender: UIButton) {
        goToRight = false
        //toolbar(textview: TextViewer().textView)
    }
}
