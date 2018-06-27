//
//  ViewController.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/22.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
	// Variables:
	var darkMode = false
	@IBOutlet var textView: NSTextView!
	@IBOutlet var resultView: ResultView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textView.delegate = self
		//NotificationCenter.default.addObserver(self, selector: #selector(updateResultView), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
		textView.string = "{\n\t\"title\": \"Programmer Dvorak-CmdQwerty Keyboard\",\n\t\"rules\": [\n\t\t{\n\t\t\t\"description\": \"Remap keys to use Programmer Dvorak-CmdQwerty keyboard layout\",\n\t\t\t\"manipulators\": [\n<\t\t\t\t{\n\t\t\t\t\t\"type\": \"basic\",\n\t\t\t\t\t\"from\": {\n\t\t\t\t\t\t\"key_code\": (\"q\",\"w\",\"e\",\"r\",\"t\",\"y\",\"u\",\"i\",\"o\",\"p\",\"openb_racket\",\"close_bracket\",\"a\",\"s\",\"d\",\"f\",\"g\",\"h\",\"j\",\"k\",\"l\",\"semicolon\",\"quote\",\"z\",\"x\",\"c\",\"v\",\"b\",\"n\",\"m\",\"comma\",\"period\",\"slash\")\n\t\t\t\t\t},\n\t\t\t\t\t\"to\": [\n\t\t\t\t\t\t{\n\t\t\t\t\t\t\t\"key_code\": (\"quote\",\"comma\",\"period\",\"p\",\"y\",\"f\",\"g\",\"c\",\"r\",\"l\",\"slash\",\"equal_sign\",\"a\",\"o\",\"e\",\"u\",\"i\",\"d\",\"h\",\"t\",\"n\",\"s\",\"hyphen\",\"semicolon\",\"q\",\"j\",\"k\",\"x\",\"b\",\"m\",\"w\",\"v\",\"z\"),\n\t\t\t\t\t\t\t\"modifiers\": [\n\t\t\t\t\t\t\t\t\"left_shift\"\n\t\t\t\t\t\t\t]\n\t\t\t\t\t\t}\n\t\t\t\t\t]\n\t\t\t\t}>\n\t\t\t]\n\t\t}\n\t]\n}"
		updateResultView()
		setStyle(with: "Off")
		highlightBlocks()
		highlightParenthesis()
		let font = NSFont(name: "Monaco", size: 18)
		textView.font = font
		resultView.font = font
		//textView.textStorage?.addAttribute(NSAttributedStringKey.font, value: font ?? "", range: NSRange(location: 0, length: textView.string.count))
	}
	@IBAction func changeDarkMode (_ sender: NSMenuItem) {
		if sender.state == .on {
			darkMode = false
			sender.state = .off
			setStyle(with: "Off")
		} else {
			darkMode = true
			sender.state = .on
			setStyle(with: "On")
		}
		highlightBlocks()
		highlightParenthesis()
	}
	func setStyle(with string: String) {
		switch string {
		case "On":
			print("On")
			textView.backgroundColor = NSColor.black
			resultView.backgroundColor = NSColor.black
			textView.textColor = NSColor.lightGray
			resultView.textColor = NSColor.white
		case "Off":
			textView.backgroundColor = NSColor.white
			resultView.backgroundColor = NSColor.white
			textView.textColor = NSColor.gray
			resultView.textColor = NSColor.black
		default:
			break
		}
	}
	func textDidChange(_ notification: Notification) {
		updateResultView()
		highlightBlocks()
		highlightParenthesis()
	}
	func updateResultView() {
		let repeatBlock = Parser.findBlock(string: textView.string)
		if repeatBlock != "" {
			let blocks = Parser.findParenthesis(string: repeatBlock)
			if blocks != [] {
				parseText(string: repeatBlock)
			} else {
				resultView.string = textView.string
			}
		} else {
			resultView.string = textView.string
		}
	}
	func highlightBlocks() {
		let text = textView.string
		let matches = Parser.matches(for: "(\\<(.|\n)*\\>)", in: text)
		//let lightRed = NSColor.red.withAlphaComponent(0.3)
		for match in matches {
			let range = text.range(of: match)
			let nsRange = text.nsRange(from: range!)
			if darkMode == false {
				textView.textStorage?.addAttribute(NSAttributedStringKey.foregroundColor, value: NSColor.black, range: nsRange)
			} else {
				textView.textStorage?.addAttribute(NSAttributedStringKey.foregroundColor, value: NSColor.white, range: nsRange)
			}
		}
	}
	func highlightParenthesis() {
		let text = textView.string
		let matches = Parser.matches(for: "\\((.*?)\\)", in: text)
		let lightYellow = NSColor.init(hue: 0.2, saturation: 0.4, brightness: 1, alpha: 0.3)
		for match in matches {
			let range = text.range(of: match)
			let nsRange = text.nsRange(from: range!)
			if darkMode == false {
				textView.textStorage?.addAttribute(NSAttributedStringKey.foregroundColor, value: NSColor.blue, range: nsRange)
				textView.insertionPointColor = NSColor.black
			} else {
				textView.textStorage?.addAttribute(NSAttributedStringKey.foregroundColor, value: NSColor.yellow, range: nsRange)
				textView.insertionPointColor = NSColor.white
			}
		}
	}
	override func keyUp(with event: NSEvent) {
		//updateResultView()
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	func parseText(string: String) {
		let text = string
		let beforeBlock = Parser.findBeforeBlock(string: textView.string)
		let afterBlock = Parser.findAfterBlock(string: textView.string)
		let blocks = Parser.findParenthesis(string: text)
		let arrays = Parser.separatebyCommas(array: blocks)
		// Rearrange array
		var pairArray = [String]()
		var rearrangedArray = [[String]]()
		for index1 in 0..<arrays[0].count {
			for index2 in 0..<arrays.count {
				if arrays.indices.contains(index2) {
					if arrays[index2].indices.contains(index1) {
						pairArray.append(arrays[index2][index1])
					}
				}
			}
			rearrangedArray.append(pairArray)
			pairArray.removeAll()
		}
		// Redo code:
		let count = arrays[0].count
		var codeText = ""
		for index in 0..<count {
			// Replacing parenthesis:
			var text = Parser.replaceParenthesisWithStrings(string: text, regexpArray: rearrangedArray[index])
			if index != (count - 1) {
				text = "\(text),"
			}
			codeText.append("\(text)\n")
		}
		resultView.string = beforeBlock + codeText + afterBlock
	}

}

extension String {
	func nsRange(from range: Range<String.Index>) -> NSRange {
		let startPos = self.distance(from: self.startIndex, to: range.lowerBound)
		let endPos = self.distance(from: self.startIndex, to: range.upperBound)
		return NSMakeRange(startPos, endPos - startPos)
	}
}

