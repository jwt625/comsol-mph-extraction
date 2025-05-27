function out = model
%
% high_voltage_insulator_geom_sequence.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Capacitive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [12 100]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [6 1050]);
model.geom('geom1').feature('r2').set('pos', [0 50]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [12 100]);
model.geom('geom1').feature('r3').set('pos', [0 1050]);
model.geom('geom1').run('r3');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 12, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 100, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 150, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 60, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 150, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 20, 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 153, 3, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('qb1').setIndex('p', 20, 0, 0);
model.geom('geom1').feature('qb1').setIndex('p', 153, 1, 0);
model.geom('geom1').feature('qb1').setIndex('p', 13, 0, 1);
model.geom('geom1').feature('qb1').setIndex('p', 154, 1, 1);
model.geom('geom1').feature('qb1').setIndex('p', 12, 0, 2);
model.geom('geom1').feature('qb1').setIndex('p', 161, 1, 2);
model.geom('geom1').feature('qb1').set('w', [1 1 1]);
model.geom('geom1').run('qb1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').setIndex('table', 12, 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 161, 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 200, 1, 1);
model.geom('geom1').feature('pol2').setIndex('table', 60, 2, 0);
model.geom('geom1').feature('pol2').setIndex('table', 200, 2, 1);
model.geom('geom1').feature('pol2').setIndex('table', 20, 3, 0);
model.geom('geom1').feature('pol2').setIndex('table', 203, 3, 1);
model.geom('geom1').run('pol2');
model.geom('geom1').create('qb2', 'QuadraticBezier');
model.geom('geom1').feature('qb2').setIndex('p', 20, 0, 0);
model.geom('geom1').feature('qb2').setIndex('p', 203, 1, 0);
model.geom('geom1').feature('qb2').setIndex('p', 13, 0, 1);
model.geom('geom1').feature('qb2').setIndex('p', 204, 1, 1);
model.geom('geom1').feature('qb2').setIndex('p', 12, 0, 2);
model.geom('geom1').feature('qb2').setIndex('p', 211, 1, 2);
model.geom('geom1').feature('qb2').set('w', [1 1 1]);
model.geom('geom1').run('qb2');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'table');
model.geom('geom1').feature('pol3').set('type', 'open');
model.geom('geom1').feature('pol3').setIndex('table', 12, 0, 0);
model.geom('geom1').feature('pol3').setIndex('table', 211, 0, 1);
model.geom('geom1').feature('pol3').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol3').setIndex('table', 250, 1, 1);
model.geom('geom1').feature('pol3').setIndex('table', 80, 2, 0);
model.geom('geom1').feature('pol3').setIndex('table', 250, 2, 1);
model.geom('geom1').feature('pol3').setIndex('table', 20, 3, 0);
model.geom('geom1').feature('pol3').setIndex('table', 253, 3, 1);
model.geom('geom1').run('pol3');
model.geom('geom1').create('qb3', 'QuadraticBezier');
model.geom('geom1').feature('qb3').setIndex('p', 20, 0, 0);
model.geom('geom1').feature('qb3').setIndex('p', 253, 1, 0);
model.geom('geom1').feature('qb3').setIndex('p', 13, 0, 1);
model.geom('geom1').feature('qb3').setIndex('p', 254, 1, 1);
model.geom('geom1').feature('qb3').setIndex('p', 12, 0, 2);
model.geom('geom1').feature('qb3').setIndex('p', 261, 1, 2);
model.geom('geom1').feature('qb3').set('w', [1 1 1]);
model.geom('geom1').run('qb3');
model.geom('geom1').feature.compositeCurves({'pol1' 'qb1' 'pol2' 'qb2' 'pol3' 'qb3'});
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'cc1'});
model.geom('geom1').feature('arr1').set('type', 'linear');
model.geom('geom1').feature('arr1').set('linearsize', 5);
model.geom('geom1').feature('arr1').set('displ', [0 161]);
model.geom('geom1').run('arr1');
model.geom('geom1').feature.duplicate('cc2', 'cc1');
model.geom('geom1').run('cc2');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'cc2'});
model.geom('geom1').feature('mov1').set('disply', 794);
model.geom('geom1').run('mov1');
model.geom('geom1').feature('cc2').feature('pol1').setIndex('table', 111, 0, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 256, 1, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 6, 2, 0);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 256, 2, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 6, 3, 0);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', -694, 3, 1);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', 12, 4, 0);
model.geom('geom1').feature('cc2').feature('pol3').setIndex('table', -694, 4, 1);
model.geom('geom1').feature('cc2').feature.removeCurveComponents({'qb3'});
model.geom('geom1').run('mov1');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'arr1' 'mov1'});
model.geom('geom1').run('csol1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('r1', 2);
model.geom('geom1').feature('fil1').selection('point').set('r3', 3);
model.geom('geom1').feature('fil1').set('radius', 8);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '2[m]');
model.geom('geom1').feature('c1').set('pos', [0 500]);
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('high_voltage_insulator_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
