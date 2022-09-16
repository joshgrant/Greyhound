//
//  Copier.swift
//  Heartbeat
//
//  Created by Joshua Grant on 9/15/22.
//

import Foundation

protocol Copyable: Codable { }

extension Copyable
{
    func deepCopy() -> Self?
    {
        do
        {
            let json = try JSONEncoder().encode(self)
            return try JSONDecoder().decode(Self.self, from: json)
        }
        catch let error
        {
            print(error)
            return nil
        }
    }
}
