function out = model
%
% vertical_cavity_surface_emitting_laser.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd').model('comp1');
model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd2').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('linpsolnum', 'auto');
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/ewfd', true);
model.study('std1').feature('eig').setSolveFor('/physics/ewfd2', true);

model.geom('geom1').insertFile('vertical_cavity_surface_emitting_laser_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.param.label('Geometry Parameters');
model.param.create('par2');
model.param('par2').label('General Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('lda0', '980.35[nm]', 'Wavelength');
model.param('par2').set('k0', '2*pi/lda0', 'Vacuum wave number');
model.param('par2').set('f0', 'c_const/lda0', 'Frequency');
model.param('par2').set('gain_QW', '1200[1/cm]', 'Quantum well gain');
model.param.create('par3');
model.param('par3').label('Material Parameters');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('n_GaAs', '3.53', 'Refractive index, GaAs');
model.param('par3').set('n_AlGaAs', '3.08', 'Refractive index, AlGaAs');
model.param('par3').set('n_AlOx', '1.60', 'Refractive index, AlOx');
model.param('par3').set('n_AlAs', '2.95', 'Refractive index, AlAs');
model.param('par3').set('n_air', '1', 'Refractive index, air');
model.param('par3').set('kappa_QW_gain', '-gain_QW/k0/2', 'Refractive index, quantum well, gain domain, imaginary part');
model.param('par3').set('kappa_QW_loss', '0.01', 'Refractive index, quantum well, loss domain, imaginary part');
model.param('par3').set('n_QW', 'n_GaAs', 'Refractive index, quantum well');

model.physics('ewfd').prop('outofplanewavenumber').set('mFloquet', 1);
model.physics('ewfd').create('sctr1', 'Scattering', 1);
model.physics('ewfd').feature('sctr1').selection.set([236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349]);
model.physics('ewfd').feature('sctr1').set('WaveType', 'CylindricalWave');
model.physics('ewfd').create('imp1', 'Impedance', 1);
model.physics('ewfd').feature('imp1').selection.set([2 229]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air Superstrate');
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.set([229]);
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n_air'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('GaAs');
model.material('mat2').selection.named('geom1_csel2_dom');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n_GaAs'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.duplicate('mat3', 'mat2');
model.material('mat3').label('AlGaAs');
model.material('mat3').selection.named('geom1_csel1_dom');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'n_AlGaAs'});
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.duplicate('mat4', 'mat3');
model.material('mat4').label('QW Gain');
model.material('mat4').selection.named('geom1_csel3_dom');
model.material('mat4').propertyGroup('RefractiveIndex').set('n', {'n_QW'});
model.material('mat4').propertyGroup('RefractiveIndex').set('ki', {'kappa_QW'});
model.material.duplicate('mat5', 'mat4');
model.material('mat5').label('QW Loss');
model.material('mat5').selection.named('geom1_csel4_dom');
model.material('mat5').propertyGroup('RefractiveIndex').set('n', {'n_QW'});
model.material('mat5').propertyGroup('RefractiveIndex').set('ki', {'kappa_QW_loss'});
model.material.duplicate('mat6', 'mat3');
model.material('mat6').label('AlAs');
model.material('mat6').selection.named('geom1_csel5_dom');
model.material('mat6').propertyGroup('RefractiveIndex').set('n', {'n_AlAs'});
model.material('mat6').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.duplicate('mat7', 'mat6');
model.material('mat7').label('AlOx');
model.material('mat7').selection.named('geom1_csel6_dom');
model.material('mat7').propertyGroup('RefractiveIndex').set('n', {'n_AlOx'});
model.material('mat7').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.duplicate('mat8', 'mat1');
model.material('mat8').label('GaAs Substrate');
model.material('mat8').selection.set([2]);
model.material('mat8').propertyGroup('RefractiveIndex').set('n', {'n_GaAs'});
model.material('mat8').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('kappa_QW', 'kappa_QW_gain');
model.variable('var1').descr('kappa_QW', 'Refractive index, quantum well, gain domain, imaginary part');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hauto', 8);
model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').label('GaAs');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('geom1_csel2_dom');
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', 'lda0/6/n_GaAs');
model.mesh('mesh1').feature.duplicate('size2', 'size1');
model.mesh('mesh1').feature('size2').label('AlGaAs');
model.mesh('mesh1').feature('size2').selection.named('geom1_csel1_dom');
model.mesh('mesh1').feature('size2').set('hmax', 'lda0/6/n_AlGaAs');
model.mesh('mesh1').feature.duplicate('size3', 'size2');
model.mesh('mesh1').feature('size3').label('QW Gain');
model.mesh('mesh1').feature('size3').selection.named('geom1_csel3_dom');
model.mesh('mesh1').feature('size3').set('hmax', 'lda0/6/n_QW');
model.mesh('mesh1').feature.duplicate('size4', 'size3');
model.mesh('mesh1').feature('size4').label('QW Loss');
model.mesh('mesh1').feature('size4').selection.named('geom1_csel4_dom');
model.mesh('mesh1').feature.duplicate('size5', 'size4');
model.mesh('mesh1').feature('size5').label('AlAs');
model.mesh('mesh1').feature('size5').selection.named('geom1_csel5_dom');
model.mesh('mesh1').feature('size5').set('hmax', 'lda0/6/n_AlAs');
model.mesh('mesh1').feature.duplicate('size6', 'size5');
model.mesh('mesh1').feature('size6').label('AlOx');
model.mesh('mesh1').feature('size6').selection.named('geom1_csel6_dom');
model.mesh('mesh1').feature('size6').set('hmax', 'lda0/6/n_AlOx');
model.mesh('mesh1').feature.move('ftri1', 7);
model.mesh('mesh1').run;

model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 1);
model.study('std1').feature('eig').set('shift', 'f0');
model.study('std1').feature('eig').set('useadvanceddisable', true);
model.study('std1').feature('eig').setSolveFor('/physics/ewfd2', false);
model.study('std1').feature('eig').set('disabledphysics', {'ewfd2'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigref', 'f0');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('e1').create('d1', 'Direct');
model.sol('sol1').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol1').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd)');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewfd)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Eigenfrequencies (ewfd)');
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('expr', {'ewfd.freq' 'ewfd.Qfactor'});
model.result.numerical('gev1').set('unit', {'THz' '1'});
model.result.table.create('tbl1', 'Table');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').run;
model.result.numerical('gev1').setResult;
model.result('pg1').run;
model.result('pg1').run;
model.result.numerical('gev1').setIndex('expr', 'ewfd.lambda0', 2);
model.result.numerical('gev1').setIndex('unit', 'nm', 2);
model.result.numerical('gev1').setIndex('descr', 'Wavelength in free space', 2);
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').appendResult;

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').label('Point Evaluation');
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([115]);
model.cpl('intop1').set('method', 'summation');

