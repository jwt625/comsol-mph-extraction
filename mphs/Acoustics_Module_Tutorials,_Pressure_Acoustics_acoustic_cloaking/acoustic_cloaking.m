function out = model
%
% acoustic_cloaking.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Tutorials,_Pressure_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/acpr', true);

model.geom('geom1').insertFile('acoustic_cloaking_geom_sequence.mph', 'geom1');
model.geom('geom1').run('boxsel10');

model.param.set('rhob', '1.25[kg/m^3]');
model.param.descr('rhob', 'Density, background material');
model.param.set('cb', '343[m/s]');
model.param.descr('cb', 'Speed of sound, background material');
model.param.set('f0', '300[Hz]');
model.param.descr('f0', 'Frequency of the analysis');
model.param.set('lam0', 'cb/f0');
model.param.descr('lam0', 'Wavelength');

model.coordSystem.create('sys2', 'geom1', 'Cylindrical');
model.coordSystem('sys2').setIndex('origin', 'x1', 0);
model.coordSystem('sys2').setIndex('origin', 'y1', 1);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Radial Coordinate: Homogenized Cloak');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.named('geom1_sel3');
model.variable('var1').set('r', 'sys2.r');
model.variable('var1').descr('r', 'Radial coordinate');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Radial Coordinate: 50 Layer Cloak');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.named('geom1_boxsel1');
model.variable('var2').set('r', 'sqrt((x-x3)^2+(y-y3)^2)', 'Radial coordinate');
model.variable('var2').descr('r', 'Radial coordinate');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Radial Coordinate: 20 Layer Cloak');
model.variable('var3').selection.geom('geom1', 2);
model.variable('var3').selection.named('geom1_boxsel2');
model.variable('var3').set('r', 'sqrt((x-x4)^2+(y-y4)^2)', 'Radial coordinate');
model.variable('var3').descr('r', 'Radial coordinate');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').label('Variables: Acoustic Cloak Data');
model.variable('var4').selection.geom('geom1', 2);
model.variable('var4').selection.named('geom1_unisel1');
model.variable('var4').set('rho1', 'rhob*(r+sqrt(2*r*R1-R1^2))/(r-R1)');
model.variable('var4').descr('rho1', 'Density, Material 1');
model.variable('var4').set('c1', 'cb*(R2-R1)/R2*r/(r-R1)');
model.variable('var4').descr('c1', 'Speed of sound, Material 1');
model.variable('var4').set('rho2', 'rhob^2/rho1');
model.variable('var4').descr('rho2', 'Density, Material 2');
model.variable('var4').set('c2', 'c1');
model.variable('var4').descr('c2', 'Speed of sound, Material 2');
model.variable('var4').set('K1', 'rho1*c1^2');
model.variable('var4').descr('K1', 'Bulk modulus, Material 1');
model.variable('var4').set('K2', 'rho2*c2^2');
model.variable('var4').descr('K2', 'Bulk modulus, Material 2');
model.variable('var4').set('K', '2*K1*K2/(K1+K2)');
model.variable('var4').descr('K', 'Effective bulk modulus');
model.variable('var4').set('rho_tangential', '2*rho1*rho2/(rho1+rho2)');
model.variable('var4').descr('rho_tangential', 'Density along layers');
model.variable('var4').set('rho_normal', '(rho1+rho2)/2');
model.variable('var4').descr('rho_normal', 'Density perpendicular to the layers');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup('def').set('density', {'rhob'});
model.material('mat1').propertyGroup('def').set('soundspeed', {'cb'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Material 1');
model.material('mat2').selection.named('geom1_sel1');
model.material('mat2').propertyGroup('def').set('density', {'rho1'});
model.material('mat2').propertyGroup('def').set('soundspeed', {'c1'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Material 2');
model.material('mat3').selection.named('geom1_sel2');
model.material('mat3').propertyGroup('def').set('density', {'rho2'});
model.material('mat3').propertyGroup('def').set('soundspeed', {'c2'});
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').label('Homogenized Material');
model.material('mat4').selection.named('geom1_sel3');
model.material('mat4').propertyGroup.create('AnisotropicAcousticsModel', 'Anisotropic_acoustics_model');
model.material('mat4').propertyGroup('AnisotropicAcousticsModel').set('rho_eff', {'rho_normal' 'rho_tangential' 'rho_tangential'});
model.material('mat4').propertyGroup('AnisotropicAcousticsModel').set('K_eff', {'K'});
model.material('mat4').propertyGroup('def').set('density', {});
model.material('mat4').propertyGroup('def').set('soundspeed', {});

model.nodeGroup.create('grp1', 'Physics', 'acpr');
model.nodeGroup('grp1').label('Homogenized Model');

model.physics('acpr').create('cwr1', 'CylindricalWaveRadiation', 1);

model.nodeGroup('grp1').add('cwr1');

model.physics('acpr').feature('cwr1').selection.set([154]);
model.physics('acpr').feature('cwr1').set('r0', {'x1' 'y1' '0'});
model.physics('acpr').create('bpf1', 'BackgroundPressureField', 2);

model.nodeGroup('grp1').add('bpf1');

model.physics('acpr').feature('bpf1').selection.named('geom1_boxsel7');
model.physics('acpr').feature('bpf1').set('pamp', 1);
model.physics('acpr').feature('bpf1').set('c_mat', 'from_mat');
model.physics('acpr').feature('bpf1').set('PressureFieldMaterial', 'mat1');
model.physics('acpr').feature('bpf1').set('phi', 'acpr.bpf1.k*x1');
model.physics('acpr').create('sym1', 'Symmetry', 1);

model.nodeGroup('grp1').add('sym1');

model.physics('acpr').feature('sym1').selection.named('geom1_boxsel3');
model.physics('acpr').create('aam1', 'AnisotropicAcousticsModel', 2);

model.nodeGroup('grp1').add('aam1');

model.physics('acpr').feature('aam1').selection.set([4]);
model.physics('acpr').feature('aam1').set('coordinateSystem', 'sys2');

model.nodeGroup.create('grp2', 'Physics', 'acpr');
model.nodeGroup('grp2').label('No Cloak Model');

model.physics('acpr').create('cwr2', 'CylindricalWaveRadiation', 1);

model.nodeGroup('grp2').add('cwr2');

model.physics('acpr').feature('cwr2').selection.set([209]);
model.physics('acpr').feature('cwr2').set('r0', {'x2' 'y2' '0'});
model.physics('acpr').create('bpf2', 'BackgroundPressureField', 2);

model.nodeGroup('grp2').add('bpf2');

model.physics('acpr').feature('bpf2').selection.named('geom1_boxsel8');
model.physics('acpr').feature('bpf2').set('pamp', 1);
model.physics('acpr').feature('bpf2').set('c_mat', 'from_mat');
model.physics('acpr').feature('bpf2').set('phi', 'acpr.bpf2.k*x2');
model.physics('acpr').create('sym2', 'Symmetry', 1);

model.nodeGroup('grp2').add('sym2');

model.physics('acpr').feature('sym2').selection.named('geom1_boxsel4');

model.nodeGroup.create('grp3', 'Physics', 'acpr');
model.nodeGroup('grp3').label('50 Layer Cloak Model');

model.physics('acpr').create('cwr3', 'CylindricalWaveRadiation', 1);

model.nodeGroup('grp3').add('cwr3');

model.physics('acpr').feature('cwr3').selection.set([153]);
model.physics('acpr').feature('cwr3').set('r0', {'x3' 'y3' '0'});
model.physics('acpr').create('bpf3', 'BackgroundPressureField', 2);

model.nodeGroup('grp3').add('bpf3');

model.physics('acpr').feature('bpf3').selection.named('geom1_boxsel9');
model.physics('acpr').feature('bpf3').set('pamp', 1);
model.physics('acpr').feature('bpf3').set('c_mat', 'from_mat');
model.physics('acpr').feature('bpf3').set('phi', 'acpr.bpf3.k*x3');
model.physics('acpr').create('sym3', 'Symmetry', 1);

model.nodeGroup('grp3').add('sym3');

model.physics('acpr').feature('sym3').selection.named('geom1_boxsel5');

model.nodeGroup.create('grp4', 'Physics', 'acpr');
model.nodeGroup('grp4').label('20 Layer Cloak Model');

model.physics('acpr').create('cwr4', 'CylindricalWaveRadiation', 1);

model.nodeGroup('grp4').add('cwr4');

model.physics('acpr').feature('cwr4').selection.set([208]);
model.physics('acpr').feature('cwr4').set('r0', {'x4' 'y4' '0'});
model.physics('acpr').create('bpf4', 'BackgroundPressureField', 2);

model.nodeGroup('grp4').add('bpf4');

model.physics('acpr').feature('bpf4').selection.named('geom1_boxsel10');
model.physics('acpr').feature('bpf4').set('pamp', 1);
model.physics('acpr').feature('bpf4').set('c_mat', 'from_mat');
model.physics('acpr').feature('bpf4').set('phi', 'acpr.bpf4.k*x4');
model.physics('acpr').create('sym4', 'Symmetry', 1);

model.nodeGroup('grp4').add('sym4');

model.physics('acpr').feature('sym4').selection.named('geom1_boxsel6');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'lam0/6');
model.mesh('mesh1').run('size');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([4]);
model.mesh('mesh1').feature('map1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis1').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis1').set('elemratio', 4);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([55]);
model.mesh('mesh1').feature('map1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('map1').feature('dis2').set('elemcount', 20);
model.mesh('mesh1').feature('map1').feature('dis2').set('elemratio', 4);
model.mesh('mesh1').feature('map1').feature('dis2').set('reverse', true);
model.mesh('mesh1').feature('map1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis3').selection.set([156]);
model.mesh('mesh1').feature('map1').feature('dis3').set('numelem', 40);
model.mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', 'f0');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
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
model.sol('sol1').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol1').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol1').feature('s1').feature('aDef').set('nullfun', 'auto');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'acpr.p_t'});
model.result('pg1').feature('surf1').set('colortable', 'Wave');
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').label('Acoustic Pressure (acpr)');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'acpr.Lp_t'});
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').label('Sound Pressure Level (acpr)');
model.result('pg1').run;
model.result('pg1').label('Total Acoustic Pressure (acpr)');
model.result('pg1').set('edges', false);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', '0');
model.result('pg1').feature('line1').set('titletype', 'none');
model.result('pg1').feature('line1').set('coloring', 'uniform');
model.result('pg1').feature('line1').set('color', 'black');
model.result('pg1').feature('line1').create('sel1', 'Selection');
model.result('pg1').feature('line1').feature('sel1').selection.set([1 2 105 106 107 108 151 152 153 154 155 156 208 209 210 211]);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('tlan1', 'TableAnnotation');
model.result('pg1').feature('tlan1').set('source', 'localtable');
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'x1', 0, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'y1+4.3[m]', 0, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Homogenized cloak', 0, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'x2', 1, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'y2+4.3[m]', 1, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'No cloak', 1, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'x3', 2, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'y3+4.3[m]', 2, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '50 Layer cloak', 2, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'x4', 3, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'y4+4.3[m]', 3, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '20 Layer cloak', 3, 2);
model.result('pg1').feature('tlan1').set('showpoint', false);
model.result('pg1').feature('tlan1').set('anchorpoint', 'center');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result.remove('pg2');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Total Sound Pressure Level (acpr)');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'acpr.Lp_t');
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Scattered Sound Pressure Level (acpr)');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'acpr.Lp_s');
model.result('pg3').feature('surf1').create('sel1', 'Selection');
model.result('pg3').feature('surf1').feature('sel1').selection.set([1 2 54 55]);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Effective Speed of Sound in Principal Directions');
model.result('pg4').selection.geom('geom1', 2);
model.result('pg4').selection.geom('geom1', 2);
model.result('pg4').selection.set([4]);
model.result('pg4').set('view', 'new');
model.result('pg4').set('applyselectiontodatasetedges', true);
model.result('pg4').run;
model.result('pg4').set('titletype', 'label');
model.result('pg4').create('pris1', 'PrincipalSurface');
model.result('pg4').feature('pris1').setIndex('princvalstressexpr', 0, 0, 1);
model.result('pg4').feature('pris1').setIndex('princvalstressexpr', 0.5, 0, 2);
model.result('pg4').feature('pris1').setIndex('princdirstressexpr', 'acpr.c_eff1x+acpr.c_eff2x', 0, 0);
model.result('pg4').feature('pris1').setIndex('princdirstressexpr', 'acpr.c_eff1y+acpr.c_eff2y', 1, 0);
model.result('pg4').feature('pris1').setIndex('princdirstressexpr', 0, 1, 1);
model.result('pg4').feature('pris1').setIndex('princdirstressexpr', 'acpr.c_eff3x', 0, 2);
model.result('pg4').feature('pris1').setIndex('princdirstressexpr', 'acpr.c_eff3y', 1, 2);
model.result('pg4').feature('pris1').setIndex('princdirstressexpr', 0, 2, 2);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Total Acoustic Pressure Along Cloak Boundary');
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Pressure (Pa)');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.set([156]);
model.result('pg5').feature('lngr1').set('expr', 'acpr.p_b');
model.result('pg5').feature('lngr1').set('titletype', 'none');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('legendmethod', 'manual');
model.result('pg5').feature('lngr1').setIndex('legends', 'Background pressure field', 0);
model.result('pg5').feature('lngr1').set('linemarker', 'circle');
model.result('pg5').feature('lngr1').set('markerpos', 'interp');
model.result('pg5').feature('lngr1').set('markers', 100);
model.result('pg5').run;
model.result('pg5').feature.duplicate('lngr2', 'lngr1');
model.result('pg5').run;
model.result('pg5').feature('lngr2').set('expr', 'acpr.p_t');
model.result('pg5').feature('lngr2').set('linemarker', 'none');
model.result('pg5').feature('lngr2').setIndex('legends', 'Homogenized cloak model', 0);
model.result('pg5').feature.duplicate('lngr3', 'lngr2');
model.result('pg5').run;
model.result('pg5').feature('lngr3').selection.set([155]);
model.result('pg5').feature('lngr3').setIndex('legends', '50 layer cloak model', 0);
model.result('pg5').feature.duplicate('lngr4', 'lngr3');
model.result('pg5').run;
model.result('pg5').feature('lngr4').selection.set([210]);
model.result('pg5').feature('lngr4').setIndex('legends', '20 layer cloak model', 0);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Speed of Sound in Homogenized Material');
model.result('pg6').set('titletype', 'label');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Speed of sound (m/s)');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').selection.set([55]);
model.result('pg6').feature('lngr1').set('expr', 'acpr.c_eff1');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').feature('lngr1').set('autosolution', false);
model.result('pg6').feature('lngr1').set('autodescr', true);
model.result('pg6').feature.duplicate('lngr2', 'lngr1');
model.result('pg6').run;
model.result('pg6').feature('lngr2').set('expr', 'acpr.c_eff3');
model.result('pg6').set('ylog', true);
model.result('pg6').run;
model.result('pg1').set('applyselectiontodatasetedges', false);
model.result('pg1').run;

model.title('Acoustic Cloaking');

model.description('This example demonstrates how to use a background field in a sound scattering problem. The application is an acoustic invisibility cloak made of a metamaterial. Two different types of metamaterials are used, one using an anisotropic acoustic material with varying properties and one using two layered materials with varying properties. Thanks to its space-dependent material properties and layered structure, both types of metamaterials are almost transparent to an incident plane pressure wave.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('acoustic_cloaking.mph');

model.modelNode.label('Components');

out = model;
