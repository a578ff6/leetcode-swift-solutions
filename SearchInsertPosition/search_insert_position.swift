// LeetCode #35 - Search Insert Position

// MARK: - 解法一：暴力法（線性走訪）
// 逐一走訪陣列，找到第一個大於等於 target 的位置
class SolutionOne {
    
    /// 給定已排序陣列 nums 與一個 target，回傳 target 應該插入在 nums 中的 index
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        
        // 逐一檢查 nums 中的元素
        for i in 0..<nums.count {
            
            // 如果找到第一個 >= target 的值，代表這個位置就是插入點
            if nums[i] >= target {
                return i
            }
        }
        
        // 如果走完整個陣列都沒遇到更大的數字
        // 代表 target 比所有數字都大 → 插在最後一位
        return nums.count
    }
    
}

// MARK: - 測試

let solutionOne = SolutionOne()

print(solutionOne.searchInsert([1, 3, 5, 6], 5)) // ➜ 2
print(solutionOne.searchInsert([1, 3, 5, 6], 2)) // ➜ 1
print(solutionOne.searchInsert([1, 3, 5, 6], 7)) // ➜ 4
print(solutionOne.searchInsert([1, 3, 5, 6], 0)) // ➜ 0
print(solutionOne.searchInsert([1], 0))          // ➜ 0


// MARK: - 解法二：Binary Search（二分搜尋法）
// 利用已排序陣列特性，每次折半查找，提高效率
class SolutionTwo {
    
    /// 給定已排序陣列 nums 與一個 target，回傳 target 應該插入在 nums 中的 index
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        
        // 初始化左右邊界
        var left = 0
        var right = nums.count - 1
        
        // 當 left <= right，表示搜尋範圍還有效，持續折半查找
        while left <= right {
            
            // 每次都從中間開始比對（折半）
            let mid = (left + right) / 2
            
            // 如果剛好找到 target，就直接回傳中間位置
            // 找到 target，直接回傳位置
            if nums[mid] == target {
                return mid
            }
            // 如果中間數小於目標，代表答案在右邊，左界往右移動
            // target 在右邊 → 縮小範圍
            else if nums[mid] < target {
                left = mid + 1
            }
            // 如果中間數大於目標，代表答案在左邊 → 右界往左移動
            // target 在左邊 → 縮小範圍
            else {
                right = mid - 1
            }
        }
        
        // 沒找到 target，left 就是「應插入的位置」
        return left
    }
    
}

// MARK: - 測試
let solutionTwo = SolutionTwo()

print(solutionTwo.searchInsert([1, 3, 5, 6], 5)) // ➜ 2
print(solutionTwo.searchInsert([1, 3, 5, 6], 2)) // ➜ 1
print(solutionTwo.searchInsert([1, 3, 5, 6], 7)) // ➜ 4
print(solutionTwo.searchInsert([1, 3, 5, 6], 0)) // ➜ 0
print(solutionTwo.searchInsert([1], 0))          // ➜ 0