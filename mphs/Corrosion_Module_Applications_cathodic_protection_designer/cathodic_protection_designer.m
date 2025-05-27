function out = model
%
% cathodic_protection_designer.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cd', 'SecondaryCurrentDistribution', 'geom1');
model.physics('cd').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cd', true);

model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'cathodic_protection_designer_geometry.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('imp1').set('selresult', true);
model.geom('geom1').feature('imp1').set('selresultshow', 'all');
model.geom('geom1').feature('imp1').set('selindividual', true);
model.geom('geom1').feature('imp1').set('selindividualshow', 'all');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [100 100 100]);
model.geom('geom1').feature('blk1').set('pos', [-50 -50 -100]);
model.geom('geom1').feature('blk1').setIndex('layer', 55, 0);
model.geom('geom1').run('blk1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').set('entitydim', -1);
model.geom('geom1').feature('boxsel1').set('xmin', -49.5);
model.geom('geom1').feature('boxsel1').set('xmax', 49.5);
model.geom('geom1').feature('boxsel1').set('ymin', -49.5);
model.geom('geom1').feature('boxsel1').set('ymax', 49.5);
model.geom('geom1').feature('boxsel1').set('zmin', -109.5);
model.geom('geom1').feature('boxsel1').set('zmax', 9.5);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').set('entitydim', -1);
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').set('entitydim', -1);
model.geom('geom1').feature('difsel1').set('add', {'boxsel2'});
model.geom('geom1').feature('difsel1').set('subtract', {'boxsel1'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('difsel1');
model.geom('geom1').feature('dif1').selection('input2').named('boxsel1');
model.geom('geom1').run('dif1');
model.geom('geom1').run('fin');

model.param.set('condWater', '3.33[S/m]');
model.param.descr('condWater', 'Water conductivity');
model.param.set('condMud', '0.75[S/m]');
model.param.descr('condMud', 'Mud conductivity');
model.param.set('simCase', '1');
model.param.descr('simCase', 'Simulation case identifier');
model.param.set('t', '(simCase==0)*0+(simCase==1)*tfinal/2+(simCase==2)*tfinal');
model.param.descr('t', 'Simulation time');
model.param.set('tfinal', '20[year]');
model.param.descr('tfinal', 'Expected time of life');
model.param.set('protectionLimit', '-800[mV]');
model.param.descr('protectionLimit', 'Cathodic protection limit vs Ag/AgCl');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('Mud');
model.selection('sel1').set([1]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('SelectedDomain');
model.selection('sel2').set([1]);
model.selection.create('box1', 'Box');
model.selection('box1').model('comp1');
model.selection('box1').set('xmin', -49.5);
model.selection('box1').set('xmax', 49.5);
model.selection('box1').set('ymin', -49.5);
model.selection('box1').set('ymax', 49.5);
model.selection('box1').set('zmin', -109.5);
model.selection('box1').set('zmax', 9.5);
model.selection('box1').set('entitydim', 2);
model.selection('box1').set('condition', 'inside');
model.selection('box1').label('Geometry surfaces');
model.selection.duplicate('box2', 'box1');
model.selection('box2').set('entitydim', 1);
model.selection('box2').label('Geometry edges');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Seawater');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte_conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'condWater'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Mud');
model.material('mat2').selection.set([1]);
model.material('mat2').selection.named('sel2');
model.material('mat2').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte_conductivity');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('sigmal', {'condMud'});
model.material('mat1').set('family', 'water');
model.material('mat2').set('family', 'concrete');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.named('geom1_imp1_1_bnd');
model.variable('var1').set('Eeq', '-600[mV]');
model.variable('var1').descr('Eeq', 'Equilibrium potential');
model.variable('var1').set('i_initial', '180[mA/m^2]');
model.variable('var1').descr('i_initial', 'Initial current density');
model.variable('var1').set('i_mean', '100[mA/m^2]');
model.variable('var1').descr('i_mean', 'Mean current density');
model.variable('var1').set('i_final', '120[mA/m^2]');
model.variable('var1').descr('i_final', 'Final current density');
model.variable('var1').set('cbfA', '0.02');
model.variable('var1').descr('cbfA', 'Coating break down factor A');
model.variable('var1').set('cbfB', '0.012[1/year]');
model.variable('var1').descr('cbfB', 'Coating breakdown factor B');
model.variable('var1').set('cbfOn', '1');
model.variable('var1').descr('cbfOn', 'Coating breakdown factor switch variable (1==On)');
model.variable('var1').set('iloc', '-(if(cbfOn,if((cbfA+cbfB*t)<1,cbfA+cbfB*t,1),1)*(i_initial*(simCase==0)+i_mean*(simCase==1)+i_final*(simCase==2)))');
model.variable('var1').descr('iloc', 'Local current density on cathode.');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').selection.geom('geom1', 1);
model.variable('var2').selection.named('geom1_imp1_2_edg');
model.variable('var2').set('edgeRadius', '0.15[m]');
model.variable('var2').descr('edgeRadius', 'Anode radius');
model.variable('var2').set('edgeAnodeFinalRadius', '0.05[m]');
model.variable('var2').descr('edgeAnodeFinalRadius', 'Anode final radius');
model.variable('var2').set('Eeq', '-1050[mV]', 'Equilibrium potential');
model.variable('var2').set('anodePolGrad', '100[mA/(m^2*mV)]');
model.variable('var2').descr('anodePolGrad', 'Anode polarization gradient');
model.variable('var2').set('iloc', 'anodePolGrad*cd.eta_er1', 'Local current density on cathode.');
model.variable('var2').descr('iloc', 'Local current density on anode.');
model.variable.duplicate('var3', 'var1');
model.variable('var3').selection.named('geom1_imp1_3_bnd');
model.variable('var3').set('cbfOn', '0');
model.variable.duplicate('var4', 'var3');
model.variable('var4').selection.named('geom1_imp1_4_bnd');
model.variable('var4').set('i_initial', '10[mA/m^2]');
model.variable('var4').set('i_mean', '10[mA/m^2]');
model.variable('var4').set('i_final', '10[mA/m^2]');

model.physics('cd').prop('ShapeProperty').set('order_electricpotentialionicphase', 2);
model.physics('cd').create('es1', 'ElectrodeSurface', 2);
model.physics('cd').feature('es1').selection.named('geom1_imp1_1_bnd');
model.physics('cd').feature('es1').feature('er1').set('Eeq', 'Eeq');
model.physics('cd').feature('es1').feature('er1').set('ilocmat_mat', 'userdef');
model.physics('cd').feature('es1').feature('er1').set('ilocmat', '-iloc');
model.physics('cd').create('edge1', 'EdgeElectrode', 1);
model.physics('cd').feature('edge1').set('redge', 'edgeRadius*(simCase==0||simCase==1)+edgeAnodeFinalRadius*(simCase==2)');
model.physics('cd').feature('edge1').set('ElectricPotentialModelSelection', 'Fixed');
model.physics('cd').feature('edge1').selection.named('geom1_imp1_2_edg');
model.physics('cd').feature('edge1').feature('er1').set('Eeq', 'Eeq');
model.physics('cd').feature('edge1').feature('er1').set('ilocmat_mat', 'userdef');
model.physics('cd').feature('edge1').feature('er1').set('ilocmat', 'iloc');
model.physics('cd').create('es2', 'ElectrodeSurface', 2);
model.physics('cd').feature('es2').selection.named('geom1_imp1_3_bnd');
model.physics('cd').feature('es2').feature('er1').set('Eeq', 'Eeq');
model.physics('cd').feature('es2').feature('er1').set('ilocmat_mat', 'userdef');
model.physics('cd').feature('es2').feature('er1').set('ilocmat', 'iloc');
model.physics('cd').feature.duplicate('es3', 'es2');
model.physics('cd').feature('es3').selection.named('geom1_imp1_4_bnd');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature.remove('size1');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmin', 0.05);
model.mesh('mesh1').run;

model.view('view1').set('showmaterial', true);

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'condWater', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'S/m', 0);
model.study('std1').feature('stat').setIndex('pname', 'condWater', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'S/m', 0);
model.study('std1').feature('stat').setIndex('pname', 'simCase', 0);
model.study('std1').feature('stat').setIndex('plistarr', '0 1 2', 0);

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
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
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
model.result('pg3').label('Electrode Potential vs. Adjacent Reference (cd)');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'cd.Ilx' 'cd.Ily' 'cd.Ilz'});
model.result('pg3').feature('str1').set('posmethod', 'start');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg3').feature('str1').set('color', 'gray');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'cd.Evsref'});
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'cd.Evsref'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('radiusexpr', 'root.comp1.cd.redge');
model.result('pg3').feature('line1').set('tuberadiusscaleactive', 'on');
model.result('pg3').feature('line1').set('tuberadiusscale', '1');
model.result('pg3').feature('line1').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Protected Surfaces');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'cd.Evsref<protectionLimit');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.remove('str1');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', 'cd.itot_edge');
model.result('pg2').feature('line1').set('colortable', 'Twilight');
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').feature('line1').set('radiusexpr', 'cd.redge');
model.result('pg2').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').feature.remove('str1');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').set('edges', false);
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Electrode potential vs. adjacent reference');
model.result('pg3').set('paramindicator', 'Final Current Density');
model.result('pg2').run;
model.result('pg2').set('edges', false);
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Surface: abs(cd.itot) (A/m<sup>2</sup>)');
model.result('pg2').set('paramindicator', 'Final Current Density');
model.result('pg2').set('title', 'Surface: Current Density (A/m<sup>2</sup>)');
model.result.table.create('tbl1', 'Table');
model.result('pg4').run;
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', 'cd.Evsref<protectionLimit');
model.result('pg4').feature('line1').set('colortable', 'Twilight');
model.result('pg4').run;
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('radiusexpr', 'cd.redge');
model.result('pg4').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').set('edges', false);
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Surface: Protected surfaces');
model.result('pg4').set('paramindicator', 'Final Current Density');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('box1');
model.result('pg2').run;
model.result('pg2').feature('line1').create('sel1', 'Selection');
model.result('pg2').feature('line1').feature('sel1').selection.named('box2');
model.result('pg3').run;
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.named('box1');
model.result('pg3').run;
model.result('pg3').feature('line1').create('sel1', 'Selection');
model.result('pg3').feature('line1').feature('sel1').selection.named('box2');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg4').feature('surf1').create('sel1', 'Selection');
model.result('pg4').feature('surf1').feature('sel1').selection.named('box1');
model.result('pg4').run;
model.result('pg4').feature('line1').create('sel1', 'Selection');
model.result('pg4').feature('line1').feature('sel1').selection.named('box2');
model.result('pg3').run;

% Started to run method changeVarTags

model.variable('var1').tag('var_imp1_1');
model.variable('var2').tag('var_imp1_2');
model.variable('var3').tag('var_imp1_3');
model.variable('var4').tag('var_imp1_4');

model.result('pg3').run;

% Finished running method changeVarTags

model.title([]);

model.description('');

model.label('cathodic_protection_designer_embedded.mph');

model.result('pg3').run;

model.title('Cathodic Protection Designer');

model.description(['The cathodic protection designer app can be used for simplified simulations of general cathodic protection designs, for cases when all different parts using different boundary conditions are separated as individual objects in the geometry.' newline  newline 'The geometry is imported as a CAD file, fulfilling certain requirements. The user can then select each part of the geometry, and set boundary conditions according to a typical simulation scheme used by corrosion engineers for cathodic protection designs, which allows for solving of the initial, mean and final current densities. The results can be exported in a report either in HTML, Word or Powerpoint formats.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('cathodic_protection_designer.mph');

model.modelNode.label('Components');

out = model;
