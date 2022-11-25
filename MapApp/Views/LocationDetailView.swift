//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Arun Rathore on 25/08/22.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {

  @EnvironmentObject private var vm: LocationViewModel

  let location: Location
  var body: some View {
    ScrollView {
      VStack {
        imageSection
          .shadow(color: Color.black.opacity(0.3),
                  radius: 20,
                  x: 0,
                  y: 10)

        VStack(alignment: .leading, spacing: 16) {
          HStack {
            VStack {
              titleSection
            }
            Spacer()
            heartImage
          }
          Divider()
          descriptionSection
          Divider()
          mapLayer
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
      }
    }
    .ignoresSafeArea()
    .background(.ultraThinMaterial)
    .overlay(backButton, alignment: .topLeading)
  }
}

struct LocationDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LocationDetailView(location: LocationsDataService.locations.first!)
      .environmentObject(LocationViewModel())
  }
}

extension LocationDetailView {

  private var imageSection: some View {
    TabView {
      ForEach(location.imageNames, id:\.self) {
        Image($0)
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width)
          .clipped()

      }
    }
    .frame(height: 500)
    .tabViewStyle(.page)
  }
}

extension LocationDetailView {
  private var titleSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(location.name)
        .font(.largeTitle)
        .fontWeight(.semibold)
      Text(location.cityName)
        .font(.title3)
        .foregroundColor(.secondary)
    }
  }

  private var descriptionSection: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(location.description)
        .font(.subheadline)
        .foregroundColor(.secondary)
      if let url = URL(string: location.link) {
        Link("Read more",destination: url)
          .font(.headline)
          .tint(.blue)
      }
    }
  }

  private var mapLayer: some View {
    Map(coordinateRegion: .constant(MKCoordinateRegion(
      center: location.coordinates,
      span: vm.mapSpan)),
        annotationItems: [location]) { location in
      MapAnnotation(coordinate: location.coordinates) {
        LocationMapAnnotationView()
          .shadow(radius: 10)
      }
    }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
  }

  private var backButton: some View {
    Button {
      vm.sheetLocation = nil
    }label: {
      Image(systemName: "xmark")
        .font(.headline)
        .padding(6)
        .foregroundColor(.primary)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(radius: 4)
        .padding()
    }
  }
}

extension LocationDetailView {
  private var heartImage: some View {
    Button {

    } label: {
      HStack{
        Image(systemName: "heart")
          .foregroundColor(.primary)
          .background(.thickMaterial)
          .cornerRadius(10)
          .shadow(radius: 4)
      }
    }
  }
}
