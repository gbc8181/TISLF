import cv2
for a in range(50,51):
	b=cv2.imread(str(a)+'.jpg')
	cv2.imwrite(str(a)+'.bmp',b)


