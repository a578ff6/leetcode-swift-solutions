// LeetCode #283 - Move Zeroes

// MARK: - 解法一：使用 Two Pointers 將非零元素往前搬
class Solution {
    
    /// 將陣列中的所有 0 移到最後面，保持非零元素順序，並在原地完成操作
    func moveZeroes(_ nums: inout [Int]) {
        
        // 指標：記錄下個非零元素應該放的位置
        var lastNonZeroIndex = 0
        
        // 把所有非 0 元素往前搬，更新下一個非零元素應該放的位置
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums[lastNonZeroIndex] = nums[i]
                lastNonZeroIndex += 1
            }
        }
        
        // 把剩下的位置補成 0
        for i in lastNonZeroIndex..<nums.count {
            nums[i] = 0
        }
        
    }
}

// MARK: - 測試一
var nums = [0, 1, 0, 3, 12]
let solution = Solution()

solution.moveZeroes(&nums)
print(nums)  // ➝ [1, 3, 12, 0, 0]