function out = model
%
% triaxial_test_hardening_soil.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Geomechanics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('disp', '0[cm]', 'Axial displacement');
model.param.set('Nu', '0.2', 'Poisson''s ratio');
model.param.set('Rho', '2400[kg/m^3]', 'Density');
model.param.set('E50ref', '20[MPa]', 'Reference stiffness for primary loading');
model.param.set('Eurref', '60[MPa]', 'Reference stiffness for unloading and reloading');
model.param.set('e0', '0.89', 'Initial void ratio');
model.param.set('m', '0.65', 'Stress exponent');
model.param.set('rc', '1.75', 'Swelling to compression ratio');
model.param.set('c', '1[kPa]', 'Cohesion');
model.param.set('Psi', '1.5[deg]', 'Dilatation angle');
model.param.set('Phi', '34[deg]', 'Angle of internal friction');
model.param.set('Rc', '1.0428', 'Ellipse aspect ratio');
model.param.set('p0', '300[kPa]', 'Pressure');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('sigmafc', '-p0*(1+sin(Phi))/(1-sin(Phi))-2*c*cos(Phi)/(1-sin(Phi))');
model.variable('var1').descr('sigmafc', 'Failure stress in compression');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'5[cm]' '10[cm]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'r1'});
model.geom('geom1').feature('arr1').set('fullsize', [1 3]);
model.geom('geom1').feature('arr1').set('displ', {'0' '20[cm]'});
model.geom('geom1').run('arr1');
model.geom('geom1').run;