model.physics('ewfd2').prop('EquationForm').setIndex('form', 'Frequency', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq_src', 'userdef', 0);
model.physics('ewfd2').prop('EquationForm').setIndex('freq', 'freq1', 0);
model.physics('ewfd2').prop('outofplanewavenumber').set('mFloquet', 1);
model.physics('ewfd2').feature('init1').set('E2', {'withsol(''sol1'',ewfd.Er)' 'withsol(''sol1'',ewfd.Ephi)' 'withsol(''sol1'',ewfd.Ez)'});
model.physics('ewfd2').feature.copy('sctr1', 'ewfd/sctr1');
model.physics('ewfd2').feature.copy('imp1', 'ewfd/imp1');
model.physics('ewfd2').create('ge1', 'GlobalEquations', -1);
model.physics('ewfd2').feature('ge1').label('Frequency');
model.physics('ewfd2').feature('ge1').setIndex('name', 'freq1', 0, 0);
model.physics('ewfd2').feature('ge1').setIndex('equation', 'intop1(real(withsol(''sol1'',ewfd.Er)))-intop1(real(ewfd2.Er))', 0, 0);
model.physics('ewfd2').feature('ge1').setIndex('initialValueU', 'withsol(''sol1'',ewfd.freq)', 0, 0);
model.physics('ewfd2').feature('ge1').setIndex('description', 'Frequency', 0, 0);
model.physics('ewfd2').feature('ge1').set('valueType', 'real');
model.physics('ewfd2').feature('ge1').set('DependentVariableQuantity', 'frequency');
model.physics('ewfd2').feature('ge1').set('SourceTermQuantity', 'electricfield');
model.physics('ewfd2').feature.duplicate('ge2', 'ge1');
model.physics('ewfd2').feature('ge2').label('Gain');
model.physics('ewfd2').feature('ge2').setIndex('name', 'kappa_QW', 0, 0);
model.physics('ewfd2').feature('ge2').setIndex('equation', 'intop1(imag(withsol(''sol1'',ewfd.Er)))-intop1(imag(ewfd2.Er))', 0, 0);
model.physics('ewfd2').feature('ge2').setIndex('initialValueU', 'kappa_QW_gain', 0, 0);
model.physics('ewfd2').feature('ge2').setIndex('description', 'Refractive index, QW, imaginary part', 0, 0);
model.physics('ewfd2').feature('ge2').set('DependentVariableQuantity', 'dimensionless');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledvariables', {'var1'});
model.study('std2').feature('stat').set('disabledphysics', {'ewfd'});

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.01);
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'mumps');
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (ewfd2)');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('st1').set('splitcomplex', true);
model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Electric Field (ewfd2)');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset2');
model.result('pg2').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev2', 'Revolve2D');
model.result.dataset('rev2').set('data', 'none');
model.result.dataset('rev2').set('startangle', -90);
model.result.dataset('rev2').set('revangle', 225);
model.result.dataset('rev2').set('data', 'dset2');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').create('hght1', 'Height');
model.result('pg2').run;
model.result('pg2').set('showlegends', false);
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('Gain Evaluation (ewfd2)');
model.result.numerical('gev2').set('data', 'dset2');
model.result.numerical('gev2').setIndex('expr', 'freq1', 0);
model.result.numerical('gev2').setIndex('unit', 'THz', 0);
model.result.numerical('gev2').setIndex('descr', 'Frequency', 0);
model.result.numerical('gev2').setIndex('expr', 'c_const/freq1', 1);
model.result.numerical('gev2').setIndex('unit', 'nm', 1);
model.result.numerical('gev2').setIndex('descr', 'Wavelength', 1);
model.result.numerical('gev2').setIndex('expr', 'kappa_QW', 2);
model.result.numerical('gev2').setIndex('unit', 1, 2);
model.result.numerical('gev2').setIndex('descr', 'Refractive index, QW, imaginary part', 2);
model.result.numerical('gev2').setIndex('expr', '-2*kappa_QW*k0', 3);
model.result.numerical('gev2').setIndex('unit', '1/cm', 3);
model.result.numerical('gev2').setIndex('descr', 'Threshold material gain', 3);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Gain Evaluation (ewfd2)');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.named('geom1_csel2_dom');
model.result('pg3').run;
model.result('pg3').feature.duplicate('surf2', 'surf1');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('expr', '2');
model.result('pg3').feature('surf2').set('inheritplot', 'surf1');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('sel1').selection.named('geom1_csel1_dom');
model.result('pg3').run;
model.result('pg3').set('showlegends', false);

