//
//  Protocols.swift
//  MusiX
//
//  Created by Timofey on 16.07.24.
//

import Foundation
import UIKit

protocol CellProtocols: AnyObject {
    static var reuseId: String { get set }
}

protocol LibraryViewControllerDelegate: AnyObject {
    func didSelectedSong(image: UIImage?, track: String, artist: String)
    
}
