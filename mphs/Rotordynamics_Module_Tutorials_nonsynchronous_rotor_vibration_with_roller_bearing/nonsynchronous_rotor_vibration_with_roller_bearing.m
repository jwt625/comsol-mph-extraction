function out = model
%
% nonsynchronous_rotor_vibration_with_roller_bearing.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Rotordynamics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rotbm', 'BeamRotor', 'geom1');
model.physics('rotbm').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/rotbm', true);

model.param.label('Parameters: Rotor');
model.param.set('Ow', '3000[rpm]');
model.param.descr('Ow', 'Angular speed of the rotor');
model.param.set('d', '0.04[m]');
model.param.descr('d', 'Rotor diameter');
model.param.set('rho_disk', '7850[kg/m^3]');
model.param.descr('rho_disk', 'Density of the disk');
model.param.set('R_disk', '0.08[m]');
model.param.descr('R_disk', 'Radius of the disk');
model.param.set('h_disk', '0.03[m]');
model.param.descr('h_disk', 'Thickness of the disk');
model.param.create('par2');
model.param('par2').label('Parameters: Bearing');
model.param('par2').set('C', '1e-4[m]');
model.param('par2').descr('C', 'Radial clearance in bearing');
model.param('par2').set('f', '0.7');
model.param('par2').descr('f', 'Fill ratio');
model.param('par2').set('N', '10');
model.param('par2').descr('N', 'Number of rollers');
model.param('par2').set('db', 'd/(N/(f*pi)-1)');
model.param('par2').descr('db', 'Ball diameter');
model.param('par2').set('dp', 'd+db');
model.param('par2').descr('dp', 'Pitch diameter');
model.param('par2').set('rin', '0.53*db');
model.param('par2').descr('rin', 'Inner race radius');
model.param('par2').set('rout', '0.53*db');
model.param('par2').descr('rout', 'Outer race radius');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '0 0.5 1');
model.geom('geom1').feature('pol1').set('y', 0);
model.geom('geom1').feature('pol1').set('z', 0);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat1').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat1').propertyGroup.create('Swift', 'Swift');
model.material('mat1').propertyGroup.create('Voce', 'Voce');
model.material('mat1').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat1').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Norton', 'Norton');
model.material('mat1').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat1').label('Structural steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat1').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat1').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat1').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat1').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat1').propertyGroup('Ludwik').addInput('temperature');
model.material('mat1').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat1').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat1').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat1').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat1').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat1').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat1').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat1').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat1').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat1').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat1').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat1').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat1').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat1').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');

model.physics('rotbm').prop('RotorProperties').set('rpt', 'Ow');
model.physics('rotbm').feature('rcs1').set('do_circ', 'd');
model.physics('rotbm').create('disk1', 'Disk', 0);
model.physics('rotbm').feature('disk1').selection.set([2]);
model.physics('rotbm').feature('disk1').set('COM', 'Relative');
model.physics('rotbm').feature('disk1').set('zr', '1e-4[m]');
model.physics('rotbm').feature('disk1').set('SpecifiedBy', 'GeomDim');
model.physics('rotbm').feature('disk1').set('rho', 'rho_disk');
model.physics('rotbm').feature('disk1').set('d', '2*R_disk');
model.physics('rotbm').feature('disk1').set('h', 'h_disk');
model.physics('rotbm').create('rrb1', 'RadialRollerBearing', 0);
model.physics('rotbm').feature('rrb1').selection.set([1]);
model.physics('rotbm').feature('rrb1').set('Nb', 'N');
model.physics('rotbm').feature('rrb1').set('d_ball', 'db');
model.physics('rotbm').feature('rrb1').set('d_pitch', 'dp');
model.physics('rotbm').feature('rrb1').set('r_in', 'rin');
model.physics('rotbm').feature('rrb1').set('r_out', 'rout');
model.physics('rotbm').feature('rrb1').set('c_radial', 'C');
model.physics('rotbm').feature.duplicate('rrb2', 'rrb1');
model.physics('rotbm').feature('rrb2').selection.set([3]);
model.physics('rotbm').create('gr1', 'Gravity', 1);

