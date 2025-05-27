function out = model
%
% surface_mount_resistor_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fatigue_Module/Energy_Based');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [3.1 0.8]);
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [1.6 0.55]);
model.geom('geom1').feature('r2').set('pos', [1.5 0.9]);
model.geom('geom1').feature('r2').set('selresult', true);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [1.05 0.025]);
model.geom('geom1').feature('r3').set('pos', [0.825 0.8]);
model.geom('geom1').feature('r3').set('selresult', true);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', [0.35 0.6]);
model.geom('geom1').feature('r4').set('pos', [1.475 0.875]);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('NiCr');
model.geom('geom1').feature('r4').set('contributeto', 'csel1');
model.geom('geom1').run('fin');
model.geom('geom1').run('r4');
model.geom('geom1').create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('qb1').setIndex('p', 0.825, 0, 0);
model.geom('geom1').feature('qb1').setIndex('p', 0.825, 1, 0);
model.geom('geom1').feature('qb1').setIndex('p', 1.35, 0, 1);
model.geom('geom1').feature('qb1').setIndex('p', 0.95, 1, 1);
model.geom('geom1').feature('qb1').setIndex('p', 1.475, 0, 2);
model.geom('geom1').feature('qb1').setIndex('p', 1.475, 1, 2);
model.geom('geom1').run('qb1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 1.475, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 1.475, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 1.475, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0.875, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 1.825, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0.875, 2, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('center', [1.875 0.875]);
model.geom('geom1').feature('ca1').set('r', 0.05);
model.geom('geom1').feature('ca1').set('angle1', 180);
model.geom('geom1').feature('ca1').set('angle2', 270);
model.geom('geom1').run('ca1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').selection('vertex1').set('ca1', 2);
model.geom('geom1').feature('ls1').selection('vertex2').set('qb1', 1);
model.geom('geom1').run('ls1');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'ca1' 'ls1' 'pol1' 'qb1'});
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Solder');
model.geom('geom1').feature('csol1').set('contributeto', 'csel2');
model.geom('geom1').run('csol1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 1.48, 0);
model.geom('geom1').feature('pt1').setIndex('p', 0.87, 1);
model.geom('geom1').feature('pt1').set('selresult', true);
model.geom('geom1').run('pt1');
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', 14);
model.geom('geom1').run('ige1');
model.geom('geom1').run('ige1');

model.title([]);

model.description('');

model.label('surface_mount_resistor_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
