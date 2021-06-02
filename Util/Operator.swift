//
//  Operator.swift
//  client
//
//  Created by 盛子康 on 2021/3/30.
//
//带log解包操作符，该操作符在测试环境上如果取nil会崩溃，正式环境回提供默认值
infix operator !?

public func !?<T: ExpressibleByIntegerLiteral>
    (wrapped: T?, failureText: @autoclosure () -> String) -> T
{
    assert(wrapped != nil, failureText())
    return wrapped ?? 0
}

public func !?<T: ExpressibleByArrayLiteral>
    (wrapped: T?, failureText: @autoclosure () -> String) -> T
{
    assert(wrapped != nil, failureText())
    return wrapped ?? []
}

public func !?<T: ExpressibleByStringLiteral>
    (wrapped: T?, failureText: @autoclosure () -> String) -> T
{
    assert(wrapped != nil, failureText())
    return wrapped ?? ""
}

public func !?<T: ExpressibleByBooleanLiteral>
    (wrapped: T?, failureText: @autoclosure () -> String) -> T
{
    assert(wrapped != nil, failureText())
    return wrapped ?? false
}

public func !?<T>(wrapped: T?,
              nilDefault: @autoclosure () -> (value: T, text: String)) -> T
{
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}
//some?.do("something") !? "可选链未执行该方法" 在调试终止，在正式上，该方法没执行不会闪退
public func !?(wrapped: ()?, failureText: @autoclosure () -> String) {
    assert(wrapped != nil, failureText())
}

//带log解包操作符，该操作符在测试环境正式环境取nil都会崩溃
infix operator !!

public func !! <T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped { return x }
    fatalError(failureText())
}
