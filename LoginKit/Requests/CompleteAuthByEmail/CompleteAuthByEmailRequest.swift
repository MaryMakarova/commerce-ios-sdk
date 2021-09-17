// Copyright 2021-present Xsolla (USA), Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at q
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing and permissions and

import Foundation
import XsollaSDKUtilities

class CompleteAuthByEmailRequest: LoginBaseRequest<CompleteAuthByEmailRequest.Params>, APIRequestProtocol
{
    typealias ResponseModel = CompleteAuthByEmailResponse
    typealias ErrorHandler = CompleteAuthByEmailErrorHandler
    typealias ErrorModel = LoginAPIErrorModel
    typealias ErrorType = LoginAPIError
    typealias Callback = (Result<ResponseModel, ErrorType>) -> Void
    
    let errorHandler = ErrorHandler()
    
    // MARK: - Request settings
    
    override var httpMethod: HTTPMethod { .post }
    
    override var relativePath: String { "/oauth2/login/email/confirm" }
    
    override var specialQueryParameters: QueryParameters { ["client_id": String(params.clientId)] }
    
    override var bodyParameters: Encodable?
    {
        ["code": params.code,
        "email": params.email,
        "operation_id": params.operationId]
    }
    
    func handleSuccess(model: ResponseModel, completionHandler: Callback)
    {
        completionHandler(.success(model))
    }
    
    func handleFailure(error: ErrorType, completionHandler: Callback)
    {
        completionHandler(.failure(error))
    }
}

extension CompleteAuthByEmailRequest
{
    struct Params: RequestParams
    {
        let clientId: Int
        let code: String
        let email: String
        let operationId: String
    }
}
