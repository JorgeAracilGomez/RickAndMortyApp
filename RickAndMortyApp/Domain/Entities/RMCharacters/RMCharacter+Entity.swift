//
//  RMCharacter+Entity.swift
//  RickAndMortyApp
//
//  Created by Jorge Aracil Gomez on 3/2/23.
//

import Foundation

struct RMCharacterEntity {
    /// The id of the character.
    var id: Int?
    /// The name of the character.
    var name: String?
    /// The status of the character ('Alive', 'Dead' or 'unknown').
    var status: RMCharacterStatusEntity?
    /// The species of the character.
    var species: String?
    /// The type or subspecies of the character.
    var type: String?
    /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
    var gender: RMCharacterGenderEntity?
    /// Name and link to the character's origin location.
    var origin: RMCharacterLocationEntity?
    /// Name and link to the character's last known location endpoint.
    var location: RMCharacterLocationEntity?
    /// Link to the character's image. All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
    var image: String?
    /// List of episodes in which this character appeared.
    var episode: [String]?
    /// Link to the character's own URL endpoint.
    var url: String?
    /// Time at which the character was created in the database.
    var created: String?
    
    /// Entity inicializer from decodable
    /// - Parameter decodable: Decodable representation for the Charactres Response.
    init(decodable: RMCharacterDecodable) {
        self.id = decodable.id
        self.name = decodable.name
        self.status = RMCharacterStatusEntity(stringValue: decodable.status ?? "")
        self.species = decodable.species
        self.type = decodable.type
        self.gender = RMCharacterGenderEntity(stringValue: decodable.gender ?? "")
        if let originDecodable = decodable.origin {
            self.origin = RMCharacterLocationEntity(decodable: originDecodable)
        }
        if let locationDecodable = decodable.location {
            self.location = RMCharacterLocationEntity(decodable: locationDecodable)
        }
        self.image = decodable.image
        self.episode = decodable.episode
        self.url = decodable.url
        self.created = decodable.created
    }
}
