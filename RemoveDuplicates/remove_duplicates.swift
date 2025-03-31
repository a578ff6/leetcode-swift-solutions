// LeetCode #26 - Remove Duplicates from Sorted Array

// MARK: - 解法一：雙指標法（Two Pointers）
class Solution {
    
    // 原地移除排序陣列中的重複元素，回傳不重複的長度
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        
        // 如果陣列為空，直接回傳 0
        if nums.isEmpty {
            return 0
        }
        
        // i 指向最後一個不重複元素的位置（初始為第 0 個）
        var i = 0
        
        // 從第二個元素開始走訪
        for j in 1..<nums.count {
            
            // 當前數字和目前「最後的不重複數字」不同 → 發現新數字
            // 往前移動 i 的位置
            // 更新 nums[i] 為新找到的不重複元素
            if nums[j] != nums[i] {
                i += 1
                nums[i] = nums[j]
            }
        }
        
        // 回傳不重複元素的數量（因為 index 是從 0 開始，所以 +1）
        return i + 1
    }
}

// MARK: - 測試
let solution = Solution()

var nums1 = [1,1,2]
print(solution.removeDuplicates(&nums1))    // 2

var nums2 = [0,0,1,1,1,2,2,3,3,4]
print(solution.removeDuplicates(&nums2))   // 5