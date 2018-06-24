//
//  ViewController.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/22.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet var textView: NSTextView!
	@IBOutlet var resultView: ResultView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textView.string = "{\n\t\"title\": \"Programmer Dvorak-CmdQwerty Keyboard\",\n\t\"rules\": [\n\t\t{\n\t\t\t\"description\": \"Remap keys to use Programmer Dvorak-CmdQwerty keyboard layout\",\n\t\t\t\"manipulators\": [\n<\t\t\t\t{\n\t\t\t\t\t\"type\": \"basic\",\n\t\t\t\t\t\"from\": {\n\t\t\t\t\t\t\"key_code\": (\"q\",\"w\",\"e\",\"r\",\"t\",\"y\",\"u\",\"i\",\"o\",\"p\",\"openb_racket\",\"close_bracket\",\"a\",\"s\",\"d\",\"f\",\"g\",\"h\",\"j\",\"k\",\"l\",\"semicolon\",\"quote\",\"z\",\"x\",\"c\",\"v\",\"b\",\"n\",\"m\",\"comma\",\"period\",\"slash\")\n\t\t\t\t\t},\n\t\t\t\t\t\"to\": [\n\t\t\t\t\t\t{\n\t\t\t\t\t\t\t\"key_code\": (\"quote\",\"comma\",\"period\",\"p\",\"y\",\"f\",\"g\",\"c\",\"r\",\"l\",\"slash\",\"equal_sign\",\"a\",\"o\",\"e\",\"u\",\"i\",\"d\",\"h\",\"t\",\"n\",\"s\",\"hyphen\",\"semicolon\",\"q\",\"j\",\"k\",\"x\",\"b\",\"m\",\"w\",\"v\",\"z\"),\n\t\t\t\t\t\t\t\"modifiers\": [\n\t\t\t\t\t\t\t\t\"left_shift\"\n\t\t\t\t\t\t\t]\n\t\t\t\t\t\t}\n\t\t\t\t\t]\n\t\t\t\t}>\n\t\t\t]\n\t\t}\n\t]\n}"
		NSEvent.addLocalMonitorForEvents(matching: .keyUp) {
			self.keyDown(with: $0)
			return $0
		}
		// Do any additional setup after loading the view.
	}
	
	
	override func keyUp(with event: NSEvent) {
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

