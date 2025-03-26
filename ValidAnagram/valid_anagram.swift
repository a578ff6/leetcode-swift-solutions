// LeetCode #242 - Valid Anagram

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            false
        }
        
        let sortedS = s.sorted()
        let sortedT = t.sorted()
        
        return sortedS == sortedT
    }
}
