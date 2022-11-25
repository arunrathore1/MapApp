//
//  LocationViewModel.swift
//  MapApp
//
//  Created by Arun Rathore on 25/08/22.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {

  @Published var locations: [Location]
  @Published var mapLocation: Location {
    didSet {
      updateMapRegion(location: mapLocation)
    }
  }
  @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
  @Published var showLocationList: Bool = false
  @Published var sheetLocation: Location? = nil
  let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

  init() {
    let locations = LocationsDataService.locations
    self.locations = locations
    self.mapLocation = locations.first!
    self.updateMapRegion(location: locations.first!)
  }

  private func updateMapRegion(location: Location) {
    withAnimation(.easeInOut) {
      mapRegion = MKCoordinateRegion(
        center: location.coordinates,
        span: mapSpan)
    }
  }

   func toggleLocationList() {
    withAnimation(.easeInOut) {
      showLocationList = !showLocationList
    }
  }

  func showNextLocation(location: Location) {
    withAnimation(.easeInOut) {
      mapLocation = location
      showLocationList = false
    }
  }


  func nextButtonPressed() {

//    Get the current Index

    guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
      print("Could not find current index")
      return
    }
//    Check if the current index valid
    let nextIndex = currentIndex + 1
    guard locations.indices.contains(nextIndex) else {
      guard let firstLocation = locations.first else { return }
      showNextLocation(location: firstLocation)
      return
    }

//     Index is valid or not
    let nextLocation = locations[nextIndex]
    showNextLocation(location: nextLocation)
  }
}
