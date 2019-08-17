//: [Previous](@previous)

import Foundation

public struct HashTable<Key: Hashable, Value> {
  
  private typealias Element = (key: Key, value: Value)
  private typealias Bucket = [Element]
  private var buckets: [Bucket]
  
  // The number of key-value pairs in the hash table.
  private(set) public var count = 0
  
  // A Boolean value that indicates whether the hash table is empty.
  public var isEmpty: Bool {
    return count == 0
  }
  
  // Create a hashtable with given capacity.
  init(capacity: Int) {
    assert(capacity > 0)
    buckets = Array<Bucket>(repeating: [], count: capacity)
  }
  
  // Access the value associated with the given key for reading and writing.
  public subscript(key: Key) -> Value? {
    get {
      return value(forKey: key)
    }
    set {
      if let value = newValue {
        updateValue(value, forKey: key)
      } else {
        removeValue(forKey: key)
      }
    }
  }
  
  // Returns the value of given key.
  public func value(forKey key: Key) -> Value? {
    let index = self.index(forKey: key)
    for element in buckets[index] {
      if element.key == key {
        return element.value
      }
    }
    return nil
  }
  
  // Update the value stored in the hash table for the given key,
  // or add a new key-value pair if the key doesn't exist.
  @discardableResult
  public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
    let index = self.index(forKey: key)
    // Check if we already have this key in the bucket.
    for (i, element) in buckets[index].enumerated() {
      if element.key == key {
        let oldValue = element.value
        buckets[index][i].value = value
        return oldValue
      }
    }
    // This key isn't in the bucket yet, add it to the chain.
    buckets[index].append((key: key, value: value))
    count += 1
    return nil
  }
  
  // Removes the given key and its associated value from the hash table.
  @discardableResult
  public mutating func removeValue(forKey key: Key) -> Value? {
    let index = self.index(forKey: key)
    
    // Find the element in bucket's chain and remove it.
    for (i, element) in buckets[index].enumerated() {
      if element.key == key {
        buckets[index].remove(at: i)
        count -= 1
        return element.value
      }
    }
    
    // Key is not found in hash table.
    return nil
  }
  
  // Remove all key-value pairs from the hash table.
  public mutating func removeAll() {
    for index in 0..<buckets.count {
      buckets[index] = []
    }
    count = 0
  }
  
  // Return the given key's array index.
  private func index(forKey key: Key) -> Int {
    return abs(key.hashValue) % buckets.count
  }
}

extension HashTable: CustomStringConvertible {
  // Contents of hashtable.
  public var description: String {
    let pairs = buckets.flatMap { b in b.map { e in "\(e.key) = \(e.value)" } }
    return pairs.joined(separator: ", ")
  }
  
  // Contents of hashtable.
  public var debugDescription: String {
    var str = ""
    for (i, bucket) in buckets.enumerated() {
      let pairs = bucket.map { e in "\(e.key) = \(e.value)" }
      str += "bucket \(i): " + pairs.joined(separator: ", ") + "\n"
    }
    return str
  }
}

let _ = {
  var hashTable = HashTable<String, String>(capacity: 10)
  hashTable["firstName"] = "Swapnil"
  hashTable["lastName"] = "Jain"
  hashTable["spouseFirstName"] = "Neha"
  hashTable["spouseLastName"] = "Jain"
  hashTable["occupation"] = "Senior Software Engineer"
  hashTable["passion"] = "TODO"
  hashTable["passion"] = "TODO_TODO"
  print(hashTable.description)
  print(hashTable.debugDescription)
  hashTable.removeAll()
  print(hashTable.description)
  print(hashTable.debugDescription)
}()
//: ---
//: [Next](@next)
