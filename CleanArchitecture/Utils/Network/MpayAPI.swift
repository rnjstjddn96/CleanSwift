//
//  MpayAPI.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire

enum MpayAPI {
    case TEST(_ string: String)
    case GET_PAY_HISTORY(days: Double, type: String)
    case GET_PAYMENT(startDate: Date, endDate: Date, cardNumber: Double?)
    
    //MARK: USER
    case HANDSHAKE(seed: String)
    case APPUSER(data: String, signatureImg: Data,
                 pincode: String, sign: String)
    case VERIFY_USER(pincode: String)
    case UPDATE_PINCODE(pincode: String, sign: String)
    case UPDATE_SIGNATURE(data: Data)
    case GET_TERMS(type: String)
    case GET_USER
    case LOCK_USER
    case UNLOCK_USER
    case DEREGISTER_USER
    
    //MARK: APP
    case GET_FAQS
    case GET_FAQS_GROUP
    case GET_NOTICE
    case GET_FRANCHISEE
    case GET_EVENT
    
    //MARK: PAYMENT
    case REQUEST_OTC(oriTid: String?, cardNumber: Double)
    
    //MARK: CARD
    case REGISTER_CARD_INFO
    case DELETE_CARD(id: String)
    case UPDATE_CARD_SEQUENCE(indexs: [String])
    case UPDATE_CARD_NAME(id: String, name: String)
    case GET_CARD(id: String)
    case GET_CARDS
    case SET_FAVORITE_CARD(id: String)
    case GET_FAVORITE_CARD
    case CHECK_LAST_CARD
    
    //MARK: TRANSACTION
    case TRANSACTION_HISTORY(month: String?) //202105
    case TRANSACTION_SUMMARY
    case TRANSACTION_TOP
}

extension MpayAPI: RequestBuilder {
    
    var request: DataRequest {
        let url = NetworkConfig.url.appendingPathComponent(path)
        let request: DataRequest =
            AF.request(url, method: method,
                       parameters: parameters,
                       encoding: self.method == .get ? URLEncoding.default : JSONEncoding.default,
                       headers: headers)
        return request
    }
    
