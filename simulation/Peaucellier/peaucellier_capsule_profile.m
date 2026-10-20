function xy=peaucellier_capsule_profile(length,width)
% CCW capsule profile; endpoint hole/pin centers stay at +/-length/2.
r=width/2;
a=linspace(-pi/2,pi/2,33)';
b=linspace(pi/2,3*pi/2,33)';
xy=[length/2+r*cos(a),r*sin(a);-length/2+r*cos(b),r*sin(b)];
end
