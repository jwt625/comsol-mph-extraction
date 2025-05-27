function out = model
%
% fluid_structure_interaction.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Fluid-Structure_Interaction');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('AdvancedSettingProperty').set('UsePseudoTime', '1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'Incompressible');
model.physics('spf').field('velocity').field('u_fluid');
model.physics('spf').field('velocity').component({'u_fluid' 'v_fluid' 'w_fluid'});
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').field('displacement').field('u_solid');
model.physics('solid').field('displacement').component({'u_solid' 'v_solid' 'w_solid'});
model.physics('solid').prop('ShapeProperty').set('order_displacement', '2');

model.multiphysics.create('fsi1', 'FluidStructureInteractionBC', 'geom1', 1);
model.multiphysics('fsi1').set('Fluid_physics', 'spf');
model.multiphysics('fsi1').set('Structure_physics', 'solid');
model.multiphysics('fsi1').selection.all;

model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').set('smoothingType', 'yeoh');
model.common('free1').selection.set([]);

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/spf', true);
model.study('std1').feature('time').setSolveFor('/physics/solid', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/fsi1', true);

model.param.set('U', '3.33[cm/s]');
model.param.descr('U', 'Inlet mean velocity at steady state');
model.param.set('H', '100[um]');
model.param.descr('H', 'Channel height');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('args', 't');
model.func('an1').set('expr', 't^2/sqrt((0.04[s^2]-t^2)^2+(0.1[s]*t)^2)');
model.func('an1').setIndex('argunit', 's', 0);

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'300' 'H'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [5 47.5]);
model.geom('geom1').feature('r2').set('pos', [100 0]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r2', [3 4]);
model.geom('geom1').feature('fil1').set('radius', 2.5);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('spf').selection.set([1]);
model.physics('solid').selection.set([2]);

model.common('free1').selection.set([1]);

model.physics('spf').create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('BoundaryCondition', 'FullyDevelopedFlow');
model.physics('spf').feature('inl1').set('Uavfdf', 'U*an1(t)');
model.physics('spf').create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([8]);
model.physics('solid').create('fix1', 'Fixed', 1);
model.physics('solid').feature('fix1').selection.set([5]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.set([1]);
model.material('mat1').propertyGroup('def').set('density', {'1e3'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'1e-3'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([2]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'2e5'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.33'});
model.material('mat2').propertyGroup('def').set('density', {'7850'});

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.geom('geom1');
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('size').set('table', 'cfd');
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,0.005,0.75) range(1,0.25,4)');
model.study('std1').feature('time').set('usertol', true);
model.study('std1').feature('time').set('rtol', '0.0001');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u_solid').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u_solid').set('scaleval', '1e-2*3.1622776601683794E-4');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*3.1622776601683794E-4');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.005,0.75) range(1,0.25,4)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-4);
model.sol('sol1').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol1').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_fsi1_vWall' 'global' 'comp1_p' 'scaled' 'comp1_spatial_disp' 'global' 'comp1_u_fluid' 'global' 'comp1_u_solid' 'global'  ...
'comp1_spf_inl1_Pinlfdf' 'global'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_fsi1_vWall' 'factor' 'comp1_p' 'factor' 'comp1_spatial_disp' 'factor' 'comp1_u_fluid' 'factor' 'comp1_u_solid' 'factor'  ...
'comp1_spf_inl1_Pinlfdf' 'factor'});
model.sol('sol1').feature('t1').set('atolfactor', {'comp1_fsi1_vWall' '0.1' 'comp1_p' '1' 'comp1_spatial_disp' '0.1' 'comp1_u_fluid' '0.1' 'comp1_u_solid' '0.1'  ...
'comp1_spf_inl1_Pinlfdf' '0.1'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('rhoinf', 0.5);
model.sol('sol1').feature('t1').set('predictor', 'constant');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_u_fluid' 'comp1_p' 'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Velocity U_fluid, Pressure p');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_u_solid'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'once');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Displacement Field');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subdamp', 0.8);
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subjtech', 'once');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subiter', 1);
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subtermconst', 'iter');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subntolfact', 0.1);
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, spatial mesh displacement (spf)');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'd2');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Spatial Mesh Displacement');
model.sol('sol1').feature('t1').feature('se1').create('ss4', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('segvar', {'comp1_fsi1_vWall'});
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subdamp', 0.7);
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d3', 'Direct');
model.sol('sol1').feature('t1').feature('d3').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d3').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d3').label('Direct 2');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').set('linsolver', 'd3');
model.sol('sol1').feature('t1').feature('se1').feature('ss4').label(['Fluid' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Structure Interaction 1']);
model.sol('sol1').feature('t1').feature('se1').set('ntolfact', 0.5);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 1);
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 20);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 100);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, fluid flow variables (spf)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.02);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_spf_inl1_Pinlfdf'});
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 164, 0);
model.result('pg1').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 164, 0);
model.result('pg2').set('defaultPlotID', 'ResultDefaults_SinglePhaseFlow/icom1/pdef1/pcond1/pg2');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').label('Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 164, 0);
model.result('pg3').set('defaultPlotID', 'stress');
model.result('pg3').label('Stress (solid)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg3').feature('surf1').set('threshold', 'manual');
model.result('pg3').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg3').feature('surf1').set('colortable', 'Rainbow');
model.result('pg3').feature('surf1').set('colortabletrans', 'none');
model.result('pg3').feature('surf1').set('colorscalemode', 'linear');
model.result('pg3').feature('surf1').set('resolution', 'normal');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 164, 0);
model.result('pg4').label('Moving Mesh');
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('meshdomain', 'surface');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg4').feature('mesh1').feature('sel1').selection.set([1 2]);
model.result('pg4').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg4').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg4').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('startmethod', 'coord');
model.result('pg1').feature('str1').set('xcoord', '0^(range(1,15)) 125*1^(range(1,2))');
model.result('pg1').feature('str1').set('ycoord', 'range(0,100/14,100) 20 5');
model.result('pg1').feature('str1').set('color', 'red');
model.result('pg1').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('looplevelinput', 'interp');
model.result.export('anim1').set('interp', 'range(0.025,0.025,0.5)');
model.result.export('anim1').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Deformed Mesh and Geometry');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', '1');
model.result('pg5').feature('surf1').set('coloring', 'uniform');
model.result('pg5').feature('surf1').set('color', 'blue');
model.result('pg5').feature('surf1').set('wireframe', true);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').create('surf2', 'Surface');
model.result('pg5').feature('surf2').set('expr', '1');
model.result('pg5').feature('surf2').set('coloring', 'uniform');
model.result('pg5').feature('surf2').create('sel1', 'Selection');
model.result('pg5').feature('surf2').feature('sel1').selection.set([2]);
model.result('pg5').run;

