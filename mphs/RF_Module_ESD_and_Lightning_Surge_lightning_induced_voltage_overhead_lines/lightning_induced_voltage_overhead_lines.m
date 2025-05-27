function out = model
%
% lightning_induced_voltage_overhead_lines.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/ESD_and_Lightning_Surge');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('temw', 'TransientElectromagneticWaves', 'geom1');
model.physics('temw').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/temw', true);

model.param.set('W_air', '1200[m]');
model.param.descr('W_air', 'Width of the air domain');
model.param.set('D_air', '800[m]');
model.param.descr('D_air', 'Depth of the air domain');
model.param.set('H_air', '1000[m]');
model.param.descr('H_air', 'Height of the air domain');
model.param.set('H_soil', '200[m]');
model.param.descr('H_soil', 'Soil layer thickness');
model.param.set('L_wire', '300[m]');
model.param.descr('L_wire', 'Length of the wire');
model.param.set('H_wire', '6[m]');
model.param.descr('H_wire', 'Height of the wire');
model.param.set('r_wire', '1[cm]');
model.param.descr('r_wire', 'Radius of the wire');
model.param.set('LDx', '80[m]');
model.param.descr('LDx', 'X distance between wire and striking point');
model.param.set('LDy', '20[m]');
model.param.descr('LDy', 'Y distance between wire and striking point');
model.param.set('ds', '1[m]');
model.param.descr('ds', 'Thin wire domain mesh size');
model.param.set('vr', '150[m/us]');
model.param.descr('vr', 'Current velocity');
model.param.set('epsilonr', 'log(1/0.23)/log(ds/r_wire)');
model.param.descr('epsilonr', 'Modified relative permittivity');
model.param.set('mur', '1/epsilonr');
model.param.descr('mur', 'Modified relative permeability');
model.param.set('C_term', '50[pF]');
model.param.descr('C_term', 'Capacitance used for termination');
model.param.set('R_term', '600[ohm]');
model.param.descr('R_term', 'Resistance used for termination');
model.param.set('S_capacitor', '0.5[m]');
model.param.descr('S_capacitor', 'Separation of the parallel plate capacitor');
model.param.set('W_capacitor', '3[m]');
model.param.descr('W_capacitor', 'Width of the capacitor');
model.param.set('L_capacitor', 'C_term*S_capacitor/epsilon0_const/W_capacitor');
model.param.descr('L_capacitor', 'Length of the capacitor');
model.param.set('angle', '90[degree]');
model.param.descr('angle', 'Angle of inclination of the wire');
model.param.set('sigma_soil', '0.01[S/m]');
model.param.descr('sigma_soil', 'Soil conductivity');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'W_air' 'D_air' 'H_air'});
model.geom('geom1').feature('blk1').set('pos', {'0' '0' '-H_soil'});
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk1').setIndex('layer', 'H_soil', 0);
model.geom('geom1').run('blk1');

model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(2);
model.view('view1').hideObjects('hide1').set('blk1', [4 5 7]);

model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'W_air/2-L_wire/2' '0' '0'});
model.geom('geom1').feature('ls1').setIndex('coord1', 'D_air/2', 1);
model.geom('geom1').feature('ls1').setIndex('coord1', 'H_wire', 2);
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'W_air/2+L_wire/2' '0' '0'});
model.geom('geom1').feature('ls1').setIndex('coord2', 'D_air/2', 1);
model.geom('geom1').feature('ls1').setIndex('coord2', 'H_wire', 2);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('coord1', {'W_air/2+L_wire/2+LDx' '0' '0'});
model.geom('geom1').feature('ls2').setIndex('coord1', 'D_air/2+LDy', 1);
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord2', {'W_air/2+L_wire/2+LDx+(H_air-H_soil)*0.8*cos(angle)' '0' '0'});
model.geom('geom1').feature('ls2').setIndex('coord2', 'D_air/2+LDy', 1);
model.geom('geom1').feature('ls2').setIndex('coord2', '(H_air-H_soil)*0.8*sin(angle)', 2);
model.geom('geom1').run('ls2');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'L_wire' '2*ds' '2*ds'});
model.geom('geom1').feature('blk2').set('base', 'center');
model.geom('geom1').feature('blk2').set('pos', {'W_air/2' 'D_air/2' '0'});
model.geom('geom1').feature('blk2').setIndex('pos', 'H_wire', 2);
model.geom('geom1').feature('blk2').set('layerfront', true);
model.geom('geom1').feature('blk2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk2').setIndex('layer', 'ds', 0);
model.geom('geom1').run('blk2');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L_wire' 'W_capacitor'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'W_air/2' 'D_air/2'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('layer', 'L_capacitor', 0);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerbottom', false);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerleft', true);
model.geom('geom1').feature('wp1').geom.feature('r1').set('layerright', true);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'S_capacitor', 0);
model.geom('geom1').feature('ext1').setIndex('distance', 'H_wire-ds', 1);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0'});
model.geom('geom1').run('ext1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('ext1', [3 4]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Air');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat1').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat1').selection.set([2 3 4 9 10]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Soil');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'sigma_soil'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Modified Material');
model.material('mat3').selection.set([5 6 7 8]);
model.material('mat3').propertyGroup('def').set('relpermittivity', {'epsilonr'});
model.material('mat3').propertyGroup('def').set('relpermeability', {'mur'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'0'});

