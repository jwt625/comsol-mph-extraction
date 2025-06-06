function out = model
%
% iron_sphere_bfield_01_static.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Electromagnetics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/mf', true);

model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);

model.geom('geom1').lengthUnit('mm');

model.param.set('B0', '1[mT]');
model.param.descr('B0', 'Background magnetic field');
model.param.set('r0', '0.125[mm]');
model.param.descr('r0', 'Radius, iron sphere');
model.param.set('sigma_air', '0 [S/m]');
model.param.descr('sigma_air', 'Stabilization electrical conductivity of air');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', '3*r0');
model.geom('geom1').feature('sph1').setIndex('layer', 'r0', 0);
model.geom('geom1').feature('sph1').setIndex('layer', 'r0', 1);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Iron Sphere');
model.selection('sel1').set([9]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Iron Sphere Surface');
model.selection('sel2').geom(2);
model.selection('sel2').set('groupcontang', true);
model.selection('sel2').add([17 18 19 20 31 32 39 42]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Inifinte Element Domain');
model.selection('sel3').set([1 2 3 4 10 11 14 17]);
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').label('Analysis domain');
model.selection('com1').set('input', {'sel3'});

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');
model.coordSystem('ie1').selection.named('sel3');
model.coordSystem('ie1').set('ScalingType', 'Spherical');

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').set([2 6 11 13]);

model.physics('mf').prop('BackgroundField').set('SolveFor', 'ReducedField');
model.physics('mf').prop('BackgroundField').set('Ab', {'0' '0' 'B0*y'});
model.physics('mf').create('als1', 'AmperesLawSolid', 3);
model.physics('mf').feature('als1').selection.named('sel1');

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
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Iron');
model.material('mat2').set('family', 'iron');
model.material('mat2').propertyGroup('def').set('relpermeability', {'4000' '0' '0' '0' '4000' '0' '0' '0' '4000'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '7870[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '200[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.29');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigma_air'});
model.material('mat2').selection.named('sel1');
model.material.duplicate('mat3', 'mat2');
model.material('mat3').selection.geom('geom1', 2);
model.material('mat3').selection.named('sel2');

model.title(['Iron Sphere in a Magnetic Field ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Introduction']);

model.description('An iron sphere is exposed to a selection of spatially uniform background magnetic fields. The introduction gives a summary of the four different modeling scenarios covered in the series and the corresponding results. It also gives the modeling instructions for setting up the geometry and materials for the subsequent tutorial models. The following tutorials all use the introduction model as a starting point and can be completed in any order.');

model.label('iron_sphere_bfield_00_introduction.mph');

model.param.set('mu_r', '4000');
model.param.descr('mu_r', 'Relative permeability, iron sphere');
model.param.set('B_analytic', '((3*mu_r)/(mu_r+2))*B0');

model.material('mat2').propertyGroup('def').set('relpermeability', {'mu_r'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;

model.study('std1').feature('freq').active(false);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'B0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'T', 0);
model.study('std1').feature('stat').setIndex('pname', 'B0', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'T', 0);
model.study('std1').feature('stat').setIndex('pname', 'mu_r', 0);
model.study('std1').feature('stat').setIndex('plistarr', '2 4 10 20 40 100 200 400 1000 4000', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('ams1', 'AMS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('ams1').set('prefun', 'ams');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('ams1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 10, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('solutionparams', 'parent');
model.result('pg1').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('mslc1').set('xcoord', 'mf.CPx');
model.result('pg1').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('mslc1').set('ycoord', 'mf.CPy');
model.result('pg1').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('mslc1').set('zcoord', 'mf.CPz');
model.result('pg1').feature('mslc1').set('colortable', 'Prism');
model.result('pg1').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg1').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('strmsl1').set('xcoord', 'mf.CPx');
model.result('pg1').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('strmsl1').set('ycoord', 'mf.CPy');
model.result('pg1').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('strmsl1').set('zcoord', 'mf.CPz');
model.result('pg1').feature('strmsl1').set('titletype', 'none');
model.result('pg1').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg1').feature('strmsl1').set('udist', 0.02);
model.result('pg1').feature('strmsl1').set('maxlen', 0.4);
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('inheritcolor', false);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('maxtime', Inf);
model.result('pg1').feature('strmsl1').set('data', 'parent');
model.result('pg1').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg1').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg1').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg1').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result.dataset('dset1').selection.geom('geom1', 3);
model.result.dataset('dset1').selection.named('com1');
model.result('pg1').run;
model.result('pg1').run;
model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset('cpt1').set('pointx', 0);
model.result.dataset('cpt1').set('pointy', 0);
model.result.dataset('cpt1').set('pointz', 0);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Magnetic Flux Density');
model.result('pg2').set('xlog', true);
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('legendpos', 'middleright');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').label('Analytical Solution');
model.result('pg2').feature('ptgr1').set('expr', 'B_analytic');
model.result('pg2').feature('ptgr1').set('unit', 'mT');
model.result('pg2').feature('ptgr1').set('linestyle', 'dotted');
model.result('pg2').feature('ptgr1').set('linecolor', 'gray');
model.result('pg2').feature('ptgr1').set('data', 'cpt1');
model.result('pg2').feature('ptgr1').set('titletype', 'label');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('autoplotlabel', true);
model.result('pg2').feature('ptgr1').set('autosolution', false);
model.result('pg2').feature('ptgr1').set('autopoint', false);
model.result('pg2').feature('ptgr1').set('autounit', true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('ptgr2', 'PointGraph');
model.result('pg2').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr2').set('linewidth', 'preference');
model.result('pg2').feature('ptgr2').label('Vector Potential (mf)');
model.result('pg2').feature('ptgr2').set('data', 'cpt1');
model.result('pg2').feature('ptgr2').set('unit', 'mT');
model.result('pg2').feature('ptgr2').set('linestyle', 'none');
model.result('pg2').feature('ptgr2').set('linemarker', 'point');
model.result('pg2').feature('ptgr2').set('linecolor', 'blue');
model.result('pg2').feature('ptgr2').set('titletype', 'label');
model.result('pg2').feature('ptgr2').set('legend', true);
model.result('pg2').feature('ptgr2').set('autoplotlabel', true);
model.result('pg2').feature('ptgr2').set('autosolution', false);
model.result('pg2').feature('ptgr2').set('autopoint', false);
model.result('pg2').feature('ptgr2').set('autounit', true);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Magnetic Flux Density Comparison');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('legendpos', 'middleright');
model.result('pg3').set('xlog', true);
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').set('data', 'cpt1');
model.result('pg3').feature('ptgr1').set('expr', '(mf.normB-B_analytic)/B_analytic');
model.result('pg3').feature('ptgr1').set('titletype', 'label');
model.result('pg3').feature('ptgr1').set('linestyle', 'none');
model.result('pg3').feature('ptgr1').set('linemarker', 'point');
model.result('pg3').feature('ptgr1').set('linecolor', 'blue');
model.result('pg3').feature('ptgr1').label('Vector (mf) to Analytical Solution');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('autoplotlabel', true);
model.result('pg3').feature('ptgr1').set('autopoint', false);
model.result('pg3').feature('ptgr1').set('autosolution', false);
model.result('pg3').run;

model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');

model.study('std1').feature('freq').setSolveFor('/physics/mfnc', true);
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);

model.physics('mfnc').prop('BackgroundField').set('SolveFor', 'ReducedField');
model.physics('mfnc').prop('BackgroundField').set('Hb', {'B0/mu0_const' '0' '0'});
model.physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.physics('mfnc').feature('zsp1').selection.set([8]);

model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').autoMeshSize(4);
model.mesh('mesh2').contribute('physics/mf', false);
model.mesh('mesh2').run;

model.study('std1').feature('stat').setEntry('activate', 'mfnc', false);
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/mf', true);
model.study('std2').feature('stat').setSolveFor('/physics/mfnc', true);
model.study('std2').feature('stat').label('Scalar potential formulation');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'B0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'T', 0);
model.study('std2').feature('stat').setIndex('pname', 'B0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'T', 0);
model.study('std2').feature('stat').setIndex('pname', 'mu_r', 0);
model.study('std2').feature('stat').setIndex('plistarr', '2 4 10 20 40 100 200 400 1000 4000', 0);
model.study('std2').feature('stat').setEntry('activate', 'mf', false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Magnetic Flux Density Norm (mfnc)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 10, 0);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevel', 10, 0);
model.result('pg4').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom12/pdef1/pcond2/pcond1/pg1');
model.result('pg4').feature.create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg4').feature('mslc1').set('solutionparams', 'parent');
model.result('pg4').feature('mslc1').set('expr', 'mfnc.normB');
model.result('pg4').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg4').feature('mslc1').set('xcoord', 'mfnc.CPx');
model.result('pg4').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg4').feature('mslc1').set('ycoord', 'mfnc.CPy');
model.result('pg4').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg4').feature('mslc1').set('zcoord', 'mfnc.CPz');
model.result('pg4').feature('mslc1').set('colortable', 'Prism');
model.result('pg4').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg4').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg4').feature('mslc1').set('data', 'parent');
model.result('pg4').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg4').feature('strmsl1').set('expr', {'mfnc.Bx' 'mfnc.By' 'mfnc.Bz'});
model.result('pg4').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg4').feature('strmsl1').set('xcoord', 'mfnc.CPx');
model.result('pg4').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg4').feature('strmsl1').set('ycoord', 'mfnc.CPy');
model.result('pg4').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg4').feature('strmsl1').set('zcoord', 'mfnc.CPz');
model.result('pg4').feature('strmsl1').set('titletype', 'none');
model.result('pg4').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg4').feature('strmsl1').set('udist', 0.02);
model.result('pg4').feature('strmsl1').set('maxlen', 0.4);
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('inheritcolor', false);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg4').feature('strmsl1').set('maxtime', Inf);
model.result('pg4').feature('strmsl1').set('data', 'parent');
model.result('pg4').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg4').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg4').feature('strmsl1').feature('col1').set('expr', 'mfnc.normB');
model.result('pg4').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg4').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg4').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg4').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg4').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Magnetic Scalar Potential (mfnc)');
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 10, 0);
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 10, 0);
model.result('pg5').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom5/pdef1/pcond2/pcond1/pg1');
model.result('pg5').feature.create('mslc1', 'Multislice');
model.result('pg5').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg5').feature('mslc1').set('solutionparams', 'parent');
model.result('pg5').feature('mslc1').set('expr', 'Vm');
model.result('pg5').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg5').feature('mslc1').set('xcoord', 'mfnc.CPx');
model.result('pg5').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg5').feature('mslc1').set('ycoord', 'mfnc.CPy');
model.result('pg5').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg5').feature('mslc1').set('zcoord', 'mfnc.CPz');
model.result('pg5').feature('mslc1').set('colortable', 'Dipole');
model.result('pg5').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg5').feature('mslc1').set('data', 'parent');
model.result('pg5').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg5').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg5').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg5').feature('strmsl1').set('expr', {'mfnc.Hx' 'mfnc.Hy' 'mfnc.Hz'});
model.result('pg5').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg5').feature('strmsl1').set('xcoord', 'mfnc.CPx');
model.result('pg5').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg5').feature('strmsl1').set('ycoord', 'mfnc.CPy');
model.result('pg5').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg5').feature('strmsl1').set('zcoord', 'mfnc.CPz');
model.result('pg5').feature('strmsl1').set('titletype', 'none');
model.result('pg5').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg5').feature('strmsl1').set('udist', 0.02);
model.result('pg5').feature('strmsl1').set('maxlen', 0.4);
model.result('pg5').feature('strmsl1').set('maxtime', Inf);
model.result('pg5').feature('strmsl1').set('inheritcolor', false);
model.result('pg5').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg5').feature('strmsl1').set('maxtime', Inf);
model.result('pg5').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg5').feature('strmsl1').set('maxtime', Inf);
model.result('pg5').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg5').feature('strmsl1').set('maxtime', Inf);
model.result('pg5').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg5').feature('strmsl1').set('maxtime', Inf);
model.result('pg5').feature('strmsl1').set('data', 'parent');
model.result('pg5').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg5').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg5').feature('strmsl1').feature('col1').set('expr', 'Vm');
model.result('pg5').feature('strmsl1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg5').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg5').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg5').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg4').run;
model.result.dataset('dset2').selection.geom('geom1', 3);
model.result.dataset('dset2').selection.named('com1');
model.result('pg4').run;
model.result('pg4').run;
model.result.dataset.create('cpt2', 'CutPoint3D');
model.result.dataset('cpt2').set('data', 'dset2');
model.result.dataset('cpt2').set('pointx', 0);
model.result.dataset('cpt2').set('pointy', 0);
model.result.dataset('cpt2').set('pointz', 0);
model.result('pg2').run;
model.result('pg2').create('ptgr3', 'PointGraph');
model.result('pg2').feature('ptgr3').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr3').set('linewidth', 'preference');
model.result('pg2').feature('ptgr3').label('Scalar Potential (mfnc)');
model.result('pg2').feature('ptgr3').set('data', 'cpt2');
model.result('pg2').feature('ptgr3').set('expr', 'mfnc.normB');
model.result('pg2').feature('ptgr3').set('unit', 'mT');
model.result('pg2').feature('ptgr3').set('titletype', 'label');
model.result('pg2').feature('ptgr3').set('linestyle', 'none');
model.result('pg2').feature('ptgr3').set('linemarker', 'diamond');
model.result('pg2').feature('ptgr3').set('linecolor', 'red');
model.result('pg2').feature('ptgr3').set('legend', true);
model.result('pg2').feature('ptgr3').set('autoplotlabel', true);
model.result('pg2').feature('ptgr3').set('autopoint', false);
model.result('pg2').feature('ptgr3').set('autosolution', false);
model.result('pg2').feature('ptgr3').set('autounit', true);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').create('ptgr2', 'PointGraph');
model.result('pg3').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr2').set('linewidth', 'preference');
model.result('pg3').feature('ptgr2').label('Scalar (mfnc) to Analytical Solution');
model.result('pg3').feature('ptgr2').set('data', 'cpt2');
model.result('pg3').feature('ptgr2').set('expr', '(mfnc.normB-B_analytic)/B_analytic');
model.result('pg3').feature('ptgr2').set('linestyle', 'none');
model.result('pg3').feature('ptgr2').set('linemarker', 'diamond');
model.result('pg3').feature('ptgr2').set('linecolor', 'red');
model.result('pg3').feature('ptgr2').set('legend', true);
model.result('pg3').feature('ptgr2').set('autoplotlabel', true);
model.result('pg3').feature('ptgr2').set('autopoint', false);
model.result('pg3').feature('ptgr2').set('autosolution', false);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('ptgr1').createTable('tbl1');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').createTable('tbl2');
model.result('pg2').run;
model.result('pg2').feature('ptgr1').createTable('tbl3');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').createTable('tbl4');
model.result('pg2').run;
model.result('pg2').feature('ptgr3').createTable('tbl5');
model.result('pg1').run;
model.result.duplicate('pg6', 'pg1');
model.result('pg6').run;
model.result('pg6').set('edges', false);
model.result('pg6').set('showlegendsmaxmin', false);
model.result('pg6').set('showlegendsunit', true);
model.result('pg6').run;
model.result('pg6').feature('mslc1').set('unit', 'mT');
model.result('pg6').feature('mslc1').set('xcoord', '');
model.result('pg6').feature('mslc1').set('ycoord', '');
model.result('pg6').feature('mslc1').create('tran1', 'Transparency');
model.result('pg6').run;
model.result('pg6').feature('mslc1').feature('tran1').set('transparency', 0.15);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature('strmsl1').set('xcoord', '');
model.result('pg6').feature('strmsl1').set('ycoord', '');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').create('slc1', 'Slice');
model.result('pg6').feature('slc1').set('expr', 'mf.normJ');
model.result('pg6').feature('slc1').set('descr', 'Current density norm');
model.result('pg6').feature('slc1').set('quickxnumber', 1);
model.result('pg6').feature('slc1').set('colortable', 'Thermal');
model.result('pg6').feature('slc1').set('colortabletrans', 'reverse');
model.result('pg6').run;
model.result('pg6').feature('slc1').create('sel1', 'Selection');
model.result('pg6').feature('slc1').feature('sel1').selection.named('sel1');
model.result('pg6').run;
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'material.boundary');
model.result('pg6').feature('surf1').set('descr', 'Material settings');
model.result('pg6').feature('surf1').set('titletype', 'none');
model.result('pg6').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg6').feature('surf1').feature('mtrl1').set('family', 'ironscratched');
model.result('pg6').run;
model.result('pg6').feature('surf1').create('filt1', 'Filter');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('filt1').set('expr', 'x>0');
model.result('pg6').run;
model.result('pg6').feature('surf1').create('sel1', 'Selection');
model.result('pg6').feature('surf1').feature('sel1').selection.named('sel2');
model.result('pg6').run;

model.title(['Iron Sphere in a Magnetic Field ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Static Field']);

model.description('An iron sphere is exposed to a static, spatially uniform background magnetic field. The perturbation to the magnetic field and the field strength inside the sphere is investigated for a range of relative permeabilities of the iron sphere. The field strength inside the sphere is computed and compared against the analytic solution. Two formulations are used to solve this problem, and the differences between these are discussed.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('iron_sphere_bfield_01_static.mph');

model.modelNode.label('Components');

out = model;
