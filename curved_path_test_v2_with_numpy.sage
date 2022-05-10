import numpy as np

u, v = var('u, v')

# There are 44 track pieces.

# The Outer Edge Track Height function was empirically determined to be 
# H = 12*cos[pi/11(u-17)] + 39.5, where u is the number of the Track Piece at which
# the height was meaured, and Z is in inches.

# Pieces 8 -- 22 comprise Red Curved portion of the Track.
# The Track Height is parametrized with polar coordinates (u,v) over the interval [-pi/2, pi/2].

# A scale factor (14/pi) maps the interval [-pi/2,pi/2] to the corresponding 
# track piece in [8,22].  The interval [8,22] is used to compute the Outer Edge Track Heights.

# The Track Surface is rendered as a linear percentage of the Outer Edge Track 
# Height over the 12-foot Track Width, as (v-16)/12, where v ranges over [16,28], 
# the radial distance from the center of Curvature.

# Linear Conversion with Slope (14/pi) and initial point (-pi/2,8)
Track_Piece_Conversion(u) = 8+(14/pi)*(u+pi/2)

# X-coordinates of Red Curved Track Surface
Red_Curved_Track_Surface_X(u, v) = v*np.cos(u)

# Y-coordinates of Red Curved Track Surface
Red_Curved_Track_Surface_Y(u, v) = v*np.sin(u)

# Z-coordinates of Red Curved Track Surface
Red_Curved_Track_Surface_Z(u, v) = ( ( ( v-16 )/12 )*( 12*np.cos( (pi/11)*( Track_Piece_Conversion(u) - 17 ) ) + 39.5 ) )/12

# Red Curved Track Surface Plot, rendered over [-pi/2,0] only
# This piece of the Optimal Curve (see below) is defined over [-pi/2,0]
Red_Curved_Track_Surface = parametric_plot3d([Red_Curved_Track_Surface_X, Red_Curved_Track_Surface_Y, Red_Curved_Track_Surface_Z], (u, -pi/2, 0), (v, 16, 28), color="red", opacity=0.5, axes=True, mesh=False)



# Blue Test Path.  This is a simple path with radius that decays *linearly* 
# from 28 to 16 over the interval [-pi/2,pi/2].  

# It is parametrized by the angle u over [-pi/2,pi/2], and given "thickness" 
# with parameter v, acting as a small epsilon interval around the radial distance 
# of the (x,y) coordinate of the Path.  

# This path renders perfectly in the plane of the Red Curved Track Surface.

# Radius of Blue Test Path
Test_Path_Radius(u,v) = v*(16 - (12/pi)*(u-pi/2))

# X-coordinates of Blue Test Path
Test_Path_X(u,v) = v*(16-(12/pi*(u-pi/2)))*np.cos(u)

# Y-coordinates of Blue Test Path
Test_Path_Y(u,v) = v*(16-(12/pi*(u-pi/2)))*np.sin(u)

# Z-coordinates of Blue Test Path
Test_Path_Z(u,v) = ( ( (Test_Path_Radius(u,v) - 16)/12 ) * ( 12*np.cos( (pi/11)*(Track_Piece_Conversion(u) - 17) ) + 39.5 ) )/12

# Blue Test Path Plot
Blue_Test_Path = parametric_plot3d([Test_Path_X, Test_Path_Y, Test_Path_Z], (u, -pi/2, 0), (v, 0.99, 1.01), color="blue", opacity=1)



# Optimal Path Equation.  This was determined during our Research Project 
# to be an "optimal" path around the Track.  

# The curve is tangent to the Track at its Outer and Inner Edges at specific 
# points to simulate a "fastest" circuit around the Track.  

# This path was determined empirically through trial & error by modeling curves 
# that conformed within the Track boundaries and met the desired tangent conditions.  
# A 2-d model can be seen at https://www.desmos.com/calculator/g4qoelrkco.

# The Optimal Path was first defined in Rectangular coordinates, parametrized by 
# rational powers of cosine and sine.  

# The Radius of the Optimal Path needs to be computed.  Here, it is done with the 
# Sage square root function.  

# Then, as above, Z-coordinates of the Optimal Path are computed as a polar function # of the Radial distance and angle over [-pi/2,pi/2].

