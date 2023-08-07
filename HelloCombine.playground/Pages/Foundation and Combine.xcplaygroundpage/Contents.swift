import Foundation
import Combine
import UIKit




// URLSessionTask Publisher and JSON Decoding Operator
struct SomeDecodable: Decodable { } // 해당 구조체를 자동으로 디코드 할 수 있다.

// 해당 url 에서 데이터를 받아서 response 중 data 값을 SomeDecodable 해당 구조체로 디코드 해서 값을 가져온다.
URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.google.com")!) // 퍼블리셔
    .map { response in
        return response.data
    }
    .decode(type: SomeDecodable.self, decoder: JSONDecoder())





// Notifications
let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: noti, object: nil) // 노티에 대한 퍼블리셔.
let subscription1 = notiPublisher.sink { _ in
    print("Noti Received") // 노티를 받을 때마다 호출.
}

center.post(name: noti, object: nil)
subscription1.cancel()





// KeyPath binding to NSObject instances
// 퍼블리셔를 이용해서 구독하면 UILabel 의 text 에 assign 하여 값을 넣어줄 수 있다.
let ageLabel = UILabel()
print("text:", ageLabel.text ?? "")
 ///
Just(28) // 단 한 번 값을 보내는 퍼블리셔.
    .map { "Age is \($0)" } // 28을 보내면 해당 스트링으로 리턴
    .assign(to: \.text, on: ageLabel) // 위에서 받은 스트링을 UILabel 의 텍스트에 넣어준다.

print("text:", ageLabel.text ?? "")





// Timer
// autoconnect 를 이용하면 subscribe 되면 바로 시작함
let timerPublisher = Timer
    .publish(every: 1.0, on: .main, in: .common) // 1초마다 메인 스레드에서 보통 방법으로..하는 퍼블리셔
    .autoconnect() // 구독하면 자동으로 실행한다.

let subscription2 = timerPublisher.sink { time in // 타이머 구독
    print("time: \(time)")
}

// 5초 뒤에 subscription2 종료한다.
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subscription2.cancel()
}
