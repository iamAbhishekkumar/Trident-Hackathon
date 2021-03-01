import tensorflow.keras
from PIL import Image, ImageOps
import numpy as np
from flask import Flask,jsonify,request


app = Flask(__name__)

def getDiseaseDetails(disease):
  disease_map = {
   "Corn Rust Leaf":{
      "disease":"Corn rust leaf",
      "introduction":"Corn rust is caused by the fungus Puccinia sorghi and occurs every growing season. It is always a concern in hybrid corn. Rust pustules usually first appear in late June. Early symptoms of common rust are chlorotic flecks on the leaf surface. These soon develop into powdery, brick-red pustules as the spores break through the leaf surface.",
      "precautions":"Remove all infected parts and destroy them, Clean away all debris in between plants to prevent rust from spreading, Avoid splashing water onto the leaves, as this can help spread rust.",
      "cure":"Foliar fungicides labeled for common corn rust are available. 15 gallon per acer should be sprayed properly throughout the plantation area. One of the best times to apply fungicide to maximize any benefits for grain corn is during tasseling (VT) and into the silking (R1-R2) timing.",
      "image1":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2qy8PczDExO9Rf5wDsIIm-ScmXy8eryucZg&usqp=CAU",
      "image2":"https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcT5qHMcnTbSdui6PRYKa2rghz0vtxtQXQjMBz3Adr97EOZiA4VSdQver65jBGDaKLivxdVJaEYGm8E&usqp=CAc",
      "location":" Mysore district of Karnataka, Rajasthan"
   },
   "Corn Leaf Blight":{
      "disease":"Corn Leaf Blight",
      "introduction":"Corn Leaf Blight (CLB), caused by the fungus Exserohilum. CLB can cause yield loss if it develops before or during the tasseling and silking phases of corn development. The spots quickly turn to tan. A disease of wet weather, corn leaf blight is most severe when temperatures are between 66 and 80F (18-27C), with constant moisture from rain or fog. ",
      "precautions":"control for this disease is often focus on management and prevention first choose corn variety or hybrid that are resistant or at least have moderate resistance to corn leaf blight. when you grow corn make sure it does not stay in wet for long period of time. The fungus that causes this infection need between 6 and 18 hours of leaf wetness to develop. plant corn with enough space for air flow and water in the morning so that leaves can dry throughout the day.",
      "cure":"Consider costs and predicted weather conditions before deciding to apply fungicides. Delaro® 325 SC fungicide is labeled for CLB and can be sprayed when the disease first appears and for a 7- to 14-day interval where necessary.",
      "image1":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSn40rn6KC11ysPZw481YyJ7HnOB5yBUiDTyg&usqp=CAU",
      "image2":"https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQdEW05U9BpbWUPUwcBcyZXuSz_RbbQLGPu1cj4t7yHzGrFxPAWjM6gtYCkxlRurVJwspI5eS7wLQX82Hi5jeagyFZunU9HDZsoO20xTbU&usqp=CAc",
      "location":"Karnataka, Maharashtra, Andhra Pradesh, Bihar and Uttarakhand"
   },
   "Grape Leaf Black Dot":{
      "disease":"Grape Leaf Black Dot",
      "introduction":"Black or dark brown spots appearing on the leaves and stems of plants typically indicate the presence of black rot, a bacterial disease or fungal infection that can result in decay and loss of the plant. This discoloration, commonly caused by Boytryosphaeria obtusa, Guignardia bidwellii and Xanthomonas campestris pv.",
      "precautions":"The ideal climate for grape growing is the Mediterranean climate. In its natural habitat, the vines grow and produce during the hot and dry period. Under South Indian conditions – vines produce vegetative growth during the period from April to September and then fruiting period from October to March.",
      "cure":"The best time to treat black rot of grapes is between bud break until about four weeks after bloom. Captan and myclobutanil are the fungicides of choice.",
      "image1":"https://smhttp-ssl-60515.nexcesscdn.net/media/catalog/product/cache/1/image/600x600/9df78eab33525d08d6e5fb8d27136e95/q/u/quali_pro-myclobutanil20ew_1.jpg",
      "image2":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqlKhRLCcOTfibb8LCDo_k3cTJUFgtQ_bTr0ynrGGqOu1gcbL8wmTiYDYzKXUlYWkyyb_4MXeg&usqp=CAc",
      "location":"Hissar and Jind districts of Haryana, Chittoor district of Andhra Pradesh and Coimbatore"
   },
   "Apple Scab Leaf":{
      "disease":"Apple Scab Leaf",
      "introduction":"This fungal disease forms pale yellow or olive-green spots on the upper surface of leaves and dark, velvety spots may appear on the lower surface. It attacks both the leaves and the fruit.",
      "precautions":"Destroy infected leaves to reduce the number of fungal spores available to start the disease cycle over again next spring. Water in the evening or early morning hours to give the leaves time to dry out before infection can occur.",
      "cure":"Plant Doctor is an earth-friendly systemic fungicide that works its way through the entire plant to combat a large number of diseases on ornamentals, turf, fruit. Use 3-4 tablespoons per gallon of water.",
      "image1":"https://www.planetnatural.com/wp-content/uploads/2013/03/plant-doctor-195x215.jpg",
      "image2":"https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTS53LOZrjd3LW2J5do3NB2Z_7xEutrOfrd0fJg8Diz_EwMn6baQmdn8Jf1fj5btwLX8xEdgaclvRPxAA0yIpBSwbLfw_ZYrDzDZUnbF-Y&usqp=CAc",
      "location":" found in Kashmir, a North Western Himalayan state of India"
   },
   "Apple Rust Leaf":{
      "disease":"Apple Rust Leaf",
      "introduction":"There are mainly three types of rust diseases, the most common is cedar-apple rust. These diseases can cause an economic loss because severe leaf infection and defoliation reduces fruit size and quality. These diseases start spreading from the leaves. it starts with small pale yellow spots on the upper surface of the leaves.",
      "precautions":" Choose resistant cultivars when available. Rake up and dispose of fallen leaves and other debris from under trees. Remove galls from infected junipers. In some cases, juniper plants should be removed entirely.",
      "cure":"Remove cedar trees located near orchards. Fungicide applications using EBDCs, such as ferbam, ziram, manzate, should be made beginning at the pink bud stage of apples and continue through the first cover.",
      "image1":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbcOnR2IIUhAcxFNidjF7n-_iD-RldFFY-4g&usqp=CAU",
      "image2":"https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTRJevgnER3aVRbUgW6XeAOuyFOiD4v0AfvRTTdlkCokJpeBCdgv3AkzwWiLqJcWGfYsMtfXUKAMQ&usqp=CAc",
      "location":"Indo-Malaysian region of South-East Asia and Middle East to the Indian Subcontinent, Kullu in northern Himachal Pradesh"
   }
  }
                
  return disease_map[disease]                                               



