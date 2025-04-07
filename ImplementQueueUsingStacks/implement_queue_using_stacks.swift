// LeetCode #232 - Implement Queue using Stacks

// MARK: - 使用兩個 Stack 模擬 Queue 結構（先進先出 FIFO）
class MyQueue {

    /// 主 stack：接收 push 的元素（扮演 queue 的尾端）
    private var inStack: [Int] = []
    
    /// 輔助 stack：負責處理 pop / peek（扮演 queue 的前端）
    /// - 當需要取出元素時，會將 inStack 內容反轉搬進 outStack，以還原先進先出的順序
    private var outStack: [Int] = []
    
    /// 初始化 queue
    init() {}
    
    /// 將元素 x 加入 queue 尾端
    func push(_ x: Int) {
        inStack.append(x)
    }
    
    /// 移除並回傳 queue 最前端的元素
    func pop() -> Int {
        
        /// 當 outStack 為空，才從 inStack 將元素倒進來（反轉順序）
        ///
        ///  - 反轉搬移順序，讓 outStack 模擬 queue 的前端
        if outStack.isEmpty {
            
            while let val = inStack.popLast() {
                outStack.append(val)
            }
        }
        
        /// 回傳 outStack 最上層的元素（也就是 queue 的最前端）
        return outStack.popLast() ?? -1
    }
    
    /// 回傳 queue 最前端元素（不移除）
    func peek() -> Int {
        
        /// 反轉搬移順序，讓 outStack 模擬 queue 的前端
        ///
        ///  - 把 inStack 全部搬到 outStack，反轉順序
        if outStack.isEmpty {
            while let val = inStack.popLast() {
                outStack.append(val)
            }
        }
        
        /// 查看最前端的元素（不移除）
        return outStack.last ?? -1
    }
    
    /// 判斷 queue 是否為空
    func empty() -> Bool {
        return inStack.isEmpty && outStack.isEmpty
    }
    
}


// MARK: - 測試一（LeetCode範例）

/**
 輸入：
 
 ["MyQueue", "push", "push", "peek", "pop", "empty"]
 
 [[], [1], [2], [], [], []]
 
 預期輸出：
 
 [null, null, null, 1, 1, false]
 */

let queueOne = MyQueue()

queueOne.push(1)
queueOne.push(2)
print(queueOne.peek())   // ➜ 1：查看最前面的元素，不移除
print(queueOne.pop())    // ➜ 1：移除最前面的元素
print(queueOne.empty())  // ➜ false：還有 2 在 queue 裡


// MARK: - 測試二（多次 pop 測試 queue 邏輯是否正確）

/**
 
 輸入：
 
 ["MyQueue", "push", "push", "push", "pop", "pop", "push", "pop", "peek", "empty", "pop", "empty"]

 [[], [10], [20], [30], [], [], [40], [], [], [], [], []]

 預期輸出：

 [null, null, null, 10, 20, null, 30, 40, false, 40, true]
 */

let queueTwo = MyQueue()

queueTwo.push(10)
queueTwo.push(20)
queueTwo.push(30)

print(queueTwo.pop())   // ➜ 10（最先進來）
print(queueTwo.pop())   // ➜ 20（次先進來）

queueTwo.push(40)
print(queueTwo.pop())   // ➜ 30（剩下的那個）
print(queueTwo.peek())  // ➜ 40（最新加入，但還沒被移除）
print(queueTwo.empty()) // ➜ false（還有一個元素）
print(queueTwo.pop())   // ➜ 40（最後一個）
print(queueTwo.empty()) // ➜ true（完全清空）