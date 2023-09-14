//
//  GetFirstConsonant.swift
//  iClone_Clock
//
//  Created by hyunjun on 2023/08/21.
//

import Foundation

let hangulConsonant = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]

/// 첫 모음을 가져오는 함수
/// - Parameter word: 검색어
/// - Returns: 해당 한글 단어의 첫 모음
func getFirstConsonant(word: String) -> String {
    let unicode = word.unicodeScalars[word.unicodeScalars.startIndex].value

    /// 한글임을 판별
    if 44032...55203 ~= unicode {
        let index = (unicode - 0xac00) / 28 / 21
        return hangulConsonant[Int(index)]
    }
    
    return "nil"
}
