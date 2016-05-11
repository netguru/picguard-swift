//
// Result.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public enum Result<T> {
	case Value(T)
	case Error(ErrorType)
}
