from fastapi import FastAPI, File, UploadFile
from PIL import Image
import numpy as np
import io

app = FastAPI()

def calculate_brightness(image: Image.Image) -> float:
    """
    Calculate the brightness of an image.
    Converts the image to grayscale and computes the mean pixel value.
    """
    grayscale_image = image.convert("L")
    numpy_image = np.array(grayscale_image)
    brightness = np.mean(numpy_image)
    return brightness

@app.post("/detect-brightness/")
async def detect_brightness(file: UploadFile = File(...)):
    """
    Endpoint to upload an image and detect whether it is 'bright' or 'dark'.
    """
    contents = await file.read()
    image = Image.open(io.BytesIO(contents))
    brightness = calculate_brightness(image)
    # Set a threshold for classifying as 'bright' or 'dark'
    threshold = 100  # bisa di adjust
    classification = "bright" if brightness > threshold else "dark"
    return {"brightness": brightness, "classification": classification}