model.view('view1').set('showgrid', false);

model.result('pg3').set('titletype', 'none');
model.result('pg3').run;
model.result.remove('pg3');
model.result('pg2').run;

model.param.set('t_GaAs_substrate', '1500[nm]');
model.param.descr('t_GaAs_substrate', 'GaAs substrate');

model.geom('geom1').run('arr2');
model.geom('geom1').create('r11', 'Rectangle');
model.geom('geom1').feature('r11').label('GaAs Substrate');
model.geom('geom1').feature('r11').set('size', {'d_outer/2' 't_GaAs_substrate'});
model.geom('geom1').feature('r11').set('pos', {'0' '-t_GaAs_substrate'});
model.geom('geom1').feature('r11').set('contributeto', 'csel2');
model.geom('geom1').run('r11');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'd_outer');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', {'0' 't_bottom_DBR+t_GaAs_cavity+t_QW/2'});
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat9', 'Common', 'comp1');
model.material('mat9').label('Air domain');
model.material('mat9').selection.set([1]);
model.material('mat9').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat9').propertyGroup('RefractiveIndex').set('n', {'n_air'});

model.physics.create('ewfd3', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd3').model('comp1');

model.study('std1').feature('eig').setSolveFor('/physics/ewfd3', true);
model.study('std2').feature('stat').setSolveFor('/physics/ewfd3', true);

model.physics('ewfd3').prop('outofplanewavenumber').set('mFloquet', 1);
model.physics('ewfd3').create('ffd1', 'FarFieldDomain', 2);
model.physics('ewfd3').feature('ffd1').selection.set([1]);
model.physics('ewfd3').feature('ffd1').feature('ffc1').selection.geom('geom1', 1);
model.physics('ewfd3').feature('ffd1').feature('ffc1').selection.set([356 357]);
model.physics('ewfd3').create('sctr1', 'Scattering', 1);
model.physics('ewfd3').feature('sctr1').selection.set([356 357]);

model.mesh('mesh1').create('size7', 'Size');
model.mesh('mesh1').feature('size7').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size7').selection.set([1]);
model.mesh('mesh1').feature('size7').set('custom', true);
model.mesh('mesh1').feature('size7').set('hmaxactive', true);
model.mesh('mesh1').feature('size7').set('hmax', 'lda0/6');
model.mesh('mesh1').feature.move('size7', 7);
model.mesh('mesh1').run;

model.study.create('std3');
model.study('std3').create('eig', 'Eigenfrequency');
model.study('std3').feature('eig').set('plotgroup', 'Default');
model.study('std3').feature('eig').set('conrad', '1');
model.study('std3').feature('eig').set('conradynhm', '1');
model.study('std3').feature('eig').set('linpsolnum', 'auto');
model.study('std3').feature('eig').set('solnum', 'auto');
model.study('std3').feature('eig').set('notsolnum', 'auto');
model.study('std3').feature('eig').set('outputmap', {});
model.study('std3').feature('eig').set('ngenAUX', '1');
model.study('std3').feature('eig').set('goalngenAUX', '1');
model.study('std3').feature('eig').set('ngenAUX', '1');
model.study('std3').feature('eig').set('goalngenAUX', '1');
model.study('std3').feature('eig').setSolveFor('/physics/ewfd', true);
model.study('std3').feature('eig').setSolveFor('/physics/ewfd2', true);
model.study('std3').feature('eig').setSolveFor('/physics/ewfd3', true);
model.study('std3').feature('eig').set('neigsactive', true);
model.study('std3').feature('eig').set('neigs', 1);
model.study('std3').feature('eig').set('shift', 'f0');
model.study('std3').feature('eig').set('useadvanceddisable', true);
model.study('std3').feature('eig').setSolveFor('/physics/ewfd', false);
model.study('std3').feature('eig').set('disabledphysics', {'ewfd'});
model.study('std3').feature('eig').setSolveFor('/physics/ewfd2', false);
model.study('std3').feature('eig').set('disabledphysics', {'ewfd' 'ewfd2'});

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'eig');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'eig');
model.sol('sol3').create('e1', 'Eigenvalue');
model.sol('sol3').feature('e1').set('eigref', 'f0');
model.sol('sol3').feature('e1').set('control', 'eig');
model.sol('sol3').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol3').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol3').feature('e1').create('d1', 'Direct');
model.sol('sol3').feature('e1').feature('d1').set('linsolver', 'mumps');
model.sol('sol3').feature('e1').feature('d1').label('Suggested Direct Solver (ewfd3)');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Field (ewfd3)');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('data', 'dset3');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'ElectromagneticWavesFrequencyDomain/phys1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result.dataset.create('rev3', 'Revolve2D');
model.result.dataset('rev3').set('data', 'none');
model.result.dataset('rev3').set('startangle', -90);
model.result.dataset('rev3').set('revangle', 225);
model.result.dataset('rev3').set('data', 'dset3');
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical('gev3').label('Eigenfrequencies (ewfd3)');
model.result.numerical('gev3').set('data', 'dset3');
model.result.numerical('gev3').set('expr', {'ewfd3.freq' 'ewfd3.Qfactor'});
model.result.numerical('gev3').set('unit', {'THz' '1'});
model.result.table.create('tbl3', 'Table');
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').run;
model.result.numerical('gev3').setResult;
model.result.create('pg4', 'PolarGroup');
model.result('pg4').label('2D Far Field (ewfd3)');
model.result('pg4').set('data', 'dset3');
model.result('pg4').create('rp1', 'RadiationPattern');
model.result('pg4').feature('rp1').set('legend', 'on');
model.result('pg4').feature('rp1').set('phidisc', '180');
model.result('pg4').feature('rp1').set('expr', {'ewfd3.normEfar'});
model.result('pg4').feature('rp1').create('exp1', 'Export');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('3D Far Field (ewfd3)');
model.result('pg5').set('data', 'none');
model.result('pg5').set('view', 'new');
model.result('pg5').set('edges', 'off');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').create('rp1', 'RadiationPattern');
model.result('pg5').feature('rp1').set('data', 'dset3');
model.result('pg5').feature('rp1').set('expr', {'ewfd3.normEfar'});
model.result('pg5').feature('rp1').set('colorexpr', {'ewfd3.normEfar'});
model.result('pg5').feature('rp1').set('useradiusascolor', true);
model.result('pg5').feature('rp1').set('directivityexpr', {'ewfd3.normEfar^2'});
model.result('pg5').feature('rp1').set('thetadisc', '180');
model.result('pg5').feature('rp1').set('phidisc', '45');
model.result('pg5').feature('rp1').set('directivity', 'on');
model.result('pg5').feature('rp1').set('colortable', 'RainbowLight');
model.result('pg5').feature('rp1').create('exp1', 'Export');
model.result('pg5').feature('rp1').feature('exp1').setIndex('expr', 'comp1.ewfd3.theta', 0);
model.result('pg4').feature('rp1').feature('exp1').setIndex('expr', 'comp1.ewfd3.theta', 0);
model.result('pg3').run;
model.result.numerical('gev3').setIndex('expr', 'ewfd3.lambda0', 2);
model.result.numerical('gev3').setIndex('unit', 'nm', 2);
model.result.numerical('gev3').setIndex('descr', 'Wavelength in free space', 2);
model.result.numerical('gev3').set('table', 'tbl3');
model.result.numerical('gev3').appendResult;
model.result('pg3').run;
model.result('pg3').set('edges', false);
model.result('pg3').run;
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.set([2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118]);
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevelinput', 'first', 0);
model.result('pg4').run;
model.result('pg4').feature('rp1').set('phidisc', 540);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').feature('rp1').set('thetadisc', 540);
model.result('pg5').run;

