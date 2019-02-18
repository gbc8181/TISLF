from PIL import Image as image  
  
#等比例压缩图片  
def resizeImg(**args):  
    args_key = {'ori_img':'','dst_img':'','dst_w':'','dst_h':'','save_q':75}  
    arg = {}  
    for key in args_key:  
        if key in args:  
            arg[key] = args[key]  
          
    im = image.open(arg['ori_img'])  
    ori_w,ori_h = im.size  
    widthRatio = heightRatio = None  
    ratio = 1  
    if (ori_w and ori_w > arg['dst_w']) or (ori_h and ori_h > arg['dst_h']):  
        if arg['dst_w'] and ori_w > arg['dst_w']:  
            widthRatio = float(arg['dst_w']) / ori_w #正确获取小数的方式  
        if arg['dst_h'] and ori_h > arg['dst_h']:  
            heightRatio = float(arg['dst_h']) / ori_h  
  
        if widthRatio and heightRatio:  
            if widthRatio < heightRatio:  
                ratio = widthRatio  
            else:  
                ratio = heightRatio  
  
        if widthRatio and not heightRatio:  
            ratio = widthRatio  
        if heightRatio and not widthRatio:  
            ratio = heightRatio  
              
        newWidth = int(ori_w * ratio)  
        newHeight = int(ori_h * ratio)  
    else:  
        newWidth = ori_w  
        newHeight = ori_h  
          
    im.resize((newWidth,newHeight),image.ANTIALIAS).save(arg['dst_img'],quality=arg['save_q']) 