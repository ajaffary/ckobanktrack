def gradient_plot_polar(fun, track_surface, x_0, range_x, range_y, plot_points=10, color="black", radius=1/10, scale=1):
    r"""
    Plot gradient vectors of a bivariate function on points of its graph.
    Arguments:
    - fun: a symbolic expression corresponding to the function
    - range_x and range_y: tuples of the form (var, min_value, max_value); the variables of fun should be
      the first elements of these tuples
    Options:
    - plot_points: number of points in each direction; it can be a number or a list or a tuple
    - color: a specific color for all vectors or "gradient"; in this case, vectors are colored depending
      on their norms
    - radius: radius of the arrow
    - scale: a factor to increase or decrease the length of the arrows
    
    Example:
    f(u,v) = u^2-v^2
    g = gradient_plot(f(u,v), (u,-1,1), (v,-1,1), scale=0.5)
    s = plot3d(f(u,v), (u,-1,1), (v,-1,1), mesh=True)
    show(g+s)
    
    Another example:
    var("x,y")
    fun = cos(x+y)*sin(x-y)
    x1, x2, y1, y2 = 0, pi, 0, pi
    surface = plot3d(fun, (x,x1,x2), (y,y1,y2), mesh=True, color="green", plot_points=21)
    gradients = gradient_plot(fun, (x,x1,x2), (y,y1,y2), plot_points=11, 
                                scale=0.5, color="gradient", radius=0.02)
    show(surface+gradients)
    """
    
    # Process arguments
    # -----------------
    # fun
    fr, fphi = fun.gradient()[:]
    G=(track_surface).function(r,phi)
    #fx = fr*cos(phi)
    #fy = fr*sin(phi)
    
    # ranges
    var_x, xmin, xmax = range_x
    var_y, ymin, ymax = range_y
    
    # plot_points
    if isinstance(plot_points, (list, tuple)):
        nx, ny = plot_points
    else:
        nx = ny = plot_points
    
    # color
    if color=="gradient":
        color = "red"
        gradient_colors = True
    else:
        gradient_colors = False    
    
    # Compute gradient vectors at surface points and obtain the
    # corresponding arrows to be plotted
    # Gradient norms are also stored
    norms = []
    arrows = []
    dx, dy = (xmax-xmin)/(nx-1), (ymax-ymin)/(ny-1)
    iter_x = [xmin+dx,xmin+dx+dx,..,xmax]
    iter_y = [ymin,ymin+dy,..,ymax]
    for xx in iter_x:
        for yy in iter_y:    
            #dic = {var_x: xx, var_y: yy}
            #p = [xx*cos(yy), xx*sin(yy), fun(dic)]
            p = [x_0+xx*cos(yy), xx*sin(yy), G(xx,yy)]
            #v = vector([fr(xx,yy)*cos(yy), fr(xx,yy)*sin(yy), 0])
            v = vector([fr(xx,yy)*cos(yy), fr(xx,yy)*sin(yy), (fr(xx,yy))**2])
            #v = vector([fx(dic), fy(dic), ((fx(dic))^2+(fy(dic))^2)])
            nv = norm(v).n()
            norms.append(nv)
            v = scale*v/nv*(-1)
            arrows.append(arrow((0,0,0),v, color=color, radius=radius).translate(p))

    # If required, modify arrow colors depending on the gradient norm.
    # Colors range from dark blue (small norm) to dark red (big norm)
    if gradient_colors:
        nvmin, nvmax = min(norms), max(norms)
        if nvmin==nvmax: nvmin = 0
        for i in range(len(arrows)):
            icol = (norms[i]-nvmin)/(nvmax-nvmin)
            vcol = colormaps.jet(icol)[:-1]
            arrows[i].set_texture(color=vcol)
    # End
    return sum(arrows)


