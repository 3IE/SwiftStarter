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
import Runes

extension Alamofire.Request {
    public func responseArgoObject<T: Decodable where T == T.DecodedType>(completionHandler: (success: Bool, successObject: T?, errorObject: NSError?) -> Void) -> Self {
        return response(serializer: Request.JSONResponseSerializer(), completionHandler: { (request, response, responseJSON, alamofireError) in
            printValues(request, response, alamofireError)
            
            if let object: AnyObject = responseJSON {
                if let error = alamofireError {
                    handleErrorWithObject(object, completionHandler)
                } else {
                    let decodedObject: Decoded<T> = decode(object)
                    
                    handleSuccess(decodedObject, completionHandler)
                }
            } else {
                completionHandler(success: false, successObject: nil, errorObject: NSError(error:ErrorType.NoResponse, message:"No Response"))
            }
        })
    }
    
    public func responseArgoArray<T: Decodable where T == T.DecodedType>(completionHandler: (success: Bool, successObject: [T]?, errorObject: NSError?) -> Void) -> Self {
        return response(serializer: Request.JSONResponseSerializer(), completionHandler: { (request, response, responseJSON, alamofireError) in
            printValues(request, response, alamofireError)
            
            if let object: AnyObject = responseJSON {
                if let error = alamofireError {
                    handleErrorWithObject(object, completionHandler)
                } else {
                    let decodedObject: Decoded<[T]> = decode(object)
                    
                    handleSuccess(decodedObject, completionHandler)
                }
            } else {
                completionHandler(success: false, successObject: nil, errorObject: NSError(error:ErrorType.NoResponse, message:"No Response"))
            }
        })
    }
}

//MARK: - Helpers

private func printValues(request: NSURLRequest, response: NSHTTPURLResponse?, alamofireError: NSError?) -> () {
    println("===============================")
    println(request)
    println(response)
    println(alamofireError)
    println("===============================")
}

private func handleErrorWithObject<T>(object: AnyObject, completionHandler: (success: Bool, successObject: T?, errorObject: NSError?) -> Void) -> Void {
    if let decodedError: NSError? = decode(object) {
        completionHandler(success: false, successObject: nil, errorObject: decodedError)
    } else {
        completionHandler(success: false, successObject: nil, errorObject: NSError(error:ErrorType.Parsing, message:"parsing error in error server"))
    }
}

private func handleSuccess<T>(decodedObject: Decoded<T>, completionHandler: (success: Bool, successObject: T?, errorObject: NSError?) -> Void) -> Void {
    switch decodedObject {
    case .MissingKey(let message):
        completionHandler(success: false, successObject: nil, errorObject: NSError(error:ErrorType.NoResponse, message:message))
    case .TypeMismatch(let message):
        completionHandler(success: false, successObject: nil, errorObject: NSError(error:ErrorType.NoResponse, message:message))
    case .Success(let value):
        completionHandler(success: true, successObject: decodedObject.value, errorObject: nil)
    }
}