import Foundation
import Combine

final class SomeViewModel {
    @Published var name: String = "Jack" // 퍼블리셔
    var age: Int = 20
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewModel()

print("text: \(label.text)")

// $name 퍼블리셔 접근 가능
// assign: Publisher가 제공한 데이터를 특정 객체의 키패스에 할당
vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")

vm.name = "Jason"
print("text: \(label.text)")

vm.name = "Hoo"
print("text: \(label.text)")

//text:
//text: Jack
//text: Jason
//text: Hoo
