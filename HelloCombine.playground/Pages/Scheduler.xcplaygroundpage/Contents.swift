import Foundation
import Combine


let arrPublisher = [1, 2, 3].publisher

let queue = DispatchQueue(label: "custom")

let subscription = arrPublisher
    .subscribe(on: queue) // 헤비한 작업인 경우 별도의 스레드에서 작업할 수있도록 할 수 있다.
    .map { value -> Int in
        print("transform: \(value), thread:\(Thread.current)")
        return value
    }
    .receive(on: DispatchQueue.main) // 유아이 작업인 경우 받은 데이터를 메인 스레드에서 처리할 수 있도록 한다.
    .sink { value in
        print("Receive Value:\(value), thread:\(Thread.current)")
    }
//transform: 1, thread:<NSThread: 0x6000033847c0>{number = 7, name = (null)} // number = 7
//transform: 2, thread:<NSThread: 0x6000033847c0>{number = 7, name = (null)}
//transform: 3, thread:<NSThread: 0x6000033847c0>{number = 7, name = (null)}
//Receive Value:1, thread:<_NSMainThread: 0x6000033ac0c0>{number = 1, name = main} // number = 1 => 메인 스레드 
//Receive Value:2, thread:<_NSMainThread: 0x6000033ac0c0>{number = 1, name = main}
//Receive Value:3, thread:<_NSMainThread: 0x6000033ac0c0>{number = 1, name = main}
