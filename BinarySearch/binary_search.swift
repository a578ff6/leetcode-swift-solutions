// LeetCode #704 - Binary Search

// MARK: - 解法一：使用 Binary Search 快速查找目標值
class Solution {
    
    /// 在已排序的整數陣列中搜尋 target，找到就回傳 index，否則回傳 -1
    func search(_ nums: [Int], _ target: Int) -> Int {
        
        // 初始化左右邊界
        var left = 0
        var right = nums.count - 1
        
        // 當搜尋範圍還有效（left 沒有超過 right）
        while left <= right {
            
            // 每次都從目前區間的中間值開始比對
            let mid = (left + right) / 2
            
            // 若中間的值剛好等於 target，直接回傳該 index
            if nums[mid] == target {
                return mid
            }
            // 若中間的值小於 target，表示答案在右邊 → 更新左界
            else if nums[mid] < target {
                left = mid + 1
            }
            // 若中間的值大於 target，表示答案在左邊 → 更新右界
            else {
                right = mid - 1
            }
        }
        
        // 如果全部比完都沒找到，代表 target 不存在 → 回傳 -1
        return -1
    }
    
}


// MARK: - 測試

let solution = Solution()

print(solution.search([-1, 0, 3, 5, 9, 12], 9))   // ➜ 4
print(solution.search([-1, 0, 3, 5, 9, 12], 2))   // ➜ -1
print(solution.search([1], 1))                   // ➜ 0
print(solution.search([1], 0))                   // ➜ -1
print(solution.search([2, 4, 6, 8, 10], 6))       // ➜ 2

