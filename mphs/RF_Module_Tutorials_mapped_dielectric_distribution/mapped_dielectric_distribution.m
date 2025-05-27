function out = model
%
% mapped_dielectric_distribution.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');

model.param.set('f0', '3[GHz]');
model.param.descr('f0', 'Operating frequency');
model.param.set('lda0', 'c_const/f0');
model.param.descr('lda0', 'Free space wavelength');
model.param.set('w0', 'lda0*4');
model.param.descr('w0', 'Gaussian beam waist size');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 3);
model.geom('geom1').feature('sq1').set('base', 'center');
model.geom('geom1').feature('sq1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('sq1').setIndex('layer', 'lda0', 0);
model.geom('geom1').feature('sq1').set('layerleft', true);
model.geom('geom1').feature('sq1').set('layerright', true);
model.geom('geom1').feature('sq1').set('layertop', true);
model.geom('geom1').run('sq1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [1 2]);
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Lens');
model.selection('sel1').set([7]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.named('sel1');
model.variable('var1').set('xp', '0.5[m]*Xg[1/m]*(2-(Yg[1/m])^2)');
model.variable('var1').descr('xp', 'Mapping of Xg -> x');
model.variable('var1').set('yp', 'Yg*(1+(0.5*(xp[1/m])^2))');
model.variable('var1').descr('yp', 'Mapping of Yg -> y');
model.variable('var1').set('erp', '(1+0.5*(Yg[1/m])^2)^2');
model.variable('var1').descr('erp', 'Dielectric distribution');

model.coordSystem.create('pml1', 'geom1', 'PML');
model.coordSystem('pml1').selection.set([1 2 3 4 6 8 9 10]);

model.common.create('free1', 'DeformingDomainDeformedGeometry', 'comp1');
model.common('free1').selection.all;
model.common('free1').selection.set([5]);
model.common('free1').set('smoothingType', 'laplace');
model.common.create('pres1', 'PrescribedDeformationDeformedGeometry', 'comp1');
model.common('pres1').selection.set([7]);
model.common('pres1').set('prescribedDeformation', {'xp-Xg' 'yp-Yg' '0'});

model.physics('emw').prop('components').set('components', 'outofplane');
model.physics('emw').create('wee2', 'WaveEquationElectric', 2);
model.physics('emw').feature('wee2').selection.named('sel1');
model.physics('emw').feature('wee2').set('epsilonr_mat', 'userdef');
model.physics('emw').feature('wee2').set('epsilonr', {'erp' '0' '0' '0' 'erp' '0' '0' '0' 'erp'});
model.physics('emw').feature('wee2').set('mur_mat', 'userdef');
model.physics('emw').feature('wee2').set('sigma_mat', 'userdef');
model.physics('emw').create('scu1', 'SurfaceCurrent', 1);
model.physics('emw').feature('scu1').selection.set([10]);
model.physics('emw').feature('scu1').set('Js0', {'0' '0' 'exp(-(y/w0)^2)'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat1').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat1').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat1').label('Air');
model.material('mat1').set('family', 'air');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('molarmass', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('pressure');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat1').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat1').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat1').propertyGroup('idealGas').addInput('temperature');
model.material('mat1').propertyGroup('idealGas').addInput('pressure');
model.material('mat1').materialType('nonSolid');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').selection.set([5 7]);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'lda0/10');
model.mesh('mesh1').feature('size').set('hmin', 0.0012);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([6 12 19 22]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').run;

model.study('std1').create('stat', 'Stationary');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('plist', 'f0');
model.study('std1').feature('freq').setEntry('activate', 'frame:material1', false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([5]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([5]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '0.007178063805790527');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'freq');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scaleval', '0.007178063805790527');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'freq');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 0.01);
model.sol('sol1').feature('s2').create('p1', 'Parametric');
model.sol('sol1').feature('s2').feature.remove('pDef');
model.sol('sol1').feature('s2').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s2').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s2').feature('p1').set('punit', {'GHz'});
model.sol('sol1').feature('s2').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s2').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s2').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s2').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s2').feature('p1').set('probes', {});
model.sol('sol1').feature('s2').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s2').set('linpmethod', 'sol');
model.sol('sol1').feature('s2').set('linpsol', 'zero');
model.sol('sol1').feature('s2').set('control', 'freq');
model.sol('sol1').feature('s2').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s2').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').label('Deformed Geometry');
model.result('pg2').create('mesh1', 'Mesh');
model.result('pg2').feature('mesh1').set('meshdomain', 'surface');
model.result('pg2').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg2').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg2').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg2').feature('mesh1').feature('sel1').selection.set([5 7]);
model.result('pg2').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg2').feature('mesh1').set('qualexpr', 'comp1.material.relVol');
model.result('pg2').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg1').create('con1', 'Contour');
model.result('pg1').feature('con1').set('number', 14);
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('color', 'black');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').create('con1', 'Contour');
model.result('pg3').feature('con1').set('expr', 'emw.epsrAv');
model.result('pg3').feature('con1').set('descr', 'Relative permittivity, average');
model.result('pg3').feature('con1').set('number', 12);
model.result('pg3').feature('con1').set('contourtype', 'filled');
model.result('pg3').feature('con1').set('colortable', 'GrayScale');
model.result('pg3').feature('con1').set('colortabletrans', 'reverse');
model.result('pg3').run;

model.title('Defining a Mapped Dielectric Distribution of a Material');

model.description('This example demonstrates how to set up a spatially varying dielectric distribution. Here, a convex lens shape is defined via a known deformation of a rectangular domain. The dielectric distribution is defined on the undeformed, original rectangular domain and is mapped onto the deformed shape of the lens. Although the lens shape defined here is convex, the dielectric distribution causes the incident beam to diverge.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('mapped_dielectric_distribution.mph');

model.modelNode.label('Components');

out = model;
