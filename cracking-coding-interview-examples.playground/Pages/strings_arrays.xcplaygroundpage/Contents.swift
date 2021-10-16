/*2. Check Permutation: Given two strings,write a method to decide if one is a permutation of the
 other.
 */

//SOLUTION 1: O(n)

func twoStringsPermutation(_ str1: String, _ str2: String) -> Bool {
    var string1Dict = [Character : Int]()
    var string2Dict = [Character : Int]()
    guard str1.count == str2.count else {
        return false
    }
    for char in str1 {
        if let charCounter = string1Dict[char] {
            string1Dict[char]! += 1
        } else {
            string1Dict[char] = 0
        }
    }
    for char in str2 {
        if let charCounter = string2Dict[char] {
            string2Dict[char]! += 1
        } else {
            string2Dict[char] = 0
        }
    }
    for char in str2 {
        if string1Dict[char] != string2Dict[char] {return false}
    }
    return true
}


twoStringsPermutation("hola", "hola  ")

/*3 URLify: Write a method to replace all spaces in a string with '%20'. You may assume that the string has sufficient space at the end to hold the additional characters, and that you are given the "true" length of the string. (Note: if implementing in Java, please use a character array so that you can perform this operation in place.)
 EXAMPLE
 Input: "Mr John Smith ", 13 . Output: "Mr%20John%20Smith"
 */

func URLify(_ string: String) -> String {
    var urlifyString = string
    var aux: Character?
    var carry1: Character? = nil
    var carry2: Character? = nil
    for (index, char) in urlifyString.enumerated() {
        if (index > 0 && urlifyString[urlifyString.index(urlifyString.startIndex, offsetBy: index)] != "2") {
            if (carry1 != nil) {
               // print(char)
                aux = char
                urlifyString.remove(at: urlifyString.index(urlifyString.startIndex, offsetBy:index))
                urlifyString.insert(carry1!, at: urlifyString.index(urlifyString.startIndex, offsetBy:index))
                
                if (carry2 != nil) {
                    carry1 = carry2
                    carry2 = aux
                }
                else {
                    carry1 = aux
                }
            }
            if urlifyString[urlifyString.index(urlifyString.startIndex, offsetBy: index)] == " " {
                urlifyString.remove(at: urlifyString.index(urlifyString.startIndex, offsetBy:index))
                urlifyString.insert(contentsOf: "%", at: urlifyString.index(urlifyString.startIndex, offsetBy:index))
                aux = urlifyString[string.index(urlifyString.startIndex, offsetBy: index + 1)]
                urlifyString.remove(at: urlifyString.index(urlifyString.startIndex, offsetBy:index + 1))
                urlifyString.insert(contentsOf: "2", at: urlifyString.index(urlifyString.startIndex, offsetBy:index + 1))
                if (carry1 != nil) {
                    carry2 = aux
                } else {
                    carry1 = aux
                }
            }
        }
    }
    return urlifyString
}

URLify("Mr John Smith    ")

/*4. Palindrome Permutation: Given a string, write a function to check if it is a permutation of a palindrome. A palindrome is a word or phrase that is the same forwards and backwards. A permutation is a rearrangement of letters. The palindrome does not need to be limited to just dictionary words.
 EXAMPLE
 Input: Tact Coa
 Output: True (permutations: "taco cat'; "atc o eta·; etc.)
 */


func palindromePermutation(_ string: String) -> Bool {
    var map: [Character: Int] = [:]
    var isOdd = false
        for character in string {
            if character != Character(" ") {
            var charLowercased = Character(character.lowercased())
            if let counter = map[charLowercased] {
                map[charLowercased]! += 1
            } else {
                map[charLowercased] = 1
            }
        }
    }
    for (type, counter) in map {
        guard counter % 2 == 0 || !isOdd else {
            return false
        }
        if (counter % 2 != 0 && !isOdd) {
            isOdd = true
        }
    }
    return true
}

palindromePermutation("Tact Coa")

/*5. One Away: There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.
 EXAMPLE
 pale, ple -> true
 pales, pale -> true
 pale, bale -> true
 pale, bae -> false
 */

//O(n)

func oneAway(str1: String, str2: String) -> Bool {
    var variations = 0
    //1. Check length
    if (str1.count == str2.count - 1 || str1.count == str2.count + 1) {
        variations += 1
    } else if str1.count != str2.count {
        return false
    }
    //2. Check characters
    var length = str1.count < str2.count ? str1.count : str2.count
    for (index, value) in [0..<length].enumerated() {
        if (str1[str1.index(str1.startIndex, offsetBy:index)] != str2[str1.index(str1.startIndex, offsetBy:index)]) {
            variations += 1
        }
        guard variations == 0 || variations == 1 else {
            return false
        }
    }
    return true
}

oneAway(str1: "pale",str2: "bae")


/*6. String Compression: Implement a method to perform basic string compression using the counts of repeated characters. For example, the string aabcccccaaa would become a2blc5a3. If the "compressed" string would not become smaller than the original string, your method should return the original string. You can assume the string has only uppercase and lowercase letters (a - z).
 */

func stringCompression(_ string: String) -> String {
    var numberOfUniqueChars = 0
    for (index, char) in string.enumerated() where index != 0 {
        if char != string[string.index(string.startIndex, offsetBy: index - 1)] {
            numberOfUniqueChars += 1
        }
    }
    if numberOfUniqueChars * 2 < string.count {
        return compressString(string)
    } else {
        return string
    }
}

func compressString(_ string: String) -> String {
    var compressed = ""
    var counter = 0
    var current: Character? = nil
    for char in string {
        if char != current {
            if current != nil {
                compressed += "\(current!)\(counter)"
            }
            current = char
            counter = 1
        } else {
            counter += 1
        }
    }
    compressed += "\(current!)\(counter)"
    return compressed
}

stringCompression("aabcccccaaa")


/*8. Zero Matrix: Write an algorithm such that if an element in an MxN matrix is 0, its entire row and column are set to 0. O(n^2)
 */

func zeromatrix (_ matrix: inout [[Int]]) -> [[Int]] {
    var i = 0
    var j = 0
    while i < matrix.count - 1 {
        while j < matrix[0].count - 1 {
            if matrix[i][j] == 0 {
                //1.set col to x
                setToXCol(&matrix, col: j)
                //2. set row to x
                setToXRow(&matrix, row: i)
            }
        }
    }
    convertToZero(&matrix)
    return matrix
}

func setToXCol(_ matrix: inout [[Int]], col: Int) {
    var i = 0
    while i < matrix.count - 1 {
        matrix[i][col] = -1
        i += 1
    }
}

func setToXRow(_ matrix: inout [[Int]], row: Int) {
    var i = 0
    while i < matrix[0].count - 1 {
        matrix[row][i] = -1
        i += 1
    }
}

func convertToZero(_ matrix: inout [[Int]]) {
    var i = 0
    var j = 0
    while i < matrix.count - 1 {
        while j < matrix[0].count - 1 {
            if matrix[i][j] == -1 {
                matrix[i][j] = 0
            }
        }
    }
}

/* StringRotation:Assumeyouhaveamethod iSubString whichchecksifonewordisasubstring of another. Given two strings, 51 and 52, write code to check if 52 is a rotation of 51 using only one call to i5Sub5tring (e.g., "waterbottle" is a rotation of" erbottlewat").
*/

func StringRotation(s1: String, s2: String) -> Bool {
   // return iSubString("\(s2)\(s2)")
    return true
}

