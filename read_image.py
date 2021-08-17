# -*- coding: utf-8 -*-
"""
Created on Mon Aug  9 20:59:36 2021

@author: qltian
"""

import cv2
import numpy as np
import matplotlib.pyplot as plt

number_of_cycles = [3, 10, 100, 1000, 10000, 20000, 30000, 40000, 60000, 70000, 80000, 90000, 125000, 150000, 175000, 200000, 250000, 300000]

for num in number_of_cycles:
    file_directory = "outlined_photo/"+str(num)+".png"
    img = cv2.imread(file_directory)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    plt.imshow(img)
    
    lower_red = np.array([230,25,30])
    upper_red = np.array([240,30,40])
    image = cv2.inRange(img, lower_red, upper_red)
    
    img2 = img.copy()
    img2[image != 255] = (255,255,255)
    
    plt.imshow(img2)
    
    gray = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)
    ret, thresh = cv2.threshold(gray,200,255,cv2.THRESH_BINARY)
    plt.imshow(thresh,cmap='gray')
    
    contours, hierarchy = cv2.findContours(thresh,cv2.RETR_TREE,cv2.CHAIN_APPROX_NONE)
    
    hull = []
    
    for i in range(len(contours)):
        # creating convex hull object for each contour
        hull.append(cv2.convexHull(contours[i], False))
    
    areas = [] #list to hold all areas
    
    for hh in hull:
      ar = cv2.contourArea(hh)
      areas.append(ar)
    
    areas_cp = areas.copy()
    areas_cp.sort()
    
    second_largest_area = areas_cp[-2]
    third_largest_area = areas_cp[-3]
    
    max_area_index = areas.index(second_largest_area)  # index of the list element with largest area
    max_area_index2 = areas.index(third_largest_area)
    
    cnt1 = hull[max_area_index] # largest area contour is usually the viewing window itself, why?
    cnt2 = hull[max_area_index2]
    
    print(len(hull))
    
    plt.imshow(cv2.drawContours(img, [cnt1], 0, (0, 255, 0), 3))
    
    new_cnt1 = []
    max_y_1 = 0
    for cnt in cnt1:
        cnt = cnt[0]
        new_cnt1.append(cnt)
        if cnt[1] > max_y_1:
            max_y_1 = cnt[1]
    
    max_y_2 = 0
    new_cnt2 = []
    for cnt in cnt2:
        cnt = cnt[0]
        new_cnt2.append(cnt)
        if cnt[1] > max_y_2:
            max_y_2 = cnt[1]
    
    if max_y_1 < max_y_2:
        upper_cnt = new_cnt1
        lower_cnt = new_cnt2
    else:
        lower_cnt = new_cnt1
        upper_cnt = new_cnt2
    
    np.savetxt("convex_hull/"+str(num)+"-upper.csv", upper_cnt, delimiter = ",")
    np.savetxt("convex_hull/"+str(num)+"-lower.csv", lower_cnt, delimiter = ",")

num = 50000
file_directory = "outlined_photo/"+str(num)+".png"
img = cv2.imread(file_directory)
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
plt.imshow(img)

lower_red = np.array([230,25,30])
upper_red = np.array([240,30,40])
image = cv2.inRange(img, lower_red, upper_red)

img2 = img.copy()
img2[image != 255] = (255,255,255)

plt.imshow(img2)

gray = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)
ret, thresh = cv2.threshold(gray,200,255,cv2.THRESH_BINARY)
plt.imshow(thresh,cmap='gray')

contours, hierarchy = cv2.findContours(thresh,cv2.RETR_TREE,cv2.CHAIN_APPROX_NONE)

hull = []

for i in range(len(contours)):
    # creating convex hull object for each contour
    hull.append(cv2.convexHull(contours[i], False))

areas = [] #list to hold all areas

for hh in hull:
  ar = cv2.contourArea(hh)
  areas.append(ar)

areas_cp = areas.copy()
areas_cp.sort()

second_largest_area = areas_cp[-2]
# third_largest_area = areas_cp[-3]

max_area_index = areas.index(second_largest_area)  # index of the list element with largest area
# max_area_index2 = areas.index(third_largest_area)

cnt1 = hull[max_area_index] # largest area contour is usually the viewing window itself, why?
# cnt2 = hull[max_area_index2]

print(len(hull))

plt.imshow(cv2.drawContours(img, [cnt1], 0, (0, 255, 0), 3))

new_cnt1 = []
max_y_1 = 0
for cnt in cnt1:
    cnt = cnt[0]
    new_cnt1.append(cnt)
    if cnt[1] > max_y_1:
        max_y_1 = cnt[1]

max_y_2 = 0
new_cnt2 = []
for cnt in cnt2:
    cnt = cnt[0]
    new_cnt2.append(cnt)
    if cnt[1] > max_y_2:
        max_y_2 = cnt[1]

if max_y_1 < max_y_2:
    upper_cnt = new_cnt1
    lower_cnt = new_cnt2
else:
    lower_cnt = new_cnt1
    upper_cnt = new_cnt2