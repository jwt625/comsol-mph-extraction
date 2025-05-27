function out = model
%
% one_sided_magnet.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Magnetostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);

model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 20);
model.geom('geom1').run('sph1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', [10 5]);
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', [0 -5]);
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', [10 -5]);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', [12 2]);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', [0 5]);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('cha1', 'Chamfer');
model.geom('geom1').feature('wp1').geom.feature('cha1').selection('pointinsketch').set('r2', 2);
model.geom('geom1').feature('wp1').geom.feature('cha1').set('dist', 1);
model.geom('geom1').feature('wp1').geom.run('cha1');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', [1 5]);
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', [10 0]);
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'full');
model.geom('geom1').feature('rev1').set('origfaces', false);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Air');
model.selection('sel1').set([1]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Cap');
model.selection('sel2').set([2 3]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Magnet');
model.selection('sel3').set([4]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').geom(2);
model.selection('sel4').label('Plate');
model.selection('sel4').set([17 18 33 38]);

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
model.material('mat1').selection.named('sel1');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').label('Acrylic plastic');
model.material('mat2').set('family', 'custom');
model.material('mat2').set('customspecular', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat2').set('customdiffuse', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat2').set('customambient', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat2').set('noise', true);
model.material('mat2').set('lighting', 'phong');
model.material('mat2').set('shininess', 1000);
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '1470[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('density', '1190[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '3.2[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material('mat2').selection.named('sel2');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat3').label('N28TH (Sintered NdFeB)');
model.material('mat3').set('family', 'chrome');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]' '0' '0' '0' '1/1.4[uohm*m]'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('normBr', '1.07[T]');
model.material('mat3').selection.named('sel3');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').label('Linear Shielding Alloy');
model.material('mat4').selection.geom('geom1', 2);
model.material('mat4').selection.named('sel4');
model.material('mat4').propertyGroup('def').set('relpermeability', {'1200'});

model.physics('mfnc').create('mag1', 'Magnet', 3);
model.physics('mfnc').feature('mag1').selection.named('sel3');
model.physics('mfnc').feature('mag1').set('DirectionMethod', 'UserDefined');
model.physics('mfnc').feature('mag1').set('directionInput', [0 0 1]);
model.physics('mfnc').create('ms1', 'MagneticShielding', 2);
model.physics('mfnc').feature('ms1').selection.named('sel4');
model.physics('mfnc').feature('ms1').set('ds', '0.5[mm]');
model.physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.physics('mfnc').feature('zsp1').selection.set([1]);

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.named('sel3');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 1);
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('sel4');
model.mesh('mesh1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run('size1');
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').label('Two-sided Magnet - Linear');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Magnetic Flux Density Norm (mfnc)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom12/pdef1/pcond2/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('solutionparams', 'parent');
model.result('pg1').feature('mslc1').set('expr', 'mfnc.normB');
model.result('pg1').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('mslc1').set('xcoord', 'mfnc.CPx');
model.result('pg1').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('mslc1').set('ycoord', 'mfnc.CPy');
model.result('pg1').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('mslc1').set('zcoord', 'mfnc.CPz');
model.result('pg1').feature('mslc1').set('colortable', 'Prism');
model.result('pg1').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg1').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg1').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg1').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg1').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg1').feature('strmsl1').set('xcoord', 'mfnc.CPx');
model.result('pg1').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg1').feature('strmsl1').set('ycoord', 'mfnc.CPy');
model.result('pg1').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg1').feature('strmsl1').set('zcoord', 'mfnc.CPz');
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
model.result('pg1').feature('strmsl1').feature('col1').set('expr', 'mfnc.normB');
model.result('pg1').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg1').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Magnetic Scalar Potential (mfnc)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom5/pdef1/pcond2/pcond1/pg1');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('solutionparams', 'parent');
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'mfnc.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'mfnc.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'mfnc.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Dipole');
model.result('pg2').feature('mslc1').set('showsolutionparams', 'on');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result('pg2').feature.create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('solutionparams', 'parent');
model.result('pg2').feature('strmsl1').set('expr', {'mfnc.Hx' 'mfnc.Hy' 'mfnc.Hz'});
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'mfnc.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'mfnc.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'mfnc.CPz');
model.result('pg2').feature('strmsl1').set('titletype', 'none');
model.result('pg2').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg2').feature('strmsl1').set('udist', 0.02);
model.result('pg2').feature('strmsl1').set('maxlen', 0.4);
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('inheritcolor', false);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('showsolutionparams', 'on');
model.result('pg2').feature('strmsl1').set('maxtime', Inf);
model.result('pg2').feature('strmsl1').set('data', 'parent');
model.result('pg2').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg2').feature('strmsl1').feature.create('col1', 'Color');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature.create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').label('Two-sided Magnet - Linear');
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('zcoord', '');
model.result('pg1').feature('mslc1').set('xcoord', '');
model.result('pg1').run;
model.result('pg1').feature('strmsl1').set('zcoord', '');
model.result('pg1').feature('strmsl1').set('xcoord', '');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'mfnc.tBx');
model.result('pg1').feature('surf1').set('descr', 'Tangential magnetic flux density, x-component');
model.result('pg1').feature('surf1').set('colortable', 'Viridis');
model.result('pg1').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').selection.named('sel4');
model.result.numerical('int1').setIndex('expr', 'mfnc.unTmz+mfnc.dnTmz', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Surface Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;

model.param.set('k', 'pi/10[mm]');
model.param.descr('k', 'Wave number in x direction');

model.physics('mfnc').feature.duplicate('mag2', 'mag1');
model.physics('mfnc').feature('mag2').set('directionInput', {'sin(k*x)' '0' 'cos(k*x)'});

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/mfnc', true);
model.study('std2').label('One-sided Magnet - Linear');
model.study('std2').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
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

model.result('pg1').run;
model.result.duplicate('pg3', 'pg1');
model.result('pg3').run;
model.result('pg3').label('One-sided Magnet - Linear');
model.result('pg3').run;
model.result('pg3').set('data', 'dset2');
model.result('pg3').run;
model.result.numerical('int1').set('data', 'dset2');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').appendResult;

model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat5').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat5').propertyGroup.create('EffectiveBHCurve', 'Effective B-H Curve');
model.material('mat5').propertyGroup('EffectiveBHCurve').func.create('BHeff', 'Interpolation');
model.material('mat5').label('Soft Iron (Without Losses)');
model.material('mat5').set('family', 'iron');
model.material('mat5').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat5').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat5').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'663.146' '1';  ...
'1067.5' '1.1';  ...
'1705.23' '1.2';  ...
'2463.11' '1.3';  ...
'3841.67' '1.4';  ...
'5425.74' '1.5';  ...
'7957.75' '1.6';  ...
'12298.3' '1.7';  ...
'20462.8' '1.8';  ...
'32169.6' '1.9';  ...
'61213.4' '2';  ...
'111408' '2.1';  ...
'188487.757' '2.2';  ...
'267930.364' '2.3';  ...
'347507.836' '2.4'});
model.material('mat5').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat5').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat5').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat5').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat5').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat5').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat5').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat5').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat5').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat5').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat5').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat5').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material('mat5').propertyGroup('EffectiveBHCurve').label('Effective B-H Curve');
model.material('mat5').propertyGroup('EffectiveBHCurve').func('BHeff').label('Interpolation 1');
model.material('mat5').propertyGroup('EffectiveBHCurve').func('BHeff').set('table', {'0' '0';  ...
'663.146' '1.000000051691021';  ...
'1067.5' '1.4936495124126294';  ...
'1705.23' '1.9415328461315795';  ...
'2463.11' '2.257765669366018';  ...
'3841.67' '2.609980642431287';  ...
'5425.74' '2.8664452090837504';  ...
'7957.75' '3.1441438097176118';  ...
'12298.3' '3.448538051654125';  ...
'20462.8' '3.7816711973679054';  ...
'32169.6' '4.058345590113038';  ...
'61213.4' '4.420646552950275';  ...
'111408' '4.721274089545955';  ...
'188487.757' '4.972148140718701';  ...
'267930.364' '5.145510860855953';  ...
'347507.836' '5.245510861426532'});
model.material('mat5').propertyGroup('EffectiveBHCurve').func('BHeff').set('extrap', 'linear');
model.material('mat5').propertyGroup('EffectiveBHCurve').func('BHeff').set('fununit', {'T'});
model.material('mat5').propertyGroup('EffectiveBHCurve').func('BHeff').set('argunit', {'A/m'});
model.material('mat5').propertyGroup('EffectiveBHCurve').func('BHeff').set('defineinv', true);
model.material('mat5').propertyGroup('EffectiveBHCurve').set('normBeff', 'BHeff(normHeffin)');
model.material('mat5').propertyGroup('EffectiveBHCurve').set('normHeff', 'BHeff_inv(normBeffin)');
model.material('mat5').propertyGroup('EffectiveBHCurve').descr('normHeffin', 'Effective magnetic field norm');
model.material('mat5').propertyGroup('EffectiveBHCurve').descr('normBeffin', 'Effective magnetic flux density norm');
model.material('mat5').propertyGroup('EffectiveBHCurve').addInput('magneticfield');
model.material('mat5').propertyGroup('EffectiveBHCurve').addInput('magneticfluxdensity');
model.material('mat5').selection.geom('geom1', 2);
model.material('mat5').selection.named('sel4');