def getLabel(probabilities):
  labels = {
          0 : "Apple Rust Leaf",
          1 : "Apple Scab Leaf",
          2 : "Grape Leaf Black Dot", 
          3 : "Corn Rust Leaf",
          4 : "Corn Leaf Blight",
          5 : "Nothing there",
          6 : "Not in DataBase right now"
          }
  max_prob = max(probabilities)
  acc = "null"
  disease_details = "null"
  for i in range(len(probabilities)):
    if probabilities[i] == max_prob:
      if max_prob > 0.85:
        max_prob_label = labels[i]
        acc = str(max_prob)
        disease_details = getDiseaseDetails(max_prob_label)
      else:
        max_prob_label = "Not in database right now or Wrong image of plant"
      return {"max_prob_label" : max_prob_label,"accuracy" : acc,"details" : disease_details}

@app.route("/", methods=["POST"])
def processImage():
  accept_file = request.files['file']
  if accept_file != None:
    # Disable scientific notation for clarity
    np.set_printoptions(suppress=True)
    # Load the model
    model = tensorflow.keras.models.load_model('keras_model.h5')
    # Create the array of the right shape to feed into the keras model
    # The 'length' or number of images you can put into the array is
    # determined by the first position in the shape tuple, in this case 1.
    data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)
    # Replace this with the path to your image
    image = Image.open(accept_file)
    #resize the image to a 224x224 with the same strategy as in TM2:
    #resizing the image to be at least 224x224 and then cropping from the center
    size = (224, 224)
    image = ImageOps.fit(image, size, Image.ANTIALIAS)
    #turn the image into a numpy array
    image_array = np.asarray(image)
    # display the resized image
    image.show()
    # Normalize the image
    normalized_image_array = (image_array.astype(np.float32) / 127.0) - 1
    # Load the image into the array
    data[0] = normalized_image_array
    # run the inference
    prob = list(model.predict(data)[0])
    return jsonify(getLabel(prob))


if __name__ == '__main__':
  app.run()





