# LeetCode 題解筆記 #155：Min Stack（Swift）

---

📂 題目分類

- 題型：Stack 操作、資料結構設計
- 難度：Easy
- 練習重點：
  - 設計自訂類別結構
  - 使用 Stack 模擬最小值記錄機制
  - 理解同步更新兩個 Stack 的邏輯

---

## 📝 題目連結  

[https://leetcode.com/problems/min-stack](https://leetcode.com/problems/min-stack)

---

## ❓ 題目說明

設計一個支援以下操作的 Stack 類別：

- `push(x)`：將元素 x 推入堆疊
- `pop()`：移除最上層元素
- `top()`：取得最上層元素
- `getMin()`：取得目前堆疊中的最小值

---

## ✅ 範例

```swift
輸入：
["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]

輸出：
[null,null,null,null,-3,null,0,-2]
```

---

## 💡 解法：使用兩個 Stack 追蹤最小值

### 1–1 解法思路

1. 為了讓 getMin() 在 O(1) 時間內取得最小值，可以使用兩個 Stack：

| Stack 名稱 | 功能說明                             |
|------------|--------------------------------------|
| stack      | 正常存放 push 的元素                  |
| minStack   | 存放「目前為止的最小值」，與主 stack 同步 |

---

### 1-2 操作邏輯如下：

- 利用 minStack 同步記錄當前最小值，就能讓 getMin() 在 O(1) 時間內取得正確結果！

| 操作方法  | 行為描述                                                                 |
|-----------|--------------------------------------------------------------------------|
| push(x)   | - 將 `x值` 加入 `stack`<br>- 若該`x值`為目前最小值`（<= minStack.top）`，也加入 `minStack`       |
| pop()     | - 從 `stack` 易除最上層元素<br>- 若該值 `== minStack.top`，也一併從 `minStack` 移除  |
| top()     | - 回傳 `stack` 最上層元素（即 `.last`）                                      |
| getMin()  | - 回傳 `minStack` 最上層元素（即目前最小值）                               |

---

### 1–3 程式碼

```swift
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
```

---

### 1–4 測試範例

```swift
let minStackOne = MinStack()

minStackOne.push(-2)
minStackOne.push(0)
minStackOne.push(-3)
print(minStackOne.getMin()) // ➜ -3

minStackOne.pop()
print(minStackOne.top())    // ➜ 0
print(minStackOne.getMin()) // ➜ -2
```
---

### 1-5 對應流程圖解

| 操作         | `stack`         | `minStack`      | 說明                          |
|--------------|------------------|------------------|-------------------------------|
| push(-2)     | [-2]             | [-2]             | 初始值，同步推入 minStack     |
| push(0)      | [-2, 0]          | [-2]             | 0 > minStack.top，不加入      |
| push(-3)     | [-2, 0, -3]      | [-2, -3]         | -3 是新最小值 → 推入 minStack |
| getMin()     | -                | [-2, -3]         | 查看目前最小值：-3            |
| pop()        | [-2, 0]          | [-2]             | -3 是最小值 → 兩邊都移除     |
| top()        | 0                | [-2]             | 取得 stack 最上層元素        |
| getMin()     | -                | [-2]             | 取得當前最小值                |

---

### 1-6 語法複習

| 語法                    | 說明                                                                 |
|-------------------------|----------------------------------------------------------------------|
| `var arr: [Int] = []`   | 宣告一個整數陣列，預設為空                                            |
| `arr.append(x)`         | 將元素 x 加入陣列尾端（Stack 推入）                                  |
| `arr.popLast()`         | 移除並回傳陣列最後一個元素，若為空則回傳 nil（Stack 彈出）           |
| `arr.last`              | 取得陣列最後一個元素，但不會移除，為 Optional 型別                   |
| `guard let x = ...`     | 安全拆解 Optional，若為 nil 則提前 return，常見於防呆處理            |
| `?? -1`                 | 使用 nil 合併運算符，若值為 nil 則給預設值，避免崩潰                 |
| `private` 修飾詞        | 將屬性設為私有，僅在該類別中使用，符合封裝性設計原則                |

---

✅ 補充說明

1. `stack.popLast()` 為 Swift 安全的陣列彈出方法，搭配 guard let 使用避免空陣列錯誤。

2. `stack.last` 不會移除元素，適合用來檢查 Stack 頂端的值。

3. `minStack.last ?? -1` 是一種防守式寫法，即使題目保證合法呼叫，仍保持穩定性。

---

### 1–7 popLast() 的用途，為什麼搭配 guard let 使用？

#### `popLast()` 的兩大功能：

| 動作     | 說明                                                   |
|----------|--------------------------------------------------------|
| 取得值   | 回傳陣列最後一個元素（Optional 型別）                  |
| 移除值   | 同時把這個元素從陣列中「移除掉」                        |

---

#### 這行程式碼：

```swift
guard let top = stack.popLast() else { return }
```

是在做兩件事 合併成一步：

1. 從 `stack` 中移除並取得最後一個元素（也就是 Stack 最上層）
2. 如果 `stack` 是空的，直接 return，不執行後續邏輯

---

#### 小範例：

```swift
var stack = [1, 2, 3]

guard let top = stack.popLast() else { return }

print(top)      // ➜ 3
print(stack)    // ➜ [1, 2]
```

- 如果 stack 是空的，這段程式碼就會跳過後續邏輯，不會崩潰。

---

#### 更傳統的寫法（對照）

```swift
if stack.isEmpty {
    return
}
let top = stack.removeLast()
```

- 功能一樣，但寫法較長。Swift 更推薦使用 popLast() 搭配 guard let，更 Swifty、簡潔、安全。

---

#### ✅ 為什麼這樣設計在 MinStack 很實用？

在 pop() 方法中，我們希望：

1. 從 stack 拿出元素
2. 若它是最小值 → 一起從 minStack 移除

```swift
guard let top = stack.popLast() else { return }

if top == minStack.last {
    minStack.popLast()
}
```

一次完成：

1. 安全移除
2. 同步最小值更新

---
## 測試二（重複最小值的情況）

```swift
["MinStack","push","push","push","push","getMin","pop","getMin","pop","getMin","pop","getMin"]
[[],[5],[3],[3],[7],[],[],[],[],[],[],[]]
```

### 2-1 延伸測試與圖解：重複最小值的情況

```swift
let minStackTwo = MinStack()

minStackTwo.push(5)
minStackTwo.push(3)
minStackTwo.push(3)
minStackTwo.push(7)
print(minStackTwo.getMin())  // ➜ 3

minStackTwo.pop()            // 移除 7
print(minStackTwo.getMin())  // ➜ 3

minStackTwo.pop()            // 移除一個 3
print(minStackTwo.getMin())  // ➜ 3 ← 另一個 3 還在

minStackTwo.pop()            // 移除最後一個 3
print(minStackTwo.getMin())  // ➜ 5 ← 回到先前的最小值
```

---

### 2-2 對應流程圖解

| 操作       | stack         | minStack      | 說明                                 |
|------------|---------------|---------------|--------------------------------------|
| push(5)    | [5]           | [5]           | 初始值，同步推入 minStack             |
| push(3)    | [5, 3]        | [5, 3]        | 3 < 5 → 推入 minStack                |
| push(3)    | [5, 3, 3]     | [5, 3, 3]     | 再次推入 3，仍是最小 → 一起記錄      |
| push(7)    | [5, 3, 3, 7]  | [5, 3, 3]     | 7 > min → 僅入主 stack               |
| getMin()   | -             | [5, 3, 3]     | 目前最小為 3                          |
| pop()      | [5, 3, 3]     | [5, 3, 3]     | 移除 7，不影響 minStack              |
| getMin()   | -             | [5, 3, 3]     | 仍是 3                               |
| pop()      | [5, 3]        | [5, 3]        | 移除一個 3，還有一個保留             |
| getMin()   | -             | [5, 3]        | 還是 3                               |
| pop()      | [5]           | [5]           | 移除最後一個 3，min 變為 5           |
| getMin()   | -             | [5]           | ✅ 成功還原先前最小值                |

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)