model.physics('mfnc').feature('ms1').set('ConstitutiveRelationBH', 'BHCurve');

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/mfnc', true);
model.study('std3').label('One-sided Magnet - Nonlinear');
model.study('std3').setGenPlots(false);

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'stat');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'stat');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol3').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol3').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol3').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol3').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result('pg4').run;
model.result('pg4').label('One-sided Magnet - Nonlinear');
model.result('pg4').set('data', 'dset3');
model.result('pg4').run;
model.result.numerical('int1').set('data', 'dset3');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').appendResult;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').label('Differential Relative Permeability');
model.result('pg4').feature('surf1').set('titletype', 'label');
model.result('pg4').feature('surf1').set('expr', 'd(comp1.mat5.BHCurve.BH(mfnc.normtH),mfnc.normtH)/mu0_const');
model.result('pg4').feature('surf1').set('colorscalemode', 'logarithmic');

model.geom('geom1').feature('sph1').active(false);
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', false);

model.geom('geom1').feature('sph1').active(true);
model.geom('geom1').run;

model.selection('sel1').set([1]);

model.physics('mfnc').feature('zsp1').selection.set([1]);

model.result('pg4').run;
model.result('pg4').set('showlegendsmaxmin', false);
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').set('edges', false);
model.result('pg4').run;

model.title('One-Sided Magnet and Plate');

model.description(['One-sided magnets are magnets designed to have both magnetic poles emerging from the same side of the magnet. This results in the magnetic flux being concentrated on one side of the magnet. These kinds of magnets are found in many applications from the common fridge magnet to particle accelerators.' newline  newline 'This tutorial demonstrates a method to model a cylindrical one-sided permanent magnet by giving the magnet a magnetization that varies in the lateral direction. The model simulates the magnetic flux from the magnet and its interaction with a nearby thin metal plate.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('one_sided_magnet.mph');

model.modelNode.label('Components');

out = model;
