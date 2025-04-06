// LeetCode #115 - Min Stack

// MARK: - 定義 MinStack 類別
class MinStack {

    /// stack 用來正常 push / pop 元素
    private var stack: [Int] = []
    
    /// minStack 用來追蹤每個狀態下的最小值
    private var minStack: [Int] = []

    /// 初始化 MinStack
    init() { }
    
    /// 推入元素 `val`
    ///
    /// - 將 val 加入 stack
    /// - 若 val 是目前為止的最小值，也推入 minStack
    func push(_ val: Int) {
        
        /// 1.  把 val 推入主 stack
        stack.append(val)
        
        /// 2. 更新 minStack
        ///
        /// - 如果 minStack 是空的，或 val 比 minStack 當前最小值還小（含等於）→ 加入 minStack
        /// (因為這代表 val 是目前為止最小的值）
        if minStack.isEmpty || val <= minStack.last! {
            minStack.append(val)
        }
    }
    
    /// 移除 stack 最上層元素，並同步更新 minStack（如果需要）
    ///
    /// - 這裡使用 popLast()：會回傳並移除最後一個元素
    /// - 如果 stack 是空的，popLast() 會回傳 nil → 使用 guard let 安全處理
    /// - 如果剛剛移除的元素 == 當前最小值 → minStack 也要同步移除
    func pop() {
        
        /// 從 stack 拿出並移除最後一個元素（最上層的）
        /// 若 stack 為空 → return（不做任何操作，避免錯誤）
        guard let top = stack.popLast() else { return }
        
        /// 如果這個被移除的元素，剛好也是 minStack 最上層（目前最小值）
        /// → 代表我們也要從 minStack 把它移除，確保最小值資訊正確
        if top == minStack.last {
            minStack.popLast()
        }
    }
    
    /// 取得目前 Stack 最上層的元素
    ///
    /// - 回傳目前 stack 最上層的元素
    /// - 若 stack 為空，這裡暫時回傳 -1（LeetCode 題目通常保證操作合法）
    func top() -> Int {
        return stack.last ?? -1
    }
    
    /// 取得目前 Stack 的最小值
    ///
    /// - `minStack` 記錄了所有狀態下的最小值
    /// - 直接取 `.last `就是目前最小值
    /// - 同樣，為保險加個 ?? -1（雖然題目保證會合法呼叫）
    func getMin() -> Int {
        return minStack.last ?? -1
    }
     
}


// MARK: - 測試一

["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]


let minStackOne = MinStack()

minStackOne.push(-2)
minStackOne.push(0)
minStackOne.push(-3)
print(minStackOne.getMin()) // ➜ -3

minStackOne.pop()
print(minStackOne.top())    // ➜ 0
print(minStackOne.getMin()) // ➜ -2


// MARK: - 測試二 （重複最小值的情況）

["MinStack","push","push","push","push","getMin","pop","getMin","pop","getMin","pop","getMin"]
[[],[5],[3],[3],[7],[],[],[],[],[],[],[]]


let minStackTwo = MinStack()

minStackTwo.push(5)
minStackTwo.push(3)
minStackTwo.push(3)
minStackTwo.push(7)
print(minStackTwo.getMin())  // ➜ 3

minStackTwo.pop()            // 移除 7，min = 3
print(minStackTwo.getMin())  // ➜ 3

minStackTwo.pop()            // 移除 3（其中一個）
print(minStackTwo.getMin())  // ➜ 3 ← 另一個 3 還在

minStackTwo.pop()            // 移除最後一個 3
print(minStackTwo.getMin())  // ➜ 5 ← 回到先前的最小值