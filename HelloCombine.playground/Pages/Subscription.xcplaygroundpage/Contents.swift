import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()

// The print() operator prints you all lifecycle events
let subscription = subject
    .print("[Debug]")
    .sink { (value) in
        print("Subscriber received value: \(value)")
    }
//subject
//    .print("[Debug]")
//    .sink { (value) in
//        print("Subscriber received value: \(value)")
//    }
//[Debug]: receive subscription: (PassthroughSubject)
//[Debug]: request unlimited
//[Debug]: receive value: (Hello!)
//[Debug]: receive value: (Hello again!)
//[Debug]: receive value: (Hello for the last time!)
//[Debug]: receive finished

subject.send("Hello!")
subject.send("Hello again!")
subject.send("Hello for the last time!")
subject.send(completion: .finished) // 구독취소
//subscription.cancel() // 구독취소
subject.send("Hello?? :(")

//Subscriber received value: Hello!
//Subscriber received value: Hello again!
//Subscriber received value: Hello for the last time!




//[Debug]: receive subscription: (PassthroughSubject)
//[Debug]: request unlimited
//[Debug]: receive value: (Hello!)
//Subscriber received value: Hello!
//[Debug]: receive value: (Hello again!)
//Subscriber received value: Hello again!
//[Debug]: receive value: (Hello for the last time!)
//Subscriber received value: Hello for the last time!
//[Debug]: receive finished

