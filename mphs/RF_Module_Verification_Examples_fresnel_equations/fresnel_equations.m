function out = model
%
% fresnel_equations.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/emw', true);

model.param.set('n_air', '1');
model.param.descr('n_air', 'Refractive index, air');
model.param.set('n_slab', '1.5');
model.param.descr('n_slab', 'Refractive index, slab');
model.param.set('lda0', '1[m]');
model.param.descr('lda0', 'Wavelength');
model.param.set('f0', 'c_const/lda0');
model.param.descr('f0', 'Frequency');
model.param.set('alpha', '70[deg]');
model.param.descr('alpha', 'Angle of incidence');
model.param.set('beta', 'asin(n_air*sin(alpha)/n_slab)');
model.param.descr('beta', 'Refraction angle');
model.param.set('alpha_brewster', 'atan(n_slab/n_air)');
model.param.descr('alpha_brewster', 'Brewster angle, TM only');
model.param.set('r_s', '(n_air*cos(alpha)-n_slab*cos(beta))/(n_air*cos(alpha)+n_slab*cos(beta))');
model.param.descr('r_s', 'Reflection coefficient, TE');
model.param.set('r_p', '(n_slab*cos(alpha)-n_air*cos(beta))/(n_air*cos(beta)+n_slab*cos(alpha))');
model.param.descr('r_p', 'Reflection coefficient, TM');
model.param.set('t_s', '(2*n_air*cos(alpha))/(n_air*cos(alpha)+n_slab*cos(beta))');
model.param.descr('t_s', 'Transmission coefficient, TE');
model.param.set('t_p', '(2*n_air*cos(alpha))/(n_air*cos(beta)+n_slab*cos(alpha))');
model.param.descr('t_p', 'Transmission coefficient, TM');

model.study('std1').label('Study 1 (TE)');

model.geom('geom1').run;

model.study('std1').feature('freq').set('plist', 'f0');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [0.2 0.2 0.8]);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk1').setIndex('layer', 0.4, 0);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run;

