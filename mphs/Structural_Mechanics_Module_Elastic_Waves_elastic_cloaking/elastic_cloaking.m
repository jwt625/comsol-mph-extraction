function out = model
%
% elastic_cloaking.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Elastic_Waves');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/solid', true);

model.param.label('Geometrical Parameters');
model.param.set('r0', '0.2 [m]');
model.param.descr('r0', 'Inner radius of cloak');
model.param.set('r1', '0.4 [m]');
model.param.descr('r1', 'Outer radius of cloak');
model.param.set('Dpml', '0.2 [m]');
model.param.descr('Dpml', 'Width of PML');
model.param.set('r2', '1 [m] +Dpml');
model.param.descr('r2', 'Outer radius of computational domain');
model.param.create('par2');
model.param('par2').label('Material Properties and Simulation Parameters');
model.param('par2').set('lambda', '2.3 [Pa]');
model.param('par2').descr('lambda', ['First Lam' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' constant']);
model.param('par2').set('mu', '1 [Pa]');
model.param('par2').descr('mu', ['Second Lam' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' constant']);
model.param('par2').set('rho', '1 [kg/m^3]');
model.param('par2').descr('rho', 'Density');
model.param('par2').set('cP', 'sqrt((lambda+2*mu)/rho)');
model.param('par2').descr('cP', 'Speed P waves');
model.param('par2').set('cS', 'sqrt(mu/rho)');
model.param('par2').descr('cS', 'Speed S waves');
model.param('par2').set('omega', '40 [rad/s]');
model.param('par2').descr('omega', 'Circular frequency');
model.param('par2').set('kappaP', 'omega/cP');
model.param('par2').descr('kappaP', 'Wavenumber P aves');
model.param('par2').set('kappaS', 'omega/cS');
model.param('par2').descr('kappaS', 'Wavenumber S waves');
model.param('par2').set('wlengthP', '2*pi/kappaP');
model.param('par2').descr('wlengthP', 'Wavelength P waves');
model.param('par2').set('wlengthS', '2*pi/kappaS');
model.param('par2').descr('wlengthS', 'Wavelength S waves');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'r2');
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', 'Dpml', 0);
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('c1').setIndex('layer', 'r2-Dpml-r1', 1);
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 3', 2);
model.geom('geom1').feature('c1').setIndex('layer', 'r1-r0', 2);
model.geom('geom1').run('c1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '-((r2-Dpml-r1)/2+r1)*cos(pi/4)', 0);
model.geom('geom1').feature('pt1').setIndex('p', '((r2-Dpml-r1)/2+r1)*sin(pi/4)', 1);
model.geom('geom1').run('pt1');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('PML');
model.selection('sel1').set([1 2 7 12]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Cloak');
model.selection('sel2').set([5 6 9 10]);
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').label('Background Solid');
model.selection('com1').set('input', {'sel1' 'sel2'});
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Background and Cloak');
model.selection('uni1').set('input', {'sel2' 'com1'});

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.named('sel1');
model.coordSystem('pml1').set('ScalingType', 'Cylindrical');

model.physics('solid').feature('lemm1').set('IsotropicOption', 'Lame');
model.physics('solid').feature('lemm1').set('lambLame_mat', 'userdef');
model.physics('solid').feature('lemm1').set('lambLame', 'lambda');
model.physics('solid').feature('lemm1').set('muLame_mat', 'userdef');
model.physics('solid').feature('lemm1').set('muLame', 'mu');
model.physics('solid').feature('lemm1').set('rho_mat', 'userdef');
model.physics('solid').feature('lemm1').set('rho', 'rho');
model.physics('solid').create('pl1', 'PointLoad', 0);
model.physics('solid').feature('pl1').selection.set([3]);
model.physics('solid').feature('pl1').set('Fp', [1 0 0]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.named('sel1');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'wlengthS/12');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([1]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 7);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map2').selection.named('sel2');
model.mesh('mesh1').feature('map2').create('size1', 'Size');
model.mesh('mesh1').feature('map2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('map2').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map2').feature('size1').set('hmax', 'wlengthS/25');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom(2);
model.mesh('mesh1').feature('bl1').selection.set([]);
model.mesh('mesh1').feature('bl1').selection.allGeom;
model.mesh('mesh1').feature('bl1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('bl1').selection.named('sel2');
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([19 20 24 25]);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhtot');
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 20);
model.mesh('mesh1').run('bl1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').run;

model.physics('solid').prop('ShapeProperty').set('order_displacement', 5);

model.study('std1').label('Free Field');
model.study('std1').setGenPlots(false);
model.study('std1').feature('freq').set('plist', 'omega/2/pi');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'omega/2/pi'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Displacement Field');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('paramindicator', '');
model.result('pg1').set('title', 'Displacement magnitude (m)');
model.result('pg1').set('edges', false);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Free Field');
model.result('pg1').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg1').run;
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('uni1');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormin', 0);
model.result('pg1').feature('surf1').set('rangecolormax', 0.15);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('P Wave');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('paramindicator', '');
model.result('pg2').set('title', 'P wave (Volumetric strain)');
model.result('pg2').set('edges', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Free Field');
model.result('pg2').feature('surf1').set('expr', 'solid.evol');
model.result('pg2').feature('surf1').set('descr', 'Volumetric strain');
model.result('pg2').feature('surf1').set('colortable', 'Wave');
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('uni1');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('rangecoloractive', true);
model.result('pg2').feature('surf1').set('rangecolormin', -1);
model.result('pg2').feature('surf1').set('rangecolormax', 1);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('S wave');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('paramindicator', '');
model.result('pg3').set('title', 'S wave (Curl of displacement, Z-component)');
model.result('pg3').set('edges', false);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'solid.curlUZ');
model.result('pg3').feature('surf1').set('descr', 'Curl of displacement, Z-component');
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.named('uni1');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('rangecoloractive', true);
model.result('pg3').feature('surf1').set('rangecolormin', -5);
model.result('pg3').feature('surf1').set('rangecolormax', 5);
model.result('pg3').run;

model.coordSystem.create('sys2', 'geom1', 'Cylindrical');
model.coordSystem('sys2').set('frametype', 'material');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('aa', '(sys2.r-r0)/sys2.r');
model.variable('var1').set('bb', '(r1/(r1-r0))^2');
model.variable('var1').set('Ccl_rrrr', '(lambda+2*mu)*aa', 'Elastic Moduli in cylindrical coordinates');
model.variable('var1').set('Ccl_tttt', '(lambda+2*mu)/aa');
model.variable('var1').set('Ccl_rrtt', 'lambda');
model.variable('var1').set('Ccl_ttrr', 'lambda');
model.variable('var1').set('Ccl_rtrt', 'mu*aa');
model.variable('var1').set('Ccl_rttr', 'mu');
model.variable('var1').set('Ccl_trrt', 'mu');
model.variable('var1').set('Ccl_trtr', 'mu/aa');
model.variable('var1').set('Ccl_1111', 'Ccl_rrrr*(cos(sys2.phi))^4+(Ccl_rrtt+Ccl_rtrt+Ccl_rttr+Ccl_trrt+Ccl_trtr+Ccl_ttrr)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_tttt*(sin(sys2.phi))^4', 'Elastic Moduli in Cartesian coordinates');
model.variable('var1').set('Ccl_1112', '(cos(sys2.phi))^3*sin(sys2.phi)*(Ccl_rrrr-Ccl_rrtt-Ccl_rtrt-Ccl_trrt)+(sin(sys2.phi))^3*cos(sys2.phi)*(Ccl_rttr+Ccl_trtr+Ccl_ttrr-Ccl_tttt)');
model.variable('var1').set('Ccl_1121', '(cos(sys2.phi))^3*sin(sys2.phi)*(Ccl_rrrr-Ccl_rrtt-Ccl_rttr-Ccl_trtr)+(sin(sys2.phi))^3*cos(sys2.phi)*(Ccl_rtrt+Ccl_ttrr+Ccl_trrt-Ccl_tttt)');
model.variable('var1').set('Ccl_1122', 'Ccl_rrtt*(cos(sys2.phi))^4+(Ccl_rrrr-Ccl_rtrt-Ccl_rttr-Ccl_trrt-Ccl_trtr+Ccl_tttt)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_ttrr*(sin(sys2.phi))^4');
model.variable('var1').set('Ccl_1211', '(cos(sys2.phi))^3*sin(sys2.phi)*(Ccl_rrrr-Ccl_rtrt-Ccl_rttr-Ccl_ttrr)+(sin(sys2.phi))^3*cos(sys2.phi)*(Ccl_rrtt+Ccl_trrt+Ccl_trtr-Ccl_tttt)');
model.variable('var1').set('Ccl_1212', 'Ccl_rtrt*(cos(sys2.phi))^4+(Ccl_rrrr+Ccl_tttt-Ccl_rrtt-Ccl_rttr-Ccl_trrt-Ccl_ttrr)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_trtr*(sin(sys2.phi))^4');
model.variable('var1').set('Ccl_1221', 'Ccl_rttr*(cos(sys2.phi))^4+(Ccl_rrrr+Ccl_tttt-Ccl_rrtt-Ccl_rtrt-Ccl_trtr-Ccl_ttrr)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_trrt*(sin(sys2.phi))^4');
model.variable('var1').set('Ccl_1222', '(cos(sys2.phi))^3*sin(sys2.phi)*(-Ccl_tttt+Ccl_rrtt+Ccl_rtrt+Ccl_rttr)+(sin(sys2.phi))^3*cos(sys2.phi)*(Ccl_rrrr-Ccl_trtr-Ccl_ttrr-Ccl_trrt)');
model.variable('var1').set('Ccl_2111', '(cos(sys2.phi))^3*sin(sys2.phi)*(Ccl_rrrr-Ccl_trtr-Ccl_ttrr-Ccl_trrt)+(sin(sys2.phi))^3*cos(sys2.phi)*(-Ccl_tttt+Ccl_rrtt+Ccl_rtrt+Ccl_rttr)');
model.variable('var1').set('Ccl_2112', 'Ccl_trrt*(cos(sys2.phi))^4+(Ccl_rrrr+Ccl_tttt-Ccl_rrtt-Ccl_rtrt-Ccl_trtr-Ccl_ttrr)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_rttr*(sin(sys2.phi))^4');
model.variable('var1').set('Ccl_2121', 'Ccl_trtr*(cos(sys2.phi))^4+(Ccl_rrrr+Ccl_tttt-Ccl_rrtt-Ccl_rttr-Ccl_trrt-Ccl_ttrr)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_rtrt*(sin(sys2.phi))^4');
model.variable('var1').set('Ccl_2122', '(cos(sys2.phi))^3*sin(sys2.phi)*(Ccl_rrtt+Ccl_trrt+Ccl_trtr-Ccl_tttt)+(sin(sys2.phi))^3*cos(sys2.phi)*(Ccl_rrrr-Ccl_rtrt-Ccl_rttr-Ccl_ttrr)');
model.variable('var1').set('Ccl_2211', 'Ccl_ttrr*(cos(sys2.phi))^4+(Ccl_rrrr-Ccl_rtrt-Ccl_rttr-Ccl_trrt-Ccl_trtr+Ccl_tttt)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_rrtt*(sin(sys2.phi))^4');
model.variable('var1').set('Ccl_2212', '(cos(sys2.phi))^3*sin(sys2.phi)*(Ccl_rtrt+Ccl_ttrr+Ccl_trrt-Ccl_tttt)+(sin(sys2.phi))^3*cos(sys2.phi)*(Ccl_rrrr-Ccl_rrtt-Ccl_rttr-Ccl_trtr)');
model.variable('var1').set('Ccl_2221', '(cos(sys2.phi))^3*sin(sys2.phi)*(Ccl_rttr+Ccl_trtr+Ccl_ttrr-Ccl_tttt)+(sin(sys2.phi))^3*cos(sys2.phi)*(Ccl_rrrr-Ccl_rrtt-Ccl_rtrt-Ccl_trrt)');
model.variable('var1').set('Ccl_2222', 'Ccl_tttt*(cos(sys2.phi))^4+(Ccl_rrtt+Ccl_rtrt+Ccl_rttr+Ccl_trrt+Ccl_trtr+Ccl_ttrr)*(sin(sys2.phi))^2*(cos(sys2.phi))^2+Ccl_rrrr*(sin(sys2.phi))^4');
model.variable('var1').set('rhocl', 'aa*bb*rho', 'Density');
model.variable('var1').label('Material Properties Cloak');

model.physics('solid').create('lemm2', 'LinearElasticModel', 2);
model.physics('solid').feature('lemm2').label('Linear Elastic Material Cloak');
model.physics('solid').feature('lemm2').selection.named('sel2');
model.physics('solid').feature('lemm2').set('SolidModel', 'Anisotropic');
model.physics('solid').feature('lemm2').set('D_mat', 'userdef');
model.physics('solid').feature('lemm2').set('D', {'Ccl_1111' 'Ccl_1122' '0' '0' '0' '0' 'Ccl_1122' 'Ccl_2222' '0' '0'  ...
'0' '0' '0' '0' '0' '0' '0' '0' '0' '0'  ...
'0' '0' '0' '0' '0' '0' '0' '0' '0' '0'  ...
'0' '0' '0' '0' '0' '0'});
model.physics('solid').feature('lemm2').set('rho_mat', 'userdef');
model.physics('solid').feature('lemm2').set('rho', 'rhocl');
model.physics('solid').feature('lemm2').create('exs1', 'ExternalStress', 2);
model.physics('solid').feature('lemm2').feature('exs1').set('StressInputType', 'StressTensorNominal');
model.physics('solid').feature('lemm2').feature('exs1').set('Pext', {'Ccl_1121*solid.gradUxY+Ccl_1112*solid.gradUyX' 'Ccl_1211*solid.gradUxX+Ccl_1221*solid.gradUxY+Ccl_1212*solid.gradUyX+Ccl_1222*solid.gradUyY' '0' 'Ccl_2111*solid.gradUxX+Ccl_2121*solid.gradUxY+Ccl_2112*solid.gradUyX+Ccl_2122*solid.gradUyY' 'Ccl_2221*solid.gradUxY+Ccl_2212*solid.gradUyX' '0' '0' '0' '0'});

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').setSolveFor('/physics/solid', true);
model.study('std2').label('Cloak');
model.study('std2').setGenPlots(false);
model.study('std2').feature('freq').set('plist', 'omega/2/pi');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'omega/2/pi'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg1').run;
model.result('pg1').set('plotarrayenable', true);
model.result('pg1').feature('surf1').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').feature('surf2').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('surf2').label('Cloak');
model.result('pg1').feature('surf2').set('data', 'dset2');
model.result('pg1').feature('surf2').set('titletype', 'none');
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('ann1', 'Annotation');
model.result('pg1').feature('ann1').set('arraydim', '1');
model.result('pg1').feature('ann1').label('Annotation Free Field');
model.result('pg1').feature('ann1').set('text', 'Free Field');
model.result('pg1').feature('ann1').set('posxexpr', 0.02);
model.result('pg1').feature('ann1').set('posyexpr', 1.2);
model.result('pg1').feature('ann1').set('showpoint', false);
model.result('pg1').feature('ann1').set('anchorpoint', 'center');
model.result('pg1').feature('ann1').set('manualindexing', true);
model.result('pg1').run;
model.result('pg1').feature.duplicate('ann2', 'ann1');
model.result('pg1').feature('ann2').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('ann2').label('Annotation Cloak');
model.result('pg1').feature('ann2').set('text', 'Cloak');
model.result('pg1').feature('ann2').set('arrayindex', 1);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('plotarrayenable', true);
model.result('pg2').feature('surf1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature.duplicate('surf2', 'surf1');
model.result('pg2').feature('surf2').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf2').label('Cloak');
model.result('pg2').feature('surf2').set('data', 'dset2');
model.result('pg2').feature('surf2').set('titletype', 'none');
model.result('pg2').feature('surf2').set('inheritplot', 'surf1');
model.result('pg2').run;
model.result('pg1').feature('ann1').set('arraydim', '1');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature.copy('ann1', 'pg1/ann1');
model.result('pg2').feature.copy('ann2', 'pg1/ann2');
model.result('pg2').feature('ann1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').set('plotarrayenable', true);
model.result('pg3').feature('surf1').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf1').label('Free Field');
model.result('pg3').feature.duplicate('surf2', 'surf1');
model.result('pg3').feature('surf2').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf2').label('Cloak');
model.result('pg3').feature('surf2').set('data', 'dset2');
model.result('pg3').feature('surf2').set('titletype', 'none');
model.result('pg3').feature('surf2').set('inheritplot', 'surf1');
model.result('pg3').run;
model.result('pg2').feature('ann1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').feature.copy('ann1', 'pg2/ann1');
model.result('pg3').feature.copy('ann2', 'pg2/ann2');
model.result('pg3').feature('ann1').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').run;

model.study('std1').feature('freq').set('useadvanceddisable', true);
model.study('std1').feature('freq').set('disabledphysics', {'solid/lemm2'});

model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Thumbnail');
model.result('pg2').feature('surf1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg4').run;
model.result('pg4').feature.copy('surf3', 'pg2/surf1');
model.result('pg4').feature.copy('surf4', 'pg2/surf2');
model.result('pg4').feature.copy('ann3', 'pg2/ann1');
model.result('pg4').feature.copy('ann4', 'pg2/ann2');
model.result('pg4').feature('surf3').set('arraydim', '1');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('arrayshape', 'square');
model.result('pg4').feature('ann2').set('arraydim', '2');
model.result('pg4').run;
model.result('pg4').feature('ann2').set('colindex', 1);
model.result('pg4').run;
model.result('pg4').feature('ann3').set('arraydim', '2');
model.result('pg4').run;
model.result('pg4').feature('ann3').set('rowindex', 1);
model.result('pg4').feature('ann4').set('arraydim', '2');
model.result('pg4').run;
model.result('pg4').feature('ann4').set('rowindex', 1);
model.result('pg4').feature('ann4').set('colindex', 1);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').create('ann5', 'Annotation');
model.result('pg4').feature('ann5').set('arraydim', '2');
model.result('pg4').feature('ann5').set('text', 'P Wave');
model.result('pg4').feature('ann5').set('posxexpr', -1.5);
model.result('pg4').feature('ann5').set('showpoint', false);
model.result('pg4').feature('ann5').set('anchorpoint', 'center');
model.result('pg4').feature('ann5').set('manualindexing', true);
model.result('pg4').feature('ann5').set('rowindex', 1);
model.result('pg4').run;
model.result('pg4').feature.duplicate('ann6', 'ann5');
model.result('pg4').feature('ann6').set('arraydim', '2');
model.result('pg4').run;
model.result('pg4').feature('ann6').set('text', 'S Wave');
model.result('pg4').feature('ann6').set('rowindex', 0);
model.result('pg4').run;
model.result('pg4').run;
model.result.remove('pg4');
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').label('Cut Line Free Field');
model.result.dataset('cln1').setIndex('genpoints', 'r1*cos(pi/4)', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', '(r2-Dpml)*cos(pi/4)', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', '-r1*sin(pi/4)', 0, 1);
model.result.dataset('cln1').setIndex('genpoints', '-(r2-Dpml)*sin(pi/4)', 1, 1);
model.result.dataset.create('cln2', 'CutLine2D');
model.result.dataset('cln2').label('Cut Line Cloak');
model.result.dataset('cln2').set('data', 'dset2');
model.result.dataset('cln2').setIndex('genpoints', 'r1*cos(pi/4)', 0, 0);
model.result.dataset('cln2').setIndex('genpoints', '(r2-Dpml)*cos(pi/4)', 1, 0);
model.result.dataset('cln2').setIndex('genpoints', '-r1*sin(pi/4)', 0, 1);
model.result.dataset('cln2').setIndex('genpoints', '-(r2-Dpml)*sin(pi/4)', 1, 1);
model.result('pg1').run;

model.title('Elastic Cloaking with Polar Material');

model.description('In this example, the External Stress feature is used to set up the material model with nonsymmetric stress required in the design of an elastic invisibility cloak. This is a device whose aim is to shield a region of space from both P and S waves.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('elastic_cloaking.mph');

model.modelNode.label('Components');

out = model;
