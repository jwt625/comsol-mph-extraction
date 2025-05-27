function out = model
%
% lossy_circulator_3d_geom.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Ferrimagnetic_Devices');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/emw', true);

model.param.set('sc_chamfer', '3');
model.param.descr('sc_chamfer', 'Geometry scale factor');
model.param.set('sc_ferrite', '0.5');
model.param.descr('sc_ferrite', 'Geometry scale factor');

model.variable.create('var1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('eps0', '8.854187817e-12[F/m]', 'Permittivity of free space');
model.variable('var1').set('mu0', '4e-7*pi[H/m]', 'Permeability of free space');
model.variable('var1').set('w', '2*pi*freq', 'Angular frequency');
model.variable('var1').set('gamma', '1.759e11[C/kg]', 'Gyromagnetic ratio');
model.variable('var1').set('H0', '(100*1e3/(4*pi))[A/m]', 'Applied magnetic bias field');
model.variable('var1').set('w0', 'mu0*gamma*H0', 'Larmor frequency');
model.variable('var1').set('Ms', '680e-4[Wb/m^2]/mu0', 'Saturation magnetization');
model.variable('var1').set('wm', 'mu0*gamma*Ms', 'Larmor frequency at saturation limit');
model.variable('var1').set('dH', '(40*1e3/(4*pi))[A/m]', 'Line width');
model.variable('var1').set('alpha', 'dH*mu0*gamma/(2*w)', 'Damping factor');
model.variable('var1').set('chim_xx_p', '(w0*wm*(w0^2-w^2)+w0*wm*w^2*alpha^2)/((w0^2-w^2*(1+alpha^2))^2+4*(w0*w*alpha)^2)', 'Magnetic susceptibility, real part');
model.variable('var1').set('chim_xx_b', '(alpha*w*wm*(w0^2+w^2*(1+alpha^2)))/((w0^2-w^2*(1+alpha^2))^2+4*(w0*w*alpha)^2)', 'Magnetic susceptibility, imaginary part');
model.variable('var1').set('chim_xy_p', '(w*wm*(w0^2-w^2*(1+alpha^2)))/((w0^2-w^2*(1+alpha^2))^2+4*(w0*w*alpha)^2)', 'Magnetic susceptibility, real part');
model.variable('var1').set('chim_xy_b', '2*w0*wm*w^2*alpha/((w0^2-w^2*(1+alpha^2))^2+4*(w0*w*alpha)^2)', 'Magnetic susceptibility, imaginary part');
model.variable('var1').set('chim_xx', 'chim_xx_p-j*chim_xx_b', 'Complex magnetic susceptibility');
model.variable('var1').set('chim_xy', 'chim_xy_b+j*chim_xy_p', 'Complex magnetic susceptibility');
model.variable('var1').set('murxx', '(1+chim_xx)', 'Complex relative magnetic permeability');
model.variable('var1').set('murxy', 'chim_xy', 'Complex relative magnetic permeability');
model.variable('var1').set('murxz', '0', 'Complex relative magnetic permeability');
model.variable('var1').set('muryx', '-chim_xy', 'Complex relative magnetic permeability');
model.variable('var1').set('muryy', 'murxx', 'Complex relative magnetic permeability');
model.variable('var1').set('muryz', '0', 'Complex relative magnetic permeability');
model.variable('var1').set('murzx', '0', 'Complex relative magnetic permeability');
model.variable('var1').set('murzy', '0', 'Complex relative magnetic permeability');
model.variable('var1').set('murzz', '1', 'Complex relative magnetic permeability');
model.variable('var1').set('tdeltae', '0.0002', 'Effective loss tangent');
model.variable('var1').set('eps_r_p', '14.5', 'Relative permittivity, real part');
model.variable('var1').set('eps_r_b', '14.5*tdeltae', 'Relative permittivity, imaginary part');
model.variable('var1').set('eps_r', 'eps_r_p-j*eps_r_b', 'Complex relative permittivity');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'0.2-0.1/(3*sqrt(3))' '1'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('size', '0.2/3', 1);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-0.2' '-0.1/3'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('copy1', 'Copy');
model.geom('geom1').feature('wp1').geom.feature('copy1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.run('copy1');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'copy1'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', 120);
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.create('copy2', 'Copy');
model.geom('geom1').feature('wp1').geom.feature('copy2').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.run('copy2');
model.geom('geom1').feature('wp1').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot2').selection('input').set({'copy2'});
model.geom('geom1').feature('wp1').geom.feature('rot2').set('rot', -120);
model.geom('geom1').feature('wp1').geom.run('rot2');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'r1' 'rot1' 'rot2'});
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', '0.2/(3*sqrt(3))');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('copy3', 'Copy');
model.geom('geom1').feature('wp1').geom.feature('copy3').selection('input').set({'uni1'});
model.geom('geom1').feature('wp1').geom.run('copy3');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'copy3'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('rot3', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot3').selection('input').set({'dif1'});
model.geom('geom1').feature('wp1').geom.feature('rot3').set('rot', 180);
model.geom('geom1').feature('wp1').geom.run('rot3');
model.geom('geom1').feature('wp1').geom.create('copy4', 'Copy');
model.geom('geom1').feature('wp1').geom.feature('copy4').selection('input').set({'rot3'});
model.geom('geom1').feature('wp1').geom.run('copy4');
model.geom('geom1').feature('wp1').geom.create('sca1', 'Scale');
model.geom('geom1').feature('wp1').geom.feature('sca1').set('isotropic', 'sc_chamfer');
model.geom('geom1').feature('wp1').geom.feature('sca1').selection('input').set({'copy4'});
model.geom('geom1').feature('wp1').geom.run('sca1');
model.geom('geom1').feature('wp1').geom.create('uni2', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni2').selection('input').set({'sca1' 'uni1'});
model.geom('geom1').feature('wp1').geom.feature('uni2').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni2');
model.geom('geom1').feature('wp1').geom.create('sca2', 'Scale');
model.geom('geom1').feature('wp1').geom.feature('sca2').selection('input').set({'rot3'});
model.geom('geom1').feature('wp1').geom.feature('sca2').set('isotropic', 'sc_ferrite');
model.geom('geom1').feature('wp1').geom.run('sca2');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', '0.1/3', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').run('fin');

model.title('Parameterized Circulator Geometry');

model.description('This is a template MPH-file containing the parameterized geometry for the model Impedance Matching of a Lossy Ferrite 3-Port Circulator.');

model.label('lossy_circulator_3d_geom.mph');

model.modelNode.label('Components');

out = model;
