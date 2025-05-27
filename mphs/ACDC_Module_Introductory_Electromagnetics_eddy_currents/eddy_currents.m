function out = model
%
% eddy_currents.m
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

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 250);
model.geom('geom1').feature('cyl1').set('h', 300);
model.geom('geom1').feature('cyl1').set('axistype', 'cartesian');
model.geom('geom1').feature('cyl1').set('ax3', [1 0 0]);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', [300 0 0]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [10 100 60]);
model.geom('geom1').feature('blk1').set('pos', [145 -50 70]);
model.geom('geom1').runPre('fin');

model.view('view1').set('transparency', true);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Plate');
model.selection('sel1').set([2]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Plate Boundaries');
model.selection('sel2').set([2]);
model.selection('sel2').geom('geom1', 3, 2, {'exterior'});
model.selection('sel2').set([2]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material('mat1').selection.named('sel1');

model.physics('mf').create('als1', 'AmperesLawSolid', 3);
model.physics('mf').feature('als1').selection.named('sel1');
model.physics('mf').create('edc1', 'EdgeCurrent', 1);
model.physics('mf').feature('edc1').selection.set([6]);
model.physics('mf').feature('edc1').set('Ie', 'sqrt(2)*24[kA]');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.named('sel1');
model.mesh('mesh1').feature('ftet1').set('yscale', 0.4);
model.mesh('mesh1').feature('ftet1').set('zscale', 0.4);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 5);
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', 50);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'50'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
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
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').selection.geom('geom1', 3);
model.result.dataset('dset2').selection.named('sel1');

model.view('view1').set('transparency', false);
model.view('view1').set('renderwireframe', true);

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Eddy Currents and Heating');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('slc1', 'Slice');
model.result('pg2').feature('slc1').set('expr', 'mf.Qrh');
model.result('pg2').feature('slc1').set('descr', 'Volumetric loss density, electric');
model.result('pg2').feature('slc1').set('quickxmethod', 'coord');
model.result('pg2').feature('slc1').set('quickx', 154.9);
model.result('pg2').feature('slc1').set('colortable', 'HeatCamera');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'mf.Jx' 'mf.Jy' 'mf.Jz'});
model.result('pg2').feature('str1').set('descr', 'Current density');
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('udist', 0.06);
model.result('pg2').feature('str1').set('color', 'black');
model.result('pg2').run;
model.result('pg2').run;
model.result.numerical.create('int1', 'IntVolume');
model.result.numerical('int1').selection.named('sel1');
model.result.numerical('int1').set('expr', {'mf.Qrh'});
model.result.numerical('int1').set('descr', {'Volumetric loss density, electric'});
model.result.numerical('int1').set('unit', {'W'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Volume Integration 1');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;

model.physics('mf').selection.set([1]);
model.physics('mf').create('imp1', 'Impedance', 2);
model.physics('mf').feature('imp1').selection.named('sel2');

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
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.named('sel2');

model.sol('sol1').detach;

model.study('std1').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std1');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'50'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std1');
model.sol('sol2').runAll;

model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.named('sel2');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Surface Loss Density, Electric');
model.result('pg3').set('data', 'dset3');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'mf.Qsrh');
model.result('pg3').feature('surf1').set('descr', 'Surface loss density, electric');
model.result('pg3').feature('surf1').set('colortable', 'HeatCamera');
model.result('pg3').run;
model.result.numerical.create('int2', 'IntSurface');
model.result.numerical('int2').set('intvolume', true);
model.result.numerical('int2').set('data', 'dset3');
model.result.numerical('int2').selection.named('sel2');
model.result.numerical('int2').set('expr', {'mf.Qsrh'});
model.result.numerical('int2').set('descr', {'Surface loss density, electric'});
model.result.numerical('int2').set('unit', {'W'});
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Surface Integration 2');
model.result.numerical('int2').set('table', 'tbl2');
model.result.numerical('int2').setResult;
model.result('pg3').run;

model.title('Eddy Currents');

model.description(['A metallic plate is placed near a 50' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'Hz AC conductor. The resulting eddy current distribution in the plate depends on the conductivity and permeability of the plate. Four different materials are considered: copper, aluminum, stainless steel, and magnetic iron.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('eddy_currents.mph');

model.modelNode.label('Components');

out = model;
