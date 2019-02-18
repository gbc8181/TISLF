#coding=gb2312  
import string  
import os   
import time  
import re  
import sys  
from optparse import OptionParser  
  
parser = OptionParser()  
#parser.add_option("-i", "--input", dest="input",action="store_true",help="input x y for each file by user")  
parser.add_option("-q", "--quality", dest="q",action="store",help="input xvid q arg",default="24")  
parser.add_option("-v", "--vcodec", dest="vcodec",action="store",help="input video codec",default="x264")  
parser.add_option("-n", "--noaudio", dest="an",action="store_true",help="no audio")  
parser.add_option("-p", "--preset", dest="preset",action="store",help="",default="")  
parser.add_option("-m", "--maxWidth", dest="maxWidth",action="store",help="input max width for output video",default="")  
parser.add_option("-f", "--fileType", dest="fileType",action="store",help="",default="mp4")  
parser.add_option("-o", "--ogg", dest="ogg",action="store_true",help="user ogg instead of aac",default="")  
parser.add_option("-3", "--mp3", dest="mp3",action="store_true",help="user mp3 instead of aac",default="")  
parser.add_option("-1", "--pad", dest="pad",action="store_true",help="pad to 16:9",default="")  
parser.add_option("-s", "--src", dest="srcD",action="store",help="source dir",default="/home/peter/Documents/forest/sourcevideo")  
parser.add_option("-t", "--target", dest="targetD",action="store",help="target dir",default="/home/peter/Documents/forest/targetvideo")  
parser.add_option("-w", "--workdir", dest="workdir",action="store",help="work dir",default="/home/peter/Documents/forest")  
  
(options, args) = parser.parse_args()  
  
if options.srcD==None or options.srcD[0:1]=='-':  
    print 'srcD Err, quit'  
    exit()   
if options.targetD==None or options.targetD[0:1]=='-':  
    print 'targetD Err, quit'  
    exit()   
if options.fileType==None or options.fileType[0:1]=='-':  
    print 'fileType Err, quit'  
    exit()   
if options.workdir==None or options.workdir[0:1]=='-':  
    print 'workdir Err, quit'  
    exit()   
      
#search origin video  
for root,dirs,files in os.walk(options.srcD):   
    for name in files:  
        name= name.replace('[','''''\[''')#if we have a Chinese char, thansform it  
        newname =name[0: name.rindex('.')]        
          
        #find FBS  
        (si, so, se) = os.popen3('cd '+options.workdir+';mkdir -p ffm;  rm -f ffm/ffm.txt ; csh -c "(ffmpeg -i '+options.srcD+'/' +name+ ' >& ffm/ffm.txt)"; grep Stream ffm/ffm.txt')   
        t=so.readlines()   
        ti=0  
        for line in se.readlines() :  
            print line  
              
        width=0  
        height=0  
          
        reg='''''^\s*Stream.*,\s*(\d+)x(\d+)(?: \[SAR|,)'''  
 #Stream #0.0: Video: RV40 / 0x30345652, 1020x572, 23 fps, 23 tbr, 23 tbn, 23 tbc  
        for line in t:  
            result = re.compile(reg).findall(line)  
  
            for c in result:  
                print name+' '+c[0] + 'x' + c[1]  
                width=string.atoi(c[0])  
                height=string.atoi(c[1])  
                if name[0:3]=='M2U' and width==720 and height==576:#4:3 and 16:9  
                    width=1024    
                      
        if width==0:  
            print 'error parsing width and height'  
            exit()  
  
        vc=''  
        qstr=''  
        astr=''  
        vpre=''       
        s=''  
          
        if options.maxWidth!='':  
            if width>string.atoi(options.maxWidth):  
                height = height * string.atoi(options.maxWidth) / width  
                width = string.atoi(options.maxWidth)  
                  
        padStr=''  
        if options.pad==True:  
            if height*16/9 - width>10:#Hight  
                padStr=' -vf "pad='+str(height*16/9)+':'+str(height)+':'+str((height*16/9 - width)/2)+':0:black"'  
            elif width - height*16/9 >10:#width  
                padStr=' -vf "pad='+str(width)+':'+str(width*9/16)+':0:'+str((width - height*16/9)/2)+':black"'  
                  
        s=' -s '+str(width)+'x'+str(height)+padStr  
        print 'adjust',s  
          
        if options.preset!='':  
            vpre=' -vpre '+options.preset  
          
        if options.an==True:  
            astr=' -an'  
        elif options.ogg==True:  
            astr=' -acodec libvorbis -ar 44100 -ab 64K'  
        elif options.mp3==True:  
            astr=' -acodec libmp3lame -ar 44100 -ab 64K'  
        else:  
            astr=' -acodec libfaac -ar 44100 -ab 64K'  
              
        if options.vcodec=='vp8':  
            vc='libvpx'  
            qstr=" -qmin "+options.q+" -qmax "+options.q  
        elif options.vcodec=='x264':  
            vc='libx264'  
            qstr=" -crf "+options.q  
        elif options.vcodec=='xvid':  
            vc='libxvid'  
            qstr=" -qmin "+options.q+" -qmax "+options.q  
              
        cmd ='csh -c "' + "cd "+options.workdir+";touch ffm/output.log;(ffmpeg -y -i "+options.srcD+"/"+name+astr+" -vcodec "+vc+vpre+qstr+s+" -r 25  -threads 8 "+options.targetD+"/"+newname+"."+options.fileType + ' >>& ffm/output.log)"'  
        print cmd  
          
        #run  
        (si, so, se) = os.popen3(cmd)  
        for line in se.readlines() :  
            print line  
        for line in so.readlines() :  
            print line  
              
        #print cmd,'   finish'#again  