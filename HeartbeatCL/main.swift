//
//  main.swift
//  HeartbeatCL
//
//  Created by Joshua Grant on 9/19/22.
//

import Foundation
import Heartbeat

// Energy is the lifeblood of everything...

// Accurately predicting atomic behavior is not possible with classical physics... but we
// can accurately predict atomic behavior _en masse_ using classical physics.

// We can convert between energy and mass with Einsteins equation

// The sun is a system of balance between outward thermal pressure and inward gravitational pressure

// It takes 4 hydrogen atoms to fuse into 1 helium atom. The leftover energy is released.
// Or... is it 2 hydrogen atoms?

// One way of staying balanced is by minimizing any extra energy...

// "Mass defect" is the amount of energy released when protons and neutrons come together to form a nucleus

// When two atoms are combined into a heavier atom, they release energy, electrons, photons, etc
// When two atoms are split into smaller atoms, they also release energy, electrons, photons, etc.

// How much energy is required to remove an ion? to add an ion?

// Fusion of materials less than Iron/Nickel generally releases energy...
// Fusion of materials greater than Iron/Nickel generally requires energy...

// Our system attempts to reduce the energy of the system to zero... right?

// Nuclear force combines protons and neutrons
// Coulomb force repels protons and neutrons
// Protons repel eachother because they're positively charged (i.e imbalance)
// Atoms repel eachother (electrostatic repulsion) but when brought close enough together, can fuse
// By fusing, they create an atom of higher mass, but release energy in the process

/*
 
 3 helium atoms fusing to give a carbon atom: 3 @ 4He → 12C
 carbon atom + helium atom fusing to give an oxygen atom: 12C + 4He → 16O
 oxygen atom + helium atom fusing to give a neon atom: 16O + 4He → 20Ne
 neon atom + helium atom fusing to give a magnesium atom: 20Ne + 4He → 24Mg

 */

/// Okay... so normally, nuclei repel eachother because of the protons. The electrons aren't really at play
/// But then, if brought close enough together, they attract eachother due to a close-contact force and release energy to be in a more stable state (i.e a more massive atom)...


///
/// So if everything is a flow... and everything is a stock... let's say we have a billion hydrogen atoms? do we have to run a physics simulation on them?
/// Or can we just create a flow that will "simulate" how many there are?
/// The flow just... approximates the behavior of the atoms, right? For example, the Sun - we know that it's a system of Hydrogen being converted into Helium,
/// which releases a certain amount of energy...
///
/// The question is: if this behavior is emergent, can we simplify the physics simulation when we zoom out? Can we create the rules that convert helium into hydrogen, and then zoom out
/// and have the sun as an emergent system that doesn't need to simulate so many atoms?
///
/// Is emergent reduction just time-based? As in, do I need to take the integral of the equation to determine the new system?
///
/// And.. is there something inherent in the structure of the atoms that yields the behavior that they follow? Or do we need other rules as well? Like gravity?
///
/// The types I recall are e.m. interaction, strong, weak, and gravitational. As Feynman explains, the existence of these interactions are fundamental axioms of our universe.
///

///
/// The electron can gain the energy it needs by absorbing light (a photon). If the electron jumps from the second energy level down to the first energy level, it must give off some energy by emitting a photon. Only a photon with an energy of exactly 10.2 eV can be absorbed or emitted when the electron jumps between the n = 1 and n = 2 energy levels.
///
/// So... that being said... photons will be travelling around, lighting things up... If they hit an atom, that atom becomes an isotope.
/// Are photons the smallest amount of energy?
/// No... and not all photons are the same size. Photons change size depending on how much energy is released.
/// Energy of a photon is directly proportional to the frequency of light??
/// E = hf, where the energy is equal to the Planck constant, multiplied by the frequency of light (1.054571817...×10−34 J⋅s)
/// So energy is quantized by an amount... essentially equal to the Planck constant
///
///
/// Not only can atoms send off extra energy in their electrons by sending out a photon, but atoms can form molecules when
/// the unbalanced electrons balance eachother out.
///
/// For molecules - they are systems of stocks... i.e NaCl is actually a system of a sodium atom and a chlorine atom
/// and the system can be unstable, of course... But NaCl isn't a constant. It's still a system
///
///

