import UIKit

var greeting = "Hello, playground"

let boldText = NSAttributedString(string: "Bold text", attributes: [.font: UIFont.boldSystemFont(ofSize: 25)])
let unboldText = remove(effects: .bold, on: boldText, range: boldText.fullRange)
let italicText = NSAttributedString(string: "Italic text", attributes: [.font: UIFont.italicSystemFont(ofSize: 25)])
let unItalicText = remove(effects: .italic, on: italicText, range: italicText.fullRange)
let underlineText = NSAttributedString(string: "Underline text", attributes: [.underlineStyle: 1])
let unUnderlineText = remove(effects: .underline, on: underlineText, range: underlineText.fullRange)
let strikethroughText = NSAttributedString(string: "Strikethrough text", attributes: [.strikethroughStyle: 2])
let unStrikethroughText = remove(effects: .strikethrough, on: strikethroughText, range: strikethroughText.fullRange)

let attributedStrings = [boldText, unboldText, italicText, unItalicText, underlineText, unUnderlineText, strikethroughText, unStrikethroughText]

let fullAttributedString = attributedStrings.reduce(into: NSMutableAttributedString()) {
    $0.append(NSAttributedString(string: "\n"))
    $0.append($1)
}

//The following test is to ensure that if there are other effects on the `NSAttributedString`, they aren't removed.

let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
textView.backgroundColor = .yellow
textView.attributedText = fullAttributedString
textView
textView.attributedText = remove(effects: .bold, on: fullAttributedString, range: fullAttributedString.fullRange)
textView
textView.attributedText = remove(effects: .italic, on: fullAttributedString, range: fullAttributedString.fullRange)
textView
textView.attributedText = remove(effects: .underline, on: fullAttributedString, range: fullAttributedString.fullRange)
textView
textView.attributedText = remove(effects: .strikethrough, on: fullAttributedString, range: fullAttributedString.fullRange)
textView
