import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates
let words = "hey hey there! Mr Mr ?"
                .components(separatedBy: " ") // " " 를 구분하여 문자열 자름.
                .publisher

words
  .removeDuplicates() // 중복되는 문자열 제거
  .sink(receiveValue: {
    print($0)
  })
  .store(in: &subscriptions) // 해당 subscriptions 통에 넣어준다고..





// compactMap
let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher

strings
  .compactMap { Float($0) } // nil 인거는 제거.. 즉, Float 로 변경이 불가한거는 제거 한다.
  .sink(receiveValue: {
    print($0)
  })
  .store(in: &subscriptions)





// ignoreOutput
let numbers = (1...10_000).publisher

numbers
  .ignoreOutput() // 아웃풋 무시..
  .sink(receiveCompletion: { print("Completed with: \($0)") }, // 얘만 호출!
        receiveValue: { print($0) }) // 만개의 데이터가 들어오지만 무시..
  .store(in: &subscriptions)

//Completed with: finished





// prefix
let tens = (1...10).publisher

tens
  .prefix(2) // 앞에서 두개만 받고 끝내겠다.
  .sink(receiveCompletion: { print("Completed with: \($0)") },
        receiveValue: { print($0) })
  .store(in: &subscriptions)

//1
//2
//Completed with: finished