def gradient_plot(fun, range_x, range_y, plot_points=10, color="black", radius=1/10, scale=1):
    r"""
    Plot gradient vectors of a bivariate function on points of its graph.
    Arguments:
    - fun: a symbolic expression corresponding to the function
    - range_x and range_y: tuples of the form (var, min_value, max_value); the variables of fun should be
      the first elements of these tuples
    Options:
    - plot_points: number of points in each direction; it can be a number or a list or a tuple
    - color: a specific color for all vectors or "gradient"; in this case, vectors are colored depending
      on their norms
    - radius: radius of the arrow
    - scale: a factor to increase or decrease the length of the arrows
    
    Example:
    f(u,v) = u^2-v^2
    g = gradient_plot(f(u,v), (u,-1,1), (v,-1,1), scale=0.5)
    s = plot3d(f(u,v), (u,-1,1), (v,-1,1), mesh=True)
    show(g+s)
    
    Another example:
    var("x,y")
    fun = cos(x+y)*sin(x-y)
    x1, x2, y1, y2 = 0, pi, 0, pi
    surface = plot3d(fun, (x,x1,x2), (y,y1,y2), mesh=True, color="green", plot_points=21)
    gradients = gradient_plot(fun, (x,x1,x2), (y,y1,y2), plot_points=11, 
                                scale=0.5, color="gradient", radius=0.02)
    show(surface+gradients)
    """
    
    # Process arguments
    # -----------------
    # fun
    fx, fy = fun.gradient()
    
    # ranges
    var_x, xmin, xmax = range_x
    var_y, ymin, ymax = range_y
    
    # plot_points
    if isinstance(plot_points, (list, tuple)):
        nx, ny = plot_points
    else:
        nx = ny = plot_points
    
    # color
    if color=="gradient":
        color = "red"
        gradient_colors = True
    else:
        gradient_colors = False    
    
    # Compute gradient vectors at surface points and obtain the
    # corresponding arrows to be plotted
    # Gradient norms are also stored
    norms = []
    arrows = []
    dx, dy = (xmax-xmin)/(nx-1), (ymax-ymin)/(ny-1)
    iter_x = [xmin,xmin+dx,..,xmax]
    iter_y = [ymin+dy,ymin+dy+dy,..,ymax]
    for xx in iter_x:
        for yy in iter_y:
            dic = {var_x: xx, var_y: yy}
            p = [xx, yy, fun(dic)]
            v = vector([fx(dic), fy(dic), ((fx(dic))^2+(fy(dic))^2)])
            nv = norm(v).n()
            norms.append(nv)
            v = scale*v/nv*(-1)
            arrows.append(arrow((0,0,0),v, color=color, radius=radius).translate(p))

    # If required, modify arrow colors depending on the gradient norm.
    # Colors range from dark blue (small norm) to dark red (big norm)
    if gradient_colors:
        nvmin, nvmax = min(norms), max(norms)
        if nvmin==nvmax: nvmin = 0
        for i in range(len(arrows)):
            icol = (norms[i]-nvmin)/(nvmax-nvmin)
            vcol = colormaps.jet(icol)[:-1]
            arrows[i].set_texture(color=vcol)
    # End
    return sum(arrows)


M.<r,phi> = EuclideanSpace(coordinates='polar')

#Red Curve
f1_x = 21+r*cos(phi)
f1_y = r*sin(phi)
J1_phi = 8+(14/pi)*(phi+pi/2)
f1_z = (((r-16)/12)*(12*cos((pi/11)*(8+(14/pi)*(phi+pi/2) - 17)) + 39.5))/12
#f1_z(u, v) = (((v-16)/12)*(12*cos((pi/11)*(J1_u - 17)) + 39.5))/12
S1=parametric_plot3d([f1_x, f1_y, f1_z], (phi,-pi/2,pi/2), (r,16,28), color="red", opacity=0.75, axes=True, mesh=False)
B1_inside=parametric_plot3d([f1_x, f1_y, 0], (phi,-pi/2,pi/2), (r,15.8,16), color="black", opacity=1, axes=True, mesh=False, scale=1)
B1_outside=parametric_plot3d([f1_x, f1_y, 0], (phi,-pi/2,pi/2), (r,27.9,28.1), color="black", opacity=1, axes=True, mesh=False, scale=1)

