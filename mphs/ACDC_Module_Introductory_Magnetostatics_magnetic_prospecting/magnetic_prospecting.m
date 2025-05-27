function out = model
%
% magnetic_prospecting.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Introductory_Magnetostatics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.physics('mfnc').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mfnc', true);

model.param.set('mur_magn', '3.5');
model.param.descr('mur_magn', 'Relative permittivity of magnetite');
model.param.set('c_magn', '0.25');
model.param.descr('c_magn', 'Magnetite concentration in ore');
model.param.set('Mr_magn', '60[A/m]');
model.param.descr('Mr_magn', 'Remanent magnetization of magnetite');
model.param.set('H0', '48163[nT]/mu0_const');
model.param.descr('H0', 'Geomagnetic field');
model.param.set('Incl', '59.357[deg]');
model.param.descr('Incl', 'Local inclination');
model.param.set('Decl', '12.275[deg]');
model.param.descr('Decl', 'Local declination');

model.variable.create('var1');
model.variable('var1').set('Br_magn', 'Mr_magn*mu0_const');
model.variable('var1').descr('Br_magn', 'Remanent flux density of magnetite');
model.variable('var1').set('Br', 'Br_magn*c_magn');
model.variable('var1').descr('Br', 'Remanent flux density of ore');
model.variable('var1').set('Gx', 'cos(Incl)*sin(Decl)');
model.variable('var1').descr('Gx', 'Geomagnetic field direction, x-component');
model.variable('var1').set('Gy', 'cos(Incl)*cos(Decl)');
model.variable('var1').descr('Gy', 'Geomagnetic field direction, y-component');
model.variable('var1').set('Gz', '-sin(Incl)');
model.variable('var1').descr('Gz', 'Geomagnetic field direction, z-component');
model.variable('var1').set('mur_ore', '1+(mur_magn-1)*c_magn');
model.variable('var1').descr('mur_ore', 'Model for the relative permittivity of ore');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'magnetic_prospecting.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('elp1', 'Ellipsoid');
model.geom('geom1').feature('elp1').set('semiaxes', [1000 200 50]);
model.geom('geom1').feature('elp1').set('pos', [2500 1500 200]);
model.geom('geom1').runPre('fin');

model.view('view1').set('transparency', true);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').label('Background Material');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([3]);
model.material('mat2').propertyGroup('def').set('relpermeability', {'mur_ore'});
model.material('mat2').label('Ore');

model.physics('mfnc').create('mfc2', 'MagneticFluxConservation', 3);
model.physics('mfnc').feature('mfc2').selection.set([3]);
model.physics('mfnc').feature('mfc2').set('ConstitutiveRelationBH', 'RemanentFluxDensity');
model.physics('mfnc').feature('mfc2').set('normBr_crel_BH_RemanentFluxDensity_mat', 'userdef');
model.physics('mfnc').feature('mfc2').set('normBr_crel_BH_RemanentFluxDensity', 'Br');
model.physics('mfnc').feature('mfc2').set('e_crel_BH_RemanentFluxDensity', {'Gx' 'Gy' 'Gz'});
model.physics('mfnc').prop('BackgroundField').set('SolveFor', 'ReducedField');
model.physics('mfnc').prop('BackgroundField').set('Hb', {'H0*Gx' 'H0*Gy' 'H0*Gz'});
model.physics('mfnc').create('exfd1', 'ExternalMagneticFluxDensity', 2);
model.physics('mfnc').feature('exfd1').selection.set([1 2 3 4 5 7 8 9 18 19]);
model.physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.physics('mfnc').feature('zsp1').selection.set([7]);

model.study('std1').setGenPlots(false);

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
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('dset2', 'Solution');
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.set([6]);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('data', 'dset2');
model.result('pg1').feature('surf1').set('expr', 'mfnc.normredH');
model.result('pg1').feature('surf1').set('descr', 'Reduced magnetic field norm');
model.result('pg1').feature('surf1').set('expr', 'down(mfnc.normredH)');
model.result('pg1').feature('surf1').set('descractive', true);
model.result('pg1').feature('surf1').set('descr', 'Reduced magnetic field norm (downside)');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('slc1', 'Slice');
model.result('pg1').feature('slc1').set('quickplane', 'xy');
model.result('pg1').feature('slc1').set('quickzmethod', 'coord');
model.result('pg1').feature('slc1').set('quickz', 1300);
model.result('pg1').feature('slc1').set('expr', 'mfnc.normredH');
model.result('pg1').feature('slc1').set('descr', 'Reduced magnetic field norm');
model.result('pg1').feature('slc1').set('colortable', 'GrayBody');
model.result('pg1').run;

model.view('view1').set('transparency', false);

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').run;
model.result('pg2').set('data', 'dset2');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', '0');
model.result('pg2').feature('surf1').set('coloring', 'uniform');
model.result('pg2').feature('surf1').set('color', 'gray');
model.result('pg2').run;
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'mfnc.redHx' 'mfnc.redHy' 'mfnc.redHz'});
model.result('pg2').feature('arws1').set('descr', 'Reduced magnetic field');
model.result('pg2').feature('arws1').set('arrowcount', 2000);
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').create('slc1', 'Slice');
model.result('pg3').feature('slc1').set('quickplane', 'xy');
model.result('pg3').feature('slc1').set('quickzmethod', 'coord');
model.result('pg3').feature('slc1').set('quickz', 200);
model.result('pg3').feature('slc1').set('expr', 'mfnc.normBr/(mu0_const*mfnc.normM)');
model.result('pg3').run;
model.result('pg1').run;

model.title('Magnetic Prospecting of Iron Ore Deposits');

model.description('Magnetic prospecting is a method for geological exploration of iron ore deposits. Passive magnetic prospecting relies on accurate mapping of local geomagnetic anomalies. This example estimates the magnetic anomaly for both surface and aerial prospecting by solving for the induced magnetization in the iron ore due to the earth''s magnetic field.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('magnetic_prospecting.mph');

model.modelNode.label('Components');

out = model;
