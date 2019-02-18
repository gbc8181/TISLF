mkdir source_images target_images
cd oak/
python2 divide.py
cd ../pine/
matlab
mv Num.mat ../wattle
cd ../wattle
matlab
cd ..

#rm -r *.bmp