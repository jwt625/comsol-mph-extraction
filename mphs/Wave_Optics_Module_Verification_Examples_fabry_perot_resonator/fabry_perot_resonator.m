function out = model
%
% fabry_perot_resonator.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Wave_Optics_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ewbe', 'ElectromagneticWavesBeamEnvelopes', 'geom1');
model.physics('ewbe').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/ewbe', true);

model.param.label('Geometry Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lda0', '1[um]', 'Wavelength');
model.param.set('f0', 'c_const/lda0', 'Frequency');
model.param.set('h_cav', '2[mm]', 'Height of domain');
model.param.set('l_in', '5[cm]', 'Length before cavity');
model.param.set('l_out', '5[cm]', 'Length after cavity');
model.param.set('l_total', 'l_cav+l_in+l_out', 'Total length');
model.param.create('par2');
model.param('par2').label('Cavity Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('rho1', '100[mm]', 'Radius of curvature of mirror 1');
model.param('par2').set('rho2', '100[mm]', 'Radius of curvature of mirror 2');
model.param('par2').set('l_cav', '50[mm]', 'Cavity length');
model.param('par2').set('g1', '1-l_cav/rho1', 'Stability parameter 1');
model.param('par2').set('g2', '1-l_cav/rho2', 'Stability parameter 2');
model.param('par2').set('w0', 'sqrt(l_cav*lda0/pi)*(g1*g2*(1-g1*g2)/((g1+g2-2*g1*g2)^2))^(1/4)', 'Beam waist radius');
model.param('par2').set('w1', 'sqrt(l_cav*lda0/pi)*(g2/(g1*(1-g1*g2)))^(1/4)', 'Beam radius on left mirror');
model.param('par2').set('w2', 'sqrt(l_cav*lda0/pi)*(g1/(g2*(1-g1*g2)))^(1/4)', 'Beam radius on right mirror');
model.param('par2').set('FSR', 'c_const/(2*l_cav)', 'Free spectral range');
model.param('par2').set('F', 'pi*(R*R)^(1/4)/(1-sqrt(R*R))', 'Finesse');
model.param('par2').set('R', 'abs((sqrt(Rl)-exp(2*i*phi)*sqrt(Rr))/(1-exp(2*i*phi)*sqrt(Rl*Rr)))^2', 'Reflectance of mirror layer');
model.param('par2').set('phi', '2*pi*d*n/(lda0)', 'Phase delay through mirror layer');
model.param('par2').set('d', 'lda0/100', 'Mirror layer thickness');
model.param('par2').set('n', '15', 'Refractive Index of mirror layer');
model.param('par2').set('n1', '1', 'Refractive index in front of mirror layer');
model.param('par2').set('n2', '1', 'Refractive index behind mirror layer');
model.param('par2').set('r1', '(n1-n)/(n1+n)', 'Reflectivity of first mirror layer interface');
model.param('par2').set('r2', '(n-n2)/(n+n2)', 'Reflectivity of second mirror layer interface');
model.param('par2').set('Rl', 'r1^2', 'Reflectance of first layer mirror interface');
model.param('par2').set('Rr', 'r2^2', 'Reflectance of second layer mirror interface');
model.param('par2').set('df', 'FSR/F', 'Frequency width');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'rho1');
model.geom('geom1').feature('c1').set('pos', {'rho1' '0'});
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 'rho2');
model.geom('geom1').feature('c2').set('pos', {'l_cav-rho2' '0'});
model.geom('geom1').run('c2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'c2'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'l_total' 'h_cav/2'});
model.geom('geom1').feature('r1').set('pos', {'-l_in' '0'});
model.geom('geom1').run('r1');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'r1' 'uni1'});
model.geom('geom1').runPre('fin');

model.view('view1').axis.set('viewscaletype', 'automatic');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive_index');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'n1'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0'});

