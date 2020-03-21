//
//  ScanView.swift
//  Cmpt419App
//
//  Created by beibei cai on 2020-03-19.
//  Copyright © 2020 Jerrick Cai. All rights reserved.
//

import SwiftUI
import Alamofire

struct ScanView: View {
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var image_uiImage: UIImage? = nil
    @State private var useCamera: Bool = false
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    @State private var someInts:[Int] = []
    @State private var index:Int = 0
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView{
            
            VStack {
                image?.resizable().scaledToFit().cornerRadius(10).padding(10)
                
                VStack{
                    HStack{
                        //take photo
                        Button(action: {
                            self.showImagePicker = true
                            self.useCamera = true
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "camera.fill")
                                Text("Take Photo")
                            }.padding()
                                .background(Color.pink)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }.sheet(isPresented: self.$showImagePicker) {
                            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image, useCamera: self.$useCamera, image_uiImage: self.$image_uiImage)
                        }
                        
                        //import photo
                        Button(action: {
                            self.showImagePicker = true
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                Text("Import Photo")
                            }.padding()
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }.sheet(isPresented: self.$showImagePicker) {
                            PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image, useCamera: self.$useCamera, image_uiImage: self.$image_uiImage)
                        }
                        Button(action: {
                            let imageData = self.image_uiImage!.jpegData(compressionQuality: 1.0)
                            AF.upload(multipartFormData: { multipartFormData in
                                multipartFormData.append(imageData!, withName: "image", fileName:"file.jpg")
                            }, to: "http://127.0.0.1:5000/")
                                .responseJSON { response in
                                    switch (response.result) {
                                       case .success(let value):
                                            if let JSON = value as? [String: Any] {
                                                let data = JSON["data"] as! [String: Any]
                                                self.someInts = data["labels"]! as! [Int]
                                                
                                                print("Index: \(self.someInts[0])")
                                                
                                                var imageUrl:String = data["image"]! as! String
                                                imageUrl = "http://127.0.0.1:5000/" + imageUrl
                                                
                                                self.confirmationMessage = "Success!"
                                                self.showingConfirmation = true
                                                
                                                self.index = 1
                                                
                                                do {
                                                    let url = URL(string: imageUrl)
                                                    let data = try Data(contentsOf: url!)
                                                    let image = UIImage(data: data)
                                                    self.image = Image(uiImage: image!)
                                                }catch let error as NSError {
                                                    print(error)
                                                }
                                            }

                                        case .failure(let error):
                                            self.confirmationMessage = "Error!"
                                            self.showingConfirmation = true
                                            print("Request error: \(error.localizedDescription)")
                                    }
                            }
                            
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                Text("Upload Photo")
                            }.padding()
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        }.alert(isPresented: $showingConfirmation) {
                            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    
                    if (self.index == 0){
                        Text("Import or Take a Photo")
                    }else{
                        ForEach(someInts, id: \.self) { number in
                            Text(self.menu[0].items[number].name)
                        }
                        
                        NavigationLink(destination: ItemDetail(item: menu[0].items[self.someInts[0]])) {
                            Text("Place Order")
                        }
                    }
                }
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        ScanView().environmentObject(order)
    }
}

class ScanOrder: Decodable {

    var image: String
    var labels: Int
    var names: String
    var prices: Int

    enum CodingKeys: String, CodingKey {
        case image
        case labels
        case names
        case prices
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decode(String.self, forKey: .image)
        self.labels = try container.decode(Int.self, forKey: .labels)
        self.names = try container.decode(String.self, forKey: .names)
        self.prices = try container.decode(Int.self, forKey: .prices)
    }
}
