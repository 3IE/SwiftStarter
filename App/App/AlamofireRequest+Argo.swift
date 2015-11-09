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
        return responseJSON(completionHandler: { response -> Void in
            printValues(response.request, response: response.response, result: response.result)
            
            switch (response.result) {
            case .Success(let value):
                let decodedObject: Decoded<T> = decode(value)
                
                handleSuccess(decodedObject, completionHandler: completionHandler)
            case .Failure(_):
                if let errorData: NSData = response.data {
                    print(":::::::")
                    print(NSString(data: errorData, encoding: NSUTF8StringEncoding))
                    print(":::::::")
                    handleErrorWithObject(errorData, completionHandler: completionHandler)
                } else {
                    completionHandler(success: false, successObject: nil, errorObject: AppError.NoResponse("No Response"))
                }
            }
        })
    }
    
    
    public func responseArgoArray<T: Decodable where T == T.DecodedType>(completionHandler: (success: Bool, successObject: [T]?, errorObject: AppError?) -> Void) -> Self {
        return responseJSON(completionHandler: { response -> Void in
            printValues(response.request, response: response.response, result: response.result)
            
            switch (response.result) {
            case .Success(let value):
                let decodedObject: Decoded<[T]> = decode(value)
                
                handleSuccess(decodedObject, completionHandler: completionHandler)
            case .Failure(_):
                if let errorData: NSData = response.data {
                    handleErrorWithObject(errorData, completionHandler: completionHandler)
                } else {
                    completionHandler(success: false, successObject: nil, errorObject: AppError.NoResponse("No Response"))
                }
            }
        })
    }
}

//MARK: - Helpers

private func printValues<Value, Error>(request: NSURLRequest?, response: NSHTTPURLResponse?, result: Result<Value, Error>) -> () {
    print("===============================")
    print(request)
    print(response)
    print(result)
    print("===============================")
}

private func handleErrorWithObject<T>(object: AnyObject, completionHandler: (success: Bool, successObject: T?, errorObject: AppError?) -> Void) -> Void {
    /*if let decodedError: AppError = decode(object) {
    completionHandler(success: false, successObject: nil, errorObject: decodedError)
    } else {
    completionHandler(success: false, successObject: nil, errorObject: AppError.Parsing("parsing error in error server"))
    }*/
    do {
        let JSON = try NSJSONSerialization.JSONObjectWithData(object as! NSData, options: NSJSONReadingOptions.AllowFragments)
        if let decodedError: AppError = decode(JSON) {
            completionHandler(success: false, successObject: nil, errorObject: decodedError)
        } else {
            completionHandler(success: false, successObject: nil, errorObject: AppError.Parsing("parsing error in error server"))
        }
    } catch {
        completionHandler(success: false, successObject: nil, errorObject: AppError.Parsing("parsing error in error server"))
    }
}

private func handleSuccess<T>(decodedObject: Decoded<T>, completionHandler: (success: Bool, successObject: T?, errorObject: AppError?) -> Void) -> Void {
    switch decodedObject {
    case .Failure(let error):
        switch error {
        case .MissingKey(let message):
            completionHandler(success: false, successObject: nil, errorObject: AppError.MissingKey(message))
        case .TypeMismatch(let message, let value):
            completionHandler(success: false, successObject: nil, errorObject: AppError.TypeMismatch(message, value))
        case .Custom(let message):
            completionHandler(success: false, successObject: nil, errorObject: AppError.TypeMismatch(message, ""))
        }
    case .Success(let value):
        completionHandler(success: true, successObject: value, errorObject: nil)
    }
}