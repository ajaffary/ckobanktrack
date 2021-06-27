R = RealField(1000)

u = var('u')
right_curve_u(u,v) = 8+(14/pi)*(u+pi/2) #8+(14/pi)*(phi+pi/2)
right_track_u(u,v) = 15-(14/pi)*(u)

exponent = (5/6)

right_curve_x(u) = (16*(cos(u))^(exponent)+21)
right_curve_y(u) = (-28*(sin(-u))^(exponent))
right_track_path_radius(u) = sqrt((right_curve_x(u)-21)^2+(right_curve_y(u))^2)
right_curve_z(u) = (((right_track_path_radius(u)-16)/12)*(12*cos((pi/11)*(right_curve_u(u) - 17)) + 39.5))/12

x_prime = derivative(right_curve_x(u), u)
y_prime = derivative(right_curve_y(u), u)
z_prime = derivative(right_curve_z(u), u)

L = sqrt(x_prime^2 + y_prime^2 + z_prime^2)
#show(numerical_integral(L, 0, pi/2))

#Track piece example change of line
u, v = var('u, v')
f_x(u, v) = v*cos(u)
f_y(u, v) = v*sin(u)
f_z(u, v) = (((v-16)/12)*(12*cos((pi/11)*(right_curve_u(u) - 17)) + 39.5))/12
T=parametric_plot3d([f_x, f_y, f_z], (u, -pi/2, 0), (v, 16, 28), color="red", opacity=0.5, axes=True, mesh=False)
#c=parametric_plot3d([f_x, f_y, f_z], (u, -pi/2, pi/2), (v, 21.9, 22.1), color="black", mesh=True)
#c is the curve in the first example with constant radius

exponent_2 = float(5/6)

#Path Equation;  Note, "u" is the parameter for the path, "v" is to give it a bit of "thickness"
#right_curve_u = 8+(14/pi)*(u+pi/2) #8+(14/pi)*(phi+pi/2)

coordinate_right_curve_x(u) = (16*(cos(u))^(exponent_2))
f_right_curve_x(u,v) = v*(16*(cos(u))^(exponent_2))
g_right_curve_x = fast_callable(f_right_curve_x, vars=[u,v], domain = R)

coordinate_right_curve_y(u) = (-28*(sin(-u))^(exponent_2))
f_right_curve_y(u,v) = v*(-28*(sin(-u))^(exponent_2))
g_right_curve_y = fast_callable(f_right_curve_y, vars=[u,v], domain = R)

f_right_curve_path_radius(u,v) = sqrt((coordinate_right_curve_x(u))^2+(coordinate_right_curve_y(u))^2)
g_right_curve_path_radius = fast_callable(f_right_curve_path_radius, vars=[u,v], domain = R)

#right_curve_path_radius_2(u,v) = v*sqrt((16^2)*(cos(u))^(5/3)+(28^2)*(sin(-u))^(5/3))
#right_curve_path_radius_2(u,v) = v*(16*28)/(((28*cos(u))^(2.4)+(16*sin(-u))^2.4)^(5/12))

f_right_curve_z(u,v) = ( ( (f_right_curve_path_radius(u) - 16)/12 ) * ( 12*cos( (pi/11)*(right_curve_u(u) - 17) ) + 39.5 ) )/12
g_right_curve_z = fast_callable(f_right_curve_z, vars=[u,v], domain = R)

#right_curve_z_2(u,v) = ( ( (right_curve_path_radius_2 - 16)/12 ) * ( 12*cos( (pi/11)*(right_curve_u - 17) ) + 39.5 ) )/12

right_curve_xy_plane = parametric_plot3d([f_right_curve_x, f_right_curve_y, 0], (u, -pi/2, -0.01), (v, 0.99, 1.01), color="black")
f_right_curve = parametric_plot3d([f_right_curve_x(u,v), f_right_curve_y(u,v), f_right_curve_z(u,v)], (u, -pi/2, -0.01), (v, 0.99, 1.01), color="red")
g_right_curve = parametric_plot3d([g_right_curve_x, g_right_curve_y, g_right_curve_z], (u, -pi/2, -0.01), (v, 0.99, 1.01), color="green")
#right_curve_2 = parametric_plot3d([right_curve_x, right_curve_y, right_curve_z_2], (u, -pi/2, -0.01), (v, 0.99, 1.01), color="green")

#Blue path, circular (cosine and sine with unit exponent)
g_x(u, v) = v*(16-(12*(u-pi/2)/pi))*cos(u)
g_y(u, v) = v*(16-(12*(u-pi/2)/pi))*sin(u)
h(u) = v*(16 - (12/pi)*(u-pi/2))
g_z(u,v) = ( ( (h(u) - 16)/12 ) * ( 12*cos( (pi/11)*(right_curve_u(u) - 17) ) + 39.5 ) )/12
c_xy=parametric_plot3d([g_x, g_y, g_z], (u, -pi/2, 0), (v, 0.99, 1.01), color="blue")
T+c_xy+right_curve_xy_plane+f_right_curve+g_right_curve#+right_curve_2

#show(cos(2).n(100))
#show(cos(2).n(1000))