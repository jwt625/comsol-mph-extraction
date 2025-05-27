function out = model
%
% multilateral_well.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Poromechanics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');
model.physics('dl').feature('porous1').set('storageModelType', {'poroelastic'});

model.multiphysics.create('poro1', 'PoroelasticCoupling', 'geom1', 3);
model.multiphysics('poro1').set('Solid_physics', 'solid');
model.multiphysics('poro1').set('PorousMediaFlow_physics', 'dl');
model.multiphysics('poro1').selection.all;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);
model.study('std1').feature('stat').setSolveFor('/physics/dl', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/poro1', true);

model.geom('geom1').lengthUnit('in');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'multilateral_well.mphbin');
model.geom('geom1').feature('imp1').importData;

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('p_r', '122.45[psi]', 'Pressure in reservoir');
model.param.set('p_w', '0[psi]', 'Pressure in well');
model.param.set('So', '850[psi]', 'Coulomb cohesion');
model.param.set('phi', '31[deg]', 'Friction angle');
model.param.set('C1', '14.7', 'Calibration constant 1');
model.param.set('C2', '40', 'Calibration constant 2');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('N', '2*So*cos(phi)/(1-sin(phi))');
model.variable('var1').descr('N', 'Fail parameter 1');
model.variable('var1').set('Q', '(1+sin(phi))/(1-sin(phi))');
model.variable('var1').descr('Q', 'Fail parameter 2');
model.variable('var1').set('fail', '(((solid.sp3+C1*(p_r-p))-Q*(solid.sp1+C1*(p_r-p))+N*(1+(solid.sp2-solid.sp1)/(solid.sp3-solid.sp1)))/C2)[1/psi]');
model.variable('var1').descr('fail', 'Fail expression');

model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material('pmat1').set('porosity', '0.3');
model.material('pmat1').feature.create('fluid1', 'Fluid', 'comp1');
model.material('pmat1').feature('fluid1').propertyGroup('def').set('compressibility', '');
model.material('pmat1').feature('fluid1').propertyGroup('def').set('density', {'0.0361[lb/in^3]'});
model.material('pmat1').feature('fluid1').propertyGroup('def').set('compressibility', {'4e-10[1/Pa]'});
model.material('pmat1').feature('fluid1').propertyGroup('def').set('dynamicviscosity', {'1e-7[psi*s]'});
model.material.create('mat1', 'Common', '');
model.material('pmat1').set('linkBase', 'mat1');
model.material('mat1').label('Porous Matrix');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'4.3e5[psi]'});
model.material('mat1').propertyGroup('Enu').set('nu', {'0.16'});
model.material('mat1').propertyGroup('def').set('density', {'0.0861[lb/in^3]'});
model.material('mat1').propertyGroup('def').set('hydraulicpermeability', {'1e-13[in^2]'});
model.material('mat1').propertyGroup.create('PoroelasticModel', 'Poroelastic_material');
model.material('mat1').propertyGroup('PoroelasticModel').set('alphaB', {'1'});

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([1 3 13]);
model.physics('solid').create('disp1', 'Displacement2', 2);
model.physics('solid').feature('disp1').selection.set([2 5]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').create('disp2', 'Displacement2', 2);
model.physics('solid').feature('disp2').selection.set([4 11 12]);
model.physics('solid').feature('disp2').setIndex('Direction', 'prescribed', 2);
model.physics('dl').feature('porous1').feature('fluid1').set('fluidType', 'compressibleLinearized');
model.physics('dl').feature('init1').set('p', 'p_r');
model.physics('dl').create('pr1', 'Pressure', 2);
model.physics('dl').feature('pr1').selection.set([1 3 13]);
model.physics('dl').feature('pr1').set('p0', 'p_r');
model.physics('dl').create('pr2', 'Pressure', 2);
model.physics('dl').feature('pr2').selection.set([6 7 8 9 10]);
model.physics('dl').feature('pr2').set('p0', 'p_w');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').label('Well boundaries');
model.selection('sel1').set([6 7 8 9 10]);

model.physics('dl').feature('pr2').selection.named('sel1');

model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (poro1) (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (poro1)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Displacement');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def1').set('scale', 1000);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').label('Fluid Pressure and Velocities');
model.result('pg2').create('iso1', 'Isosurface');
model.result('pg2').feature('iso1').set('expr', 'p');
model.result('pg2').feature('iso1').set('unit', 'psi');
model.result('pg2').feature('iso1').set('colortable', 'Cividis');
model.result('pg2').feature('iso1').set('legendtype', 'filled');
model.result('pg2').run;
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'dl.u' 'dl.v' 'dl.w'});
model.result('pg2').feature('str1').set('descr', 'Total Darcy velocity field (spatial frame)');
model.result('pg2').feature('str1').set('posmethod', 'start');
model.result('pg2').feature('str1').set('number', 60);
model.result('pg2').feature('str1').set('linetype', 'tube');
model.result('pg2').feature('str1').set('radiusexpr', '0.4');
model.result('pg2').feature('str1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('str1').feature('col1').set('expr', 'dl.U');
model.result('pg2').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', '1');
model.result('pg2').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('mtrl1').set('appearance', 'custom');
model.result('pg2').feature('surf1').feature('mtrl1').set('family', 'steel');
model.result('pg2').run;
model.result('pg2').feature('surf1').create('sel1', 'Selection');
model.result('pg2').feature('surf1').feature('sel1').selection.named('sel1');
model.result('pg2').run;
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Fail Function');
model.result('pg3').create('iso1', 'Isosurface');
model.result('pg3').feature('iso1').set('expr', 'fail');
model.result('pg3').run;
model.result('pg3').feature('iso1').set('levelmethod', 'levels');
model.result('pg3').feature('iso1').set('levels', 'range(-20,10,20)');
model.result('pg3').feature('iso1').set('colortable', 'WaveLight');
model.result('pg3').run;

model.title('Failure of a Multilateral Well');

model.description('This example, which shows how to analyze failure from deformations near an open-hole well, comes from Dr. Roberto Suarez Rivera of TerraTek Inc. Their poroelastic approach builds a model of porous media flow with solid deformation and analyzes the potential for collapse using Coulomb failure expressions.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('multilateral_well.mph');

model.modelNode.label('Components');

out = model;
