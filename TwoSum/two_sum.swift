// LeetCode #1 - Two Sum

// MARK: - 解法一：暴力法
// 檢查所有可能的數對組合，找到總和為 target 的一組 index
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]       // 找到符合條件的組合就回傳
            }
        }
    }
    return []
}

// MARK: - 解法二：使用 Dictionary 優化
// 邊走邊記錄已看過的數字與 index，只需一層迴圈即可解
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    
    for (i, num) in nums.enumerated() {
        let complement = target - num
        
        // 如果之前看過 complement，就直接回傳解答
        if let j = dict[complement] {
            return [j, i]
        }
        
        // 否則把目前數字記錄進 dict
        dict[num] = i
    }
    return []
}
