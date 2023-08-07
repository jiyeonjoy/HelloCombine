import Foundation
import Combine


// Basic CombineLatest

let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()


//Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in
//    print("Receive: \(str), \(num)")
//}
strPublisher.combineLatest(numPublisher).sink { (str, num) in // 튜플 형식으로 내려옴..
    print("Receive: \(str), \(num)")
}

//strPublisher.send("a")
//strPublisher.send("b")
//strPublisher.send("c")
//
//numPublisher.send(1)
//numPublisher.send(2)
//numPublisher.send(3)

//Receive: c, 1
//Receive: c, 2
//Receive: c, 3

strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
strPublisher.send("c")

numPublisher.send(2)
numPublisher.send(3)

//Receive: a, 1
//Receive: b, 1
//Receive: c, 1
//Receive: c, 2
//Receive: c, 3





// Advanced CombineLatest

//: **simulate** input from text fields with subjects
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

//: **combine** the latest value of each input to compute a validation
let validatedCredentialsSubscription = Publishers.CombineLatest(usernamePublisher, passwordPublisher)
    .map { (username, password) -> Bool in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("CombineLatest: are the credentials valid? \(valid)")
    }

//: Example: simulate typing a username and the password twice
usernamePublisher.send("jasonlee")
passwordPublisher.send("weakpw")
passwordPublisher.send("verystrongpassword")

//CombineLatest: are the credentials valid? false
//CombineLatest: are the credentials valid? true





// Merge

//let publisher1 = [1,2,3,4,5].publisher
//let publisher2 = [300,400,500].publisher
let publisher1 = ["1","2","3","4","5"].publisher
let publisher2 = ["300","400","500"].publisher

// 이건 밑에거 안됨...
//let publisher1 = PassthroughSubject<String, Never>()
//let publisher2 = PassthroughSubject<String, Never>()
//publisher1.send("111")
//publisher1.send("222")
//publisher2.send("???")
//publisher1.send("333")

let mergedPublishersSubscription = Publishers
    .Merge(publisher1, publisher2) // 타입이 같은 퍼블리셔인 경우 첫번째 데이터를 먼저 구독하고 그다음 두번째 퍼블리셔를 구독한다.
    .sink { value in
        print("Merge: subscription received value \(value)")
}
