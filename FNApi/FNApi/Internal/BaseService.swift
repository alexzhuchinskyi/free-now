//
//  BaseService.swift
//  FNApi
//
//  Created by Alexandr Zhuchinskiy
//  Copyright © 2019 Alexandr Zhuchinskiy. All rights reserved.
//

import Alamofire
import BrightFutures

public class BaseService {
    private enum Constants {
        static let baseURL = "https://poi-api.mytaxi.com"
    }

    func performRequest<T: FNDecodable>(with path: String, params: Parameters? = nil, method: HTTPMethod = .get) -> Future<T, APIError> {
        return Future { completion in
            let url = Constants.baseURL + path
            Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.queryString)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let model = try T.decode(data: data)
                            completion(.success(model))
                        }
                        catch {
                            completion(.failure(.jsonParsing))
                        }
                    case .failure(let error):
                        completion(.failure(error.tryAsAPIError()))
                    }
            }
        }
    }
}
