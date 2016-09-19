//
//  RegExtension.swift
//  SaaSPro
//
//  Created by Stepan Maksymov on 11/27/15.
//  Copyright © 2015 Buena Digital. All rights reserved.
//

import Foundation

struct RegExtension {
    var pattern: String {
        didSet {
            updateRegex()
        }
    }
    var expressionOptions: NSRegularExpressionOptions {
        didSet {
            updateRegex()
        }
    }
    var matchingOptions: NSMatchingOptions
    
    var regex: NSRegularExpression?
    
    init(pattern: String, expressionOptions: NSRegularExpressionOptions, matchingOptions: NSMatchingOptions) {
        self.pattern = pattern
        self.expressionOptions = expressionOptions
        self.matchingOptions = matchingOptions
        updateRegex()
    }
    
    init(pattern: String) {
        self.pattern = pattern
        expressionOptions = NSRegularExpressionOptions(rawValue: 0)
        matchingOptions = NSMatchingOptions(rawValue: 0)
        updateRegex()
    }
    
    mutating func updateRegex() {
        self.regex = try? NSRegularExpression(pattern: pattern, options: expressionOptions)
    }
}


extension String {
    func matchRegex(pattern: RegExtension) -> Bool {
        let range: NSRange = NSMakeRange(0, self.characters.count)
        if pattern.regex != nil {
            let matches: [AnyObject] = pattern.regex!.matchesInString(self, options: pattern.matchingOptions, range: range)
            return matches.count > 0
        }
        return false
    }
    
    func match(patternString: String) -> Bool {
        return self.matchRegex(RegExtension(pattern: patternString))
    }
    
    func matchesForRegexInText(regex: String!) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            let results = regex.matchesInString(self,
                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func matchesForRegexInTextAll(regex: String!) -> [[String]] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            
            var resultsFinal = [[String]]()
            
            let results = regex.matchesInString(self,
                options: [], range: NSMakeRange(0, nsString.length))
            
            for result in results {
                var internalString = [String]()
                for var i = 0; i < result.numberOfRanges; ++i{
                    internalString.append(nsString.substringWithRange(result.rangeAtIndex(i)))
                }
                resultsFinal.append(internalString)
            }
            
            return resultsFinal
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
    
    func replaceRegex(pattern: RegExtension, template: String) -> String {
        if self.matchRegex(pattern) {
            let range: NSRange = NSMakeRange(0, self.characters.count)
            if pattern.regex != nil {
                return pattern.regex!.stringByReplacingMatchesInString(self, options: pattern.matchingOptions, range: range, withTemplate: template)
            }
        }
        return self
    }
    
    func replace(pattern: String, template: String) -> String {
        return self.replaceRegex(RegExtension(pattern: pattern), template: template)
    }
}