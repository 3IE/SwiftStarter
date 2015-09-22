//
//  AlamofireRequest+Argo.swift
//  App
//
//  Created by Cédric Eugeni on 05/06/2015.
//  Copyright (c) 2015 Cédric Eugeni. All rights reserved.
//

import Foundation
import Alamofire
import Argo
import Curry

extension Alamofire.Request {
    public func responseArgoObject<T: Decodable where T == T.DecodedType>(completionHandler: (success: Bool, successObject: T?, errorObject: AppError?) -> Void) -> Self {
        return responseJSON(completionHandler: { (request, response, result) -> Void in
            printValues(request, response: response, result: result)
            
            switch (result) {
            case .Success(let value):
                let decodedObject: Decoded<T> = decode(value)
                
                handleSuccess(decodedObject, completionHandler: completionHandler)
            case .Failure(let data, _):
                if let errorData: NSData = data {
                    handleErrorWithObject(errorData, completionHandler: completionHandler)
                } else {
                    completionHandler(success: false, successObject: nil, errorObject: AppError.NoResponse("No Response"))
                }
            }
        })
    }
    
    public func responseArgoArray<T: Decodable where T == T.DecodedType>(completionHandler: (success: Bool, successObject: [T]?, errorObject: AppError?) -> Void) -> Self {
        return responseJSON(completionHandler: { (request, response, result) -> Void in
            printValues(request, response: response, result: result)
            
            switch (result) {
            case .Success(let value):
                let decodedObject: Decoded<[T]> = decode(value)
                
                handleSuccess(decodedObject, completionHandler: completionHandler)
            case .Failure(let data, _):
                if let errorData: NSData = data {
                    handleErrorWithObject(errorData, completionHandler: completionHandler)
                } else {
                    completionHandler(success: false, successObject: nil, errorObject: AppError.NoResponse("No Response"))
                }
            }
        })
    }
}


//MARK: - Helpers

private func printValues(request: NSURLRequest?, response: NSHTTPURLResponse?, result: Result<AnyObject>) -> () {
    print("===============================")
    print(request)
    print(response)
    print(result)
    print("===============================")
}

private func handleErrorWithObject<T>(object: AnyObject, completionHandler: (success: Bool, successObject: T?, errorObject: AppError?) -> Void) -> Void {
    if let decodedError: AppError = decode(object) {
        completionHandler(success: false, successObject: nil, errorObject: decodedError)
    } else {
        completionHandler(success: false, successObject: nil, errorObject: AppError.Parsing("parsing error in error server"))
    }
}

private func handleSuccess<T>(decodedObject: Decoded<T>, completionHandler: (success: Bool, successObject: T?, errorObject: AppError?) -> Void) -> Void {
    switch decodedObject {
    case .Failure(let decodedError):
        switch decodedError {
        case .MissingKey(let message):
            completionHandler(success: false, successObject: nil, errorObject: AppError.MissingKey(message))
        case .TypeMismatch(expected: let expected, actual: let actual):
            completionHandler(success: false, successObject: nil, errorObject: AppError.TypeMismatch(expected, actual))
        }
    case .Success(let value):
        completionHandler(success: true, successObject: value, errorObject: nil)
    }
}