model.study('std1').create('batsw', 'BatchSweep');
model.study('std1').feature('batsw').setIndex('pname', 'C', 0);
model.study('std1').feature('batsw').setIndex('plistarr', '', 0);
model.study('std1').feature('batsw').setIndex('punit', 'm', 0);
model.study('std1').feature('batsw').setIndex('pname', 'C', 0);
model.study('std1').feature('batsw').setIndex('plistarr', '', 0);
model.study('std1').feature('batsw').setIndex('punit', 'm', 0);
model.study('std1').feature('batsw').setIndex('plistarr', '2e-5 5e-5 2e-4', 0);
model.study('std1').feature('batsw').setIndex('punit', 'm', 0);
model.study('std1').feature('batsw').set('clearsol', false);
model.study('std1').feature('batsw').set('clearmesh', false);
model.study('std1').feature('batsw').set('maxallow', 3);
model.study('std1').feature('time').set('tlist', 'range(0,2e-4,0.2)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_rotbm_phi').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_rotbm_phi').set('scaleval', '1e-2');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.0');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,2e-4,0.2)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.1);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'intermediate');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('rhoinf', 0.75);
model.sol('sol1').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ratelimitactive', false);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 4);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ratelimitactive', false);
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('t1').feature('fc1').set('ntermconst', 'tol');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('b1', 'Batch');
model.batch('b1').study('std1');
model.batch('b1').create('so1', 'Solutionseq');
model.batch('b1').feature('so1').set('seq', 'sol1');
model.batch('b1').feature('so1').set('store', 'on');
model.batch('b1').feature('so1').set('clear', 'on');
model.batch('b1').feature('so1').set('psol', 'none');
model.batch('b1').set('batchfile', 'batchmodel.mph');
model.batch('b1').set('batchfileactive', 'off');
model.batch('b1').set('batchdir', '/lscratch/home/testusr/large_model_workdir/prefsdir/batch_rotor.SuiteModelsRotor_TRotorTutorialModels.nonsynchronous_rotor_vibration_with_roller_bearing_6.2.0.255');
model.batch('b1').set('paramfilename', 'on');
model.batch('b1').set('synchsolutions', 'on');
model.batch('b1').set('clearsynchdata', 'on');
model.batch('b1').set('savemodelaftersynch', 'off');
model.batch('b1').attach('std1');
model.batch('b1').set('control', 'batsw');
model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');

model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').label('Accumulated Probe Table 1');

model.study('std1').feature('batsw').set('accumtable', 'tbl1');

