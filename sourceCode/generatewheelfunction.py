from solid import *
from solid.utils import *
from subprocess import run
import numpy as np
import os

#scadfile = import_scad('wheel_PARAM_try.scad')

    
def generatewheelfunction(size,LG,QG,MRF):
    
    
    if MRF:
        scadfile = import_scad('sourceCode/wheel_QG.scad') 
    else:
        scadfile = import_scad('sourceCode/wheel_LG.scad')
    
    w = size[0]
    #w = w * 0.9591836734693878
    #w = w * 0.9879032258064516
    #w = 241 - 3
    w = size[0] * 0.9714285714285714
    AR = size[1]
    inches = size[2]
    i = inches
    r_rim = inches/2 * 25.4
    r = r_rim + w*AR/98

    try:
        ng = int(LG[1])
    except:
        ng = 0

    try:
        garea = int(LG[2])
    except:
        garea = 321.4
    
    try:
        gh = 9.2
        gw = garea/(ng * gh)
    except:
        gh = 9.2
        gw = 0


    #QG scan
    if MRF:
        incl = -QG[1]
        nQG = QG[2]
        QGl = QG[3] / np.cos(incl * np.pi / 180)
        QGw = QG[4] / 10

        if QG[0] == '2':
            #incl = 0
            #nQG = 80
            #QGl = 45
            #QGw = 4
            #geometry = scadfile.QG_2(incl,nQG,QGl,QGw,w,r,ng,gh,gw)
            geometry = scadfile.QG_2_far(incl,nQG,QGl,QGw,w,AR,i,ng,gh,gw)
            geometry_MRF = scadfile.MRF_2_far(incl,nQG,QGl,QGw,w,AR,i,ng,gh,gw)
        if QG[0] == 'External':
            incl = 0
            nQG = 80
            QGl = 45
            QGw = 4
            geometry = scadfile.QG_E(incl,nQG,QGl,QGw,w,r,ng,gh,gw)
        if QG[0] == 'Internal':

            incl = 0
            nQG = 80
            QGl = 45
            QGw = 4
            geometry = scadfile.QG_I(incl,nQG,QGl,QGw,w,r,ng,gh,gw)
            #print(incl)
            #print(nQG)
            #print(QGl)
            #print(QGw)
            #geometry = scadfile.QG_I(0,40,45,4,240,339,4,9,3)
    else:
        #LG scan
        if LG[3] == '' or LG[4] == '':
            #specialflag = 0
        
        
            if LG[0] == 'S' or LG[0] == 'Slick':
                geometry = scadfile.slick_1(w,AR,i)

            if LG[0] == 'Far' or LG[0] == 'F':
                ##if LG[3] == '' or LG[4] == '':
                geometry = scadfile.wheel_LG_far_mod(w,AR,i,ng,gh,gw)
            if LG[0] == 'Left' or LG[0] == 'L':
                geometry = scadfile.wheel_LG_left(w,AR,i,ng,gh,gw)

            if LG[0] == 'Right' or LG[0] == 'R':
                geometry = scadfile.wheel_LG_right(w,AR,i,ng,gh,gw)

            if LG[0] == 'Central' or LG[0] == 'C':
                geometry = scadfile.wheel_LG_central(w,AR,i,ng,gh,gw)
            
        else:
            LG[3] = LG[3] + '_'
            LG[4] = LG[4] + '_'
            sep1 = [i for i, ltr in enumerate(LG[3]) if ltr == '_']
            sep2 = [i for i, ltr in enumerate(LG[4]) if ltr == '_']
            opt1 = [i for i in range(0,len(sep1))]
            opt2 = [i for i in range(0,len(sep1)-1)]
            opt1[0] = int(LG[3][0:sep1[0]])
            for i in range(1,len(sep1)):
                opt1[i] = int(LG[3][sep1[i-1]+1:sep1[i]])
                    
            gap = LG[4].find('[]')
            if gap == -1:
                LG[4] = '[]' + LG[4][sep2[0]:]
                gap = LG[4].find('[]')
            if gap == 0:
                opt2[0] = []
                for i in range(1,len(sep2)):
                    opt2[i] = int(LG[4][sep2[i-1]+1:sep2[i]])
            elif gap == sep2[0]+1:
                opt2[0] = int(LG[4][0:sep2[0]])
                opt2[1] = []
                for i in range(2,len(sep2)):
                    opt2[i] = int(LG[4][sep2[i-1]+1:sep2[i]])
            elif gap == sep2[1]+1:
                opt2[0] = int(LG[4][0:sep2[0]])
                opt2[1] = int(LG[4][sep2[0]+1:sep2[1]])
                opt2[2] = []
                for i in range(3,len(sep2)):
                    opt2[i] = int(LG[4][sep2[i-1]+1:sep2[i]])
                    
            elif gap == sep2[2]+1:
                opt2[0] = int(LG[4][0:sep2[0]])
                opt2[1] = int(LG[4][sep2[0]+1:sep2[1]])
                opt2[2] = int(LG[4][sep2[1]+1:sep2[2]])
                opt2[3] = []
                
                #elif gap == -1:
                #    opt2[0] = int(LG[4][0:sep2[0]])
                #    for i in range(1,len(sep2)):
                #        opt2[i] = int(LG[4][sep2[i-1]+1:sep2[i]])
                #opt2[0] = int(LG[4][0:sep2[0]])
                #opt2 = [int(LG[4][0:sep2[0]]),int(LG[4][sep2[0]:sep2[1]]),int(LG[4][sep2[1]:sep2[2]])]
            i = inches
            
            if LG[0] == 'S' or LG[0] == 'Slick':
                geometry = scadfile.slick_1(w,AR,i)

            if LG[0] == 'Far' or LG[0] == 'F':
                geometry = scadfile.wheel_LG_special(w,AR,i,ng,gh,gw,opt1,opt2)

            if LG[0] == 'Left' or LG[0] == 'L':
                geometry = scadfile.wheel_LG_left_special(w,AR,i,ng,gh,gw,opt1,opt2)

            if LG[0] == 'Right' or LG[0] == 'R':
                geometry = scadfile.wheel_LG_right_special(w,AR,i,ng,gh,gw,opt1,opt2)

            if LG[0] == 'Central' or LG[0] == 'C':
                geometry = scadfile.wheel_LG_central_special(w,AR,i,ng,gh,gw,opt1,opt2)


    
    
    
    filename = 'out.stl'
    filename_MRF = 'out_MRF.stl'
    
    scad_render_to_file(geometry, 'sourceCode/out.scad')
    
    if MRF:
        scad_render_to_file(geometry_MRF,'sourceCode/out_MRF.scad')

    
    run(["openscad", "-o",  filename, "sourceCode/out.scad"])
    os.remove('sourceCode/out.scad')
    
    if MRF:
        run(["openscad", "-o", filename_MRF, 'sourceCode/out_MRF.scad'])
        os.remove('sourceCode/out_MRF.scad')

    return filename
