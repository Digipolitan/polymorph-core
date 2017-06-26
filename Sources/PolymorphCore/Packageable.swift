//
//  Packageable.swift
//  PolymorpthCore
//
//  Created by Benoit BRIATTE on 15/06/2017.
//

import Foundation

public protocol Packageable: Codable {
    var package: Package { get set }
}

extension Packageable {

    static func check(package: String) throws {
        let availableCharacters = CharacterSet(charactersIn: ".abcdefghijklmopqrstuvwxyz")
        for ch in package {
            for scalar in ch.unicodeScalars {
                if !availableCharacters.contains(scalar) {
                    throw PolymorphCoreError.notAvailableInPackage(character: ch)
                }
            }
        }
    }

    /*
 static appendPackage(aPackage, sub) {
 if (sub && sub.length > 0) {
 if (aPackage.length > 0) {
 return aPackage + "." + sub
 } else {
 return sub;
 }
 }
 return aPackage;
 }
 /**
 * Transform a package string to an array (split dot)
 * @param {?string} aPackage
 * @return {!string[]}
 */
 static asArray(aPackage) {
 if (aPackage) {
 return aPackage.split(".");
 }
 return [];
 }
 /**
 * Retrieve the relative path from a mainPackage to a childPackage
 * @param {!string} mainPackage
 * @param {!string} childPackage
 * @param {?boolean} camelCase
 */
 static relativePath(mainPackage, childPackage, camelCase) {
 const indexOf = childPackage.indexOf(mainPackage);
 if (indexOf >= 0) {
 childPackage = childPackage.substring(indexOf + mainPackage.length + 1);
 }
 return PackageUtils.absolutePath(childPackage, camelCase);
 }
 /**
 * Transform the input package to an absolute system path
 * @param {!string} aPackage
 * @param {?boolean} camelCase
 * @return {!string}
 */
 static absolutePath(aPackage, camelCase) {
 const components = this.asArray(aPackage);
 if (camelCase) {
 for (let i in components) {
 components[i] = StringUtils.camelCaseString(components[i], 1);
 }
 }
 return path.join.apply(this, components);
 }
 */

}