model.physics('ewbe').prop('components').set('components', 'outofplane');
model.physics('ewbe').create('symp1', 'SymmetryPlane', 1);
model.physics('ewbe').feature('symp1').selection.set([2 4 7]);
model.physics('ewbe').create('trans1', 'TransitionBoundaryCondition', 1);
model.physics('ewbe').feature('trans1').selection.set([9 10]);
model.physics('ewbe').feature('trans1').set('n_mat', 'userdef');
model.physics('ewbe').feature('trans1').set('n', 'n');
model.physics('ewbe').feature('trans1').set('ki_mat', 'userdef');
model.physics('ewbe').feature('trans1').set('d', 'd');
model.physics('ewbe').create('sctr1', 'Scattering', 1);
model.physics('ewbe').feature('sctr1').selection.set([1]);
model.physics('ewbe').feature('sctr1').set('IncidentField', 'GaussianBeam');
model.physics('ewbe').feature('sctr1').set('w0', 'w0');
model.physics('ewbe').feature('sctr1').set('p0', 'l_in+l_cav/2');
model.physics('ewbe').feature('sctr1').set('Eg0', [0 0 1]);
model.physics('ewbe').feature('sctr1').create('rpnt1', 'ReferencePoint', 0);
model.physics('ewbe').feature('sctr1').feature('rpnt1').selection.set([1]);
model.physics('ewbe').create('sctr2', 'Scattering', 1);
model.physics('ewbe').feature('sctr2').selection.set([8]);
model.physics('ewbe').feature('sctr2').set('inputWave', 'SecondWave');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.set([1]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.set([8]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('R', 'intop1(ewbe.nPoav2)/intop1(-ewbe.nPoav1)');
model.variable('var1').descr('R', 'Reflectance');
model.variable('var1').set('T', 'intop2(ewbe.nPoav1)/intop1(-ewbe.nPoav1)');
model.variable('var1').descr('T', 'Transmittance');

model.physics('ewbe').prop('MeshControl').set('elemCountT', 60);
model.physics('ewbe').prop('MeshControl').set('elemCountL', 30);

model.mesh('mesh1').run;

model.study('std1').label('Study 1 - FSR Sweep');
model.study('std1').feature('freq').set('plist', 'range(f0,FSR/101,f0+FSR)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(f0,FSR/101,f0+FSR)'});
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
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Field (ewbe)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 102, 0);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Electric Field');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 21, 0);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'ewbe.normE1');
model.result('pg1').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormax', 2);
model.result('pg1').run;
model.result('pg1').create('arws1', 'ArrowSurface');
model.result('pg1').feature('arws1').set('expr', {'ewbe.Poav1x' 'ewbe.Poav1y'});
model.result('pg1').feature('arws1').set('descr', 'Power flow, time-average, first wave');
model.result('pg1').feature('arws1').set('xnumber', 10);
model.result('pg1').feature('arws1').set('ynumber', 21);
model.result('pg1').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('arws1').set('scaleactive', true);
model.result('pg1').feature('arws1').set('scale', 0.2);
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('expr', 'ewbe.normE2');
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').feature('surf2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('trn1').set('trans', {'0' 'h_cav*0.55'});
model.result('pg1').run;
model.result('pg1').feature.duplicate('arws2', 'arws1');
model.result('pg1').run;
model.result('pg1').feature('arws2').setIndex('expr', 'ewbe.Poav2x', 0);
model.result('pg1').feature('arws2').setIndex('expr', 'ewbe.Poav2y', 1);
model.result('pg1').feature('arws2').set('inheritplot', 'arws1');
model.result('pg1').feature('arws2').create('trn1', 'Translation');
model.result('pg1').run;
model.result('pg1').feature('arws2').feature('trn1').set('trans', {'0' 'h_cav*0.55'});
model.result('pg1').run;
model.result('pg1').create('ann1', 'Annotation');
model.result('pg1').feature('ann1').set('text', 'First wave');
model.result('pg1').feature('ann1').set('posxexpr', 'l_cav/2');
model.result('pg1').feature('ann1').set('posyexpr', 'h_cav/4');
model.result('pg1').feature('ann1').set('anchorpoint', 'center');
model.result('pg1').feature('ann1').set('showpoint', false);
model.result('pg1').feature.duplicate('ann2', 'ann1');
model.result('pg1').run;
model.result('pg1').feature('ann2').set('text', 'Second wave');
model.result('pg1').feature('ann2').set('posyexpr', 'h_cav*0.55+h_cav/4');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Sweep Over One FSR');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'T', 0);
model.result('pg2').feature('glob1').setIndex('unit', 1, 0);
model.result('pg2').feature('glob1').setIndex('descr', 'Transmittance', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'R', 1);
model.result('pg2').feature('glob1').setIndex('unit', 1, 1);
model.result('pg2').feature('glob1').setIndex('descr', 'Reflectance', 1);
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').feature('glob1').set('xdataexpr', 'freq-f0');
model.result('pg2').feature('glob1').set('xdataunit', 'GHz');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').set('legendpos', 'middleright');

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
model.study('std2').feature('freq').setSolveFor('/physics/ewbe', true);
model.study('std2').label('Study 2 - Resonance Sweep');
model.study('std2').feature('freq').set('plist', 'range(f0+0.5[GHz],0.001[GHz],f0+0.7[GHz])');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'freq');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'freq');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'range(f0+0.5[GHz],0.001[GHz],f0+0.7[GHz])'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'THz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol2').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol2').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol2').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol2').feature('s1').feature('p1').set('probes', {});
model.sol('sol2').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol2').feature('s1').set('linpmethod', 'sol');
model.sol('sol2').feature('s1').set('linpsol', 'zero');
model.sol('sol2').feature('s1').set('control', 'freq');
model.sol('sol2').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('s1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol2').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol2').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Field (ewbe) 1');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 201, 0);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 201, 0);
model.result('pg3').set('defaultPlotID', 'ElectromagneticWavesBeamEnvelopes/phys1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').label('Electric Field');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').run;
model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').set('data', 'dset2');
model.result.dataset('mir1').setIndex('genpoints', 1, 1, 0);
model.result.dataset('mir1').setIndex('genpoints', 0, 1, 1);
model.result('pg3').run;
model.result('pg3').set('data', 'mir1');
model.result('pg3').setIndex('looplevel', 92, 0);
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'ewbe.normE1');
model.result('pg3').feature('surf1').set('colortable', 'Twilight');
model.result('pg3').feature('surf1').create('hght1', 'Height');
model.result('pg3').run;
model.result('pg3').feature('surf1').feature('hght1').set('scaleactive', true);
model.result('pg3').feature('surf1').feature('hght1').set('scale', 0.001);
model.result('pg3').run;

