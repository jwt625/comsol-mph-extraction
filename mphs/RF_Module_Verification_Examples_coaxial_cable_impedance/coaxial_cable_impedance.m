function out = model
%
% coaxial_cable_impedance.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');
model.study('std1').create('mode', 'ModeAnalysis');
model.study('std1').feature('mode').set('shiftactive', false);
model.study('std1').feature('mode').set('conrad', '1');
model.study('std1').feature('mode').set('conradynhm', '1');
model.study('std1').feature('mode').set('linpsolnum', 'auto');
model.study('std1').feature('mode').set('outputmap', {});
model.study('std1').feature('mode').set('ngenAUX', '1');
model.study('std1').feature('mode').set('goalngenAUX', '1');
model.study('std1').feature('mode').set('ngenAUX', '1');
model.study('std1').feature('mode').set('goalngenAUX', '1');
model.study('std1').feature('mode').setSolveFor('/physics/emw', true);

model.param.set('r_i', '0.5[mm]');
model.param.descr('r_i', 'Coax inner radius');
model.param.set('r_o', '3.43[mm]');
model.param.descr('r_o', 'Coax outer radius');
model.param.set('eps_r', '2.4');
model.param.descr('eps_r', 'Relative dielectric constant');
model.param.set('Z0_analytic', '(Z0_const/(2*pi*sqrt(eps_r)))*log(r_o/r_i)');
model.param.descr('Z0_analytic', 'Characteristic impedance, analytic');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('type', 'curve');
model.geom('geom1').feature('c1').set('r', 'r_o');
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', 'r_o-r_i', 0);
model.geom('geom1').run('c1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Insulator');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'eps_r'});
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'int_rad');
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([1]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'int_circ');
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.set([5 6 9 12]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('V', 'int_rad(-emw.Ex*t1x-emw.Ey*t1y)');
model.variable('var1').descr('V', 'Voltage');
model.variable('var1').set('I', '-int_circ(emw.Hx*t1x+emw.Hy*t1y)');
model.variable('var1').descr('I', 'Current');
model.variable('var1').set('Z0_model', 'V/I');
model.variable('var1').descr('Z0_model', 'Characteristic impedance');

model.mesh('mesh1').contribute('physics/emw', false);
model.mesh('mesh1').run;

model.study('std1').feature('mode').set('neigsactive', true);
model.study('std1').feature('mode').set('neigs', 1);
model.study('std1').feature('mode').set('shiftactive', true);
model.study('std1').feature('mode').set('shift', 'sqrt(eps_r)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'mode');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'mode');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '1');
model.sol('sol1').feature('e1').set('control', 'mode');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (emw)');
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
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('xnumber', 21);
model.result('pg1').feature('arws1').set('ynumber', 21);
model.result('pg1').feature('arws1').set('scaleactive', true);
model.result('pg1').feature('arws1').set('scale', '7e-6');
model.result('pg1').feature('arws1').set('color', 'white');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('expr', {'tx' 'ty'});
model.result('pg1').feature('arwl1').set('descr', 'Tangent');
model.result('pg1').feature('arwl1').set('arrowcount', 50);
model.result('pg1').run;
model.result('pg1').feature('arwl1').active(false);
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'Z0_model'});
model.result.numerical('gev1').set('descr', {'Characteristic impedance'});
model.result.numerical('gev1').set('unit', {['ohm' ]});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Finding the Impedance of a Coaxial Cable');

model.description('The coaxial cable is one of the most ubiquitous transmission line structures. This example computes the electric and magnetic field distributions inside a coaxial cable. Using these fields, the characteristic impedance of the cable is computed and compared with the analytic result.');

model.label('coaxial_cable_impedance.mph');

model.modelNode.label('Components');

out = model;
