//
//  Credential.swift
//  20220321-KingtakWong-NYCSchools
//
//  Created by Kingtak Justin Wong on 3/19/22.
//

import Foundation

protocol Credential {
    var apitoken: String { get }
    var urlBase: String { get }
    var privateAPIKey: String { get }
}
