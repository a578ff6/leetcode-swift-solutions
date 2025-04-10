// LeetCode #88 - Merge Sorted Array

// MARK: - 解法一：使用額外陣列合併（基礎觀念練習）
class SolutionOne {
    
    /// 合併兩個已排序的陣列，將 nums2 的元素合併進 nums1
    ///
    /// - Parameters:
    ///   - nums1: 主陣列，長度為 m + n，前 m 個為有效數字，其餘為 0（預留空間）
    ///   - m: nums1 中有效元素的數量
    ///   - nums2: 欲合併進來的排序陣列
    ///   - n: nums2 的元素數量
    ///
    /// - 操作：
    ///   1. 使用兩個指標 i 和 j 分別遍歷 nums1 與 nums2
    ///   2. 每次比較兩邊當前元素，將較小者加入 merged 陣列中
    ///   3. 若其中一邊先走完，就將另一邊剩下的全部加入
    ///   4. 最後將 merged 的結果覆蓋寫回 nums1（in-place）
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        /// 用來存放最終排序好的合併結果
        var merged: [Int] = []
        
        /// 指標 i 用於走訪 nums1 的前 m 個有效數字
        var i = 0
        /// 指標 j 用於走訪 nums2 的全部元素
        var j = 0
        
        /// 同步遍歷兩陣列，只要兩邊都還有元素可比
        while i < m && j < n {
            if nums1[i] < nums2[j] {
                // 若 nums1[i] 較小，加入 merged，並前進 i
                merged.append(nums1[i])
                i += 1
            } else {
                // 若 nums2[j] 較小或相等，加入 merged，並前進 j
                merged.append(nums2[j])
                j += 1
            }
        }
        
        /// nums1 可能還有剩下未處理的元素，全部補進 merged
        while i < m {
            merged.append(nums1[i])
            i += 1
        }
        
        /// nums2 可能還有剩下未處理的元素，全部補進 merged
        while j < n {
            merged.append(nums2[j])
            j += 1
        }
        
        /// 最後將合併好的 merged 陣列內容複製回 nums1 前 m+n 位
        for k in 0..<m+n {
            nums1[k] = merged[k]
        }
    }
    
}

// MARK: - 測試一 範例測試

var nums1 = [1,2,3,0,0,0]
let m = 3
let nums2 = [2,5,6]
let n = 3

let solutionOne = SolutionOne()
solutionOne.merge(&nums1, m, nums2, n)
print(nums1)  // 預期輸出: [1,2,2,3,5,6]


// MARK: - 解法二：從後往前合併（In-place 原地合併）

class SolutionTwo {
    
    /// 合併兩個已排序的陣列（in-place 不使用額外空間）
    ///
    /// - nums1：主陣列，長度為 m + n，前 m 個是有效資料，後面是 0 占位
    /// - m：nums1 的有效元素數量
    /// - nums2：次陣列，長度為 n
    /// - n：nums2 的元素數量
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        /// `p1`：指向 `nums1` 有效資料的最後一個位置（m - 1）
        var p1 = m - 1
        
        /// `p2`：指向 `nums2` 的最後一個元素（n - 1）
        var p2 = n - 1
        
        /// `p`：指向 `nums1` 最尾端的位置（m + n - 1），也是填入結果的位置
        var p = m + n - 1
        
        /// 從陣列尾端開始合併，誰大誰放後面
        while p1 >= 0 && p2 >= 0 {
            if nums1[p1] > nums2[p2] {
                /// 若 `nums1` 的元素比較大，放入 `nums1` 的尾端，`p1` 往前
                nums1[p] = nums1[p1]
                p1 -= 1
            } else {
                /// 否則放入 `nums2` 的元素，`p2` 往前
                nums1[p] = nums2[p2]
                p2 -= 1
            }
            /// 每次填完一個數字，`p` 一定要往前
            p -= 1
        }
        
        /// 補上 `nums2` 剩下還沒合併的元素
        /// 若 `nums2` 還沒走完（代表 `nums1` 的比較值都比較大已放完）
        while p2 >= 0 {
            nums1[p] = nums2[p2]
            p2 -= 1
            p -= 1
        }
        
        // 補充說明：
        // 不需要處理 nums1 剩下的值，因為它們已經在正確位置上
    }
    
}

// MARK: - 測試二：從後往前合併（In-place 原地合併）

var nums1 = [1,2,3,0,0,0]
let m = 3
let nums2 = [2,5,6]
let n = 3

let solutionTwo = SolutionTwo()
solutionTwo.merge(&nums1, m, nums2, n)
print(nums1)  // 預期輸出: [1,2,2,3,5,6]