model.physics('temw').prop('ShapeProperty').set('order_magneticvectorpotential', 1);
model.physics('temw').create('sctr1', 'Scattering', 2);
model.physics('temw').feature('sctr1').selection.set([1 2 3 4 5 7 8 9 58 59]);
model.physics('temw').create('pec2', 'PerfectElectricConductor', 2);
model.physics('temw').feature('pec2').selection.set([12 13 15 17 24 42 45 53 54 56]);
model.physics('temw').create('lelement1', 'LumpedElement', 2);
model.physics('temw').feature('lelement1').label('Lumped Element A');
model.physics('temw').feature('lelement1').selection.set([10]);
model.physics('temw').feature('lelement1').set('Zelement', 'R_term');
model.physics('temw').create('lelement2', 'LumpedElement', 2);
model.physics('temw').feature('lelement2').label('Lumped Element B');
model.physics('temw').feature('lelement2').selection.set([52]);
model.physics('temw').feature('lelement2').set('Zelement', 'R_term');
model.physics('temw').create('constr1', 'PointwiseConstraint', 1);
model.physics('temw').feature('constr1').selection.set([35]);
model.physics('temw').feature('constr1').set('constraintExpression', '0-tAx');
model.physics('temw').feature.duplicate('constr2', 'constr1');
model.physics('temw').feature('constr2').set('constraintExpression', '0-tAy');
model.physics('temw').feature.duplicate('constr3', 'constr2');
model.physics('temw').feature('constr3').set('constraintExpression', '0-tAz');
model.physics('temw').create('edc1', 'EdgeCurrent', 1);
model.physics('temw').feature('edc1').selection.set([101]);
model.physics('temw').feature('edc1').set('CurrentPulseType', 'Lightning');
model.physics('temw').feature('edc1').set('v_p', 'vr');
model.physics('temw').prop('MeshControl').set('PhysicsControlledMeshMaximumElementSize', '120[m]');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature.move('map1', 1);
model.mesh('mesh1').feature('map1').selection.set([17 20 24 27]);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([5 6 7 8]);
model.mesh('mesh1').feature('swe1').create('size1', 'Size');
model.mesh('mesh1').feature('swe1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('swe1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('swe1').feature('size1').set('hmax', '3*ds');
model.mesh('mesh1').feature('swe1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('swe1').feature('size1').set('hmin', 'ds');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([101]);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', '5[m]');
model.mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size2').selection.set([10 52]);
model.mesh('mesh1').feature('ftet1').feature('size2').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size2').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size2').set('hmax', 'S_capacitor*0.6');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);
model.study('std1').feature('time').set('tunit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 's']);
model.study('std1').feature('time').set('tlist', 'range(0,0.01,3)');
model.study('std1').feature('time').set('useparam', true);
model.study('std1').feature('time').setIndex('pname', 'W_air', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'm', 0);
model.study('std1').feature('time').setIndex('pname', 'W_air', 0);
model.study('std1').feature('time').setIndex('plistarr', '', 0);
model.study('std1').feature('time').setIndex('punit', 'm', 0);
model.study('std1').feature('time').setIndex('pname', 'sigma_soil', 0);
model.study('std1').feature('time').setIndex('plistarr', '0.01 0.02', 0);
model.study('std1').feature('time').setIndex('punit', 'S/m', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,3)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').create('tp1', 'TimeParametric');
model.sol('sol1').feature('t1').feature.remove('tpDef');
model.sol('sol1').feature('t1').feature('tp1').set('control', 'time');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Suggested Direct Solver (temw)');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', '0.01[us]');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Electric Field');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', '1');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'gray');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.set([1 2 3 6 8 9 12 42 58 59]);
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').create('sel1', 'Selection');
model.result('pg1').feature('line1').feature('sel1').selection.set([101]);
model.result('pg1').run;
model.result('pg1').create('line2', 'Line');
model.result('pg1').feature('line2').create('sel1', 'Selection');
model.result('pg1').feature('line2').feature('sel1').selection.set([35]);
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result('pg1').set('showlegends', false);

model.view('view1').set('showgrid', false);

model.result('pg1').set('titletype', 'none');
model.result('pg1').setIndex('looplevel', 101, 0);
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Induced Voltage');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', ['Time, ' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 's']);
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Induced Voltage, kV');
model.result('pg2').set('legendpos', 'lowerleft');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg2').feature('glob1').setIndex('expr', 'temw.Velement_1', 0);
model.result('pg2').feature('glob1').setIndex('unit', 'kV', 0);
model.result('pg2').feature('glob1').setIndex('descr', 'End A', 0);
model.result('pg2').feature('glob1').setIndex('expr', 'temw.Velement_2', 1);
model.result('pg2').feature('glob1').setIndex('unit', 'kV', 1);
model.result('pg2').feature('glob1').setIndex('descr', 'End B', 1);
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').feature('glob1').set('markerpos', 'interp');
model.result('pg2').run;

model.title('Lightning-Induced Voltage of an Overhead Line Over Lossy Ground');

model.description('This model shows how to calculate the lightning-induced voltage of an overhead line over a lossy ground. Lightning channels with different inclinations are considered. The effect of soil conductivity is also shown.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('lightning_induced_voltage_overhead_lines.mph');

model.modelNode.label('Components');

out = model;
