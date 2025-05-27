function out = model
%
% graphene_metamaterial_perfect_absorber.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Gratings_and_Metamaterials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewfd', true);

model.param.set('T', '300[K]');
model.param.descr('T', 'Temperature');
model.param.set('Ef', '0.2[eV]');
model.param.descr('Ef', 'Fermi energy');
model.param.set('tau', '1e-13[s]');
model.param.descr('tau', 'Relexation time');
model.param.set('d_eff', '1[nm]');
model.param.descr('d_eff', 'Effective thickness of graphene');
model.param.set('a', '15[um]');
model.param.descr('a', 'Unit cell length');
model.param.set('b', '2[um]');
model.param.descr('b', 'Geometric parameter 1');
model.param.set('d_sub', '17.6[um]');
model.param.descr('d_sub', 'Substrate thickness');
model.param.set('d_domain', '40[um]');
model.param.descr('d_domain', 'Simulation domain height');
model.param.set('w', '12[um]');
model.param.descr('w', 'Geometric parameter 2');
model.param.set('n_bg', '1.53');
model.param.descr('n_bg', 'Substrate refractive index');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').label('H');
model.func('an1').set('funcname', 'H');
model.func('an1').set('expr', 'sinh(hbar_const*x/(k_B_const*T))/(cosh(hbar_const*x/(k_B_const*T))+cosh(Ef/(k_B_const*T)))');
model.func('an1').setIndex('argunit', 'rad/s', 0);
model.func('an1').setIndex('plotargs', '1e16', 0, 2);

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Omega', '1[rad/s]');
model.variable('var1').descr('Omega', 'Variable of integral');
model.variable('var1').set('integral', 'integrate((H(Omega)-H(ewfd.omega/2))/(ewfd.omega^2-4*Omega^2),Omega,0[rad/s],1e16[rad/s])');
model.variable('var1').descr('integral', 'Integral in the interband conductivity equation');
model.variable('var1').set('sigma_intra', '((2*k_B_const*T*e_const^2)/(pi*hbar_const^2))*(log(2*cosh(Ef/(2*k_B_const*T)))*(-j/(ewfd.omega-j/tau)))');
model.variable('var1').descr('sigma_intra', 'Intraband conductivity');
model.variable('var1').set('sigma_inter', '(e_const^2/(4*hbar_const))*(H(ewfd.omega/2)-(j*4*ewfd.omega/pi)*integral)');
model.variable('var1').descr('sigma_inter', 'Interband conductivity');
model.variable('var1').set('sigma', 'sigma_intra+sigma_inter');
model.variable('var1').descr('sigma', 'Total graphene conductivity');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'a/2' 'a/2' 'd_domain'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 'd_sub');
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', 'w/2');
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'b/2' '(a-w)/2'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'0' 'w/2'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'(a-w)/2' 'b/2'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'w/2' '0'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Background');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n_bg'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Graphene');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'sigma/d_eff'});
model.material('mat2').selection.geom('geom1', 2);

model.view('view1').set('renderwireframe', true);

model.material('mat2').selection.set([6 8 10]);

model.physics('ewfd').create('pmc1', 'PerfectMagneticConductor', 2);
model.physics('ewfd').feature('pmc1').selection.set([2 5 9]);
model.physics('ewfd').create('port1', 'Port', 2);
model.physics('ewfd').feature('port1').selection.set([7]);
model.physics('ewfd').feature('port1').set('E0', [1 0 0]);
model.physics('ewfd').feature('port1').set('beta', 'ewfd.k');
model.physics('ewfd').create('trans1', 'TransitionBoundaryCondition', 2);
model.physics('ewfd').feature('trans1').selection.set([6 8 10]);
model.physics('ewfd').feature('trans1').set('DisplacementFieldModel', 'RelativePermittivity');
model.physics('ewfd').feature('trans1').set('epsilonr_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('murbnd_mat', 'userdef');
model.physics('ewfd').feature('trans1').set('d', '2*d_eff');

model.mesh('mesh1').autoMeshSize(1);

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'Ef', 0);
model.study('std1').feature('param').setIndex('plistarr', '0 0.1 0.2 0.5', 0);
model.study('std1').feature('param').setIndex('punit', 'eV', 0);
model.study('std1').feature('freq').set('plist', 'range(0.1,0.1,5)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.001);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(0.1,0.1,5)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'THz'});
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
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (ewfd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'fgmres');
model.sol('sol1').feature('s1').feature('i2').label('Suggested Iterative Solver (ewfd) 2');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'Ef'});
model.batch('p1').set('plistarr', {'0 0.1 0.2 0.5'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 50, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 50, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'ewfd.Rport_1'});
model.result('pg2').feature('glob1').set('descr', {'Reflectance, port 1'});
model.result('pg2').label('Reflectance (ewfd)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Reflectance (1)');
model.result('pg2').feature('glob1').set('xdataexpr', 'freq');
model.result('pg2').feature('glob1').set('xdataunit', 'THz');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Absorptance');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('xlabel', 'Frequency (THz)');
model.result('pg3').set('ylabelactive', true);
model.result('pg3').set('ylabel', 'Absorptance');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Absorptance at different Fermi energies');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'ewfd.Atotal'});
model.result('pg3').feature('glob1').set('descr', {'Absorptance'});
model.result('pg3').feature('glob1').set('unit', {'1'});
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Conductivity');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Frequency (THz)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', '\sigma (S)');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Sheet conductivity at different Fermi energies');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'real(sigma)', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'S', 0);
model.result('pg4').feature('glob1').setIndex('descr', '', 0);
model.result('pg4').run;
model.result('pg4').create('glob2', 'Global');
model.result('pg4').feature('glob2').set('markerpos', 'datapoints');
model.result('pg4').feature('glob2').set('linewidth', 'preference');
model.result('pg4').feature('glob2').setIndex('expr', '-imag(sigma)', 0);
model.result('pg4').feature('glob2').setIndex('unit', 'S', 0);
model.result('pg4').feature('glob2').setIndex('descr', '', 0);
model.result('pg4').feature('glob2').set('linestyle', 'dotted');
model.result('pg4').feature('glob2').set('linecolor', 'cyclereset');
model.result('pg4').run;

model.title('Graphene Metamaterial Perfect Absorber');

model.description('Graphene, carbon atoms arranged in a two-dimensional hexagonal lattice, has sparked tremendous research and application interests since its experimental discovery about two decades ago. Besides being ultra-thin, this magical material exhibits a plethora of interesting properties, including high electrical and thermal conductivities, high elasticity, high mechanical strengthens, and so on. Among various applications, a promising field is graphene-based electro-optical devices, such as photodetectors, photodiodes, and metamaterials. An additional desirable trait of graphene is that its optical response can be actively controlled by changing its Fermi energy via electrical gating. In this model, we first demonstrate how to compute the optical conductivity of graphene using the Kubo formula. The computed conductivity is then used to model a graphene-based THz metamaterial absorber.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('graphene_metamaterial_perfect_absorber.mph');

model.modelNode.label('Components');

out = model;
