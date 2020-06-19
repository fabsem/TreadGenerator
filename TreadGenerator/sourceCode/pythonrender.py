from stl import mesh,stl
from mpl_toolkits import mplot3d
#import matplotlib.pyplot as plt
import vtkplotlib as vpl

stl.MAX_COUNT = 1e10

def renderimage(tread,options):
    reifenflanke = 'rimAndShoulder/reifenflanke.stl'
    modulfelge = 'rimAndShoulder/modulfelge.stl'

    # Read the STL using numpy-stl
    geom = mesh.Mesh.from_file(tread)
    shoulder = mesh.Mesh.from_file(reifenflanke)
    rim = mesh.Mesh.from_file(modulfelge)
    
# Plot the mesh
    vpl.mesh_plot(geom,color=[76,76,76])
    if options == 'full':
        vpl.mesh_plot(shoulder,color=[76,76,76])
        vpl.mesh_plot(rim,color=[1,1,1])

# Show the figure
    vpl.view(camera_direction = [0.8,0.5,0],up_view=[0,0,1])
    #fig = vpl.gcf()
    #fig.background_color = "transparent"
  #vpl.show()
    #name = 'render.png'
    vpl.save_fig('render/render.png',off_screen=True,magnification=2)
    vpl.close()
    
