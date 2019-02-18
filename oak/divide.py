import cv2
#print("Please tell me the name of the video")
print("Please input the name of the video")
name = raw_input()
print("Please input the Frame/Time")
timeF = input()
vc = cv2.VideoCapture(name) #Read the Vedio
c=1
if vc.isOpened(): #If it is Ok to open
    rval , frame1 = vc.read()
    print("Good")
    #print(rval)
    #cv2.imshow(frame)
    #cv2.imwrite('image.jpg',frame1)
    #rval , frame2 = vc.read()
    #cv2.imwrite('image1.jpg',frame2)
else:
    rval = False
    print("Bad")


#timeF=5  
while (rval):
    rval, frame = vc.read()
    if(c%timeF == 0): 
    	cv2.imwrite('../source_images/' + str(c/timeF) + '.bmp',frame) 
    c = c + 1
    #cv2.waitKey(1)
#vc.release()