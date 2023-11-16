import sys

import pytz as pytz
import torch
import re
import cv2
import time
#import pytesseract
import re
import os
import numpy as np
import easyocr
import firebase_admin
from firebase_admin import firestore
from firebase_admin import credentials
from datetime import datetime
import time

##### DEFINING GLOBAL VARIABLE
EASY_OCR = easyocr.Reader(['en']) ### initiating easyocr
OCR_TH = 0.2


cred = credentials.Certificate("cred.json")
firebase_admin.initialize_app(cred)
firestore_client = firestore.client()




def process_string(s):

    try:
        if not isinstance(s, (str, bytes)):
            return "Cannot proccess number plate"


        s = re.sub(r'[^a-zA-Z0-9]', '', s)

        words = s.split()

        words = [w.upper() for w in words]

        result = ''.join(words)
        return result
    except ValueError:
        print("Cannot proccess number plate")
### -------------------------------------- function to run detection ---------------------------------------------------------
def detectx (frame, model):
    frame = [frame]
    print(f"[INFO] Detecting. . . ")
    results = model(frame)
    # results.show()
    # print( results.xyxyn[0])
    # print(results.xyxyn[0][:, -1])
    # print(results.xyxyn[0][:, :-1])

    labels, cordinates = results.xyxyn[0][:, -1], results.xyxyn[0][:, :-1]

    return labels, cordinates

### ------------------------------------ to plot the BBox and results --------------------------------------------------------
def plot_boxes(results, frame,classes):

    """
    --> This function takes results, frame and classes
    --> results: contains labels and coordinates predicted by model on the given frame
    --> classes: contains the strting labels

    """
    labels, cord = results
    n = len(labels)
    x_shape, y_shape = frame.shape[1], frame.shape[0]

    print(f"[INFO] Total {n} detections. . . ")
    print(f"[INFO] Looping through all detections. . . ")


    ### looping through the detections
    for i in range(n):
        row = cord[i]
        if row[4] >= 0.55: ### threshold value for detection. We are discarding everything below this value
            print(f"[INFO] Extracting BBox coordinates. . . ")
            x1, y1, x2, y2 = int(row[0]*x_shape), int(row[1]*y_shape), int(row[2]*x_shape), int(row[3]*y_shape) ## BBOx coordniates
            text_d = classes[int(labels[i])]
            # cv2.imwrite("./output/dp.jpg",frame[int(y1):int(y2), int(x1):int(x2)])

            coords = [x1,y1,x2,y2]

            plate_num = recognize_plate_easyocr(img = frame, coords= coords, reader= EASY_OCR, region_threshold= OCR_TH)


            # if text_d == 'mask':
            cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 2) ## BBox
            cv2.rectangle(frame, (x1, y1-20), (x2, y1), (0, 255,0), -1) ## for text label background
            cv2.putText(frame, f"{plate_num}", (x1, y1), cv2.FONT_HERSHEY_SIMPLEX, 0.5,(255,255,255), 2)

            # cv2.imwrite("./output/np.jpg",frame[int(y1)-25:int(y2)+25, int(x1)-25:int(x2)+25])




    return frame


def database_operation(text):


    doc_ref = firestore_client.collection("Users")
    query = doc_ref.where("NumberPlate", "==", process_string(text).strip())
    results = query.get()
    username=""
    for doc in results:
        username = doc.get("Email")
        print(username)
    entry_ref = firestore_client.collection("Entry")
    entry_query = entry_ref.where("PlateNumber", "==", process_string(text).strip())
    entry_result = entry_query.get()
    print(results)
    Data=False
    for  numbers in entry_result:
        Data=numbers.to_dict()
    print(entry_result)

    if entry_result :
        for result in entry_result:
             data=result.to_dict()
             if(data.get("Status")=='IN') :
                 checkin_time = data.get("CheckIn").replace(tzinfo=pytz.UTC).astimezone(pytz.timezone('Asia/Kolkata'))
                 checkout_time = datetime.now(pytz.timezone('Asia/Kolkata'))
                 duration_seconds=( checkout_time -  checkin_time).total_seconds()
                 duration_minutes = duration_seconds / 60
                 data= {"Status": "OUT", "CheckOutTime":checkout_time,"duration":int(duration_minutes),"Amount":int(duration_minutes)*1.5,"Email":username,"Payment":"PENDING","ParkingName":"Parking Area-1,Malad ,Mumbai"}
                 result.reference.update(data)
                 print(int(duration_minutes))
                 time.sleep(50)


    if results:
         if Data!=False :
            if Data.get('Status')!='IN':
                checkin_time =datetime.now(pytz.timezone('Asia/Kolkata'))
                data= {"Status": "IN","NotificationSent":"false", "CheckIn": checkin_time,"PlateNumber":text,"Email":username,"ParkingName":"Parking Area-1,Malad ,Mumbai"}
                entry_ref.add(data)
                time.sleep(50)



         if Data == False:
            checkin_time =datetime.now(pytz.timezone('Asia/Kolkata'))
            data= {"Status": "IN","NotificationSent":"false", "CheckIn": checkin_time,"PlateNumber":text,"Email":username,"ParkingName":"Parking Area-1,Malad ,Mumbai"}
            entry_ref.add(data)
            time.sleep(50)




    #print(results)

    if results:
     print("Document exists")
     # data= {"PlateNumber": process_string(text).strip(), "Status": "IN"}
     # entry_ref.add(data)