model.physics.create('ewfd4', 'ElectromagneticWavesFrequencyDomain', 'geom1');
model.physics('ewfd4').model('comp1');

model.study('std1').feature('eig').setSolveFor('/physics/ewfd4', true);
model.study('std2').feature('stat').setSolveFor('/physics/ewfd4', true);
model.study('std3').feature('eig').setSolveFor('/physics/ewfd4', true);

model.physics('ewfd4').prop('outofplanewavenumber').set('mFloquet', 1);
model.physics('ewfd4').feature('init1').set('E4', {'withsol(''sol3'',ewfd3.Er)' 'withsol(''sol3'',ewfd3.Er)' 'withsol(''sol3'',ewfd3.Er)'});
model.physics('ewfd4').create('ge1', 'GlobalEquations', -1);
model.physics('ewfd4').feature('ge1').label('Frequency');
model.physics('ewfd4').feature('ge1').setIndex('name', 'freq2', 0, 0);
model.physics('ewfd4').feature('ge1').setIndex('equation', 'intop1(real(withsol(''sol3'',ewfd3.Er)))-intop1(real(ewfd4.Er))', 0, 0);
model.physics('ewfd4').feature('ge1').setIndex('initialValueU', 'withsol(''sol3'',ewfd3.freq)', 0, 0);
model.physics('ewfd4').feature('ge1').setIndex('description', 'Frequency', 0, 0);
model.physics('ewfd4').feature('ge1').set('valueType', 'real');
model.physics('ewfd4').feature('ge1').set('DependentVariableQuantity', 'frequency');
model.physics('ewfd4').feature('ge1').set('SourceTermQuantity', 'electricfield');
model.physics('ewfd4').create('ge2', 'GlobalEquations', -1);
model.physics('ewfd4').feature('ge2').label('Gain');
model.physics('ewfd4').feature('ge2').setIndex('name', 'kappa_QW2', 0, 0);
model.physics('ewfd4').feature('ge2').setIndex('equation', 'intop1(imag(withsol(''sol3'',ewfd3.Er)))-intop1(imag(ewfd4.Er))', 0, 0);
model.physics('ewfd4').feature('ge2').setIndex('initialValueU', 'kappa_QW_gain', 0, 0);
model.physics('ewfd4').feature('ge2').setIndex('description', 'Refractive index, QW, imaginary part', 0, 0);

