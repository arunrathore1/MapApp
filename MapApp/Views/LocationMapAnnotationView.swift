//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by Arun Rathore on 25/08/22.
//

import SwiftUI

struct LocationMapAnnotationView: View {
  let accentColor = Color("AccentColor")
    var body: some View {
      VStack(spacing: 0) {
        Image("map")
          .resizable()
          .scaledToFill()
          .frame(width: 30, height: 30)
          .font(.headline)
          .foregroundColor(Color.white)
          .cornerRadius(20)
      }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView()
    }
}
