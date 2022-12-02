//
//  Router.swift
//  iOSInterview
//
//  Created by Eric Jubber on 11/30/22.
//

import Foundation


enum Router {
    case getQuestions(id: Int?, page: Int?)
    case answerQuestion(body: [String: Any])
    case likeAnswer(body: [String: Any])
    case unlikeAnswer(body: [String: Any])
    
    private static var baseURL = "https://us-central1-ivella-372e0.cloudfunctions.net"
    
    private enum HTTPMethod {
        case get
        case post
        case put
        case delete
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }
    
    private var method: HTTPMethod {
        switch self {
            case .getQuestions: return .get
            case .answerQuestion: return .post
            case .likeAnswer: return .post
            case .unlikeAnswer: return .post
        }
    }
    
    private var path: String {
        switch self {
        case .getQuestions(let id, let page):
            var base = "/prompts?"
            if let id = id {
                base.append("prompt_id=\(id)")
            } else if let page = page {
                base.append("page=\(page)")
            }
            return base
        case .answerQuestion(_):
            return "/answer"
        case .likeAnswer(_):
            return "/likeAnswer"
        case .unlikeAnswer(_):
            return "/unlikeAnswer"
        }
    }
    
    func makeURLRequest() throws -> URLRequest {
        let urlString = "\(Router.baseURL)\(path)"
        
        guard let url = URL(string: urlString) else {
            throw "Invalid URL"
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
            case .getQuestions(_, _):
                return request
            case .answerQuestion(let body):
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                return request
            case .likeAnswer(let body):
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                return request
            case .unlikeAnswer(let body):
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                return request
        }
    }
    
}