model.batch('p1').create('jo1', 'Jobseq');
model.batch('p1').feature('jo1').set('seq', 'b1');
model.batch('p1').set('pname', {'C'});
model.batch('p1').set('plistarr', {'2e-5 5e-5 2e-4'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'batsw');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('b1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');
model.batch('b1').feature('daDef').run;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1001, 0);
model.result('pg1').setIndex('looplevel', 3, 1);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'rotbm.mises'});
model.result('pg1').feature('line1').set('threshold', 'manual');
model.result('pg1').feature('line1').set('thresholdvalue', 0.2);
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('colortabletrans', 'none');
model.result('pg1').feature('line1').set('colorscalemode', 'linear');
model.result('pg1').label('Stress (rotbm)');
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'rotbm.re');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', 1);
model.result('pg1').feature('line1').set('tubeendcaps', false);
model.result('pg1').feature('line1').create('def', 'Deform');
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg1').create('line2', 'Line');
model.result('pg1').feature('line2').set('expr', {'1'});
model.result('pg1').feature('line2').set('linetype', 'tube');
model.result('pg1').feature('line2').set('radiusexpr', {'rotbm.re '});
model.result('pg1').feature('line2').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line2').set('tuberadiusscale', 1);
model.result('pg1').feature('line2').set('tubeendcaps', false);
model.result('pg1').feature('line2').set('coloring', 'uniform');
model.result('pg1').feature('line2').set('color', 'custom');
model.result('pg1').feature('line2').set('customcolor', [0.9803921580314636 0.7843137383460999 0.7058823704719543]);
model.result('pg1').feature('line2').set('threshold', 'manual');
model.result('pg1').feature('line2').set('thresholdvalue', 0.2);
model.result('pg1').feature('line2').set('titletype', 'none');
model.result('pg1').feature('line2').label('Rotor');
model.result('pg1').feature('line2').create('def', 'Deform');
model.result('pg1').feature('line2').feature('def').set('scaleactive', true);
model.result('pg1').feature('line2').feature('def').set('scale', '1');
model.result('pg1').feature('line2').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg1').create('pttraj1', 'PointTrajectories');
model.result('pg1').feature('pttraj1').set('plotdata', 'points');
model.result('pg1').feature('pttraj1').selection.geom('geom1', 0);
model.result('pg1').feature('pttraj1').selection.set([2]);
model.result('pg1').feature('pttraj1').selection.inherit(false);
model.result('pg1').feature('pttraj1').set('linetype', 'none');
model.result('pg1').feature('pttraj1').set('expr', {'X' 'Y' 'Z'});
model.result('pg1').feature('pttraj1').set('pointtype', 'ellipse');
model.result('pg1').feature('pttraj1').set('pointcolor', 'custom');
model.result('pg1').feature('pttraj1').set('custompointcolor', [0.8039215803146362 0.5215686559677124 0.24705882370471954]);
model.result('pg1').feature('pttraj1').set('semimajorexpr', {'0.5*rotbm.disk1.de*rotbm.e20x ' '0.5*rotbm.disk1.de*rotbm.e20y ' '0.5*rotbm.disk1.de*rotbm.e20z '});
model.result('pg1').feature('pttraj1').set('semiminorexpr', {'0.5*rotbm.disk1.de*rotbm.e30x ' '0.5*rotbm.disk1.de*rotbm.e30y ' '0.5*rotbm.disk1.de*rotbm.e30z '});
model.result('pg1').feature('pttraj1').set('ellipsecount', 1);
model.result('pg1').feature('pttraj1').set('ellipsearrowscaleactive', true);
model.result('pg1').feature('pttraj1').set('ellipsearrowtype', 'none');
model.result('pg1').feature('pttraj1').set('titletype', 'none');
model.result('pg1').feature('pttraj1').label('Disk 1');
model.result('pg1').feature('pttraj1').create('def', 'Deform');
model.result('pg1').feature('pttraj1').feature('def').set('scaleactive', true);
model.result('pg1').feature('pttraj1').feature('def').set('scale', '1');
model.result('pg1').feature('pttraj1').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg1').create('pttraj2', 'PointTrajectories');
model.result('pg1').feature('pttraj2').set('plotdata', 'points');
model.result('pg1').feature('pttraj2').selection.geom('geom1', 0);
model.result('pg1').feature('pttraj2').selection.set([1]);
model.result('pg1').feature('pttraj2').selection.inherit(false);
model.result('pg1').feature('pttraj2').set('linetype', 'none');
model.result('pg1').feature('pttraj2').set('pointtype', 'arrow');
model.result('pg1').feature('pttraj2').set('expr', {'X-1.0*rotbm.re*rotbm.rrb1.e3gx ' 'Y-1.0*rotbm.re*rotbm.rrb1.e3gy ' 'Z-1.0*rotbm.re*rotbm.rrb1.e3gz '});
model.result('pg1').feature('pttraj2').set('arrowexpr', {'rotbm.re*rotbm.rrb1.e3gx ' 'rotbm.re*rotbm.rrb1.e3gy ' 'rotbm.re*rotbm.rrb1.e3gz '});
model.result('pg1').feature('pttraj2').set('arrowtype', 'arrowhead');
model.result('pg1').feature('pttraj2').set('arrowbase', 'head');
model.result('pg1').feature('pttraj2').set('arrowscale', '10');
model.result('pg1').feature('pttraj2').set('arrowscaleactive', true);
model.result('pg1').feature('pttraj2').set('pointcolor', 'custom');
model.result('pg1').feature('pttraj2').set('custompointcolor', [0.5882353186607361 0.8627451062202454 0.5882353186607361]);
model.result('pg1').feature('pttraj2').set('titletype', 'none');
model.result('pg1').feature('pttraj2').label('Radial Roller Bearing 1');
model.result('pg1').feature('pttraj2').create('def', 'Deform');
model.result('pg1').feature('pttraj2').feature('def').set('scaleactive', true);
model.result('pg1').feature('pttraj2').feature('def').set('scale', '1');
model.result('pg1').feature('pttraj2').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg1').create('pttraj3', 'PointTrajectories');
model.result('pg1').feature('pttraj3').set('plotdata', 'points');
model.result('pg1').feature('pttraj3').selection.geom('geom1', 0);
model.result('pg1').feature('pttraj3').selection.set([3]);
model.result('pg1').feature('pttraj3').selection.inherit(false);
model.result('pg1').feature('pttraj3').set('linetype', 'none');
model.result('pg1').feature('pttraj3').set('pointtype', 'arrow');
model.result('pg1').feature('pttraj3').set('expr', {'X-1.0*rotbm.re*rotbm.rrb2.e3gx ' 'Y-1.0*rotbm.re*rotbm.rrb2.e3gy ' 'Z-1.0*rotbm.re*rotbm.rrb2.e3gz '});
model.result('pg1').feature('pttraj3').set('arrowexpr', {'rotbm.re*rotbm.rrb2.e3gx ' 'rotbm.re*rotbm.rrb2.e3gy ' 'rotbm.re*rotbm.rrb2.e3gz '});
model.result('pg1').feature('pttraj3').set('arrowtype', 'arrowhead');
model.result('pg1').feature('pttraj3').set('arrowbase', 'head');
model.result('pg1').feature('pttraj3').set('arrowscale', '10');
model.result('pg1').feature('pttraj3').set('arrowscaleactive', true);
model.result('pg1').feature('pttraj3').set('pointcolor', 'custom');
model.result('pg1').feature('pttraj3').set('custompointcolor', [0.5882353186607361 0.8627451062202454 0.5882353186607361]);
model.result('pg1').feature('pttraj3').set('titletype', 'none');
model.result('pg1').feature('pttraj3').label('Radial Roller Bearing 2');
model.result('pg1').feature('pttraj3').create('def', 'Deform');
model.result('pg1').feature('pttraj3').feature('def').set('scaleactive', true);
model.result('pg1').feature('pttraj3').feature('def').set('scale', '1');
model.result('pg1').feature('pttraj3').feature('def').set('expr', {'-rotbm.De_max*rotbm.e30x ' '-rotbm.De_max*rotbm.e30y ' '-rotbm.De_max*rotbm.e30z '});
model.result('pg1').run;
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Orbit');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevelinput', 'manualindices', 1);
model.result('pg2').setIndex('looplevelindices', 1, 1);
model.result('pg2').set('preserveaspect', true);
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Orbit at disk and bearing');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([1 2]);
model.result('pg2').feature('ptgr1').set('expr', 'w/C');
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', 'v/C');
model.result('pg2').feature('ptgr1').set('linewidth', 2);
model.result('pg2').feature('ptgr1').set('linestyle', 'cycle');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'Bearing', 0);
model.result('pg2').feature('ptgr1').setIndex('legends', 'Disk', 1);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevelindices', 2, 1);
model.result('pg2').run;
model.result('pg2').setIndex('looplevelindices', 3, 1);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Frequency spectrum w');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([1]);
model.result('pg3').feature('ptgr1').set('expr', 'w');
model.result('pg3').feature('ptgr1').set('xdata', 'fourier');
model.result('pg3').feature('ptgr1').set('fouriershow', 'spectrum');
model.result('pg3').feature('ptgr1').set('nfreqsactive', true);
model.result('pg3').feature('ptgr1').set('nfreqs', 400);
model.result('pg3').feature('ptgr1').set('linestyle', 'cycle');
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('autopoint', false);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').set('axislimits', true);
model.result('pg3').set('xmax', 600);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').set('data', 'dset2');
model.result('pg4').label('Bearing Force');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'rotbm.rrb1.Fsz'});
model.result('pg4').feature('glob1').set('descr', {'Force on shaft (rrb1), z-component'});
model.result('pg4').feature('glob1').set('unit', {'N'});
model.result('pg4').feature('glob1').set('autodescr', false);
model.result('pg4').run;
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Bearing Moment');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'rotbm.rrb1.Msy'});
model.result('pg5').feature('glob1').set('descr', {'Moment on shaft (rrb1), y-component'});
model.result('pg5').feature('glob1').set('unit', {'N*m'});
model.result('pg5').feature('glob1').set('autodescr', false);
model.result('pg5').run;
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg5').run;

model.batch('b1').feature('daDef').set('operation', 'clearalldata');
model.batch('b1').feature('daDef').run;

model.result('pg2').run;

model.title('Effect of Roller Bearing Clearance on Nonsynchronous Vibration of a Rotor');

model.description('Bearing clearances should be kept to a minimum to avoid nonsynchronous vibration of a rotor. However, a tight clearance reduces the durability of the bearing. This example illustrates modeling of the vibration induced by nonlinear contact for different radial clearances.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('nonsynchronous_rotor_vibration_with_roller_bearing.mph');

model.modelNode.label('Components');

out = model;