model.view('view1').axis.set('xmin', 50);
model.view('view1').axis.set('xmax', 150);
model.view('view1').axis.set('ymin', 0);
model.view('view1').axis.set('ymax', 80);

model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 156, 0);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').set('expr', {'xt' 'yt'});
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 31, 0);
model.result('pg5').create('arws2', 'ArrowSurface');
model.result('pg5').run;
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Mesh Velocity');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', 'U*an1(t)', 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Inlet mean velocity', 0);
model.result('pg6').run;
model.result.dataset.create('cpt1', 'CutPoint2D');
model.result.dataset('cpt1').set('pointx', 105);
model.result.dataset('cpt1').set('pointy', 50);
model.result('pg6').run;
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('ptgr1').set('linewidth', 'preference');
model.result('pg6').feature('ptgr1').set('data', 'cpt1');
model.result('pg6').feature('ptgr1').set('expr', 'xt');
model.result('pg6').feature('ptgr1').set('unit', 'mm/s');
model.result('pg6').feature('ptgr1').set('legend', true);
model.result('pg6').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg6').feature('ptgr1').setIndex('legends', 'Mesh velocity in the x direction (mm/s)', 0);
model.result('pg6').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg6').run;
model.result('pg6').feature('ptgr2').set('expr', 'x-X');
model.result('pg6').feature('ptgr2').set('unit', 'mm');
model.result('pg6').feature('ptgr2').setIndex('legends', 'Mesh displacement in the x direction (mm)', 0);
model.result('pg6').run;
model.result('pg1').run;

model.title(['Fluid' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Structure Interaction']);

model.description(['This model exemplifies how to model fluid' native2unicode(hex2dec({'20' '13'}), 'unicode') 'structure interactions (FSI) using the MEMS Module. Viscous forces and the system''s pressure impose forces to the surface of a structure. The deformation in the soft structure is not small and the fluid regime will therefore change. This means that changes in the structure and the fluid dynamics are coupled.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('fluid_structure_interaction.mph');

model.modelNode.label('Components');

out = model;
