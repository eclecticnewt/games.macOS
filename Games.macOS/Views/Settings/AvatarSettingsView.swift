import SwiftUI

struct AvatarSettingsView: View {
    @State private var selectedFaceShape: String = "Oval"
    @State private var selectedEyeShape: String = "Round"
    @State private var selectedNoseShape: String = "Small"
    @State private var selectedMouthShape: String = "Smile"
    @State private var selectedHairStyle: String = "Short"
    @State private var selectedHairColor: Color = .black
    @State private var selectedEyeColor: Color = .blue
    @State private var selectedSkinTone: Color = .pink

    var body: some View {
        VStack {
            Text("Avatar Creator")
                .font(.largeTitle)
                .bold()
                .padding()

            AvatarPreview(
                faceShape: selectedFaceShape,
                eyeShape: selectedEyeShape,
                noseShape: selectedNoseShape,
                mouthShape: selectedMouthShape,
                hairStyle: selectedHairStyle,
                hairColor: selectedHairColor,
                eyeColor: selectedEyeColor,
                skinTone: selectedSkinTone
            )
            .frame(width: 200, height: 300)
            .padding()

            Form {
                Section(header: Text("Face")) {
                    Picker("Face Shape", selection: $selectedFaceShape) {
                        ForEach(["Oval", "Round", "Square", "Heart"], id: \.self) { shape in
                            Text(shape)
                        }
                    }
                    ColorPicker("Skin Tone", selection: $selectedSkinTone)
                }

                Section(header: Text("Eyes")) {
                    Picker("Eye Shape", selection: $selectedEyeShape) {
                        ForEach(["Round", "Almond", "Wide"], id: \.self) { shape in
                            Text(shape)
                        }
                    }
                    ColorPicker("Eye Color", selection: $selectedEyeColor)
                }

                Section(header: Text("Nose")) {
                    Picker("Nose Shape", selection: $selectedNoseShape) {
                        ForEach(["Small", "Medium", "Large"], id: \.self) { shape in
                            Text(shape)
                        }
                    }
                }

                Section(header: Text("Mouth")) {
                    Picker("Mouth Shape", selection: $selectedMouthShape) {
                        ForEach(["Smile", "Neutral", "Frown"], id: \.self) { shape in
                            Text(shape)
                        }
                    }
                }

                Section(header: Text("Hair")) {
                    Picker("Hair Style", selection: $selectedHairStyle) {
                        ForEach(["Short", "Medium", "Long", "Curly"], id: \.self) { style in
                            Text(style)
                        }
                    }
                    ColorPicker("Hair Color", selection: $selectedHairColor)
                }
            }
        }
        .padding()
    }
}

struct AvatarPreview: View {
    let faceShape: String
    let eyeShape: String
    let noseShape: String
    let mouthShape: String
    let hairStyle: String
    let hairColor: Color
    let eyeColor: Color
    let skinTone: Color

    var body: some View {
        ZStack {
            // Skin Tone
            if faceShape == "Oval" {
                Ellipse()
                    .fill(skinTone)
                    .frame(width: 150, height: 200)
                    .overlay(Ellipse().stroke(Color.black, lineWidth: 2))
            } else if faceShape == "Round" {
                Circle()
                    .fill(skinTone)
                    .frame(width: 150, height: 200)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
            } else if faceShape == "Square" {
                Rectangle()
                    .fill(skinTone)
                    .frame(width: 150, height: 200)
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            } else {
                RoundedRectangle(cornerRadius: 30)
                    .fill(skinTone)
                    .frame(width: 150, height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
            }

            // Eyes
            HStack(spacing: 30) {
                eyeShapeView(eyeShape: eyeShape)
                eyeShapeView(eyeShape: eyeShape)
            }
            .offset(y: -50)

            // Nose
            noseView(noseShape: noseShape)
                .offset(y: 0)

            // Mouth
            mouthView(mouthShape: mouthShape)
                .offset(y: 60)

            // Hair
            hairView(hairStyle: hairStyle, hairColor: hairColor)
                .offset(y: -130)
        }
    }

    @ViewBuilder
    func eyeShapeView(eyeShape: String) -> some View {
        if eyeShape == "Round" {
            Circle()
                .fill(eyeColor)
                .frame(width: 20, height: 20)
        } else if eyeShape == "Almond" {
            Ellipse()
                .fill(eyeColor)
                .frame(width: 30, height: 15)
        } else {
            Rectangle()
                .fill(eyeColor)
                .frame(width: 30, height: 10)
                .cornerRadius(10)
        }
    }

    @ViewBuilder
    func noseView(noseShape: String) -> some View {
        if noseShape == "Small" {
            Circle()
                .fill(Color.black)
                .frame(width: 10, height: 10)
        } else if noseShape == "Medium" {
            Ellipse()
                .fill(Color.black)
                .frame(width: 20, height: 15)
        } else {
            Ellipse()
                .fill(Color.black)
                .frame(width: 30, height: 20)
        }
    }

    @ViewBuilder
    func mouthView(mouthShape: String) -> some View {
        if mouthShape == "Smile" {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addQuadCurve(to: CGPoint(x: 60, y: 0), control: CGPoint(x: 30, y: 20))
            }
            .stroke(Color.black, lineWidth: 2)
            .frame(width: 60, height: 20)
        } else if mouthShape == "Neutral" {
            Rectangle()
                .fill(Color.black)
                .frame(width: 60, height: 5)
        } else {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addQuadCurve(to: CGPoint(x: 60, y: 0), control: CGPoint(x: 30, y: -20))
            }
            .stroke(Color.black, lineWidth: 2)
            .frame(width: 60, height: 20)
        }
    }

    @ViewBuilder
    func hairView(hairStyle: String, hairColor: Color) -> some View {
        if hairStyle == "Short" {
            Rectangle()
                .fill(hairColor)
                .frame(width: 150, height: 30)
        } else if hairStyle == "Medium" {
            Rectangle()
                .fill(hairColor)
                .frame(width: 150, height: 50)
        } else if hairStyle == "Long" {
            Rectangle()
                .fill(hairColor)
                .frame(width: 150, height: 70)
        } else if hairStyle == "Curly" {
            Circle()
                .fill(hairColor)
                .frame(width: 150, height: 60)
        }
    }
}

struct AvatarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSettingsView()
    }
}