f1 = M.scalar_field(f1_z, name='f')
#show(f1.gradient()[:])
g1 = gradient_plot_polar(f1, f1_z, 21, (r,16,28), (phi,-pi/2,pi/2), plot_points=[5,16], scale=3)

#Blue Straight
u, v = var('u, v')
f2_x(u, v) = u
f2_y(u, v) = v
J2_u(u) = 22-(8/42)*(u-21)
f2_z(u, v) = (((v-16)/12)*(12*cos((pi/11)*(J2_u - 17)) + 39.5))/12
S2=parametric_plot3d([f2_x, f2_y, f2_z], (u, -21, 21), (v, 16, 28), color="blue", opacity=0.75, axes=True, mesh=False)
B2_inside=parametric_plot3d([f2_x, f2_y, 0], (u,-21,21), (v,15.8,16), color="black", opacity=1, axes=True, mesh=False, scale=1)
B2_outside=parametric_plot3d([f2_x, f2_y, 0], (u,-21,21), (v,27.9,28.1), color="black", opacity=1, axes=True, mesh=False, scale=1)

#show(f2_z.gradient()[:])
g2 = gradient_plot(f2_z(u,v), (u,-21,21), (v,16,28), plot_points=[8,4], scale=3)

#Purple Curved
f3_x = -21+r*cos(phi)
f3_y = r*sin(phi)
J3_phi = 30+(14/pi)*(phi-pi/2)
f3_z = (((r-16)/12)*(12*cos((pi/11)*(J3_phi - 17)) + 39.5))/12
S3=parametric_plot3d([f3_x, f3_y, f3_z], (phi,pi/2,3*pi/2), (r,16,28), color="purple", opacity=0.75, axes=True, mesh=False)
B3_inside=parametric_plot3d([f3_x, f3_y, 0], (phi,pi/2,3*pi/2), (r,15.8,16), color="black", opacity=1, axes=True, mesh=False, scale=1)
B3_outside=parametric_plot3d([f3_x, f3_y, 0], (phi,pi/2,3*pi/2), (r,27.9,28.1), color="black", opacity=1, axes=True, mesh=False, scale=1)

f3 = M.scalar_field(f3_z, name='f')
#show(f3.gradient()[:])
g3 = gradient_plot_polar(f3, f3_z, -21, (r,16,28), (phi,pi/2,3*pi/2), plot_points=[5,16], scale=3)

#Green Straight
f4_x(u, v) = u
f4_y(u, v) = v
J4_u(u) = 44+(8/42)*(u+21)
f4_z(u, v) = ((-1*(v+16)/12)*(12*cos((pi/11)*(J4_u - 17)) + 39.5))/12
S4=parametric_plot3d([f4_x, f4_y, f4_z], (u,-21,21), (v,-28,-16), color="green", opacity=0.75, axes=True, mesh=False, scale=1)
B4_inside=parametric_plot3d([f4_x, f4_y, 0], (u,-21,21), (v,-16,-15.8), color="black", opacity=1, axes=True, mesh=False, scale=1)
B4_outside=parametric_plot3d([f4_x, f4_y, 0], (u,-21,21), (v,-28.1,-27.9), color="black", opacity=1, axes=True, mesh=False, scale=1)

#show(f4_z.gradient()[:])
g4 = gradient_plot(f4_z(u,v), (u,-21,21), (v,-32,-20), plot_points=[8,4], scale=3)




#Floor
f(u,v) = 0
floor = plot3d(f(u,v), (u,-50,50), (v,-30,30), mesh=False, color="gray", opacity=0.5, plot_points=20)       
       
show(S1+B1_inside+B1_outside+g1+S2+B2_inside+B2_outside+g2+S3+B3_inside+B3_outside+g3+S4+B4_inside+B4_outside+g4+floor)