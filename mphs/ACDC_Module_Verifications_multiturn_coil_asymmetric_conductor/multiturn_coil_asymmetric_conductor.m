function out = model
%
% multiturn_coil_asymmetric_conductor.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Verifications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');

model.geom('geom1').insertFile('multiturn_coil_asymmetric_conductor_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('dif1').label('Conductor');
model.geom('geom1').feature('dif1').set('selresult', true);
model.geom('geom1').feature('ext1').label('Coil');
model.geom('geom1').feature('ext1').set('selresult', true);

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom('geom1', 2);
model.view('view1').hideEntities('hide1').set([1 2 3 4 5 52]);

model.physics('mf').create('als1', 'AmperesLawSolid', 3);
model.physics('mf').feature('als1').selection.named('geom1_dif1_dom');
model.physics('mf').setGroupBySpaceDimension(true);
model.physics('mf').create('coil1', 'Coil', 3);
model.physics('mf').feature('coil1').selection.named('geom1_ext1_dom');
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('CoilType', 'Numeric');
model.physics('mf').feature('coil1').set('N', 2742);
model.physics('mf').feature('coil1').feature('ccc1').feature('ct1').selection.set([37]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('emissivity', '0.5');
model.material('mat1').propertyGroup('def').set('density', '8940[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '126e9[Pa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.34');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.667e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '3.862e-3[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '293.15[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material('mat1').selection.named('geom1_ext1_dom');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.named('geom1_dif1_dom');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'3.526e7'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat2').label('Aluminum');

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('size1').selection.named('geom1_dif1_dom');
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', 12);
model.mesh('mesh1').create('size2', 'Size');
model.mesh('mesh1').feature('size2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('size2').selection.named('geom1_ext1_dom');
model.mesh('mesh1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('size2').set('hmax', 20);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run('ftet1');

model.study('std1').create('ccc', 'CoilCurrentCalculation');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('plist', '50 200');
model.study('std1').setGenPlots(false);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'ccc');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'ccc');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_mf_coil1_ccc1_s'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_mf_coil1_ccc1_p' 'comp1_mf_coil1_ccc1_lm'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').set('segterm', 'itertol');
model.sol('sol1').feature('s1').feature('se1').set('segiter', 6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'freq');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'freq');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').create('p1', 'Parametric');
model.sol('sol1').feature('s2').feature.remove('pDef');
model.sol('sol1').feature('s2').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s2').feature('p1').set('plistarr', {'50 200'});
model.sol('sol1').feature('s2').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s2').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s2').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s2').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s2').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s2').feature('p1').set('probes', {});
model.sol('sol1').feature('s2').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s2').set('linpmethod', 'sol');
model.sol('sol1').feature('s2').set('linpsol', 'zero');
model.sol('sol1').feature('s2').set('control', 'freq');
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s2').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_A'});
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').feature('v2').set('solnum', 'auto');
model.sol('sol1').feature('v2').set('solvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Coil Direction and Induced Current Density, 50 Hz');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').create('sel1', 'Selection');
model.result('pg1').feature('arwv1').feature('sel1').selection.named('geom1_ext1_dom');
model.result('pg1').run;
model.result('pg1').feature('arwv1').set('expr', {'mf.coil1.eCoilx' 'mf.coil1.eCoily' 'mf.coil1.eCoilz'});
model.result('pg1').feature('arwv1').set('descr', 'Coil direction');
model.result('pg1').feature('arwv1').set('xnumber', 10);
model.result('pg1').feature('arwv1').set('ynumber', 10);
model.result('pg1').feature('arwv1').set('znumber', 5);
model.result('pg1').feature('arwv1').set('scaleactive', true);
model.result('pg1').feature('arwv1').set('scale', 20);
model.result('pg1').run;
model.result('pg1').create('arwv2', 'ArrowVolume');
model.result('pg1').feature('arwv2').create('sel1', 'Selection');
model.result('pg1').feature('arwv2').feature('sel1').selection.named('geom1_dif1_dom');
model.result('pg1').run;
model.result('pg1').feature('arwv2').set('expr', {'mf.Jix' 'mf.Jiy' 'mf.Jiz'});
model.result('pg1').feature('arwv2').set('descr', 'Conduction current density');
model.result('pg1').feature('arwv2').set('xnumber', 20);
model.result('pg1').feature('arwv2').set('ynumber', 20);
model.result('pg1').feature('arwv2').set('arrowzmethod', 'coord');
model.result('pg1').feature('arwv2').set('zcoord', 19);
model.result('pg1').feature('arwv2').set('color', 'black');
model.result('pg1').feature('arwv2').set('arrowtype', 'cone');
model.result('pg1').run;
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').create('sel1', 'Selection');
model.result('pg1').feature('vol1').feature('sel1').selection.named('geom1_dif1_dom');
model.result('pg1').run;
model.result('pg1').feature('vol1').set('expr', 'mf.Jiy');
model.result('pg1').feature('vol1').set('descr', 'Conduction current density, y-component');
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Coil Direction and Induced Current Density, 200 Hz');
model.result('pg2').setIndex('looplevel', 2, 0);
model.result('pg2').run;
model.result.dataset.create('cln1', 'CutLine3D');
model.result.dataset('cln1').setIndex('genpoints', 72, 0, 1);
model.result.dataset('cln1').setIndex('genpoints', 34, 0, 2);
model.result.dataset('cln1').setIndex('genpoints', 288, 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 72, 1, 1);
model.result.dataset('cln1').setIndex('genpoints', 34, 1, 2);
model.result.dataset.duplicate('cln2', 'cln1');
model.result.dataset('cln2').setIndex('genpoints', 18.99, 0, 2);
model.result.dataset('cln2').setIndex('genpoints', 18.99, 1, 2);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('multiturn_coil_asymmetric_conductor_table1.txt');
model.result.table('tbl1').setIndex('headers', 'x [mm]', 0, 1);
model.result.table('tbl1').setIndex('headers', 'Bz(x,72,34) at 50Hz', 1, 1);
model.result.table('tbl1').setIndex('headers', 'Bz(x,72,34) at 200Hz', 2, 1);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').importData('multiturn_coil_asymmetric_conductor_table2.txt');
model.result.table('tbl2').setIndex('headers', 'x [mm]', 0, 1);
model.result.table('tbl2').setIndex('headers', 'Jy(x,72,19) at 50Hz', 1, 1);
model.result.table('tbl2').setIndex('headers', 'Jy(x,72,19) at 200Hz', 2, 1);
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg3').feature('lngr1').set('linewidth', 'preference');
model.result('pg3').feature('lngr1').set('data', 'cln1');
model.result('pg3').feature('lngr1').set('solutionparams', 'parent');
model.result('pg3').feature('lngr1').set('expr', 'sign(real(mf.Bz))*abs(mf.Bz)');
model.result('pg3').feature('lngr1').set('unit', 'mT');
model.result('pg3').feature('lngr1').set('legend', true);
model.result('pg3').feature('lngr1').set('legendmethod', 'evaluated');
model.result('pg3').feature('lngr1').set('legendpattern', 'eval(freq) Hz');
model.result('pg3').run;
model.result('pg3').label('Bz(x,72,34)');
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg3').feature('tblp1').set('linewidth', 'preference');
model.result('pg3').feature('tblp1').set('xaxisdata', 1);
model.result('pg3').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg3').feature('tblp1').set('plotcolumns', [2]);
model.result('pg3').feature('tblp1').set('linestyle', 'none');
model.result('pg3').feature('tblp1').set('linecolor', 'blue');
model.result('pg3').feature('tblp1').set('linemarker', 'circle');
model.result('pg3').feature.duplicate('tblp2', 'tblp1');
model.result('pg3').run;
model.result('pg3').feature('tblp2').set('plotcolumns', [3]);
model.result('pg3').feature('tblp2').set('linecolor', 'green');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').set('data', 'cln2');
model.result('pg4').feature('lngr1').set('solutionparams', 'parent');
model.result('pg4').feature('lngr1').set('expr', 'sign(real(mf.Jy))*abs(mf.Jy)');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'evaluated');
model.result('pg4').feature('lngr1').set('legendpattern', 'eval(freq) Hz');
model.result('pg4').run;
model.result('pg4').label('Jy(x,72,19)');
model.result('pg4').create('tblp1', 'Table');
model.result('pg4').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg4').feature('tblp1').set('linewidth', 'preference');
model.result('pg4').feature('tblp1').set('table', 'tbl2');
model.result('pg4').feature('tblp1').set('xaxisdata', 1);
model.result('pg4').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg4').feature('tblp1').set('plotcolumns', [2]);
model.result('pg4').feature('tblp1').set('linestyle', 'none');
model.result('pg4').feature('tblp1').set('linecolor', 'blue');
model.result('pg4').feature('tblp1').set('linemarker', 'circle');
model.result('pg4').feature.duplicate('tblp2', 'tblp1');
model.result('pg4').run;
model.result('pg4').feature('tblp2').set('plotcolumns', [3]);
model.result('pg4').feature('tblp2').set('linecolor', 'green');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').run;

model.title('Multiturn Coil Above an Asymmetric Conductor Plate');

model.description(['This example solves Testing Electromagnetic Analysis Methods (TEAM) problem 7, ''Asymmetrical Conductor with a Hole'' ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' a benchmark problem concerning the calculation of eddy currents and magnetic fields produced when an aluminum conductor is placed asymmetrically above a multiturn coil carrying a sinusoidally varying current. Comparing the simulation results at specified positions in space with measured data from the literature shows agreement.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('multiturn_coil_asymmetric_conductor.mph');

model.modelNode.label('Components');

out = model;
