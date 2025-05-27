function out = model
%
% stray_current.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/General_Corrosion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cdbem', 'CurrentDistributionBEM', 'geom1');
model.physics('cdbem').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cdbem', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('ranode', '0.1[m]/2', 'Anode radius');
model.param.set('rpipe1', '0.762[m]/2', 'Pipeline 1 radius');
model.param.set('rpipe2', '0.4064[m]/2', 'Pipeline 2 radius');
model.param.set('lanode', '5[m]', 'Anode length');
model.param.set('lpipe', '1600[m]', 'Pipeline length');
model.param.set('sigma', '0.005[S/m]', 'Electrolyte conductivity');
model.param.set('Itot', '2.4[A]', 'Total current');
model.param.set('iapp', 'Itot/(2*pi*ranode*lanode)', 'Applied current density');

model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'-lpipe/2' '-100' '0'});
model.geom('geom1').feature('ls1').setIndex('coord1', -1, 2);
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'-lpipe/2' '-100' '0'});
model.geom('geom1').feature('ls1').setIndex('coord2', '-1-lanode', 2);
model.geom('geom1').feature('ls1').set('selresult', true);
model.geom('geom1').feature('ls1').label('Anode');
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').label('Pipeline 1 (Protected)');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('coord1', {'-lpipe/2' '0' '-4'});
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord2', {'lpipe/2' '0' '-4'});
model.geom('geom1').feature('ls2').set('selresult', true);
model.geom('geom1').run('ls2');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').label('Pipeline 2 (Interference)');
model.geom('geom1').feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('ls3').set('coord1', {'0' '-lpipe/2' '-2'});
model.geom('geom1').feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('ls3').set('coord2', {'0' 'lpipe/2' '-2'});
model.geom('geom1').feature('ls3').set('selresult', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('Q235 steel in soil');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-0.425' '3e-3';  ...
'-0.56' '0';  ...
'-0.72' '-18e-3';  ...
'-0.95' '-66e-3';  ...
'-1.1' '-90e-3';  ...
'-1.14' '-105e-3';  ...
'-1.18' '-126e-3'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'A/m^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['G. Cui, Z. Li, C. Yang and M. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'The influence of DC stray current on pipeline corrosion' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Petroleum Science, vol. 13, p. 135, 2016.']);
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.314 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental CSE reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['G. Cui, Z. Li, C. Yang and M. Wang, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'The influence of DC stray current on pipeline corrosion' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', Petroleum Science, vol. 13, p. 135, 2016.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.56 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. CSE');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.314 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');

model.physics('cdbem').prop('PhysicsVsMaterialsReferenceElectrodePotential').set('PhysicsVsMaterialsReferenceElectrodePotential', 'CSE');
model.physics('cdbem').feature('ice1').set('sigmalInf', 'sigma');
model.physics('cdbem').create('icd1', 'ElectrolyteNormalCurrentDensityEdge', 1);
model.physics('cdbem').feature('icd1').selection.named('geom1_ls1_edg');
model.physics('cdbem').feature('icd1').set('nil', 'iapp');
model.physics('cdbem').create('edge1', 'EdgeElectrode', 1);
model.physics('cdbem').feature('edge1').selection.named('geom1_ls2_edg');
model.physics('cdbem').feature('edge1').set('redge', 'rpipe1');
model.physics('cdbem').feature('edge1').set('ElectricPotentialModelSelection', 'Fixed');
model.physics('cdbem').feature('edge1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cdbem').feature.duplicate('edge2', 'edge1');
model.physics('cdbem').feature('edge2').selection.named('geom1_ls3_edg');
model.physics('cdbem').feature('edge2').set('redge', 'rpipe2');
model.physics('cdbem').feature('edge2').set('ElectricPotentialModelSelection', 'Floating');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('edg1').create('size1', 'Size');
model.mesh('mesh1').feature('edg1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('edg1').feature('size1').set('hmax', 8);
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
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (cdbem)');
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i2').label('GMRES Iterative Solver (cdbem)');
model.sol('sol1').feature('s1').feature('i2').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i2').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'dense');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (cdbem)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('grid1', 'Grid3D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('data', 'dset1');
model.result.dataset('grid1').set('parmin1', -2400);
model.result.dataset('grid1').set('parmax1', 2400);
model.result.dataset('grid1').set('parmin2', -2400);
model.result.dataset('grid1').set('parmax2', 2400);
model.result.dataset('grid1').set('parmin3', -11);
model.result.dataset('grid1').set('parmax3', 4);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'grid1');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', {'cdbem.phil'});
model.result('pg1').label('Electrolyte Potential (cdbem)');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'cdbem.phil'});
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'root.comp1.cdbem.redge');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg1').feature('line1').set('tuberadiusscale', '1');
model.result('pg1').feature('line1').set('data', 'dset1');
model.result('pg1').feature('line1').set('inheritplot', 'mslc1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').label('Electrolyte Current Density (cdbem)');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'abs(cdbem.nIl)'});
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('radiusexpr', 'root.comp1.cdbem.redge');
model.result('pg2').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg2').feature('line1').set('tuberadiusscale', '1');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrode Potential vs. Adjacent Reference (cdbem)');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'cdbem.Evsref'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', 'root.comp1.cdbem.redge');
model.result('pg3').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg3').feature('line1').set('tuberadiusscale', '1');
model.result('pg1').run;
model.result('pg3').run;

