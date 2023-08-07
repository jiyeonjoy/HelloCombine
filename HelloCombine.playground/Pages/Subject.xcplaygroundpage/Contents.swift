import Foundation
import Combine

// PassthroughSubject
// String 타입을 배출하는 퍼블리셔 / Never: 실패할리는 없다 / 초기값 필요 없음!!
let relay = PassthroughSubject<String, Never>()
relay.send("Initial text")

let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")
//subscription1 received value: Hello
//subscription1 received value: World!





// CurrentValueSubject
// String 타입을 배출하는 퍼블리셔 / Never: 실패할리는 없다 / 초기값 필요!!! ""
// 구독 전 초기 값(바로 전 값)을 받는다.
let variable = CurrentValueSubject<String, Never>("")

variable.send("Initial text")
variable.send("Initial text2")

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
variable.value // "More text"
//subscription2 received value: Initial text2
//subscription2 received value: More text





//let publisher = ["Here","we","go!"].publisher
//publisher.subscribe(relay)
//publisher.subscribe(variable)
