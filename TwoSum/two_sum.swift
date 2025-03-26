// LeetCode #1 - Two Sum

// 解法一：暴力法
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return []
}

// 解法二：使用 Dictionary 優化
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    
    for (i, num) in nums.enumerated() {
        let complement = target - num
        if let j = dict[complement] {
            return [j, i]
        }
        dict[num] = i
    }
    
    return []
}