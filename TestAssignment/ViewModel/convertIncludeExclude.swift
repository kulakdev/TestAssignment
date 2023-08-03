//
//  convertIncludeExclude.swift
//  TestAssignment


import Foundation
import SwiftUI



func convertInclude(includes: String) -> String{
    var result: String = includes
    if includes != "" {
        let array = includes.split(whereSeparator: { $0.isWhitespace || $0.isPunctuation })
        let mutatedArr = array.map { "+\"\($0)\""  }
        result = mutatedArr.joined()
        return result
    }
    return ""
}

func convertExclude(excludes: String) -> String{
    var result: String = excludes
    if excludes != ""{
        let array = excludes.split(whereSeparator: { $0.isWhitespace || $0.isPunctuation })
        let mutatedArr = array.map { "-\"\($0)\"" }
        result = mutatedArr.joined()
        print(result)
        return result
    }
    return ""
}

struct ConvertIncludeExclude_Previews: PreviewProvider {
    @ObservedObject var viewModel: ArticleViewModel
    
    static var previews: some View {
        Button("click to run"){
            let something = convertInclude(includes: "hello world this is a string")
            print(something)
        }
    }
}
