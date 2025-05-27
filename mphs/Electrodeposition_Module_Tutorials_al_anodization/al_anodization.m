function out = model
%
% al_anodization.m
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
model.param.set('T', '25[degC]', 'Temperature');
model.param.set('sigma', '0.55[S/cm]', 'Electrolyte conductivity');
model.param.set('i_avg', '100[A/m^2]', 'Average anodization current density');
model.param.set('E_cell_init', '15[V]', 'Cell potential initial value');
model.param.set('rho', '3.97[g/cm^3]', 'Density');
model.param.set('M', '102[g/mol]', 'Molar weight');
model.param.set('eff', '70[%]', 'Current efficiency');
model.param.set('por', '30[%]', 'Layer porosity');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'5[cm]' '1[dm]'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'4[cm]' '8[cm]'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'0' '2[cm]'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('dif1', [1 2 3 4 5 6]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', '3[mm]');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'fil1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', [1 5]);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'0' '2[dm]'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', '2[m]', 0);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Anodes');
model.geom('geom1').feature('ext1').set('contributeto', 'csel1');
model.geom('geom1').run('ext1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'ext1'});
model.geom('geom1').feature('mov1').set('displx', '1.25[dm]');
model.geom('geom1').feature('mov1').set('disply', '1[dm]');
model.geom('geom1').feature('mov1').set('displz', '1[dm]');
model.geom('geom1').run('mov1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'2.2[m]' '0.25[m]' '1'});
model.geom('geom1').feature('blk1').setIndex('size', '1.2[m]', 2);
model.geom('geom1').run('blk1');

model.view('view1').set('transparency', true);

model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'mov1'});
model.geom('geom1').run('dif1');
model.geom('geom1').run;

model.physics('cd').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cd').feature('ice1').set('sigmal', {'sigma' '0' '0' '0' 'sigma' '0' '0' '0' 'sigma'});

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('source', 'file');
model.func('int1').set('filename', 'al_polarization_data.csv');
model.func('int1').importData;
model.func('int1').setIndex('funcs', 'iloc_Al', 0, 0);
model.func('int1').setIndex('argunit', 'V', 0);
model.func('int1').setIndex('argunit', 'degC', 1);
model.func('int1').setIndex('fununit', 'A/m^2', 0);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('geom1_csel1_bnd');

model.physics('cd').create('es1', 'ElectrodeSurface', 2);
model.physics('cd').feature('es1').label('Electrode Surface - Anodes');
model.physics('cd').feature('es1').selection.named('geom1_csel1_bnd');
model.physics('cd').feature('es1').set('BoundaryCondition', 'AverageCurrentDensity');
model.physics('cd').feature('es1').set('Ial', 'i_avg');
model.physics('cd').feature('es1').set('phisext0init', 'E_cell_init');
model.physics('cd').feature('es1').feature('er1').set('ilocmat_mat', 'userdef');
model.physics('cd').feature('es1').feature('er1').set('ilocmat', 'iloc_Al(cd.Evsref,T)');
model.physics('cd').create('es2', 'ElectrodeSurface', 2);
model.physics('cd').feature('es2').label('Electrode Surface - Cathode');
model.physics('cd').feature('es2').selection.set([2]);
model.physics('cd').feature('es2').feature('er1').set('ElectrodeKinetics', 'PrimaryConditionThermodynamicEquilibrium');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([2]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '15 20 25', 0);
model.study('std1').feature('stat').setIndex('punit', 'degC', 0);

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
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_cd_es2_er1_iloc_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_cd_es2_er1_iloc_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
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
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_cd_es2_er1_iloc_lm'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_cd_es2_er1_iloc_lm'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
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
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 3, 0);
model.result('pg1').label('Electrolyte Potential (cd)');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily' 'cd.Ilz'});
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').label('Electrolyte Current Density (cd)');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily' 'cd.Ilz'});
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'root.comp1.cd.IlMag');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'abs(cd.itot)'});
model.result('pg2').feature('surf1').set('inheritplot', 'str1');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 3, 0);
model.result('pg3').label('Electrode Potential with Respect to Ground (cd)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'cd.phisext'});
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 3, 0);
model.result('pg4').label('Electrode Potential vs. Adjacent Reference (cd)');
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily' 'cd.Ilz'});
model.result('pg4').feature('str1').set('posmethod', 'start');
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('str1').set('color', 'gray');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'cd.Evsref'});
model.result('pg1').run;

