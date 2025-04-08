// LeetCode #121 - Best Time to Buy and Sell Stock

// MARK: - 解法一：暴力雙迴圈（先建立觀念）
class SolutionOne {
    
    /// 回傳最大利潤
    ///
    /// - `參數 prices`: 股票價格陣列
    /// - `回傳`：可獲得的最大利潤（若永遠不會賺錢 → 回傳 0）
    func maxProfit(_ prices: [Int]) -> Int {
        
        /// 用來記錄目前為止找到的最大利潤
        var maxProfit = 0
        
        /// 外層迴圈：模擬「哪一天買進」
        for i in 0..<prices.count {
            
            /// 內層迴圈：模擬「從第 i+1 天起」嘗試賣出（之後哪一天賣出）
            for j in (i+1)..<prices.count {
                
                /// 利潤 = 賣價 - 買價
                let profit = prices[j] - prices[i]
                
                /// 比較目前最大利潤
                /// 若這筆交易利潤更高，就更新 maxProfit
                maxProfit = max(maxProfit, profit)
            }
        }
        
        /// 回傳最大利潤
        return maxProfit
    }
    
}


// MARK: - 測試一（暴力雙迴圈）

let solutionOne = SolutionOne()

print(solutionOne.maxProfit([7,1,5,3,6,4]))    // ➜ 5
print(solutionOne.maxProfit([7,6,4,3,1]))      // ➜ 0


// MARK: - 解法二：線性掃描（一次遍歷）
class SolutionTwo {
    
    /// 回傳最大利潤
    ///
    /// - `參數 prices`: 股票價格陣列
    /// - `回傳`：可獲得的最大利潤（若永遠不會賺錢 → 回傳 0）
    func maxProfit(_ prices: [Int]) -> Int {
        
        /// 紀錄目前為止「最低的買入價格」
        /// 初始設為 `Int.max`，確保第一筆價格一定會被取代
        var minPrice = Int.max
        
        /// 紀錄目前為止「最大利潤」
        var maxProfit = 0
        
        /// 一次迴圈遍歷整個價格陣列
        for price in prices {
            
            /// 如果今天的價格更便宜 → 更新目前最低價（`minPrice`）
            if price < minPrice {
                
                minPrice = price
                
            } else {
                
                /// 否則表示今天價格比歷史低點高
                /// 試著用今天價格「賣出」，看看能賺多少
                let profit = price - minPrice
                
                /// 若利潤更高，就更新 maxProfit
                maxProfit = max(maxProfit, profit)
            }
        }
        
        /// 回傳最終計算出的最大利潤
        return maxProfit
    }
}

// MARK: - 測試二（ 線性掃描）

let solutionTwo = SolutionTwo()
print(solutionTwo.maxProfit([7,1,5,3,6,4]))    // ➜ 5
print(solutionTwo.maxProfit([7,6,4,3,1]))      // ➜ 0
