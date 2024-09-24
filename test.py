# from random import choice
# from string import ascii_lowercase
from datetime import datetime
from ultralytics import YOLO

def func1():
    model = YOLO("models/helm.pt")
    results = model("resources/img/helm3.jpeg")
    for result in results:
        result.save(f"results/img/result{int(datetime.now().timestamp())}.jpg")
        # ''.join(choice(ascii_lowercase) for x in range(5))

def func2():
    model = YOLO("models/yolov8n.pt")
    model.track("resources/vd/car-detection.mp4", stream=False, save=True, project="results", name="vd", exist_ok=True)

def func3():
    model = YOLO("models/helm.pt")
    model.track("resources/vd/helm.mp4", stream=False, save=True, project="results", name="vd", exist_ok=True)

func3()