model.view('view1').set('transparency', false);

model.result('pg4').run;
model.result('pg4').selection.geom('geom1', 2);
model.result('pg4').selection.named('geom1_csel1_bnd');
model.result('pg4').run;
model.result('pg4').feature.remove('str1');
model.result('pg4').run;
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Normalized Current Distribution');
model.result('pg5').selection.geom('geom1', 2);
model.result('pg5').selection.named('geom1_csel1_bnd');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'cd.itot/i_avg');
model.result('pg5').feature('surf1').set('descractive', true);
model.result('pg5').feature('surf1').set('descr', 'Normalized current density');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 2, 0);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 3, 0);
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Deposited Layer Thickness after 25 min');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('expr', 'cd.itot*25[min]*M*eff/(6*F_const*rho*(1-por))');
model.result('pg6').feature('surf1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg6').feature('surf1').set('descr', 'Oxide layer thickness after 25 min');
model.result('pg6').run;
model.result.dataset.create('grid1', 'Grid1D');
model.result.dataset('grid1').set('source', 'function');
model.result.dataset('grid1').set('function', 'int1');
model.result.dataset('grid1').set('parmax1', 16);
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Experimental Al Polarization Data');
model.result('pg7').set('data', 'grid1');
model.result('pg7').set('titletype', 'label');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('xlabel', 'Anodization Potential vs. SHE (V)');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Current Density (A/m<sup>2</sup>)');
model.result('pg7').set('axislimits', true);
model.result('pg7').set('xmin', 0);
model.result('pg7').set('xmax', 16);
model.result('pg7').set('ymin', 0);
model.result('pg7').set('ymax', 159);
model.result('pg7').set('legendpos', 'lowerright');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').set('expr', 'comp1.iloc_Al(root.x[V],15[degC])');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('legendmethod', 'manual');
model.result('pg7').feature('lngr1').setIndex('legends', '15<sup>\circ</sup>C', 0);
model.result('pg7').feature.duplicate('lngr2', 'lngr1');
model.result('pg7').run;
model.result('pg7').feature('lngr2').set('expr', 'comp1.iloc_Al(root.x[V],20[degC])');
model.result('pg7').feature('lngr2').setIndex('legends', '20<sup>\circ</sup>C', 0);
model.result('pg7').feature.duplicate('lngr3', 'lngr2');
model.result('pg7').run;
model.result('pg7').feature('lngr3').set('expr', 'comp1.iloc_Al(root.x[V],25[degC])');
model.result('pg7').feature('lngr3').setIndex('legends', '25<sup>\circ</sup>C', 0);
model.result('pg7').run;

model.title('Aluminum Anodization');

model.description(['When anodizing aluminum, the surface is electrochemically altered to form an abrasive and corrosion-resistive Al' native2unicode(hex2dec({'20' '82'}), 'unicode') 'O' native2unicode(hex2dec({'20' '83'}), 'unicode') ' film. The electrode kinetics during the process are only marginally affected as the oxide layer grows, so a stationary analysis of the current distribution is sufficient to determine the uniformity of this layer' native2unicode(hex2dec({'20' '19'}), 'unicode') 's thickness.' newline  newline 'Anode kinetics from experimental polarization data are used to investigate the uniformity of the anodization current density at three different temperatures, for a specified average current density. At higher temperatures, the cell potential is reduced while the current distribution and thickness become less uniform. This is attributed to lower activation losses (faster kinetics) at higher temperatures.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('al_anodization.mph');

model.modelNode.label('Components');

out = model;