model.view('view3').camera.set('viewscaletype', 'automatic');

model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Resonance Shape');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('legendpos', 'middleright');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').setIndex('expr', 'T', 0);
model.result('pg4').feature('glob1').setIndex('unit', 1, 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Transmittance', 0);
model.result('pg4').feature('glob1').setIndex('expr', 'R', 1);
model.result('pg4').feature('glob1').setIndex('unit', 1, 1);
model.result('pg4').feature('glob1').setIndex('descr', 'Reflectance', 1);
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'freq-f0');
model.result('pg4').feature('glob1').set('xdataunit', 'GHz');
model.result('pg1').run;
model.result.duplicate('pg5', 'pg1');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature.remove('surf2');
model.result('pg5').run;
model.result('pg5').feature.remove('arws2');
model.result('pg5').run;
model.result('pg5').feature.remove('ann1');
model.result('pg5').feature.remove('ann2');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('surf1').set('expr', 'ewbe.normE');
model.result('pg5').run;
model.result('pg5').feature.remove('arws1');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').set('titletype', 'none');
model.result.dataset.create('mir2', 'Mirror2D');
model.result.dataset('mir2').setIndex('genpoints', 1, 1, 0);
model.result.dataset('mir2').setIndex('genpoints', 0, 1, 1);
model.result('pg5').run;
model.result('pg5').feature.duplicate('surf2', 'surf1');
model.result('pg5').run;
model.result('pg5').feature('surf2').set('data', 'mir2');
model.result('pg5').feature('surf2').set('inheritplot', 'surf1');
model.result('pg5').feature('surf2').setIndex('looplevel', 21, 0);
model.result('pg5').run;
model.result('pg5').set('edges', false);
model.result('pg5').create('line1', 'Line');
model.result('pg5').feature('line1').set('expr', '1');
model.result('pg5').feature('line1').create('sel1', 'Selection');
model.result('pg5').feature('line1').feature('sel1').selection.set([5 9 10]);
model.result('pg5').run;
model.result('pg5').feature('line1').set('coloring', 'uniform');
model.result('pg5').feature('line1').set('color', 'gray');
model.result('pg5').feature.duplicate('line2', 'line1');
model.result('pg5').run;
model.result('pg5').feature('line2').set('data', 'mir2');
model.result('pg5').run;
model.result('pg5').set('showlegends', false);
model.result('pg5').create('ann1', 'Annotation');
model.result('pg5').feature('ann1').set('text', 'Incident and reflected beams');
model.result('pg5').feature('ann1').set('posxexpr', '-l_in/2');
model.result('pg5').feature('ann1').set('posyexpr', 'h_cav/4');
model.result('pg5').feature('ann1').set('anchorpoint', 'center');
model.result('pg5').feature('ann1').set('showpoint', false);
model.result('pg5').feature.duplicate('ann2', 'ann1');
model.result('pg5').run;
model.result('pg5').feature.duplicate('ann3', 'ann2');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('ann2').set('text', 'Cavity');
model.result('pg5').feature('ann2').set('posxexpr', 'l_cav/2');
model.result('pg5').run;
model.result('pg5').feature('ann3').set('text', 'Transmitted beam');
model.result('pg5').feature('ann3').set('posxexpr', 'l_cav+l_out/2');
model.result('pg5').feature.duplicate('ann4', 'ann3');
model.result('pg5').run;
model.result('pg5').feature('ann4').set('text', 'Front mirror');
model.result('pg5').feature('ann4').set('posxexpr', 0);
model.result('pg5').feature('ann4').set('posyexpr', '-h_cav/4');
model.result('pg5').feature('ann4').set('anchorpoint', 'middleleft');
model.result('pg5').feature('ann4').set('showpoint', true);
model.result('pg5').feature.duplicate('ann5', 'ann4');
model.result('pg5').run;
model.result('pg5').feature('ann5').set('text', 'Rear mirror');
model.result('pg5').feature('ann5').set('posxexpr', 'l_cav');
model.result('pg5').run;
model.result('pg5').feature.duplicate('ann6', 'ann1');
model.result('pg5').run;
model.result('pg5').feature('ann6').set('text', 'Air');
model.result('pg5').feature('ann6').set('posyexpr', '-3*h_cav/8');
model.result('pg5').feature.duplicate('ann7', 'ann6');
model.result('pg5').run;
model.result('pg5').feature('ann7').set('posxexpr', 'l_cav/2');
model.result('pg5').feature.duplicate('ann8', 'ann7');
model.result('pg5').run;
model.result('pg5').feature('ann8').set('posxexpr', 'l_cav+l_out/2');
model.result('pg5').run;

model.view('view1').set('showgrid', false);

model.result('pg5').run;
model.result.remove('pg5');
model.result.dataset.remove('mir2');
model.result('pg1').run;

model.title(['Fabry' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Perot Resonator']);

model.description(['A Fabry' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Perot resonator is one of the fundamental optical devices and has a broad range of applications. A few example applications are length measurement, frequency and/or wavelength measurement or filtering of specific spatial modes.' newline  newline 'This model uses the Electromagnetic Waves, Beam Envelopes interface in the bidirectional formulation to efficiently compute mode shape and reflection/transmission properties of a macroscopic Fabry' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Perot resonator.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('fabry_perot_resonator.mph');

model.modelNode.label('Components');

out = model;