    var path: String {
        switch self {
        case .TEST(let string):
            return string 
        case .GET_PAY_HISTORY(_, _):
            return "/payments/history"
        case .GET_PAYMENT(_, _, _):
            return "/payments"
        case .GET_USER:
            return "/appusers/profile"
        case .GET_TERMS(_):
            return "/terms"
        case .HANDSHAKE(_):
            return "/appusers/handshake"
        case .APPUSER(_, _, _, _):
            return "/appusers"
        case .DEREGISTER_USER:
            return "/appusers/unregister"
        case .VERIFY_USER(_):
            return "/appusers/verify"
        case .UPDATE_PINCODE(_, _):
            return "/appusers/pin-code"
        case .UPDATE_SIGNATURE(_):
            return "/appusers/sign"
        case .LOCK_USER:
            return "/appusers/lock"
        case .UNLOCK_USER:
            return "/appusers/unlock"
        case .GET_FAQS:
            return "/faqs"
        case .GET_FAQS_GROUP:
            return "faqs/group"
        case .GET_NOTICE:
            return "/notices"
        case .GET_FRANCHISEE:
            return "/stores"
            
        case .REGISTER_CARD_INFO:
            return "/cards/registerV2"
        case .DELETE_CARD(id: let id):
            return "/cards/v2/\(id)"
        case .UPDATE_CARD_NAME(id: let id,_):
            return  "/cards/\(id)/card-name"
        case .UPDATE_CARD_SEQUENCE(_):
            return "/cards/sequence"
        case .GET_CARD(id: let id):
            return "/cards/\(id)"
        case .GET_CARDS:
            return "/cards"
        case .CHECK_LAST_CARD:
            return "/cards/checkLast"
        case .GET_EVENT:
            return "/events"
        case .SET_FAVORITE_CARD(let id):
            return "/cards/\(id)/main"
        case .GET_FAVORITE_CARD:
            return "/cards/main"
        case .REQUEST_OTC(_,_):
            return "/payments/otc"
        case .TRANSACTION_HISTORY:
            return "/transactions/history"
        case .TRANSACTION_SUMMARY:
            return "/transactions/summary"
        case .TRANSACTION_TOP:
            return "/transactions/top"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .TEST(_):
            return .get
        case .GET_PAY_HISTORY(days: _, type: _):
            return .post
        case .GET_PAYMENT(_, _, _):
            return .get
        case .GET_TERMS(_):
            return .get
        case .HANDSHAKE(_):
            return .post
        case .APPUSER(_,_,_,_):
            return .post
        case .GET_USER:
            return .get
        case .UPDATE_PINCODE(_, _):
            return .put
        case .LOCK_USER:
            return .put
        case .UNLOCK_USER:
            return .put
        case .DEREGISTER_USER:
            return .post
        case .VERIFY_USER(_):
            return .post
        case .UPDATE_SIGNATURE(_):
            return .put
        case .GET_FAQS:
            return .get
        case .GET_FAQS_GROUP:
            return .get
        case .GET_NOTICE:
            return .get
        case .GET_FRANCHISEE:
            return .get
        case .REGISTER_CARD_INFO:
            return .post
        case .DELETE_CARD(_):
            return .delete
        case .UPDATE_CARD_SEQUENCE(_):
            return .put
        case .UPDATE_CARD_NAME(_,_):
            return .put
        case .GET_CARD(_):
            return.get
        case .GET_CARDS:
            return .get
        case .SET_FAVORITE_CARD:
            return .put
        case .GET_FAVORITE_CARD:
            return .get
        case .CHECK_LAST_CARD:
            return .get
        case .GET_EVENT:
            return .get
        case .REQUEST_OTC(_,_):
            return .post
            
        case .TRANSACTION_TOP:
            return .get
        case .TRANSACTION_HISTORY(_):
            return .get
        case .TRANSACTION_SUMMARY:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        switch self {
        
        //X-AUTH-TOKEN 필요, multipart
        case .APPUSER(_, _, _,_), .UPDATE_SIGNATURE(_):
            headers["Content-Type"] = "multipart/form-data"
            if let token =
                prefs.value(forKey: PrefsEnum.X_AUTH_TOKEN.rawValue) as? String, !token.isEmpty {
                headers["X-Auth-Token"] = token
                headers["x-auth-type"] = "mpay"
            }
            return headers
            
        //X-AUTH-TOKEN 필요, JSON
        case .UPDATE_PINCODE(_, _), .REGISTER_CARD_INFO, .DELETE_CARD(_),
             .UPDATE_CARD_SEQUENCE(_), .UPDATE_CARD_NAME(_,_),
             .GET_CARD(_), .GET_CARDS, .GET_USER, .VERIFY_USER(_), .LOCK_USER, .UNLOCK_USER,
             .REQUEST_OTC(_,_), .SET_FAVORITE_CARD, .GET_FAVORITE_CARD,
             .TRANSACTION_SUMMARY, .TRANSACTION_HISTORY(_), .TRANSACTION_TOP,
             .GET_PAYMENT(startDate: _, endDate: _, cardNumber: _), .GET_PAY_HISTORY(days: _, type: _),
             .DEREGISTER_USER, .CHECK_LAST_CARD :

            headers["x-auth-type"] = "mpay"
            
            if let token =
                prefs.value(forKey: PrefsEnum.X_AUTH_TOKEN.rawValue) as? String, !token.isEmpty {
                headers["X-Auth-Token"] = token
            }
            if method != .get {
                headers["Content-Type"] = "application/json"
            }
            return headers
        
        //X-AUTH-TOKEN 필요 X, JSON
        default:
            if method != .get {
                headers["Content-Type"] = "application/json"
            }
            return headers
        }
    }
    
    var parameters: Parameters? {
        var parameters = Parameters()
        
        switch self {
        case .TEST(_):
            return nil
            
        case .GET_PAY_HISTORY(days: let days, type: let type):
            parameters.updateValue(days, forKey: "days")
            parameters.updateValue(type, forKey: "type")
            return parameters
            
        case .GET_PAYMENT(startDate: let startDate, endDate: let endDate, cardNumber: let cardNumber):
            var parameters = Parameters()
            var dateGteParam: [String: Any] = [:]
            var dateLteParam: [String: Any] = [:]
            var and: [[String: Any]] = []
            
            let paymentDateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
                formatter.timeZone = TimeZone(abbreviation: "UTC")
                return formatter
            }()
            
            let startDateParam = startDate.setTime(hour: 00, min: 00,
                                                   sec: 00, timeZoneAbbrev: "KST") ?? Date()
            let endDateParam = endDate.setTime(hour: 23, min: 59,
                                               sec: 59, timeZoneAbbrev: "KST") ?? Date()
            
            dateGteParam.updateValue(paymentDateFormatter.string(from: startDateParam), forKey: "gte")
            dateLteParam.updateValue(paymentDateFormatter.string(from: endDateParam), forKey: "lte")

            let gte = [
                ["created": dateGteParam]
            ]
            
            let lte = [
                ["updated": dateLteParam]
            ]
            and.append(contentsOf: gte)
            and.append(contentsOf: lte)
            
            if let _cardNumber = cardNumber {
                and.append(["cardNumber": _cardNumber])
            }
            
            parameters.updateValue(["and": and], forKey: "where")
            
            let result = ["filter": parameters]
            return result
            
        case .UPDATE_SIGNATURE(_):
            return nil
            
        case .UPDATE_PINCODE(let encPin, let sign):
            parameters.updateValue(encPin, forKey: "pinCode")
            parameters.updateValue(sign, forKey: "sign")
            parameters.updateValue("mpay", forKey: "type")
            return parameters
        case .GET_USER:
            return nil
        case .LOCK_USER:
            return nil
        case .UNLOCK_USER:
            return nil
        case .DEREGISTER_USER:
            return nil
        case .GET_TERMS(let type):
            if type != "" {
                var _query = [String: Any]()
                var _where = [String: Any]()
                _where.updateValue(type, forKey: "data.type")
                _query.updateValue(_where, forKey: "where")
                
                parameters.updateValue(_query, forKey: "filter")
            }
            return parameters
            
        case .HANDSHAKE(let seed):
            parameters.updateValue(seed, forKey: "seed")
            parameters.updateValue("mpay", forKey: "type")
            return parameters
            
        case .APPUSER(let data, _, let pincode, let sign):
            parameters.updateValue(data, forKey: "data")
            parameters.updateValue("mpay", forKey: "type")
            parameters.updateValue(pincode, forKey: "pinCode")
            parameters.updateValue(sign, forKey: "sign")
            return parameters
            
        case .VERIFY_USER(let pinCode):
            parameters.updateValue("mpay", forKey: "type")
            parameters.updateValue(pinCode, forKey: "pinCode")
            return parameters
            
        case .GET_FAQS:
            return nil
        case .GET_FAQS_GROUP:
            return nil
        case .GET_NOTICE:
            return nil
        case .GET_FRANCHISEE:
            return nil
        case .REGISTER_CARD_INFO:
            return nil
        case .DELETE_CARD(_):
            return nil
        case .UPDATE_CARD_SEQUENCE(indexs: let indexs):
            parameters["cardIds"] = indexs
            return parameters
        case .UPDATE_CARD_NAME(id: _, name: let name):
            parameters["cardName"] = name
            return parameters
        case .GET_CARD(_):
            return nil
        case .GET_CARDS:
            var query = [String: String]()
            query.updateValue("sequence ASC", forKey: "order")
            parameters.updateValue(query, forKey: "filter")
            return parameters
        case .SET_FAVORITE_CARD(let id):
            parameters.updateValue(id, forKey: "id")
            return parameters
        case .GET_FAVORITE_CARD:
            return nil
        case .CHECK_LAST_CARD:
            return nil
        case .GET_EVENT:
            return nil
            
        case .REQUEST_OTC(let originTid, let cardNumber):
            if let oriTid = originTid {
                parameters.updateValue(oriTid, forKey: "oriTid")
            }
            parameters.updateValue(cardNumber, forKey: "cardNumber")
            return parameters
        
        case .TRANSACTION_HISTORY(let month):
            if let _month = month {
                parameters.updateValue(_month, forKey: "month")
            }
            return parameters
        case .TRANSACTION_SUMMARY:
            return nil
        case .TRANSACTION_TOP:
            return nil
        }
    }
    
    var multipartData: Multiparts? {
        var multipartItem = [String: Data?]()
        switch self {
        case .APPUSER(_, signatureImg: let signature, _, _):
            multipartItem["signatureImg"] = signature
        case .UPDATE_SIGNATURE(data: let signature):
            multipartItem["signatureImg"] = signature
        default:
            break
        }
        return multipartItem
    }
}
