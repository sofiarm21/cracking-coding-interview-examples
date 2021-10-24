struct Stack<T> {
    var store = [T]()
    var isEmpty: Bool {
        return peek() == nil
    }
    mutating func push(_ value: T) {
        store.append(value)
    }
    mutating func pop() -> T {
        return store.removeLast()
    }
    func peek() -> T? {
        return store.last
    }
}
struct Queue<T> {
    var store = [T]()
    var isEmpty: Bool {
        return peek() == nil
    }
    mutating func add(_ element: T) {
        store.append(element)
    }
    mutating func remove() -> T? {
        return store.removeFirst()
    }
    func peek() -> T? {
        return store[0]
    }

}