/// Photons are tricky. Not only does the amount of energy change (i.e not all photons are the same) but also
/// their mass changes depending on how fast they're moving.
/// Maybe... modern physics doesn't take into consideration of the mass of a photon, and that's why they need to invent dark energy
/// But really, we just need to conserve energy (we know that energy can be converted into mass when divided by the speed of light, squared)
/// and if a photon is moving at the speed of light, then...
///
/// Let's start from the beginning. Energy is not quantized. 

let speedOfLight = Measurement<UnitSpeed>.init(value: 299_792_458, unit: .metersPerSecond)

let neutronMassCoefficient = 1.67492749804e-27
let protonMassCoefficient = 1.67262192369e-27
let electronMassCoefficient = 9.1093837015e-31

let neutronEnergyCoefficient = neutronMassCoefficient * speedOfLight.value * speedOfLight.value
let protonEnergyCoefficient = protonMassCoefficient * speedOfLight.value * speedOfLight.value
let electronEnergyCoefficient = electronMassCoefficient * speedOfLight.value * speedOfLight.value

extension UnitEnergy
{
    static let neutron = UnitEnergy(symbol: "n", converter: UnitConverterLinear(coefficient: neutronEnergyCoefficient))
    static let proton = UnitEnergy(symbol: "p", converter: UnitConverterLinear(coefficient: protonEnergyCoefficient))
    static let electron = UnitEnergy(symbol: "e", converter: UnitConverterLinear(coefficient: electronEnergyCoefficient))
}

extension UnitMass
{
    static let neutron = UnitMass(symbol: "n", converter: UnitConverterLinear(coefficient: neutronMassCoefficient))
    static let proton = UnitMass(symbol: "p", converter: UnitConverterLinear(coefficient: protonMassCoefficient))
    static let electron = UnitMass(symbol: "e", converter: UnitConverterLinear(coefficient: electronMassCoefficient))
}

class Atom: System
{
    // MARK: - Variables
    
    var name: String
    
    var neutrons: Stock
    var protons: Stock
    var electrons: Stock
    
    // MARK: - Initialization
    
    init(name: String, neutrons: Double, protons: Double, electrons: Double)
    {
        self.name = name
        self.neutrons = Stock(unit: UnitEnergy.neutron, current: { neutrons }, maximum: { neutrons + neutrons * 0.5 }, ideal: { neutrons })
        self.protons = Stock(unit: UnitEnergy.proton, current: { protons }, maximum: { protons }, ideal: { protons })
        self.electrons = Stock(unit: UnitEnergy.electron, current: { electrons }, maximum: { electrons + 6 }, ideal: { electrons })
    }
}