# Currently, the Z-coordinates of the Optimal Path are being computed inaccurately, 
# as the rendered path does not remain in the plane of the Red Curved Track Surface.

# X-coordinates of Optimal Path

Optimal_Path_X = lambda u,v: v*(16*(np.float_power(np.cos(u),5/6)))

#FC_Optimal_Path_X = fast_callable(Optimal_Path_X, vars=[u,v], domain = R)

# Y-coordinates of Optimal Path
Optimal_Path_Y = lambda u,v: v*(-28*(np.float_power(np.sin(-u),5/6)))

#FC_Optimal_Path_Y = fast_callable(Optimal_Path_Y, vars=[u,v], domain = R)

# Radius of Optimal Path Curve (w/Numpy square root function)
Optimal_Path_Radius_Numpy = lambda u,v: v*(np.sqrt( (16**2)*(np.float_power(np.cos(u),5/3)) + (28**2)*(np.float_power(np.sin(-u),5/3)) ))

#FC_Optimal_Path_Radius_Sage = fast_callable(Optimal_Path_Radius_Sage, vars=[u,v], domain = R)

# Z-coordinates of Optimal Path
Optimal_Path_Z = lambda u,v: ( ( ( v*(np.sqrt( (16**2)*(np.float_power(np.cos(u),5/3)) + (28**2)*(np.float_power(np.sin(-u),5/3)) )) - 16 ) / 12 )*( 12*np.cos((pi/11)*( Track_Piece_Conversion(u) - 17 ) ) + 39.5 ) )/12

#FC_Optimal_Path_Z = fast_callable(Optimal_Path_Z, vars=[u,v], domain = R)

# Optimal Path Plot
Optimal_Path = parametric_plot3d([Optimal_Path_X, Optimal_Path_Y, Optimal_Path_Z], (u, -pi/2, 0), (v, 0.99, 1.01), color="black", opacity=1)

#FC_Optimal_Path = parametric_plot3d([FC_Optimal_Path_X, FC_Optimal_Path_Y, FC_Optimal_Path_Z], (u, -pi/2, 0), (v, 0.99, 1.01), color="green", opacity=0.5)



'''
coordinate_right_curve_x(u) = (16*(cos(u))^(exponent_2))
f_right_curve_x(u,v) = v*(16*(cos(u))^(exponent_2))
g_right_curve_x = fast_callable(f_right_curve_x, vars=[u,v], domain = R)

coordinate_right_curve_y(u) = (-28*(sin(-u))^(exponent_2))
f_right_curve_y(u,v) = v*(-28*(sin(-u))^(exponent_2))
g_right_curve_y = fast_callable(f_right_curve_y, vars=[u,v], domain = R)

f_right_curve_path_radius(u,v) = sqrt((coordinate_right_curve_x(u))^2+(coordinate_right_curve_y(u))^2)
g_right_curve_path_radius = fast_callable(f_right_curve_path_radius, vars=[u,v], domain = R)

f_right_curve_z(u,v) = ( ( (f_right_curve_path_radius(u) - 16)/12 ) * ( 12*cos( (pi/11)*(right_curve_u(u) - 17) ) + 39.5 ) )/12
g_right_curve_z = fast_callable(f_right_curve_z, vars=[u,v], domain = R)

#right_curve_z_2(u,v) = ( ( (right_curve_path_radius_2 - 16)/12 ) * ( 12*cos( (pi/11)*(right_curve_u - 17) ) + 39.5 ) )/12

right_curve_xy_plane = parametric_plot3d([f_right_curve_x, f_right_curve_y, 0], (u, -pi/2, -0.01), (v, 0.99, 1.01), color="black")
f_right_curve = parametric_plot3d([f_right_curve_x(u,v), f_right_curve_y(u,v), f_right_curve_z(u,v)], (u, -pi/2, -0.01), (v, 0.99, 1.01), color="red")
g_right_curve = parametric_plot3d([g_right_curve_x, g_right_curve_y, g_right_curve_z], (u, -pi/2, -0.01), (v, 0.99, 1.01), color="green")
'''

show(Red_Curved_Track_Surface+Blue_Test_Path+Optimal_Path)#+FC_Optimal_Path)