model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').set('useadvanceddisable', true);
model.study('std4').feature('stat').set('disabledphysics', {'ewfd'});
model.study('std4').feature('stat').setSolveFor('/physics/ewfd2', false);
model.study('std4').feature('stat').set('disabledphysics', {'ewfd' 'ewfd2' 'ewfd3'});

model.sol.create('sol4');
model.sol('sol4').study('std4');
model.sol('sol4').create('st1', 'StudyStep');
model.sol('sol4').feature('st1').set('study', 'std4');
model.sol('sol4').feature('st1').set('studystep', 'stat');
model.sol('sol4').create('v1', 'Variables');
model.sol('sol4').feature('v1').set('control', 'stat');
model.sol('sol4').create('s1', 'Stationary');
model.sol('sol4').attach('std4');
model.sol('sol4').runAll;

model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Electric Field (ewfd4)');
model.result('pg6').set('data', 'dset4');
model.result('pg6').set('edges', false);
model.result('pg6').set('showlegends', false);
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').create('sel1', 'Selection');
model.result('pg6').feature('surf1').feature('sel1').selection.set([2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118]);
model.result('pg6').run;
model.result('pg6').feature('surf1').create('hght1', 'Height');
model.result('pg6').run;
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical('gev4').label('Gain Evaluation (ewfd4)');
model.result.numerical('gev4').set('data', 'dset4');
model.result.numerical('gev4').setIndex('expr', 'freq2', 0);
model.result.numerical('gev4').setIndex('unit', 'THz', 0);
model.result.numerical('gev4').setIndex('descr', 'Frequency', 0);
model.result.numerical('gev4').setIndex('expr', 'c_const/freq2', 1);
model.result.numerical('gev4').setIndex('unit', 'nm', 1);
model.result.numerical('gev4').setIndex('descr', 'Wavelength', 1);
model.result.numerical('gev4').setIndex('expr', 'kappa_QW2', 2);
model.result.numerical('gev4').setIndex('unit', 1, 2);
model.result.numerical('gev4').setIndex('descr', 'Refractive index, QW, imaginary part', 2);
model.result.numerical('gev4').setIndex('expr', '-2*kappa_QW2*k0', 3);
model.result.numerical('gev4').setIndex('unit', '1/cm', 3);
model.result.numerical('gev4').setIndex('descr', 'Threshold material gain', 3);
model.result.table.create('tbl4', 'Table');
model.result.table('tbl4').comments('Gain Evaluation (ewfd4)');
model.result.numerical('gev4').set('table', 'tbl4');
model.result.numerical('gev4').setResult;

