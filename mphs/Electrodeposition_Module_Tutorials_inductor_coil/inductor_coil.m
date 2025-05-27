function out = model
%
% inductor_coil.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryCurrentDistributionNernstPlanck', 'geom1', {'c'});
model.physics('tcd').prop('SpeciesProperties').set('ChargeTransportModel', 'SupportingElectrolyte');

model.multiphysics.create('ndbdg1', 'NonDeformingBoundaryDeformedGeometry', 'geom1', 2);
model.multiphysics('ndbdg1').set('Echem_physics', 'tcd');
model.multiphysics('ndbdg1').selection.all;
model.multiphysics.create('desdg1', 'DeformingElectrodeSurfaceDeformedGeometry', 'geom1', 2);
model.multiphysics('desdg1').set('Echem_physics', 'tcd');
model.multiphysics('desdg1').selection.all;

model.common.create('free1', 'DeformingDomainDeformedGeometry', 'comp1');
model.common('free1').set('smoothingType', 'hyperelastic');
model.common('free1').selection.all;

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/tcd', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/desdg1', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/tcd', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/desdg1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('r0', '20e-6[m]', 'Spiral starting radius');
model.param.set('a1', '10e-6[m]', 'Coil width');
model.param.set('a_tot', 'a1*2', 'Spiral lap width');
model.param.set('laps', '3', 'Number of revolved laps in spiral');
model.param.set('w_tot', '2*pi*laps', 'Total revolved angle');
model.param.set('c_ref', '500[mol/m^3]', 'Reference concentration in electrolyte');
model.param.set('D_Cu', '4.5e-10', 'Diffusion coefficient');
model.param.set('d_dl', '50e-6[m]', 'Diffusion layer thickness');
model.param.set('Eeq_Cu', '0.34[V]', 'Equilibrium potential Cu/Cu');
model.param.set('d_pr', '10e-6[m]', 'Photoresist layer thickness');
model.param.set('i_avg', '-10[A/dm^2]', 'Average cathode current density');
model.param.set('i0', '100[A/m^2]', 'Exchange current density');
model.param.set('alpha_a', '1.5', 'Anode transfer coefficient');

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'spiralX');
model.func('an1').set('expr', '-(s/(2*pi)*a_tot+R)*sin(s)');
model.func('an1').set('args', 's, R');
model.func('an1').setIndex('argunit', 1, 0);
model.func('an1').setIndex('argunit', 'm', 1);
model.func('an1').set('fununit', 'm');
model.func.create('an2', 'Analytic');
model.func('an2').set('funcname', 'spiralY');
model.func('an2').set('expr', '-(s/(2*pi)*a_tot+R)*cos(s)');
model.func('an2').set('args', 's, R');
model.func('an2').setIndex('argunit', 1, 0);
model.func('an2').setIndex('argunit', 'm', 1);
model.func('an2').set('fununit', 'm');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('pc1', 'ParametricCurve');
model.geom('geom1').feature('wp1').geom.feature('pc1').set('parmax', 'w_tot');
model.geom('geom1').feature('wp1').geom.feature('pc1').set('coord', {'spiralX(s,r0)' ''});
model.geom('geom1').feature('wp1').geom.feature('pc1').setIndex('coord', 'spiralY(s,r0)', 1);
model.geom('geom1').feature('wp1').geom.run('pc1');
model.geom('geom1').feature('wp1').geom.create('pc2', 'ParametricCurve');
model.geom('geom1').feature('wp1').geom.feature('pc2').set('parmax', 'w_tot');
model.geom('geom1').feature('wp1').geom.feature('pc2').set('coord', {'spiralX(s,r0+a1)' ''});
model.geom('geom1').feature('wp1').geom.feature('pc2').setIndex('coord', 'spiralY(s,r0+a1)', 1);
model.geom('geom1').feature('wp1').geom.run('pc2');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'a1' '2*a1'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'0' '-r0-a1'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', '2*a1');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('pos', {'-a1/2' '-a1'});
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('pointinsketch').set('r1', 2);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'a1');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'a1' '2*a1'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'-a1' '-r0-2*a1-laps*a_tot'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('sq2', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('size', '2*a1');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('pos', {'-1.5*a1' '-r0-4*a1-laps*a_tot'});
model.geom('geom1').feature('wp1').geom.run('sq2');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'fil1' 'pc1' 'pc2' 'r2' 'sq1' 'sq2'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 'd_pr', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'2*(r0+a_tot*laps+d_dl)' '1' '1'});
model.geom('geom1').feature('blk1').setIndex('size', '2*(r0+a_tot*laps+d_dl)+3*a1', 1);
model.geom('geom1').feature('blk1').setIndex('size', 'd_dl', 2);
model.geom('geom1').feature('blk1').set('pos', {'0' '-2*a1' 'd_pr+d_dl/2'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');

model.view('view1').set('transparency', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').set([1]);
model.selection('sel1').label('Fixed domain');
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').set('input', {'sel1'});
model.selection('com1').label('Deforming domain');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').all;
model.selection('sel2').geom('geom1', 3, 2, {'exterior'});
model.selection('sel2').all;
model.selection('sel2').label('Exterior boundaries');
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(2);
model.selection('sel3').set([4]);
model.selection('sel3').label('Bulk electrolyte boundary');
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').geom(2);
model.selection('sel4').set([8 13 18 25 30]);
model.selection('sel4').label('Cathode');
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').set('input', {'sel1'});
model.selection('adj1').label('Fixed boundaries');
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').set('entitydim', 2);
model.selection('dif1').set('add', {'sel2'});
model.selection('dif1').set('subtract', {'sel4' 'adj1'});
model.selection('dif1').label('Photoresist vertical walls');

model.physics('tcd').prop('SpeciesProperties').set('ChargeTransportModel', 'Electroanalysis');
model.physics('tcd').feature('ice1').set('D_c', {'D_Cu' '0' '0' '0' 'D_Cu' '0' '0' '0' 'D_Cu'});
model.physics('tcd').feature('init1').setIndex('initc', 'c_ref', 0);
model.physics('tcd').create('es1', 'ElectrodeSurface', 2);
model.physics('tcd').feature('es1').selection.named('sel4');
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').set('BoundaryCondition', 'AverageCurrentDensity');
model.physics('tcd').feature('es1').set('Ial', 'i_avg');
model.physics('tcd').feature('es1').feature('er1').set('nm', 2);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vib', 1, 0, 0);
model.physics('tcd').feature('es1').feature('er1').set('Eeq_ref', 'Eeq_Cu');
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0');
model.physics('tcd').feature('es1').feature('er1').set('alphaa', 'alpha_a');
model.physics('tcd').create('conc1', 'Concentration', 2);
model.physics('tcd').feature('conc1').selection.named('sel3');
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'c_ref', 0);
model.physics('tcd').prop('ShapeProperty').set('order_concentration', 1);
model.physics('tcd').prop('ShapeProperty').set('order_electricpotential', 1);

model.common.create('pres1', 'PrescribedDeformationDeformedGeometry', 'comp1');
model.common('pres1').selection.all;
model.common('pres1').selection.named('sel1');

model.multiphysics('ndbdg1').set('BoundaryCondition', 'ZeroNormalDisplacement');
model.multiphysics.create('ndbdg2', 'NonDeformingBoundaryDeformedGeometry', 'geom1', 2);
model.multiphysics('ndbdg2').selection.named('dif1');
model.multiphysics('ndbdg2').set('BoundaryCondition', 'ZeroNormalDisplacement');
model.multiphysics('ndbdg2').set('LineDeformation', true);
model.multiphysics('ndbdg2').set('l', [0 0 1]);

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature.clear;
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([25]);
model.mesh('mesh1').feature('map1').set('adjustedgdistr', true);
model.mesh('mesh1').feature('map1').create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', 'a1/2');
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([8 13 18 30]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'a1/2');
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.named('com1');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run('ftet1');

model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tlist', 'range(0,30,180)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 3 4 5 6]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 3 4 5 6]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_tcd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '4.419812220819354E-6');
model.sol('sol1').feature('v1').feature('comp1_tcd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_tcd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scaleval', '4.419812220819354E-6');
model.sol('sol1').feature('v2').feature('comp1_tcd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_material_lm_nv').set('out', 'off');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,30,180)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('mumpsalloc', 1.4);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('damp', 1);
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;