model.physics('solid').create('epsm1', 'ElastoplasticSoilMaterial', 2);
model.physics('solid').feature('epsm1').label(['Hardening Soil: Mohr' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Coulomb']);
model.physics('solid').feature('epsm1').selection.set([1]);
model.physics('solid').feature('epsm1').set('MaterialModel', 'HardeningSoil');
model.physics('solid').feature('epsm1').set('Kc_mat', 'FromRatio');
model.physics('solid').feature('epsm1').set('Rf', 0.95);
model.physics('solid').feature('epsm1').set('pc0', '1000[kPa]');
model.physics('solid').feature('epsm1').create('exs1', 'ExternalStress', 2);
model.physics('solid').feature('epsm1').feature('exs1').set('StressInputType', 'InSituStress');
model.physics('solid').feature('epsm1').feature('exs1').set('sins', {'-p0' '0' '0' '0' '-p0' '0' '0' '0' '-p0'});
model.physics('solid').feature.duplicate('epsm2', 'epsm1');
model.physics('solid').feature('epsm2').label(['Hardening Soil: Matsuoka' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Nakai']);
model.physics('solid').feature('epsm2').selection.set([2]);
model.physics('solid').feature('epsm2').set('HardeningSoilOption', 'HSSmooth');
model.physics('solid').feature.duplicate('epsm3', 'epsm1');
model.physics('solid').feature('epsm3').label(['Hardening Soil: Panteghini' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Lagioia']);
model.physics('solid').feature('epsm3').selection.set([3]);
model.physics('solid').feature('epsm3').set('HardeningSoilOption', 'HSCombined');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2 5 8]);
model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([3 6 9]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', 'disp', 2);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Soil Material');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('nu', {'Nu'});
model.material('mat1').propertyGroup.create('HardeningSoilModel', 'Hardening_Soil');
model.material('mat1').propertyGroup('HardeningSoilModel').set('E50Ref', {'E50ref'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('EurRef', {'Eurref'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('mH', {'m'});
model.material('mat1').propertyGroup.create('MohrCoulomb', 'Mohr_Coulomb_criterion');
model.material('mat1').propertyGroup('MohrCoulomb').set('cohesion', {'c'});
model.material('mat1').propertyGroup('MohrCoulomb').set('psid', {'Psi'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('rsc', {'rc'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('Rcap', {'Rc'});
model.material('mat1').propertyGroup('HardeningSoilModel').set('evoid0', {'e0'});
model.material('mat1').propertyGroup('MohrCoulomb').set('internalphi', {'Phi'});
model.material('mat1').propertyGroup('def').set('density', {'Rho'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.all;
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 1);
model.mesh('mesh1').run('map1');

model.study('std1').setGenPlots(false);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'disp', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,-0.0001,-0.017)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_solid_sp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_solid_sp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_solid_sp').set('scaleval', '10000');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.5024937810560445');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Axial Stress vs. Axial Strain');
model.result('pg1').set('titletype', 'label');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Axial strain (1)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Axial stress (kPa)');
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([8]);
model.result('pg1').feature('ptgr1').set('expr', '-solid.SZZ');
model.result('pg1').feature('ptgr1').set('unit', 'kPa');
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', '-solid.eZZ');
model.result('pg1').feature('ptgr1').set('linemarker', 'cycle');
model.result('pg1').feature('ptgr1').set('markerpos', 'interp');
model.result('pg1').feature('ptgr1').set('markers', 6);
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg1').feature('ptgr1').setIndex('legends', 'HS-MC', 0);
model.result('pg1').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg1').run;
model.result('pg1').feature('ptgr2').selection.set([10]);
model.result('pg1').feature('ptgr2').set('markers', 7);
model.result('pg1').feature('ptgr2').setIndex('legends', 'HS-MN', 0);
model.result('pg1').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg1').run;
model.result('pg1').feature('ptgr3').selection.set([12]);
model.result('pg1').feature('ptgr3').set('markers', 8);
model.result('pg1').feature('ptgr3').setIndex('legends', 'HS-PL', 0);
model.result('pg1').feature.duplicate('ptgr4', 'ptgr3');
model.result('pg1').run;
model.result('pg1').feature('ptgr4').set('expr', '-sigmafc');
model.result('pg1').feature('ptgr4').set('linestyle', 'dashed');
model.result('pg1').feature('ptgr4').set('linecolor', 'magenta');
model.result('pg1').feature('ptgr4').setIndex('legends', 'Failure stress', 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('von Mises Stress vs. Axial Strain');
model.result('pg2').set('titletype', 'label');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Axial strain (1)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'von Mises stress (kPa)');
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([8]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.mises');
model.result('pg2').feature('ptgr1').set('unit', 'kPa');
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', '-solid.eZZ');
model.result('pg2').feature('ptgr1').set('linemarker', 'cycle');
model.result('pg2').feature('ptgr1').set('markerpos', 'interp');
model.result('pg2').feature('ptgr1').set('markers', 6);
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg2').feature('ptgr1').setIndex('legends', 'HS-MC', 0);
model.result('pg2').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg2').run;
model.result('pg2').feature('ptgr2').selection.set([10]);
model.result('pg2').feature('ptgr2').set('markers', 7);
model.result('pg2').feature('ptgr2').setIndex('legends', 'HS-MN', 0);
model.result('pg2').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg2').run;
model.result('pg2').feature('ptgr3').selection.set([12]);
model.result('pg2').feature('ptgr3').set('markers', 8);
model.result('pg2').feature('ptgr3').setIndex('legends', 'HS-PL', 0);
model.result('pg2').feature.duplicate('ptgr4', 'ptgr3');
model.result('pg2').run;
model.result('pg2').feature('ptgr4').set('expr', '-sigmafc-p0');
model.result('pg2').feature('ptgr4').set('linestyle', 'dashed');
model.result('pg2').feature('ptgr4').set('linecolor', 'magenta');
model.result('pg2').feature('ptgr4').setIndex('legends', 'Failure von Mises stress', 0);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Volumetric Strain vs. Axial Strain');
model.result('pg3').set('titletype', 'label');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Axial strain (1)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Volumetric strain (1)');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').set('linewidth', 'preference');
model.result('pg3').feature('ptgr1').selection.set([8]);
model.result('pg3').feature('ptgr1').set('expr', 'solid.evol');
model.result('pg3').feature('ptgr1').set('xdata', 'expr');
model.result('pg3').feature('ptgr1').set('xdataexpr', '-solid.eZZ');
model.result('pg3').feature('ptgr1').set('linemarker', 'cycle');
model.result('pg3').feature('ptgr1').set('markerpos', 'interp');
model.result('pg3').feature('ptgr1').set('markers', 6);
model.result('pg3').feature('ptgr1').set('legend', true);
model.result('pg3').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg3').feature('ptgr1').setIndex('legends', 'HS-MC', 0);
model.result('pg3').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg3').run;
model.result('pg3').feature('ptgr2').selection.set([10]);
model.result('pg3').feature('ptgr2').set('markers', 7);
model.result('pg3').feature('ptgr2').setIndex('legends', 'HS-MN', 0);
model.result('pg3').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg3').run;
model.result('pg3').feature('ptgr3').selection.set([12]);
model.result('pg3').feature('ptgr3').set('markers', 8);
model.result('pg3').feature('ptgr3').setIndex('legends', 'HS-PL', 0);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Volumetric Plastic Strain vs. Axial Strain');
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Axial strain (1)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Volumetric plastic strain (1)');
model.result('pg4').create('ptgr1', 'PointGraph');
model.result('pg4').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg4').feature('ptgr1').set('linewidth', 'preference');
model.result('pg4').feature('ptgr1').selection.set([4]);
model.result('pg4').feature('ptgr1').set('expr', 'solid.epvol');
model.result('pg4').feature('ptgr1').set('xdata', 'expr');
model.result('pg4').feature('ptgr1').set('xdataexpr', '-solid.eZZ');
model.result('pg4').feature('ptgr1').set('linemarker', 'cycle');
model.result('pg4').feature('ptgr1').set('markerpos', 'interp');
model.result('pg4').feature('ptgr1').set('markers', 6);
model.result('pg4').feature('ptgr1').set('legend', true);
model.result('pg4').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg4').feature('ptgr1').setIndex('legends', 'HS-MC', 0);
model.result('pg4').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg4').run;
model.result('pg4').feature('ptgr2').selection.set([10]);
model.result('pg4').feature('ptgr2').set('markers', 7);
model.result('pg4').feature('ptgr2').setIndex('legends', 'HS-MN', 0);
model.result('pg4').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg4').run;
model.result('pg4').feature('ptgr3').selection.set([12]);
model.result('pg4').feature('ptgr3').set('markers', 8);
model.result('pg4').feature('ptgr3').setIndex('legends', 'HS-PL', 0);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Mobilized Dilatancy Angle vs. Mobilized Friction Angle');
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Mobilized friction angle (deg)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Mobilized dilatancy angle (deg)');
model.result('pg5').set('legendpos', 'upperleft');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([8]);
model.result('pg5').feature('ptgr1').set('expr', 'solid.epsm1.psim');
model.result('pg5').feature('ptgr1').set('descr', 'Mobilized dilatancy angle');
model.result('pg5').feature('ptgr1').set('expr', 'solid.epsm1.psim*180/pi');
model.result('pg5').feature('ptgr1').set('xdataexpr', 'solid.epsm1.phim');
model.result('pg5').feature('ptgr1').set('xdatadescr', 'Mobilized friction angle');
model.result('pg5').feature('ptgr1').set('xdataexpr', 'solid.epsm1.phim*180/pi');
model.result('pg5').feature('ptgr1').set('linemarker', 'cycle');
model.result('pg5').feature('ptgr1').set('markerpos', 'interp');
model.result('pg5').feature('ptgr1').set('markers', 6);
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'HS-MC', 0);
model.result('pg5').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg5').run;
model.result('pg5').feature('ptgr2').selection.set([10]);
model.result('pg5').feature('ptgr2').set('expr', 'solid.epsm2.psim*180/pi');
model.result('pg5').feature('ptgr2').set('xdataexpr', 'solid.epsm2.phim*180/pi');
model.result('pg5').feature('ptgr2').set('markers', 7);
model.result('pg5').feature('ptgr2').setIndex('legends', 'HS-MN', 0);
model.result('pg5').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg5').run;
model.result('pg5').feature('ptgr3').selection.set([12]);
model.result('pg5').feature('ptgr3').set('expr', 'solid.epsm3.psim*180/pi');
model.result('pg5').feature('ptgr3').set('xdataexpr', 'solid.epsm3.phim*180/pi');
model.result('pg5').feature('ptgr3').set('markers', 8);
model.result('pg5').feature('ptgr3').setIndex('legends', 'HS-PL', 0);
model.result('pg5').run;
model.result('pg1').run;

model.title('Triaxial Test with Hardening Soil Material Model');

model.description('In this example a triaxial test is simulated using the Hardening Soil material model. The test consists of two main stages; an initial isotropic compression, followed by axial compression. A hyperbolic stress-strain relation is recovered. It is also verified that the asymptotic value of the axial stress is equal to the analytical value of the failure stress.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('triaxial_test_hardening_soil.mph');

model.modelNode.label('Components');

out = model;