model.physics('emw').feature('wee1').set('DisplacementFieldModel', 'RefractiveIndex');
model.physics('emw').label('Electromagnetic Waves, Frequency Domain (TE)');
model.physics('emw').create('port1', 'Port', 2);
model.physics('emw').feature('port1').selection.set([7]);
model.physics('emw').feature('port1').set('PortType', 'Periodic');
model.physics('emw').feature('port1').set('Eampl', [0 1 0]);
model.physics('emw').feature('port1').set('n', {'n_air' '0' '0' '0' 'n_air' '0' '0' '0' 'n_air'});
model.physics('emw').feature('port1').set('alpha1_inc', 'alpha');
model.physics('emw').create('port2', 'Port', 2);
model.physics('emw').feature('port2').selection.set([3]);
model.physics('emw').feature('port2').set('PortType', 'Periodic');
model.physics('emw').feature('port2').set('Eampl', [0 1 0]);
model.physics('emw').feature('port2').set('n', {'n_slab' '0' '0' '0' 'n_slab' '0' '0' '0' 'n_slab'});
model.physics('emw').create('pc1', 'PeriodicCondition', 2);
model.physics('emw').feature('pc1').selection.set([1 4 10 11]);
model.physics('emw').feature('pc1').set('PeriodicType', 'Floquet');
model.physics('emw').feature('pc1').set('Floquet_source', 'FromPeriodicPort');
model.physics('emw').create('pc2', 'PeriodicCondition', 2);
model.physics('emw').feature('pc2').selection.set([2 5 8 9]);
model.physics('emw').feature('pc2').set('PeriodicType', 'Floquet');
model.physics('emw').feature('pc2').set('Floquet_source', 'FromPeriodicPort');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').selection.set([2]);
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n_air'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Glass');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'n_slab'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'n_air', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'n_air', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'alpha', 0);
model.study('std1').feature('param').setIndex('plistarr', 'range(0,2[deg],88[deg])', 0);
model.study('std1').feature('param').setIndex('punit', 'deg', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'alpha'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(0,2[deg],88[deg])'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'deg'});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', '300');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankasolv', {'stored'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankarelax', 0.95);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 45, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg1').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' ''});
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB' 'emw.S21dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S21'});
model.result('pg2').label('S-parameter (emw)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'S-parameter (dB)');
model.result('pg2').feature('glob1').set('xdataexpr', 'alpha');
model.result('pg2').feature('glob1').set('xdataunit', 'deg');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg3', 'SmithGroup');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('rgr1', 'ReflectionGraph');
model.result('pg3').feature('rgr1').set('unit', {''});
model.result('pg3').feature('rgr1').set('expr', {'emw.S11'});
model.result('pg3').feature('rgr1').set('descr', {'S11'});
model.result('pg3').label('Smith Plot (emw)');
model.result('pg3').feature('rgr1').set('titletype', 'manual');
model.result('pg3').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg3').feature('rgr1').set('linemarker', 'point');
model.result('pg3').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('rgr1').create('col1', 'Color');
model.result('pg3').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg3').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').label('Polarization Plot (emw)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Polarization states, Color: Phase (Radians)');
model.result('pg4').setIndex('looplevelinput', 'manual', 0);
model.result('pg4').setIndex('looplevel', '1', 0);
model.result('pg4').create('plz1', 'Polarization');
model.result('pg4').feature('plz1').set('linestyle', 'solid');
model.result('pg4').feature('plz1').set('linewidth', 2);
model.result('pg4').feature('plz1').set('display', '0');
model.result('pg4').feature('plz1').create('col1', 'Color');
model.result('pg4').feature('plz1').feature('col1').set('colortable', 'Cyclic');
model.result('pg4').feature('plz1').feature('col1').set('colorlegend', true);
model.result('pg4').feature('plz1').set('legend', true);
model.result('pg4').feature('plz1').set('legendmethod', 'manual');
model.result('pg4').feature('plz1').setIndex('legends', 'Reflection', 0);
model.result('pg4').create('plz2', 'Polarization');
model.result('pg4').feature('plz2').set('linestyle', 'dashed');
model.result('pg4').feature('plz2').set('linewidth', 2);
model.result('pg4').feature('plz2').set('display', '1');
model.result('pg4').feature('plz2').create('col1', 'Color');
model.result('pg4').feature('plz2').feature('col1').set('colortable', 'Cyclic');
model.result('pg4').feature('plz2').feature('col1').set('colorlegend', false);
model.result('pg4').feature('plz2').set('legend', true);
model.result('pg4').feature('plz2').set('legendmethod', 'manual');
model.result('pg4').feature('plz2').setIndex('legends', 'Transmission', 0);
model.result('pg1').run;
model.result('pg1').label('Electric Field (emw, TE)');
model.result('pg1').run;
model.result('pg1').feature('mslc1').set('expr', 'emw.Ey');
model.result('pg1').feature('mslc1').set('descr', 'Electric field, y-component');
model.result('pg1').feature('mslc1').set('xnumber', '0');
model.result('pg1').feature('mslc1').set('znumber', '0');
model.result('pg1').feature('mslc1').set('colortable', 'WaveLight');
model.result('pg1').run;
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'emw.Poavx' 'emw.Poavy' 'emw.Poavz'});
model.result('pg1').feature('arwv1').set('descr', 'Power flow, time average');
model.result('pg1').feature('arwv1').set('ynumber', 1);
model.result('pg1').feature('arwv1').set('color', 'green');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 36, 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('S-Parameter (emw, TE)');
model.result('pg2').set('titletype', 'none');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('ylabel', 'S-parameter');
model.result('pg2').set('legendpos', 'middleleft');
model.result('pg2').run;
model.result('pg2').feature('glob1').setIndex('expr', 'abs(emw.S11)^2', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Reflectance', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'abs(emw.S21)^2', 1);
model.result('pg2').feature('glob1').setIndex('unit', 1, 1);
model.result('pg2').feature('glob1').setIndex('descr', 'Transmittance', 1);
model.result('pg2').run;
model.result('pg2').feature('glob1').set('linestyle', 'none');
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').feature('glob1').set('markerpos', 'interp');
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').feature('glob2').setIndex('expr', 'abs(r_s)^2', 0);
model.result('pg2').feature('glob2').setIndex('unit', '', 0);
model.result('pg2').feature('glob2').setIndex('descr', 'Reflectance, analytic', 0);
model.result('pg2').feature('glob2').setIndex('expr', 'n_slab*cos(beta)/(n_air*cos(alpha))*abs(t_s)^2', 1);
model.result('pg2').feature('glob2').setIndex('unit', '', 1);
model.result('pg2').feature('glob2').setIndex('descr', 'Transmittance, analytic', 1);
model.result('pg2').feature('glob2').set('xdataparamunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').label('Smith Plot (emw, TE)');
model.result('pg3').run;
model.result('pg3').feature('rgr1').feature('col1').set('expr', 'alpha');
model.result('pg3').feature('rgr1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg3').run;
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Reflection Graph: S-parameter, Color: Angle of incidence (deg)');
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').label('Polarization Plot (emw, TE)');
model.result('pg4').run;

model.physics.copy('emw2', 'emw', 'comp1');
model.physics('emw2').label('Electromagnetic Waves, Frequency Domain (TM)');

model.study('std1').feature('freq').setEntry('activate', 'emw', true);
model.study('std1').feature('freq').setEntry('activate', 'emw2', false);

model.physics('emw2').feature('port1').set('InputType', 'H');
model.physics('emw2').feature('port1').set('Hampl', [0 1 0]);
model.physics('emw2').feature('port2').set('InputType', 'H');
model.physics('emw2').feature('port2').set('Hampl', [0 1 0]);

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');
model.study('std2').feature('freq').set('plotgroup', 'Default');
model.study('std2').feature('freq').set('solnum', 'auto');
model.study('std2').feature('freq').set('notsolnum', 'auto');
model.study('std2').feature('freq').set('outputmap', {});
model.study('std2').feature('freq').set('ngenAUX', '1');
model.study('std2').feature('freq').set('goalngenAUX', '1');
model.study('std2').feature('freq').set('ngenAUX', '1');
model.study('std2').feature('freq').set('goalngenAUX', '1');
model.study('std2').feature('freq').setSolveFor('/physics/emw', true);
model.study('std2').feature('freq').setSolveFor('/physics/emw2', true);
model.study('std2').feature('freq').set('plist', 'f0');
model.study('std2').feature('freq').setEntry('activate', 'emw', false);
model.study('std2').feature('freq').setEntry('activate', 'emw2', true);
model.study('std2').label('Study 2 (TM)');
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'n_air', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);
model.study('std2').feature('param').setIndex('pname', 'n_air', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', '', 0);
model.study('std2').feature('param').setIndex('pname', 'alpha', 0);
model.study('std2').feature('param').setIndex('plistarr', 'range(0,2[deg],88[deg])', 0);
model.study('std2').feature('param').setIndex('punit', 'deg', 0);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.01);
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'alpha'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'range(0,2[deg],88[deg])'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'deg'});
model.sol('sol2').feature('s1').feature('p1').set('sweeptype', 'sparse');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'param');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').label('Suggested Direct Solver (emw2)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', '300');
model.sol('sol2').feature('s1').feature('i1').label('Suggested Iterative Solver (emw2)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('va1', 'Vanka');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankavars', {'comp1_E2'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankasolv', {'stored'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('va1').set('vankarelax', 0.95);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E2'});
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 1);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 0.5);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Electric Field (emw2)');
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 45, 0);
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 45, 0);
model.result('pg5').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg5').feature.create('mslc1', 'Multislice');
model.result('pg5').feature('mslc1').label('Multislice');
model.result('pg5').feature('mslc1').set('expr', 'emw2.normE');
model.result('pg5').feature('mslc1').set('smooth', 'internal');
model.result('pg5').feature('mslc1').set('data', 'parent');
model.result('pg5').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg5').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('unit', {'' ''});
model.result('pg6').feature('glob1').set('expr', {'emw2.S11dB' 'emw2.S21dB'});
model.result('pg6').feature('glob1').set('descr', {'S11' 'S21'});
model.result('pg6').label('S-parameter (emw2)');
model.result('pg6').feature('glob1').set('titletype', 'none');
model.result('pg6').feature('glob1').set('xdata', 'expr');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'S-parameter (dB)');
model.result('pg6').feature('glob1').set('xdataexpr', 'alpha');
model.result('pg6').feature('glob1').set('xdataunit', 'deg');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('xdatasolnumtype', 'all');
model.result.create('pg7', 'SmithGroup');
model.result('pg7').set('data', 'dset2');
model.result('pg7').create('rgr1', 'ReflectionGraph');
model.result('pg7').feature('rgr1').set('unit', {''});
model.result('pg7').feature('rgr1').set('expr', {'emw2.S11'});
model.result('pg7').feature('rgr1').set('descr', {'S11'});
model.result('pg7').label('Smith Plot (emw2)');
model.result('pg7').feature('rgr1').set('titletype', 'manual');
model.result('pg7').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg7').feature('rgr1').set('linemarker', 'point');
model.result('pg7').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg7').feature('rgr1').create('col1', 'Color');
model.result('pg7').feature('rgr1').feature('col1').set('expr', 'emw2.freq/1e9');
model.result('pg7').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').label('Polarization Plot (emw2)');
model.result('pg8').set('data', 'dset2');
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Polarization states, Color: Phase (Radians)');
model.result('pg8').setIndex('looplevelinput', 'manual', 0);
model.result('pg8').setIndex('looplevel', '1', 0);
model.result('pg8').create('plz1', 'Polarization');
model.result('pg8').feature('plz1').set('linestyle', 'solid');
model.result('pg8').feature('plz1').set('linewidth', 2);
model.result('pg8').feature('plz1').set('display', '2');
model.result('pg8').feature('plz1').create('col1', 'Color');
model.result('pg8').feature('plz1').feature('col1').set('colortable', 'Cyclic');
model.result('pg8').feature('plz1').feature('col1').set('colorlegend', true);
model.result('pg8').feature('plz1').set('legend', true);
model.result('pg8').feature('plz1').set('legendmethod', 'manual');
model.result('pg8').feature('plz1').setIndex('legends', 'Reflection', 0);
model.result('pg8').create('plz2', 'Polarization');
model.result('pg8').feature('plz2').set('linestyle', 'dashed');
model.result('pg8').feature('plz2').set('linewidth', 2);
model.result('pg8').feature('plz2').set('display', '3');
model.result('pg8').feature('plz2').create('col1', 'Color');
model.result('pg8').feature('plz2').feature('col1').set('colortable', 'Cyclic');
model.result('pg8').feature('plz2').feature('col1').set('colorlegend', false);
model.result('pg8').feature('plz2').set('legend', true);
model.result('pg8').feature('plz2').set('legendmethod', 'manual');
model.result('pg8').feature('plz2').setIndex('legends', 'Transmission', 0);
model.result('pg5').run;
model.result('pg5').label('Magnetic Field (emw2, TM)');
model.result('pg5').run;
model.result('pg5').feature('mslc1').set('expr', 'emw2.Hy');
model.result('pg5').feature('mslc1').set('xnumber', '0');
model.result('pg5').feature('mslc1').set('znumber', '0');
model.result('pg5').feature('mslc1').set('colortable', 'WaveLight');
model.result('pg5').run;
model.result('pg5').create('arwv1', 'ArrowVolume');
model.result('pg5').feature('arwv1').setIndex('expr', 'emw2.Poavx', 0);
model.result('pg5').feature('arwv1').setIndex('expr', 'emw2.Poavy', 1);
model.result('pg5').feature('arwv1').setIndex('expr', 'emw2.Poavz', 2);
model.result('pg5').feature('arwv1').set('ynumber', 1);
model.result('pg5').feature('arwv1').set('color', 'green');
model.result('pg5').run;
model.result('pg6').run;
model.result('pg6').label('S-Parameter (emw2, TM)');
model.result('pg6').set('titletype', 'none');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('ylabel', 'S-parameter');
model.result('pg6').set('legendpos', 'middleleft');
model.result('pg6').run;
model.result('pg6').feature('glob1').setIndex('expr', 'abs(emw2.S11)^2', 0);
model.result('pg6').feature('glob1').setIndex('unit', 1, 0);
model.result('pg6').feature('glob1').setIndex('descr', 'Reflectance', 0);
model.result('pg6').feature('glob1').setIndex('expr', 'abs(emw2.S21)^2', 1);
model.result('pg6').feature('glob1').setIndex('unit', 1, 1);
model.result('pg6').feature('glob1').setIndex('descr', 'Transmittance', 1);
model.result('pg6').feature('glob1').set('linestyle', 'none');
model.result('pg6').feature('glob1').set('linemarker', 'cycle');
model.result('pg6').feature('glob1').set('markerpos', 'interp');
model.result('pg6').run;
model.result('pg6').create('glob2', 'Global');
model.result('pg6').feature('glob2').set('markerpos', 'datapoints');
model.result('pg6').feature('glob2').set('linewidth', 'preference');
model.result('pg6').feature('glob2').setIndex('expr', 'abs(r_p)^2', 0);
model.result('pg6').feature('glob2').setIndex('unit', '', 0);
model.result('pg6').feature('glob2').setIndex('descr', 'Reflectance, analytic', 0);
model.result('pg6').feature('glob2').setIndex('expr', 'n_slab*cos(beta)/(n_air*cos(alpha))*abs(t_p)^2', 1);
model.result('pg6').feature('glob2').setIndex('unit', '', 1);
model.result('pg6').feature('glob2').setIndex('descr', 'Transmittance, analytic', 1);
model.result('pg6').feature('glob2').set('xdataparamunit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg6').run;
model.result('pg7').run;
model.result('pg7').label('Smith Plot (emw2, TM)');
model.result('pg7').run;
model.result('pg7').feature('rgr1').feature('col1').set('expr', 'alpha');
model.result('pg7').feature('rgr1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b0'}), 'unicode') ]);
model.result('pg7').run;
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Reflection Graph: S-parameter, Color: Angle of incidence (deg)');
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').label('Polarization Plot (emw2, TM)');
model.result('pg8').run;
model.result('pg1').run;

model.title('Fresnel Equations');

model.description('A plane electromagnetic wave propagating through free space is incident at an angle upon an infinite dielectric medium. This example computes the reflection and transmission coefficients and compares the results to those given by the Fresnel equations.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('fresnel_equations.mph');

model.modelNode.label('Components');

out = model;
