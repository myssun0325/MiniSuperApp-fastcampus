//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by YoungsunMoon on 2022/03/03.
//

import Combine
import CombineExt
import Foundation

// 데이터를 사용하는 객체는 value 프로퍼티로 read.
public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
  
  public typealias Output = Element
  public typealias Failure = Never
  
  public var value: Element {
    currentValueRelay.value
  }
  
  fileprivate let currentValueRelay: CurrentValueRelay<Output>
  
  fileprivate init(_ initialValue: Element) {
    currentValueRelay = CurrentValueRelay(initialValue)
  }
  
  public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
    currentValueRelay.receive(subscriber: subscriber)
  }
  
}

// 데이터를 관리하는 객체가 send를 해주고
public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
  
  typealias Output = Element
  typealias Failure = Never
  
  public override init(_ initialValue: Element) {
    super.init(initialValue)
  }

  public func send(_ value: Element) {
    currentValueRelay.accept(value)
  }
  
}
