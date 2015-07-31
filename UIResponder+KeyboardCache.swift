// UIResponder+KeyboardCache
//
// ObjectiveC version: Copyright (c) 2012 Brandon Williams (http://www.opetopic.com)
// Switf version: Copyright (c) 2015 Andrea Busi (http://www.bubidevs.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

var hasAlreadyCachedKeyboard = false

extension UIResponder {
    
    class func cacheKeyboard(onNextRunloop: Bool = false) {
        if !hasAlreadyCachedKeyboard {
            hasAlreadyCachedKeyboard = true
            if onNextRunloop {
                let time = dispatch_time(DISPATCH_TIME_NOW, 0)
                dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                    UIResponder.executeKeyboardCache()
                }
            } else {
                UIResponder.executeKeyboardCache()
            }
        }
    }
    
    private class func executeKeyboardCache() {
        let textField = UITextField()
        UIApplication.sharedApplication().windows.last?.addSubview(textField)
        textField.becomeFirstResponder()
        textField.resignFirstResponder()
        textField.removeFromSuperview()
    }
}