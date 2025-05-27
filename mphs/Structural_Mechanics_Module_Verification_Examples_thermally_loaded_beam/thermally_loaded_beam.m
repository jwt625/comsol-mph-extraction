function out = model
%
% thermally_loaded_beam.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('beam', 'HermitianBeam', 'geom1');
model.physics('beam').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/beam', true);

model.param.set('a', '0.04[m]');
model.param.descr('a', 'Side length');
model.param.set('deltaT', '50[K]');
model.param.descr('deltaT', 'Temperature difference');
model.param.set('Tg', 'deltaT/a');
model.param.descr('Tg', 'Temperature gradient');
model.param.set('Lb', '3[m]');
model.param.descr('Lb', 'Beam length');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', 'Lb/2', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 2);
model.geom('geom1').feature('pol1').setIndex('table', 'Lb', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 2);
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'11e-6'});
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'210e9'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.3'});
model.material('mat1').propertyGroup('def').set('density', {'7800'});

model.physics('beam').feature('csd1').set('SectionType', 'RectangularSection');
model.physics('beam').feature('csd1').set('hy_rect', 'a');
model.physics('beam').feature('csd1').set('hz_rect', 'a');
model.physics('beam').feature('csd1').feature('so1').set('OrientationMethod', 'vector_beam');
model.physics('beam').feature('csd1').feature('so1').set('vector_beam', [0 1 0]);
model.physics('beam').create('pdr1', 'DispRot0', 0);
model.physics('beam').feature('pdr1').selection.set([1]);
model.physics('beam').feature('pdr1').setIndex('Direction', 'prescribed', 0);
model.physics('beam').feature('pdr1').setIndex('Direction', 'prescribed', 1);
model.physics('beam').feature('pdr1').setIndex('Direction', 'prescribed', 2);
model.physics('beam').feature('pdr1').set('RotationType', 'RotationGroup');
model.physics('beam').feature('pdr1').setIndex('FreeRotationAround', true, 1);
model.physics('beam').feature('pdr1').setIndex('FreeRotationAround', true, 2);
model.physics('beam').create('pdr2', 'DispRot0', 0);
model.physics('beam').feature('pdr2').selection.set([3]);
model.physics('beam').feature('pdr2').setIndex('Direction', 'prescribed', 1);
model.physics('beam').feature('pdr2').setIndex('Direction', 'prescribed', 2);
model.physics('beam').feature('emm1').create('te1', 'ThermalExpansion', 1);

model.common('cminpt').set('modified', {'strainreferencetemperature' '0'});

model.physics('beam').feature('emm1').feature('te1').set('minput_temperature_src', 'userdef');
model.physics('beam').feature('emm1').feature('te1').set('minput_temperature', 200);
model.physics('beam').feature('emm1').feature('te1').set('TGy', 'Tg');
model.physics('beam').feature('emm1').feature('te1').set('TGz', '-Tg');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'beam.mises'});
model.result('pg1').feature('line1').set('threshold', 'manual');
model.result('pg1').feature('line1').set('thresholdvalue', 0.2);
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('colortabletrans', 'none');
model.result('pg1').feature('line1').set('colorscalemode', 'linear');
model.result('pg1').label('Stress (beam)');
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'beam.re');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', 1);
model.result('pg1').feature('line1').set('tubeendcaps', false);
model.result('pg1').feature('line1').create('def', 'Deform');
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('line1').feature('def').set('descr', 'Displacement field');
model.result('pg1').run;
model.result('pg1').label('Displacements');
model.result('pg1').run;
model.result('pg1').feature('line1').set('expr', 'beam.disp');
model.result('pg1').feature('line1').set('descr', 'Displacement magnitude');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Transverse Displacement');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'z displacement (m)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').label('Transverse displacement (z direction)');
model.result('pg2').feature('lngr1').selection.set([1 2]);
model.result('pg2').feature('lngr1').set('expr', 'w');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').set('linewidth', 2);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Displacement');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'displacement (m)');
model.result('pg3').set('legendpos', 'center');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').label('Displacement magnitude');
model.result('pg3').feature('lngr1').selection.set([1 2]);
model.result('pg3').feature('lngr1').set('descractive', true);
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').set('linestyle', 'cycle');
model.result('pg3').feature('lngr1').set('linemarker', 'cycle');
model.result('pg3').feature('lngr1').set('markerpos', 'interp');
model.result('pg3').feature('lngr1').set('linewidth', 2);
model.result('pg3').feature('lngr1').set('autodescr', true);
model.result('pg3').feature('lngr1').set('autosolution', false);
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature.duplicate('lngr2', 'lngr1');
model.result('pg3').run;
model.result('pg3').feature('lngr2').label('Magnitude of transverse displacement');
model.result('pg3').feature('lngr2').set('expr', 'sqrt(v^2+w^2)');
model.result('pg3').feature('lngr2').set('descr', 'Magnitude of transverse displacement');
model.result('pg3').feature.duplicate('lngr3', 'lngr2');
model.result('pg3').run;
model.result('pg3').feature('lngr3').label('Axial displacement');
model.result('pg3').feature('lngr3').set('expr', 'u');
model.result('pg3').feature('lngr3').set('descr', 'Axial displacement');
model.result('pg3').run;
model.result('pg1').run;

model.title('Thermally Loaded Beam');

model.description('In this example, a 3D beam is exposed to thermal loads. The temperature varies linearly over the beam cross section. The solution is compared with an analytical solution.');

model.label('thermally_loaded_beam.mph');

model.modelNode.label('Components');

out = model;
