function out = model
%
% cascade_impactor_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Rcol35', '8.225[cm]/2', 'Collector plate radius of bottom three stages');
model.param.set('L0', '4.1[mm]', 'Nozzle length of level 0');
model.param.set('L1', '4.1[mm]', 'Nozzle length of level 1');
model.param.set('L24', '1.5[mm]', 'Nozzle length of levels 2-4');
model.param.set('R0', '1.275[mm]', 'Nozzle radius of level 0');
model.param.set('R1', '0.94[mm]', 'Nozzle radius of level 1');
model.param.set('R2', '0.457[mm]', 'Nozzle radius of level 2');
model.param.set('R3', '0.3555[mm]', 'Nozzle radius of level 3');
model.param.set('R4', '0.2665[mm]', 'Nozzle radius of level 4');
model.param.set('Gap0', '2.02[mm]');
model.param.set('Gap1', '2.15[mm]');
model.param.set('Ri', '10.2[mm]', 'Inlet radius');
model.param.set('Ti', '22[mm]', 'Inlet depth');
model.param.set('Rpsb', '40[mm]', 'Preseparator base radius');
model.param.set('Tpsb', '6.5[mm]', 'Preseparator base thickness');
model.param.set('Rch', '44[mm]', 'Collector plate holder radius');
model.param.set('Tch', '5.2[mm]', 'Collector plate holder thickness');
model.param.set('Rc', '39[mm]', 'Chamber radius');
model.param.set('Tc', '15.8[mm]', 'Chamber thickness');
model.param.set('Rcol12', 'Rcol35-10[mm]', 'Collector plate radius for top two stages');
model.param.set('Tcol', '1[mm]', 'Collector plate thickness');
model.param.set('Re', '10[mm]', 'Exit radius');
model.param.set('Te', '22[mm]', 'Exit thickness');
model.param.set('Tps', '26.8[mm]');
model.param.set('D12', '6.5[mm]', 'Distance between nozzles on first two stages');
model.param.set('D35', '4.15[mm]', 'Distance between nozzles on bottom three stages');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'Ri' 'Ti'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'Rpsb' 'Tpsb'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'0' '-Tps'});
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'Ri', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', '0.925*Rpsb', 2, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'Tpsb-Tps', 2, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 0, 3, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'Tpsb-Tps', 3, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'Rch' 'Tch'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', {'0' '-Tps-L0-Tch'});
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', {'Rc' 'Tc'});
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', {'0' '-Tps-L0-Tch-Tc'});
model.geom('geom1').feature('wp1').geom.run('r4');
model.geom('geom1').feature('wp1').geom.create('r5', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r5').set('size', {'Rcol12' 'Tcol'});
model.geom('geom1').feature('wp1').geom.feature('r5').set('pos', {'Rcol35-Rcol12' '0'});
model.geom('geom1').feature('wp1').geom.feature('r5').setIndex('pos', '-Tps-L0-Gap0-Tcol', 1);
model.geom('geom1').feature('wp1').geom.run('r5');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r3'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r5'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'dif1' 'r4'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', [1 2]);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'0' '-L1-Tch-Tc'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').feature('wp1').geom.create('r6', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r6').set('size', {'Rch' 'Tch'});
model.geom('geom1').feature('wp1').geom.feature('r6').set('pos', {'0' '-Tps-L0-L1-L24-3*Tch-2*Tc'});
model.geom('geom1').feature('wp1').geom.run('r6');
model.geom('geom1').feature('wp1').geom.create('r7', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r7').set('size', {'Rc' 'Tc'});
model.geom('geom1').feature('wp1').geom.feature('r7').set('pos', {'0' '-Tps-L0-L1-L24-3*Tch-3*Tc'});
model.geom('geom1').feature('wp1').geom.run('r7');
model.geom('geom1').feature('wp1').geom.create('r8', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r8').set('size', {'Rcol35' 'Tcol'});
model.geom('geom1').feature('wp1').geom.feature('r8').set('pos', {'0' '-Tps-L0-L1-L24-2*Tch-2*Tc-Gap1-Tcol'});
model.geom('geom1').feature('wp1').geom.run('r8');
model.geom('geom1').feature('wp1').geom.create('dif2', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif2').selection('input').set({'r6'});
model.geom('geom1').feature('wp1').geom.feature('dif2').selection('input2').set({'r8'});
model.geom('geom1').feature('wp1').geom.run('dif2');
model.geom('geom1').feature('wp1').geom.create('arr2', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr2').selection('input').set({'dif2' 'r7'});
model.geom('geom1').feature('wp1').geom.feature('arr2').set('fullsize', [1 3]);
model.geom('geom1').feature('wp1').geom.feature('arr2').set('displ', {'0' '-L24-Tch-Tc'});
model.geom('geom1').feature('wp1').geom.run('arr2');
model.geom('geom1').feature('wp1').geom.create('r9', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r9').set('size', {'Re' 'Te'});
model.geom('geom1').feature('wp1').geom.feature('r9').set('pos', {'0' '-Tps-L0-L1-3*L24-5*Tch-5*Tc-Te'});
model.geom('geom1').feature('wp1').geom.run('r9');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle1', -15);
model.geom('geom1').feature('rev1').set('angle2', 15);
model.geom('geom1').run('rev1');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('All Nozzles');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Thin Nozzles');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R0');
model.geom('geom1').feature('cyl1').set('h', 'L0');
model.geom('geom1').feature('cyl1').set('pos', {'14[mm]' '0' '-Tps-L0'});
model.geom('geom1').run('cyl1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'cyl1'});
model.geom('geom1').feature('arr1').set('fullsize', [4 1 1]);
model.geom('geom1').feature('arr1').set('displ', {'D12' '0' '0'});
model.geom('geom1').feature('arr1').set('contributeto', 'csel1');
model.geom('geom1').run('arr1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'R1');
model.geom('geom1').feature('cyl2').set('h', 'L1');
model.geom('geom1').feature('cyl2').set('pos', {'14[mm]' '0' '-Tps-L0-Tch-Tc-L1'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').set({'cyl2'});
model.geom('geom1').feature('arr2').set('fullsize', [4 1 1]);
model.geom('geom1').feature('arr2').set('displ', {'D12' '0' '0'});
model.geom('geom1').feature('arr2').set('contributeto', 'csel1');
model.geom('geom1').run('arr2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'R2');
model.geom('geom1').feature('cyl3').set('h', 'L24');
model.geom('geom1').feature('cyl3').set('pos', {'5[mm]' '0' '-Tps-L0-L1-2*Tch-2*Tc-L24'});
model.geom('geom1').run('cyl3');
model.geom('geom1').create('arr3', 'Array');
model.geom('geom1').feature('arr3').selection('input').set({'cyl3'});
model.geom('geom1').feature('arr3').set('fullsize', [8 1 1]);
model.geom('geom1').feature('arr3').set('displ', {'D35' '0' '0'});
model.geom('geom1').feature('arr3').set('contributeto', 'csel2');
model.geom('geom1').run('arr3');
model.geom('geom1').create('arr4', 'Array');
model.geom('geom1').feature('arr4').selection('input').named('csel2');
model.geom('geom1').feature('arr4').set('fullsize', [1 1 3]);
model.geom('geom1').feature('arr4').set('displ', {'0' '0' '-L24-Tch-Tc'});
model.geom('geom1').feature('arr4').set('contributeto', 'csel2');
model.geom('geom1').run('arr4');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').named('csel2');
model.geom('geom1').feature('rot1').set('rot', '-7.5 7.5');
model.geom('geom1').feature('rot1').set('contributeto', 'csel1');
model.geom('geom1').run('rot1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'arr1' 'arr2' 'rev1' 'rot1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('cascade_impactor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
