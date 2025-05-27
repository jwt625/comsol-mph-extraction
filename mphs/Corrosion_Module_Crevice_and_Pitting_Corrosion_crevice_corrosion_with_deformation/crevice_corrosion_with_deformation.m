function out = model
%
% crevice_corrosion_with_deformation.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Crevice_and_Pitting_Corrosion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cd', 'SecondaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');

model.multiphysics.create('ndbdg1', 'NonDeformingBoundaryDeformedGeometry', 'geom1', 1);
model.multiphysics('ndbdg1').set('Echem_physics', 'cd');
model.multiphysics('ndbdg1').selection.all;
model.multiphysics.create('desdg1', 'DeformingElectrodeSurfaceDeformedGeometry', 'geom1', 1);
model.multiphysics('desdg1').set('Echem_physics', 'cd');
model.multiphysics('desdg1').selection.all;
model.multiphysics('desdg1').set('embs', '0');

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
model.study('std1').feature('cdi').setSolveFor('/physics/cd', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/desdg1', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/cd', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/desdg1', true);

model.param.set('V_pol', '0.3[V]');
model.param.descr('V_pol', 'Polarization potential vs SCE');
model.param.set('w', '0.35[mm]');
model.param.descr('w', 'Crevice width');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'10[mm]' 'w'});
model.geom('geom1').run('r1');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', '2[mm]');
model.geom('geom1').feature('sq1').set('pos', {'-2[mm]' '-1[mm]+w/2'});
model.geom('geom1').run('sq1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'r1' 'sq1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('Ni in 1M H2SO4 (Anodic)');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-0.264' '0.0001';  ...
'-0.257' '0.001';  ...
'-0.205' '0.01';  ...
'-0.189' '0.02';  ...
'-0.169' '0.1';  ...
'-0.144' '0.6';  ...
'-0.130' '1';  ...
'-0.100' '2';  ...
'-0.075' '2.42';  ...
'-0.0193' '1.76';  ...
'-0.0067' '2';  ...
'0.020' '3';  ...
'0.033' '4';  ...
'0.0371' '5';  ...
'0.043' '6';  ...
'0.068' '7.1';  ...
'0.0903' '7.46';  ...
'0.123' '7';  ...
'0.143' '6';  ...
'0.154' '5';  ...
'0.165' '4';  ...
'0.170' '3';  ...
'0.179' '2';  ...
'0.185' '1';  ...
'0.193' '0.1';  ...
'0.208' '0.04';  ...
'0.250' '0.02';  ...
'0.380' '0.01';  ...
'0.698' '0.007';  ...
'0.87' '0.01';  ...
'0.957' '0.02';  ...
'0.993' '0.03';  ...
'1.070' '0.1'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'mA/cm^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', ['M. Abdulsalam and H. W. Pickering, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'The effect of crevice-opening dimension on the stability of crevice corrosion for nickel in sulfuric acid' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', J. Electrochem. Soc., vol. 145, p. 2276, 1998.']);
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental SCE reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['M. Abdulsalam and H. W. Pickering, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'The effect of crevice-opening dimension on the stability of crevice corrosion for nickel in sulfuric acid' native2unicode(hex2dec({'20' '1d'}), 'unicode') ', J. Electrochem. Soc., vol. 145, p. 2276, 1998.']);
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.264 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. SCE');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.set([4 5]);

model.physics('cd').prop('PhysicsVsMaterialsReferenceElectrodePotential').set('PhysicsVsMaterialsReferenceElectrodePotential', 'SCE');
model.physics('cd').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cd').feature('ice1').set('sigmal', {'0.184[S/cm]' '0' '0' '0' '0.184[S/cm]' '0' '0' '0' '0.184[S/cm]'});
model.physics('cd').create('es1', 'ElectrodeSurface', 1);
model.physics('cd').feature('es1').selection.set([4 5]);
model.physics('cd').feature('es1').set('phisext0', 'V_pol');
model.physics('cd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('cd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('cd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('cd').feature('es1').setIndex('rhos', '8900[kg/m^3]', 0, 0);
model.physics('cd').feature('es1').setIndex('Ms', '0.05869[kg/mol]', 0, 0);
model.physics('cd').feature('es1').feature('er1').set('nm', 2);
model.physics('cd').feature('es1').feature('er1').setIndex('Vib', 1, 0, 0);
model.physics('cd').feature('es1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cd').create('eip1', 'ElectrolytePotential', 1);
model.physics('cd').feature('eip1').selection.set([1]);

model.multiphysics('ndbdg1').set('BoundaryCondition', 'ZeroNormalDisplacement');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([5]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.mesh('mesh1').run;

model.study('std1').feature('cdi').set('initType', 'secondary');
model.study('std1').feature('cdi').set('useparam', true);
model.study('std1').feature('cdi').setIndex('pname', 'V_pol', 0);
model.study('std1').feature('cdi').setIndex('plistarr', '', 0);
model.study('std1').feature('cdi').setIndex('punit', 'V', 0);
model.study('std1').feature('cdi').setIndex('pname', 'V_pol', 0);
model.study('std1').feature('cdi').setIndex('plistarr', '', 0);
model.study('std1').feature('cdi').setIndex('punit', 'V', 0);
model.study('std1').feature('cdi').setIndex('plistarr', 'range(-0.2,0.1,0.3)', 0);
model.study('std1').feature('time').set('tlist', 'range(0,10*3600,50*3600)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '1.2148703634544716E-4');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'cdi');
model.sol('sol1').feature('s1').set('control', 'cdi');
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
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scaleval', '1.2148703634544716E-4');
model.sol('sol1').feature('v2').feature('comp1_material_lm_nv').set('out', 'off');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,10*3600,50*3600)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
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
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('mumpsalloc', 1.4);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 6, 0);
model.result('pg1').label('Electrolyte Potential (cd)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'phil'});
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily'});
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('recover', 'pprint');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('color', 'gray');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 6, 0);
model.result('pg2').label('Electrolyte Current Density (cd)');
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily'});
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('recover', 'pprint');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').feature('str1').feature('col1').set('expr', 'root.comp1.cd.IlMag');
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'abs(cd.itot)'});
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('inherittubescale', false);
model.result('pg2').feature('line1').set('inheritplot', 'str1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 6, 0);
model.result('pg3').label('Electrode Potential with Respect to Ground (cd)');
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'cd.phisext'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('inherittubescale', false);
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 6, 0);
model.result('pg4').label('Electrode Potential vs. Adjacent Reference (cd)');
model.result('pg4').create('str1', 'Streamline');
model.result('pg4').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily'});
model.result('pg4').feature('str1').set('posmethod', 'uniform');
model.result('pg4').feature('str1').set('recover', 'pprint');
model.result('pg4').feature('str1').set('pointtype', 'arrow');
model.result('pg4').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('str1').set('color', 'gray');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'cd.Evsref'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('inherittubescale', false);
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 6, 0);
model.result('pg5').label('Total Electrode Thickness Change (cd)');
model.result('pg5').create('line1', 'Line');
model.result('pg5').feature('line1').set('expr', {'cd.sbtot'});
model.result('pg5').feature('line1').set('linetype', 'tube');
model.result('pg5').feature('line1').set('inherittubescale', false);
model.result('pg5').feature('line1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 6, 0);
model.result('pg6').label('Deformed Geometry');
model.result('pg6').create('mesh1', 'Mesh');
model.result('pg6').feature('mesh1').set('meshdomain', 'surface');
model.result('pg6').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg6').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg6').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg6').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg6').feature('mesh1').feature('sel1').selection.set([1]);
model.result('pg6').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg6').feature('mesh1').set('qualexpr', 'comp1.material.relVol');
model.result('pg6').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('frametype', 'geometry');
model.result('pg1').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg7').feature('lngr1').set('linewidth', 'preference');
model.result('pg7').feature('lngr1').selection.set([5]);
model.result('pg7').feature('lngr1').set('expr', 'cd.iloc_er1');
model.result('pg7').feature('lngr1').set('descr', 'Local current density');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'x');
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').feature('lngr1').set('legendmethod', 'evaluated');
model.result('pg7').feature('lngr1').set('legendpattern', 'eval(t,h) h');
model.result('pg7').run;
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').feature('lngr1').set('expr', 'cd.Evsref');
model.result('pg8').feature('lngr1').set('descr', 'Electrode potential vs. adjacent reference');
model.result('pg8').run;
model.result('pg8').run;
model.result.duplicate('pg9', 'pg8');
model.result('pg9').run;
model.result('pg9').run;
model.result('pg9').feature('lngr1').set('expr', 'y');
model.result('pg9').feature('lngr1').set('unit', 'mm');
model.result('pg9').run;
model.result('pg9').set('legendpos', 'lowerright');
model.result('pg9').run;
model.result('pg7').run;
model.result('pg7').label('Corrosion Current Density');
model.result('pg8').run;
model.result('pg8').label('Electrode Potential');
model.result('pg9').run;
model.result('pg9').label('Electrode Shape');

model.title('Crevice Corrosion of Nickel with Electrode Deformation');

model.description('This 2D model exemplifies the basic principles of crevice corrosion and how a time-dependent study can be used to simulate the electrode deformation.');

model.label('crevice_corrosion_with_deformation.mph');

model.modelNode.label('Components');

out = model;
