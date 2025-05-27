function out = model
%
% quadrupole.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Electromagnetics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);

model.param.set('M', '11');
model.param.descr('M', 'Ion mass number');
model.param.set('Z', '5');
model.param.descr('Z', 'Ion charge number');
model.param.set('L1', '1[m]');
model.param.descr('L1', 'Length of first quadrupole');
model.param.set('L2', '2[m]');
model.param.descr('L2', 'Length of second quadrupole');
model.param.set('L3', '1[m]');
model.param.descr('L3', 'Length of third quadrupole');
model.param.set('vz', '0.01*c_const');
model.param.descr('vz', 'Ion velocity');
model.param.set('m', 'M*mp_const');
model.param.descr('m', 'Ion mass');
model.param.set('q', 'Z*e_const');
model.param.descr('q', 'Ion charge');
model.param.set('Br', '8[mT]');
model.param.descr('Br', 'Quadrupole remanent flux density');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.177 0.07]);
model.geom('geom1').feature('r1').set('pos', [0 -0.035]);
model.geom('geom1').run('r1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'r1'});
model.geom('geom1').feature('rot1').set('rot', 45);
model.geom('geom1').run('rot1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.2);
model.geom('geom1').feature('c1').set('pos', [0.2 0.2]);
model.geom('geom1').run('c1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'c1' 'rot1'});
model.geom('geom1').run('int1');
model.geom('geom1').create('rot2', 'Rotate');
model.geom('geom1').feature('rot2').selection('input').set({'int1'});
model.geom('geom1').feature('rot2').set('rot', '90, 180, 270');
model.geom('geom1').feature('rot2').set('keep', true);
model.geom('geom1').run('rot2');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 0.2);
model.geom('geom1').run('c2');
model.geom('geom1').create('c3', 'Circle');
model.geom('geom1').feature('c3').set('r', 0.12);
model.geom('geom1').run('c3');
model.geom('geom1').create('co1', 'Compose');
model.geom('geom1').feature('co1').selection('input').set({'c2' 'c3' 'int1' 'rot2'});
model.geom('geom1').feature('co1').set('formula', 'c2+c3-(int1+rot2(1)+rot2(2)+rot2(3))');
model.geom('geom1').run('co1');
model.geom('geom1').create('c4', 'Circle');
model.geom('geom1').feature('c4').set('r', 0.2);
model.geom('geom1').run('c4');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Iron');
model.material('mat1').set('family', 'iron');
model.material('mat1').propertyGroup('def').set('relpermeability', {'4000' '0' '0' '0' '4000' '0' '0' '0' '4000'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7870[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '200[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.29');
model.material('mat1').selection.set([2]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Magnets');
model.material('mat2').selection.set([1 3 5 6]);
model.material('mat2').propertyGroup.create('RemanentFluxDensity', 'Remanent_flux_density');
model.material('mat2').propertyGroup('RemanentFluxDensity').set('murec', {'1.05'});
model.material('mat2').propertyGroup('RemanentFluxDensity').set('normBr', {'Br'});

model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').selection.set([6]);
model.physics('mf').feature('als1').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mf').feature('als1').set('e_crel_BH_RemanentFluxDensity', {'-1/sqrt(2)' '-1/sqrt(2)' '0'});
model.physics('mf').feature('als1').set('sigma_mat', 'userdef');
model.physics('mf').feature('als1').set('epsilonr_mat', 'userdef');
model.physics('mf').create('als2', 'AmperesLawSolid', 2);
model.physics('mf').feature('als2').selection.set([3]);
model.physics('mf').feature('als2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mf').feature('als2').set('e_crel_BH_RemanentFluxDensity', {'-1/sqrt(2)' '1/sqrt(2)' '0'});
model.physics('mf').feature('als2').set('sigma_mat', 'userdef');
model.physics('mf').feature('als2').set('epsilonr_mat', 'userdef');
model.physics('mf').create('als3', 'AmperesLawSolid', 2);
model.physics('mf').feature('als3').selection.set([1]);
model.physics('mf').feature('als3').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mf').feature('als3').set('e_crel_BH_RemanentFluxDensity', {'1/sqrt(2)' '1/sqrt(2)' '0'});
model.physics('mf').feature('als3').set('sigma_mat', 'userdef');
model.physics('mf').feature('als3').set('epsilonr_mat', 'userdef');
model.physics('mf').create('als4', 'AmperesLawSolid', 2);
model.physics('mf').feature('als4').selection.set([5]);
model.physics('mf').feature('als4').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mf').feature('als4').set('e_crel_BH_RemanentFluxDensity', {'1/sqrt(2)' '-1/sqrt(2)' '0'});
model.physics('mf').feature('als4').set('sigma_mat', 'userdef');
model.physics('mf').feature('als4').set('epsilonr_mat', 'userdef');
model.physics('mf').create('als5', 'AmperesLawSolid', 2);
model.physics('mf').feature('als5').selection.set([2]);

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('surf1').set('colorcalibration', -0.8);
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.03);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').feature.create('con1', 'Contour');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('solutionparams', 'parent');
model.result('pg1').feature('con1').set('expr', 'mf.Az');
model.result('pg1').feature('con1').set('titletype', 'none');
model.result('pg1').feature('con1').set('number', 10);
model.result('pg1').feature('con1').set('levelrounding', false);
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('color', 'custom');
model.result('pg1').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg1').feature('con1').set('resolution', 'fine');
model.result('pg1').feature('con1').set('inheritcolor', false);
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('data', 'parent');
model.result('pg1').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').feature('con1').feature.create('filt1', 'Filter');
model.result('pg1').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'mf.normH');
model.result('pg1').feature('surf1').set('descr', 'Magnetic field norm');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Ions Trajectories');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'mf.normH');
model.result('pg2').feature('surf1').set('descr', 'Magnetic field norm');
model.result('pg2').feature('surf1').set('colortable', 'GrayBody');
model.result('pg2').run;
model.result('pg2').create('ptr1', 'ParticleMass');
model.result('pg2').feature('ptr1').set('fx', '-q*vz*mf.By*(1-2*(partt>L1/vz)+2*(partt>(L1+L2)/vz)-(partt>(L1+L2+L3)/vz))');
model.result('pg2').feature('ptr1').set('fy', 'q*vz*mf.Bx*(1-2*(partt>L1/vz)+2*(partt>(L1+L2)/vz)-(partt>(L1+L2+L3)/vz))');
model.result('pg2').feature('ptr1').set('mass', 'm');
model.result('pg2').feature('ptr1').set('xcoord', '0.03*cos(range(0,0.05*pi,2*pi))');
model.result('pg2').feature('ptr1').set('ycoord', '0.03*sin(range(0,0.05*pi,2*pi))');
model.result('pg2').feature('ptr1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('ptr1').feature('col1').set('expr', '1+(partt>L1/vz)+(partt>(L1+L2)/vz)+(partt>(L1+L2+L3)/vz)');
model.result('pg2').feature('ptr1').feature('col1').set('colortable', 'Cyclic');
model.result('pg2').run;
model.result('pg2').feature('ptr1').set('rtol', '1e-6');
model.result('pg2').feature('ptr1').set('maxstepsactive', true);
model.result('pg2').feature('ptr1').set('maxsteps', '1e5');
model.result('pg2').feature('ptr1').set('statictendactive', true);
model.result('pg2').feature('ptr1').set('statictend', '5/3e6');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'sqrt(x^2+y^2)');
model.result('pg2').feature('con1').set('levelmethod', 'levels');
model.result('pg2').feature('con1').set('levels', '0.01 0.03');
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('color', 'custom');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').run;

model.view('view1').axis.set('xmin', -0.12);
model.view('view1').axis.set('xmax', 0.12);
model.view('view1').axis.set('ymin', -0.12);
model.view('view1').axis.set('ymax', 0.12);

model.result('pg2').run;

model.title('Quadrupole Lens');

model.description('Just like optical lenses focus light, electric and magnetic lenses can be used for focusing beams of charged particles. This COMSOL Multiphysics model shows the path of B5+ ions passing through a focusing system of three magnetic quadrupoles.');

model.label('quadrupole.mph');

model.modelNode.label('Components');

out = model;
