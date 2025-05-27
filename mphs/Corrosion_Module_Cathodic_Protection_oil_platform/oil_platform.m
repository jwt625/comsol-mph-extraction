function out = model
%
% oil_platform.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Cathodic_Protection');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cp', 'CathodicProtection', 'geom1');
model.physics('cp').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cp', true);

model.param.set('i_oxygen', '-0.1[A/m^2]');
model.param.descr('i_oxygen', 'Limiting current for oxygen reduction at steel structure');
model.param.set('Eeq_Al', '-1.05[V]');
model.param.descr('Eeq_Al', 'Anode equilibrium potential vs. Ag/AgCl');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'oil_platform.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('imp1').set('selresult', true);
model.geom('geom1').feature('imp1').set('selresultshow', 'bnd');
model.geom('geom1').feature('imp1').set('selindividual', true);
model.geom('geom1').feature('imp1').set('selindividualshow', 'bnd');
model.geom('geom1').run('imp1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 40);
model.geom('geom1').feature('cyl1').set('h', 92);
model.geom('geom1').run('cyl1');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('r', 60);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1' 'cyl2'});
model.geom('geom1').feature('dif1').selection('input2').set({'imp1'});
model.geom('geom1').run('dif1');

model.coordSystem.create('ie1', 'geom1', 'InfiniteElement');

model.geom('geom1').run;

model.coordSystem('ie1').selection.set([1]);
model.coordSystem('ie1').set('ScalingType', 'Cylindrical');

model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').label('Anodes');
model.selection('dif1').set('entitydim', 2);
model.selection('dif1').set('add', {'geom1_imp1_bnd'});
model.selection('dif1').set('subtract', {'geom1_imp1_41_bnd'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat1').label('Seawater');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('source', 'file');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('importedname', 'seawater conductivity.txt');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('importeddim', '2D');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {'' ''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('sourcetype', 'model');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('nargs', '2');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('struct', 'spreadsheet');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigma0*int1(S,(T-0[degC])[1/K])' '0' '0' '0' 'sigma0*int1(S,(T-0[degC])[1/K])' '0' '0' '0' 'sigma0*int1(S,(T-0[degC])[1/K])'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['Fofonoff, N. P., and R. C. Millard, Jr., Algorithms for computation of' newline 'fundamental properties of seawater, UNESCO, Tech. Pap. Mar.' newline 'Sci., 44, 53 pp., Paris, 1984.' newline  newline 'Physical Properties of Seawater -' newline 'A New Salinity Scale and Equation of State for Seawater, Fofonoff, J. Geophysical Research, Vol. 90, No. C2, 3332-3342, 1985' newline ]);
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('S', '35');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('S', 'Practical Salinity (PSS 78)');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigma0', '4.29[S/m]');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('sigma0', 'Conductivity at T=15[degC] and S=35');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('temperature');

model.physics('cp').prop('ShapeProperty').set('order_electricpotentialionicphase', 1);
model.physics('cp').feature('ice1').set('minput_temperature_src', 'userdef');
model.physics('cp').feature('ice1').set('minput_temperature', '10[degC]');
model.physics('cp').create('es1', 'ElectrodeSurface', 2);
model.physics('cp').feature('es1').label('Electrode Surface - Anodes');
model.physics('cp').feature('es1').selection.named('dif1');
model.physics('cp').feature('es1').feature('er1').set('Eeq', 'Eeq_Al');
model.physics('cp').feature('es1').feature('er1').set('ElectrodeKinetics', 'PrimaryConditionThermodynamicEquilibrium');
model.physics('cp').create('protms1', 'ProtectedMetalSurface', 2);
model.physics('cp').feature('protms1').label('Protected Metal Surface - Steel');
model.physics('cp').feature('protms1').selection.named('geom1_imp1_41_bnd');
model.physics('cp').feature('protms1').set('iO2', 'i_oxygen');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 15);
model.mesh('mesh1').feature('size').set('hmin', 0.5);
model.mesh('mesh1').feature('size').set('hcurve', 0.9);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature.move('ftri1', 1);
model.mesh('mesh1').feature('ftri1').selection.set([17 19 145 147 314 316 368 370]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 1.08);
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cp)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cp)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_cp_es1_er1_iloc_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_cp_es1_er1_iloc_lm'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cp)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_cp_es1_er1_iloc_lm'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavarsactive', 'on');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_cp_es1_er1_iloc_lm'});
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
model.result('pg1').label('Electrolyte Potential (cp)');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').label('Electrolyte Current Density (cp)');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'root.comp1.cp.IlMag');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'abs(cp.itot)'});
model.result('pg2').feature('surf1').set('inheritplot', 'str1');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrode Potential vs. Adjacent Reference (cp)');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'cp.Ilx' 'cp.Ily' 'cp.Ilz'});
model.result('pg3').feature('str1').set('posmethod', 'start');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'cp.Evsref'});
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Anode current densities (cp)');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Anode current densities (A/m<sup>2</sup>)');
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature('str1').active(false);
model.result('pg2').run;
model.result('pg2').feature('surf1').set('inheritplot', 'none');
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('dif1');
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').label('Steel potential (cp)');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Steel potential vs. Ag/AgCl (V)');
model.result('pg3').set('edges', false);
model.result('pg3').run;
model.result('pg3').feature('str1').active(false);
model.result('pg3').run;
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.named('geom1_imp1_41_bnd');
model.result('pg3').run;
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('sel1').selection.set([212 213 214 218 219 220 223 224]);
model.result('pg4').run;
model.result('pg4').label('Steel potential, close-up (cp)');
model.result('pg4').run;
model.result('pg1').run;

model.title('Corrosion Protection of an Oil Platform Using Sacrificial Anodes');

model.description('This example models the corrosion protection system of an oil platform using sacrificial aluminum anodes. An Infinite Element Domain is used to describe the infinite extension of the ocean.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('oil_platform.mph');

model.modelNode.label('Components');

out = model;