extension Atom
{
    static let hydrogen = Atom(name: "Hydrogen", neutrons: 0, protons: 1, electrons: 1)
    static let helium = Atom(name: "Helium", neutrons: 2, protons: 2, electrons: 2)
    static let lithium = Atom(name: "Lithium", neutrons: 4, protons: 3, electrons: 3)
    static let beryllium = Atom(name: "Beryllium", neutrons: 5, protons: 4, electrons: 4)
    static let boron = Atom(name: "Boron", neutrons: 6, protons: 5, electrons: 5)
    static let carbon = Atom(name: "Carbon", neutrons: 6, protons: 6, electrons: 6)
    static let nitrogen = Atom(name: "Nitrogen", neutrons: 7, protons: 7, electrons: 7)
    static let oxygen = Atom(name: "Oxygen", neutrons: 8, protons: 8, electrons: 8)
    static let fluorine = Atom(name: "Fluorine", neutrons: 10, protons: 9, electrons: 9)
    static let neon = Atom(name: "Neon", neutrons: 10, protons: 10, electrons: 10)
    static let sodium = Atom(name: "Sodium", neutrons: 12, protons: 11, electrons: 11)
    static let magnesium = Atom(name: "Magnesium", neutrons: 12, protons: 12, electrons: 12)
    static let aluminum = Atom(name: "Aluminum", neutrons: 14, protons: 13, electrons: 13)
    static let silicon = Atom(name: "Silicon", neutrons: 14, protons: 14, electrons: 14)
    static let phosphorous = Atom(name: "Phosphorous", neutrons: 16, protons: 15, electrons: 15)
    static let sulfur = Atom(name: "Sulfur", neutrons: 16, protons: 16, electrons: 16)
    static let chlorine = Atom(name: "Chlorine", neutrons: 17, protons: 17, electrons: 17)
    static let argon = Atom(name: "Argon", neutrons: 22, protons: 18, electrons: 18)
    static let potassium = Atom(name: "Potassium", neutrons: 20, protons: 19, electrons: 19)
    static let calcium = Atom(name: "Calcium", neutrons: 20, protons: 20, electrons: 20)
    static let scandium = Atom(name: "Scandium", neutrons: 24, protons: 21, electrons: 21)
    static let titanium = Atom(name: "Titanium", neutrons: 26, protons: 22, electrons: 22)
    static let vanadium = Atom(name: "Vanadium", neutrons: 28, protons: 23, electrons: 23)
    static let chromium = Atom(name: "Chromium", neutrons: 28, protons: 24, electrons: 24)
    static let manganese = Atom(name: "Manganese", neutrons: 30, protons: 25, electrons: 25)
    static let iron = Atom(name: "Iron", neutrons: 30, protons: 26, electrons: 26)
    static let cobalt = Atom(name: "Cobalt", neutrons: 32, protons: 27, electrons: 27)
    static let nickel = Atom(name: "Nickel", neutrons: 31, protons: 28, electrons: 28)
    static let copper = Atom(name: "Copper", neutrons: 35, protons: 29, electrons: 29)
    static let zinc = Atom(name: "Zinc", neutrons: 35, protons: 30, electrons: 30)
    static let gallium = Atom(name: "Gallium", neutrons: 39, protons: 31, electrons: 31)
    static let germanium = Atom(name: "Germanium", neutrons: 41, protons: 32, electrons: 32)
    static let arsenic = Atom(name: "Arsenic", neutrons: 42, protons: 33, electrons: 33)
    static let selenium = Atom(name: "Selenium", neutrons: 45, protons: 34, electrons: 34)
    static let bromine = Atom(name: "Bromine", neutrons: 45, protons: 35, electrons: 35)
    static let krypton = Atom(name: "Krypton", neutrons: 48, protons: 36, electrons: 36)
    static let rubidium = Atom(name: "Rubidium", neutrons: 48, protons: 37, electrons: 37)
    static let strontium = Atom(name: "Strontium", neutrons: 50, protons: 38, electrons: 38)
    static let yttrium = Atom(name: "Yttrium", neutrons: 50, protons: 39, electrons: 39)
    static let zirconium = Atom(name: "Zirconium", neutrons: 51, protons: 40, electrons: 40)
    static let niobium = Atom(name: "Niobium", neutrons: 52, protons: 41, electrons: 41)
    static let molybdenum = Atom(name: "Molybdenum", neutrons: 54, protons: 42, electrons: 42)
    static let technetium = Atom(name: "Technetium", neutrons: 55, protons: 43, electrons: 43)
    static let ruthenium = Atom(name: "Ruthenium", neutrons: 57, protons: 44, electrons: 44)
    static let rhodium = Atom(name: "Rhodium", neutrons: 58, protons: 45, electrons: 45)
    static let palladium = Atom(name: "Palladium", neutrons: 60, protons: 46, electrons: 46)
    static let silver = Atom(name: "Silver", neutrons: 61, protons: 47, electrons: 47)
    static let cadmium = Atom(name: "Cadmium", neutrons: 64, protons: 48, electrons: 48)
    static let indium = Atom(name: "Indium", neutrons: 66, protons: 49, electrons: 49)
    static let tin = Atom(name: "Tin", neutrons: 69, protons: 50, electrons: 50)
    static let antimony = Atom(name: "Antimony", neutrons: 71, protons: 51, electrons: 51)
    static let tellurium = Atom(name: "Tellurium", neutrons: 76, protons: 52, electrons: 52)
    static let iodine = Atom(name: "Iodine", neutrons: 74, protons: 53, electrons: 53)
    static let xenon = Atom(name: "Xenon", neutrons: 77, protons: 54, electrons: 54)
    static let cesium = Atom(name: "Cesium", neutrons: 78, protons: 55, electrons: 55)
    static let barium = Atom(name: "Barium", neutrons: 81, protons: 56, electrons: 56)
    static let lanthanum = Atom(name: "Lanthanum", neutrons: 82, protons: 57, electrons: 57)
    static let cerium = Atom(name: "Cerium", neutrons: 82, protons: 58, electrons: 58)
    static let praseodymium = Atom(name: "Praseodymium", neutrons: 82, protons: 59, electrons: 59)
    static let neodymium = Atom(name: "Neodymium", neutrons: 84, protons: 60, electrons: 60)
    static let promethium = Atom(name: "Promethium", neutrons: 84, protons: 61, electrons: 61)
    static let samarium = Atom(name: "Samarium", neutrons: 88, protons: 62, electrons: 62)
    static let europium = Atom(name: "Europium", neutrons: 89, protons: 63, electrons: 63)
    static let gadolinium = Atom(name: "Gadolinium", neutrons: 93, protons: 64, electrons: 64)
    static let terbium = Atom(name: "Terbium", neutrons: 94, protons: 65, electrons: 65)
    static let dysprosium = Atom(name: "Dysprosium", neutrons: 97, protons: 66, electrons: 66)
    static let holmium = Atom(name: "Holmium", neutrons: 98, protons: 67, electrons: 67)
    static let erbium = Atom(name: "Erbium", neutrons: 99, protons: 68, electrons: 68)
    static let thulium = Atom(name: "Thulium", neutrons: 100, protons: 69, electrons: 69)
    static let ytterbium = Atom(name: "Ytterbium", neutrons: 103, protons: 70, electrons: 70)
    static let lutetium = Atom(name: "Lutetium", neutrons: 104, protons: 71, electrons: 71)
    static let hafnium = Atom(name: "Hafnium", neutrons: 106, protons: 72, electrons: 72)
    static let tantalum = Atom(name: "Tantalum", neutrons: 108, protons: 73, electrons: 73)
    static let tungsten = Atom(name: "Tungsten", neutrons: 110, protons: 74, electrons: 74)
    static let rhenium = Atom(name: "Rhenium", neutrons: 111, protons: 75, electrons: 75)
    static let osmium = Atom(name: "Osmium", neutrons: 114, protons: 76, electrons: 76)
    static let iridium = Atom(name: "Iridium", neutrons: 115, protons: 77, electrons: 77)
    static let platinum = Atom(name: "Platinum", neutrons: 117, protons: 78, electrons: 78)
    static let gold = Atom(name: "Gold", neutrons: 118, protons: 79, electrons: 79)
    static let mercury = Atom(name: "Mercury", neutrons: 121, protons: 80, electrons: 80)
    static let thallium = Atom(name: "Thallium", neutrons: 123, protons: 81, electrons: 81)
    static let lead = Atom(name: "Lead", neutrons: 125, protons: 82, electrons: 82)
    static let bismuth = Atom(name: "Bismuth", neutrons: 126, protons: 83, electrons: 83)
    static let polonium = Atom(name: "Polonium", neutrons: 125, protons: 84, electrons: 84)
    static let astatine = Atom(name: "Astatine", neutrons: 125, protons: 85, electrons: 85)
    static let radon = Atom(name: "Radon", neutrons: 136, protons: 86, electrons: 86)
    static let francium = Atom(name: "Francium", neutrons: 136, protons: 87, electrons: 87)
    static let radium = Atom(name: "Radium", neutrons: 138, protons: 88, electrons: 88)
    static let actinium = Atom(name: "Actinium", neutrons: 138, protons: 89, electrons: 89)
    static let thorium = Atom(name: "Thorium", neutrons: 142, protons: 90, electrons: 90)
    static let protactinium = Atom(name: "Protactinium", neutrons: 148, protons: 91, electrons: 91)
    static let uranium = Atom(name: "Uranium", neutrons: 146, protons: 92, electrons: 92)
}

class Universe: System
{
    var energy: Stock
    
    init(energy: Stock)
    {
        self.energy = energy
    }
}

//let energy = Stock(unit: UnitEnergy.photon, current: { 10e80 }, maximum: { 10e100 }, ideal: { 0 })
//let universe = Universe(energy: energy)
//
//print(energy.current)
