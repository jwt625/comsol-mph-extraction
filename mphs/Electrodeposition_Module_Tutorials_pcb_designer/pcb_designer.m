function out = model
%
% pcb_designer.m
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

model.physics.create('cd', 'SecondaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rhoCu', '8900[kg/m^3]', 'Copper density');
model.param.set('MCu', '68[g/mol]', 'Copper molar mass');
model.param.set('Iavg', '2[A/dm^2]', 'Average applied current density on cathode');
model.param.set('i0', '10[A/m^2]', 'Exchange current density');
model.param.set('alphaa', '1.5', 'Anodic transfer coefficient');
model.param.set('CopperArea', '0.4262900321[in^2]', 'Area of copper traces from imported PCB layout');
model.param.set('DummyArea', '1.1869299746[in^2]', 'Area of dummy pattern');
model.param.set('CathodeArea', 'CopperArea+DummyArea', 'Cathode area');
model.param.set('Itot', 'Iavg*CathodeArea', 'Total applied current');
model.param.set('PlatingThkavg', '10[um]', 'Target plating average thickness');
model.param.set('PlatingRateavg', 'Iavg/2/F_const*MCu/rhoCu', 'Average plating rate');
model.param.set('PlatingTime', 'PlatingThkavg/PlatingRateavg', 'Total plating time');

model.geom('geom1').insertFile('pcb_designer_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('transparency', true);

model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Electrolyte swept mesh region 2');
model.geom('geom1').feature('boxsel1').set('zmin', 0);
model.geom('geom1').feature('boxsel1').set('zmax', 0);
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Electrolyte swept mesh regions');
model.geom('geom1').feature('unisel2').set('input', {'blk3' 'boxsel1'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('PCB top dielectric');
model.geom('geom1').feature('adjsel1').set('input', {'unisel1'});
model.geom('geom1').feature('adjsel1').set('entitydim', 2);
model.geom('geom1').feature('adjsel1').set('input', {'unisel1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('PCB top');
model.geom('geom1').feature('unisel3').set('entitydim', 2);
model.geom('geom1').feature('unisel3').set('input', {'unisel1' 'adjsel1'});
model.geom('geom1').run('unisel3');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('PCB without cathode');
model.geom('geom1').feature('difsel1').set('add', {'blk1'});
model.geom('geom1').feature('difsel1').set('subtract', {'unisel1'});
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'blk1'});
model.geom('geom1').feature('difsel1').set('subtract', {'unisel1'});

model.cpl.create('intop1', 'Integration', 'geom1');

model.geom('geom1').run;

model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('geom1_unisel1_bnd');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('ItotCathode', 'Iavg*intop1(1)', 'Total current on cathode');
model.variable('var1').set('phil_initial', '-(BathDepth-z)*Itot/(50[S/m])/(BathWidth*BathHeight)', 'Initial value for electrolyte potential');
model.variable('var1').set('thickness_cathode', '-cd.iloc_er1/2/F_const*MCu/rhoCu*PlatingTime', 'Thickness on cathode');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Electrolyte');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte_conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'50'});

model.physics('cd').create('es1', 'ElectrodeSurface', 2);
model.physics('cd').feature('es1').selection.named('geom1_unisel1_bnd');
model.physics('cd').feature('es1').set('BoundaryCondition', 'TotalCurrent');
model.physics('cd').feature('es1').set('Itl', '-ItotCathode');
model.physics('cd').feature('es1').feature('er1').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('cd').feature('es1').feature('er1').set('i0', 'i0');
model.physics('cd').feature('es1').feature('er1').set('alphaa', 'alphaa');
model.physics('cd').create('es2', 'ElectrodeSurface', 2);
model.physics('cd').feature('es2').selection.named('geom1_ext1_bnd');
model.physics('cd').feature('es2').feature('er1').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('cd').feature('es2').feature('er1').set('i0', 'i0');
model.physics('cd').feature('es2').feature('er1').set('alphaa', 'alphaa');
model.physics('cd').feature('init1').set('phil', 'phil_initial');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('ftri1').selection.named('geom1_unisel3');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('geom1_unisel1_bnd');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.named('geom1_unisel2');
model.mesh('mesh1').feature('swe1').selection('sourceface').set([9]);
model.mesh('mesh1').feature('swe1').set('facemethod', 'tri');
model.mesh('mesh1').feature('swe1').create('size1', 'Size');
model.mesh('mesh1').feature('swe1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('swe1').feature('size1').selection.set([9]);
model.mesh('mesh1').feature('swe1').feature('size1').set('hauto', 3);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 'round((PCBThickness/1.5[mm]>=1)*PCBThickness/1.5[mm]+(PCBThickness/1.5[mm]<1),0)');
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.named('geom1_boxsel1');
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', '((PCBOffset-PCBThickness)/2[mm]>=1)*(PCBOffset-PCBThickness)/2[mm]+((PCBOffset-PCBThickness)/2[mm]<1)');
model.mesh('mesh1').create('swe2', 'Sweep');
model.mesh('mesh1').feature('swe2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe2').selection.named('geom1_ext3_dom');
model.mesh('mesh1').feature('swe2').selection('sourceface').named('geom1_wp5_bnd');
model.mesh('mesh1').feature('swe2').set('facemethod', 'tri');
model.mesh('mesh1').feature('swe2').create('size1', 'Size');
model.mesh('mesh1').feature('swe2').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('swe2').feature('size1').selection.named('geom1_wp5_bnd');
model.mesh('mesh1').feature('swe2').feature('size1').set('hauto', 3);
model.mesh('mesh1').feature('swe2').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe2').feature('dis1').set('numelem', '(ApertureThickness/1.5[mm]>=1)*ApertureThickness/1.5[mm]+(ApertureThickness/1.5[mm]<1)');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cd_es1_phisext').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cd)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '1e-6');