model.view.create('view3', 'geom1');
model.view('view3').model('comp1');
model.view('view3').camera.setIndex('position', -6000, 0);
model.view('view3').camera.setIndex('position', -8000, 1);
model.view('view3').camera.set('position', [-6000 -8000 6000]);
model.view('view3').camera.set('target', [-5 0 -5]);
model.view('view3').camera.setIndex('up', 0, 0);
model.view('view3').camera.setIndex('up', 0, 1);
model.view('view3').camera.set('up', [0 0 1]);
model.view('view3').camera.setIndex('viewoffset', 0, 0);
model.view('view3').camera.set('viewoffset', [0 0]);
model.view('view3').camera.set('zoomanglefull', 0.5);

model.result('pg3').run;
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Electrode Potential');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.named('geom1_ls3_edg');
model.result('pg4').feature('lngr1').set('expr', 'cdbem.Evsref');
model.result('pg4').feature('lngr1').set('descr', 'Electrode potential vs. adjacent reference');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'y');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Local current density');
model.result('pg5').run;
model.result('pg5').feature('lngr1').set('expr', 'cdbem.iloc_er1');
model.result('pg5').feature('lngr1').set('descr', 'Local current density');
model.result('pg5').feature('lngr1').set('unit', 'mA/m^2');
model.result('pg5').run;
model.result('pg2').run;
model.result.duplicate('pg6', 'pg2');
model.result('pg6').run;
model.result('pg6').label('Stray Current Density');
model.result('pg6').run;
model.result('pg6').feature('line1').set('expr', 'cdbem.iloc_er1');
model.result('pg6').feature('line1').set('descr', 'Local current density');
model.result('pg6').feature('line1').set('titletype', 'none');
model.result('pg6').feature('line1').create('sel1', 'Selection');
model.result('pg6').feature('line1').feature('sel1').selection.named('geom1_ls3_edg');
model.result('pg6').run;
model.result('pg6').feature.duplicate('line2', 'line1');
model.result('pg6').run;
model.result('pg6').feature('line2').set('expr', '1');
model.result('pg6').feature('line2').set('coloring', 'uniform');
model.result('pg6').feature('line2').set('color', 'gray');
model.result('pg6').run;
model.result('pg6').feature('line2').feature('sel1').selection.named('geom1_ls2_edg');
model.result('pg6').run;
model.result('pg6').create('arwl1', 'ArrowLine');
model.result('pg6').feature('arwl1').set('expr', {'0' '0' 'cdbem.iloc_er1'});
model.result('pg6').feature('arwl1').set('titletype', 'manual');
model.result('pg6').feature('arwl1').set('title', 'Arrow Line: Local current density (A/m<sup>2</sup>)');
model.result('pg6').feature('arwl1').set('inheritplot', 'line1');
model.result('pg6').feature('arwl1').create('sel1', 'Selection');
model.result('pg6').feature('arwl1').feature('sel1').selection.named('geom1_ls3_edg');
model.result('pg6').run;
model.result('pg6').feature('arwl1').create('col1', 'Color');
model.result('pg6').run;
model.result('pg6').feature('arwl1').feature('col1').set('expr', 'cdbem.iloc_er1');
model.result('pg6').feature('arwl1').feature('col1').set('descr', 'Local current density');
model.result('pg6').run;
model.result('pg6').run;

model.title('Stray Current Pipeline Corrosion');

model.description('This example demonstrates stray current corrosion of a buried pipeline, which is located close to a crossing pipeline protected by an impressed current cathodic protection (ICCP) system. The model predicts corrosion of the nonprotected pipeline close to the crossing.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('stray_current.mph');

model.modelNode.label('Components');

out = model;