model.physics('ewfd').selection.set([3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118]);
model.physics('ewfd2').selection.set([3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118]);

model.study('std1').feature('eig').setSolveFor('/physics/ewfd3', false);
model.study('std1').feature('eig').set('disabledphysics', {'ewfd2' 'ewfd3'});
model.study('std1').feature('eig').setSolveFor('/physics/ewfd4', false);
model.study('std1').feature('eig').set('disabledphysics', {'ewfd2' 'ewfd3' 'ewfd4'});
model.study('std2').feature('stat').set('disabledphysics', {'ewfd' 'ewfd3' 'ewfd4'});
model.study('std3').feature('eig').setSolveFor('/physics/ewfd4', false);
model.study('std3').feature('eig').set('disabledphysics', {'ewfd' 'ewfd2' 'ewfd4'});

model.title('Threshold Gain Calculations for Vertical-Cavity Surface-Emitting Lasers (VCSELs)');

model.description(['An eigenfrequency study is used to find the resonance frequency and threshold gain for an oxide-confined, GaAs-based, vertical-cavity surface-emitting laser (VCSEL).' newline  newline 'The simulations are performed in two steps. A regular eigenfrequency analysis is first performed, to find good initial values for the subsequent nonlinear eigenfrequency analysis.' newline  newline 'The resonance frequencies and threshold gain, calculated for different device geometries, compare well to values from a paper collecting the results from different computational methods on this benchmark problem.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('vertical_cavity_surface_emitting_laser.mph');

model.modelNode.label('Components');

out = model;