#### ---------------------------- function to recognize license plate --------------------------------------


# function to recognize license plate numbers using Tesseract OCR
def recognize_plate_easyocr(img, coords,reader,region_threshold):
    # separate coordinates from box
    xmin, ymin, xmax, ymax = coords
    # get the subimage that makes up the bounded region and take an additional 5 pixels on each side
    # nplate = img[int(ymin)-5:int(ymax)+5, int(xmin)-5:int(xmax)+5]
    nplate = img[int(ymin):int(ymax), int(xmin):int(xmax)] ### cropping the number plate from the whole image


    ocr_result = reader.readtext(nplate)



    text = filter_text(region=nplate, ocr_result=ocr_result, region_threshold= region_threshold)

    if len(text) ==1:
        text = text[0].upper()

        database_operation(process_string(text).strip())
        print(process_string(text))

    return process_string(text).strip()


### to filter out wrong detections 

def filter_text(region, ocr_result, region_threshold):
    rectangle_size = region.shape[0]*region.shape[1]
    
    plate = [] 
    print(ocr_result)
    for result in ocr_result:
        length = np.sum(np.subtract(result[0][1], result[0][0]))
        height = np.sum(np.subtract(result[0][2], result[0][1]))
        
        if length*height / rectangle_size > region_threshold:
            plate.append(result[1])
    return plate





### ---------------------------------------------- Main function -----------------------------------------------------

def main(img_path=None, vid_path=None,vid_out = None):

    print(f"[INFO] Loading model... ")

    # model =  torch.hub.load('ultralytics/yolov5', 'custom', path='last.pt',force_reload=True) ## if you want to download the git repo and then run the detection
    model =  torch.hub.load('./yolov5-master', 'custom', source ='local', path='best.pt',force_reload=True) ### The repo is stored locally

    classes = model.names ### class names in string format




    ### --------------- for detection on image --------------------
    if img_path != None:
        print(f"[INFO] Working with image: {img_path}")
        img_out_name = f"./output/result_{img_path.split('/')[-1]}"

        frame = cv2.imread(img_path) ### reading the image
        frame = cv2.cvtColor(frame,cv2.COLOR_BGR2RGB)
        
        results = detectx(frame, model = model) ### DETECTION HAPPENING HERE    

        frame = cv2.cvtColor(frame,cv2.COLOR_RGB2BGR)

        frame = plot_boxes(results, frame,classes = classes)
        

        cv2.namedWindow("img_only", cv2.WINDOW_NORMAL) ## creating a free windown to show the result

        while True:
            # frame = cv2.cvtColor(frame,cv2.COLOR_RGB2BGR)

            cv2.imshow("img_only", frame)

            if cv2.waitKey(5) & 0xFF == ord('q'):
                print(f"[INFO] Exiting. . . ")

                cv2.imwrite(f"{img_out_name}",frame) ## if you want to save he output result.

                break


    elif vid_path !=None:
        print(f"[INFO] Working with video: {vid_path}")


        cap = cv2.VideoCapture(vid_path)


        if vid_out: ### creating the video writer if video output path is given

            # by default VideoCapture returns float instead of int
            width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
            fps = int(cap.get(cv2.CAP_PROP_FPS))
            codec = cv2.VideoWriter_fourcc(*'mp4v') ##(*'XVID')
            out = cv2.VideoWriter(vid_out, codec, fps, (width, height))

        # assert cap.isOpened()
        frame_no = 1

        cv2.namedWindow("vid_out", cv2.WINDOW_NORMAL)
        while True:
            # start_time = time.time()
            ret, frame = cap.read()
            if ret  and frame_no %1 == 0:
                print(f"[INFO] Working with frame {frame_no} ")

                frame = cv2.cvtColor(frame,cv2.COLOR_BGR2RGB)
                results = detectx(frame, model = model)
                frame = cv2.cvtColor(frame,cv2.COLOR_RGB2BGR)


                frame = plot_boxes(results, frame,classes = classes)
                
                cv2.imshow("vid_out", frame)
                if vid_out:
                    print(f"[INFO] Saving output video. . . ")
                    out.write(frame)

                if cv2.waitKey(5) & 0xFF == ord('q'):
                    break
                frame_no += 1
        
        print(f"[INFO] Clening up. . . ")
        ### releaseing the writer
        out.release()
        
        ## closing all windows
        cv2.destroyAllWindows()





main(vid_path=1) ### for custom video
#main(vid_path='http://192.168.137.16:8081/') #### for webcam

#main(img_path="./test_images/bus.jpg")
#main(img_path="./demo.jpg") ## for image
            

