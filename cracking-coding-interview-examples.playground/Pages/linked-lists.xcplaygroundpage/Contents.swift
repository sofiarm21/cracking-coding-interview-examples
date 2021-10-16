class Node<Element: Equatable>: Equatable {
    
    static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        return lhs == rhs
    }
    
    var value: Element
    var next: Node?
    
    func append(_ node: Node) {
        self.next = node
    }
    
    init(value: Element, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<T: Equatable> {
    var head: Node<T>?
    var tail: Node<T>?
    var isEmpty: Bool {
        return head == nil
    }
    
    mutating func push(_ value: T) {
        head = Node(value: value, next: self.head)
        if tail == nil {
            tail = head
        }
    }
    
    mutating func append(_ value: T) {
        guard !isEmpty else {
            return push(value)
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    mutating func pop() -> T? {
        guard !isEmpty else {
            return nil
        }
        let headNode = head
        head = head!.next
        if isEmpty {
            tail = nil
        }
        return headNode?.value
    }
    
    mutating func deleteNode(_ node: Node<T>) {
        guard !isEmpty else {
            return
        }
        if head == node {
            pop()
            return
        }
        if tail == node {
            var current = head
            while current!.next != tail {
                current = current?.next
            }
            tail = current
        }
        var pointer = head!
        while pointer.next != nil {
            if (pointer.next == node) {
                pointer.next = pointer.next!.next
                return
            }
            pointer = pointer.next!
        }
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = self.next else {
            return "\(value)"
        }
        return "\(value) -> \(next)"
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        return "\(head)"
    }
}

/*
 1. R�mov� Dups! Write code to remove duplicates from an unsorted linked list.
 FOLLOW UP
 How would you solve this problem if a temporary buffer is not allowed?
 */

func removeDup<T>(_ list: inout LinkedList<T>) -> LinkedList<T>? {
    guard !list.isEmpty else {
        return nil
    }
    var p1 = list.head!
    var p2: Node<T>
    while p1.next != nil {
        p2 = p1
        while p2.next != nil {
            if p1.value == p2.next!.value {
                var aux = p2.next!
                while  aux.next != nil {
                    if aux.next!.value != p1.value {
                        break
                    }
                    aux = aux.next!
                }
                p2.next = aux.next
            }
            guard p2.next != nil else {
                return list
            }
            p2 = p2.next!
        }
        p1 = p1.next!
    }
    return list
}

//var list = LinkedList<Int>()
//list.push(4)
//list.push(5)
//list.push(5)
//list.push(3)
//list.push(5)
//list.push(1)
//
//print(removeDup(&list))

/*
 Return Kth to Last: Implement an algorithm to find the kth to last element of a singly linked list.
 */

func kthElement<T>(_ list: LinkedList<T>, k: Int) -> T? {
    guard !list.isEmpty else {
        return nil
    }
    var p1 = list.head!
    while p1.next != nil {
        var p2 = p1
        for int in 0...k {
            if p2.next != nil {
                p2 = p2.next!
            }
            else {
                return p1.value
            }
        }
        p1 = p1.next!
    }
    return list.tail!.value
}

//var list = LinkedList<Int>()
//list.push(4)
//list.push(5)
//list.push(5)
//list.push(3)
//list.push(5)
//list.push(1)
//
//kthElement(list, k:5)

/*3. Delete Middle Node: Implement an algorithm to delete a node in the middle (i.e., any node but the first and last node, not necessarily the exact middle) of a singly linked list, given only access to that node.
 EXAMPLE
 lnput:the node c from the linked list a->b->c->d->e->f
 Result: nothing is returned, but the new linked list looks like a->b->d->e->f
 */

func deleteMiddleNode<T>(_ node: inout Node<T>) {
    guard node != nil && node.next != nil else {
        return
    }
    while node.next != nil {
        node.value = node.next!.value
        if node.next!.next == nil {
            node.next = nil
            return
        } else {
            node = node.next!
        }
    }
}

/*
 4. Partition: Write code to partition a linked list around a value x, such that all nodes less than x come before all nodes greater than or equal to x. If x is contained within the list the values of x only need to be after the elements less than x (see below). The partition element x can appear anywhere in the "right partition"; it does not need to appear between the left and right partitions.
 EXAMPLE
 Input: 3 -> 5 -> 8 -> 5 -> 10 -> 2 -> 1[partition=5]
 Output: 3 -> 1 -> 2 -> 10 -> 5 -> 5 -> 8
 */

func partition(_ list: LinkedList<Int>, partition: Int) -> LinkedList<Int> {
    var leftPartition = LinkedList<Int>()
    var rightPatition = LinkedList<Int>()
    guard !list.isEmpty else {
        return list
    }
    var node = list.head!
    while node.next != nil {
        if (node.value < partition) {
            leftPartition.append(node.value)
        } else {
            rightPatition.append(node.value)
        }
        node = node.next!
    }
    node = leftPartition.tail!
    node.next = rightPatition.head!
    return leftPartition
}

var list = LinkedList<Int>()
list.push(1)
list.push(2)
list.push(10)
list.push(5)
list.push(8)
list.push(20)
list.push(5)
list.push(3)
list.push(243)


print(partition(list, partition: 7))

/*
5. Sum Lists: You have two numbers represented by a linked list,where each node contains a single digit. The digits are stored in reverse order,such that the 1's digit is at the head of the list. Write a function that adds the two numbers and returns the sum as a linked list.
 EXAMPLE
 Input: (7-> 1 -> 6) + (5 -> 9 -> 2).That is,617 + 295. Output:2 -> 1 -> 9.Thatis,912.
 FOLLOW UP
 Suppose the digits are stored in forward order. Repeat the above problem. Input: (6 -> 1 -> 7) + (2 -> 9 -> 5).Thatis,617 + 295. Output:9 ->1 ->2.Thatis,912.

 */

func sumList(listA: LinkedList<Int>, listB: inout LinkedList<Int>) -> LinkedList<Int>? {
    guard !listA.isEmpty && !listB.isEmpty else {
        return nil
    }
    var carry = 0
    var nodeA = listA.head!
    var nodeB = listB.head!
    var pastNodeB = 0
    while nodeA != nil {
        pastNodeB = nodeB.value
        nodeB.value = (nodeA.value + nodeB.value + carry) % 10
        carry = (nodeA.value + pastNodeB + carry) / 10
        //carry = (nodeA.value + nodeB.value + carry) / 10
        guard nodeA.next != nil && nodeB.next != nil else {
            break
        }
        nodeA = nodeA.next!
        nodeB = nodeB.next!
    }
    if (carry != 0) {
        while (carry / 10 != 0) {
            nodeB.next = Node(value: carry % 10)
            carry = carry / 10
        }
    }
    return listB
}

var listA = LinkedList<Int>()
listA.push(234)
listA.push(445)
listA.push(2342)
var listB = LinkedList<Int>()
listB.push(2)
listB.push(9)
listB.push(5)

print(sumList(listA: listA, listB: &listB))

/*
 6. Palindrome: Implement a function to check if a linked list is a palindrome.
 */

func palindrome<T: Equatable>(_ list: LinkedList<T>) -> Bool {
    guard !list.isEmpty else {
        return false
    }
    var pointer = list.head!
    var counter = 0
    var reversedList = LinkedList<T>()
    while pointer != nil {
        reversedList.push(pointer.value)
        counter += 1
        guard pointer.next != nil else {
            break
        }
        pointer = pointer.next!
    }
    pointer = list.head!
    var pointerR = reversedList.head!
    for _ in 0..<counter/2 {
        if (pointer.value != pointerR.value) {
            return false
        }
        pointer = pointer.next!
        pointerR = pointerR.next!
    }
    return true
}

var list6 = LinkedList<Int>()
list6.push(0)
list6.push(1)
list6.push(2)
list6.push(1)
list6.push(0)
palindrome(list6)