model.study('std1').setGenPlots(false);

model.sol('sol1').runAll;

model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').label('Cathode');
model.result.dataset('surf1').set('param', 'expr');
model.result.dataset('surf1').selection.named('geom1_unisel1_bnd');
model.result.dataset.create('surf2', 'Surface');
model.result.dataset('surf2').label('Cathode copper layout');
model.result.dataset('surf2').set('param', 'expr');
model.result.dataset('surf2').selection.named('geom1_csel1_bnd');
model.result.dataset.create('surf3', 'Surface');
model.result.dataset('surf3').label('PCB without cathode');
model.result.dataset('surf3').selection.named('geom1_difsel1');
model.result.dataset.create('surf4', 'Surface');
model.result.dataset('surf4').label('Walls');
model.result.dataset('surf4').selection.set([1 2 3 4 5 7 8 11 12]);
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').run;
model.result('pg1').label('Thickness on Cathode');
model.result('pg1').set('data', 'surf2');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'thickness_cathode');
model.result('pg1').feature('surf1').set('descr', 'Thickness on cathode');
model.result('pg1').feature('surf1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').run;
model.result('pg1').set('titletype', 'label');
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Current Density on Cathode');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'cd.iloc_er1');
model.result('pg2').feature('surf1').set('descr', 'Local current density');
model.result('pg2').feature('surf1').set('expr', '-cd.iloc_er1');
model.result('pg2').feature('surf1').set('unit', 'A/dm^2');
model.result('pg2').feature('surf1').set('descractive', true);
model.result('pg2').feature('surf1').set('descr', 'Current Density on Cathode');
model.result('pg2').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Thickness Distribution and Electric Field Lines');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('data', 'surf1');
model.result('pg3').feature('surf1').set('expr', 'thickness_cathode');
model.result('pg3').feature('surf1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg3').run;
model.result('pg3').create('surf2', 'Surface');
model.result('pg3').feature('surf2').set('data', 'surf3');
model.result('pg3').feature('surf2').set('coloring', 'uniform');
model.result('pg3').feature('surf2').set('color', 'custom');
model.result('pg3').feature('surf2').set('customcolor', [0.03529411926865578 0.4627451002597809 0.03529411926865578]);
model.result('pg3').run;
model.result('pg3').create('surf3', 'Surface');
model.result('pg3').feature('surf3').set('data', 'surf4');
model.result('pg3').feature('surf3').set('expr', '1');
model.result('pg3').feature('surf3').set('coloring', 'uniform');
model.result('pg3').feature('surf3').set('color', 'white');
model.result('pg3').run;
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('selnumber', 50);
model.result('pg3').feature('str1').selection.named('geom1_unisel1_bnd');
model.result('pg3').feature('str1').set('linetype', 'ribbon');
model.result('pg3').feature('str1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg3').run;
model.result('pg3').set('titletype', 'label');
model.result('pg3').run;

model.view('view1').set('transparency', false);
model.view('view1').camera.setIndex('position', 50, 0);
model.view('view1').camera.setIndex('position', 20, 1);
model.view('view1').camera.set('position', [50 20 40]);
model.view('view1').camera.setIndex('up', -0.1, 0);
model.view('view1').camera.setIndex('up', 1, 1);
model.view('view1').camera.set('up', [-0.1 1 -0.1]);

model.title('Electroplating of a Printed Circuit Board');

model.description(['This example simulates electroplating of a printed circuit board (PCB) in 3D using the Secondary Current Distribution interface. In order to achieve thickness uniformity across the PCB, a dummy pattern is included in the design, along with an aperture in the electroplating bath.' newline  newline 'This example requires the ECAD Import Module.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('pcb_designer.mph');

model.modelNode.label('Components');

out = model;
