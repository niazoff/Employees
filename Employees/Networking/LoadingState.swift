enum LoadingState<Value> {
  case idle
  case loading
  case value(Value)
  case error
}

extension LoadingState: Equatable where Value: Equatable {}