model.view('view1').set('transparency', false);

model.result('pg1').set('edges', false);
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('expr', 'c');
model.result('pg1').feature('slc1').set('descr', 'Concentration');
model.result('pg1').feature('slc1').set('quickxnumber', 1);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'c');
model.result('pg1').feature('surf1').set('inheritplot', 'slc1');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('sel4');
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'tcd.tflux_cx' 'tcd.tflux_cy' 'tcd.tflux_cz'});
model.result('pg1').feature('str1').set('descr', 'Total flux (spatial and material frames)');
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('startmethod', 'coord');
model.result('pg1').feature('str1').set('xcoord', 0);
model.result('pg1').feature('str1').set('ycoord', 'range(-150e-6,20e-6,150e-6)');
model.result('pg1').feature('str1').set('zcoord', 'd_dl+d_pr');
model.result('pg1').feature('str1').set('linetype', 'tube');
model.result('pg1').feature('str1').set('color', 'black');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').selection.geom('geom1', 2);
model.result('pg2').selection.named('sel4');
model.result('pg2').set('frametype', 'geometry');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'tcd.iloc_er1');
model.result('pg2').feature('surf1').set('descr', 'Local current density');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'tcd.sbtot');
model.result('pg3').feature('surf1').set('descr', 'Total electrode thickness change');
model.result('pg3').feature('surf1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg3').feature.duplicate('surf2', 'surf1');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('data', 'dset1');
model.result('pg3').feature('surf2').setIndex('looplevel', 1, 0);
model.result('pg3').feature('surf2').set('expr', '1');
model.result('pg3').feature('surf2').set('coloring', 'uniform');
model.result('pg3').feature('surf2').set('color', 'black');
model.result('pg3').feature('surf2').create('sel1', 'Selection');
model.result('pg3').feature('surf2').feature('sel1').selection.named('sel4');
model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').label('Cu Concentration in Electrolyte');
model.result('pg2').run;
model.result('pg2').label('Electrode Reaction Current Density');
model.result('pg3').run;
model.result('pg3').label('Deposited Thickness');

model.title('Electrodeposition of an Inductor Coil');

model.description(['This example models the deposition of an inductor coil in 3D.' newline  newline 'The geometry includes the extrusion of the deposition pattern into an isolating photoresist mask, and a diffusion layer on top of the photoresist. The mass transfer of copper ions in the electrolyte has a major impact on the deposition kinetics, resulting in higher deposition rates in the outer parts of the deposition pattern.' newline  newline 'The model is solved in a time-dependent study using a deformed geometry.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('inductor_coil.mph');

model.modelNode.label('Components');

out = model;
