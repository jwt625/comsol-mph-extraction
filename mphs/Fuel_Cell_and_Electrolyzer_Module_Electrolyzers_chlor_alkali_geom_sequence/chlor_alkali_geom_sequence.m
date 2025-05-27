function out = model
%
% chlor_alkali_geom_sequence.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fuel_Cell_and_Electrolyzer_Module/Electrolyzers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [3.5 10]);
model.geom('geom1').feature('r1').set('pos', [-3.5 -4]);
model.geom('geom1').run('r1');
model.geom('geom1').create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('qb1').setIndex('p', -2.5, 0, 0);
model.geom('geom1').feature('qb1').setIndex('p', 1.5, 1, 0);
model.geom('geom1').feature('qb1').setIndex('p', -3, 0, 1);
model.geom('geom1').feature('qb1').setIndex('p', 1.8, 1, 1);
model.geom('geom1').feature('qb1').setIndex('p', -3.5, 0, 2);
model.geom('geom1').feature('qb1').setIndex('p', 1.8, 1, 2);
model.geom('geom1').run('qb1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '-3.5 -3.5 -3.5 -2.25 -2.25 -1.5 -1.5 -2.5');
model.geom('geom1').feature('pol1').set('y', '1.8 0.3 0.3 -0.3 -0.3 0.8 0.8 1.5');
model.geom('geom1').run('pol1');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'pol1' 'qb1'});
model.geom('geom1').run('csol1');
model.geom('geom1').create('qb2', 'QuadraticBezier');
model.geom('geom1').feature('qb2').setIndex('p', -1.75, 0, 0);
model.geom('geom1').feature('qb2').setIndex('p', 1.7, 1, 0);
model.geom('geom1').feature('qb2').setIndex('p', -2.55, 0, 1);
model.geom('geom1').feature('qb2').setIndex('p', 2.2, 1, 1);
model.geom('geom1').feature('qb2').setIndex('p', -3.5, 0, 2);
model.geom('geom1').feature('qb2').setIndex('p', 2.2, 1, 2);
model.geom('geom1').run('qb2');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', [-3.5 2.2]);
model.geom('geom1').feature('ls1').set('coord2', [-3.5 2]);
model.geom('geom1').run('ls1');
model.geom('geom1').create('qb3', 'QuadraticBezier');
model.geom('geom1').feature('qb3').setIndex('p', -3.5, 0, 0);
model.geom('geom1').feature('qb3').setIndex('p', 2, 1, 0);
model.geom('geom1').feature('qb3').setIndex('p', -2.63, 0, 1);
model.geom('geom1').feature('qb3').setIndex('p', 2, 1, 1);
model.geom('geom1').feature('qb3').setIndex('p', -1.75, 0, 2);
model.geom('geom1').feature('qb3').setIndex('p', 1.4, 1, 2);
model.geom('geom1').run('qb3');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord1', [-1.75 1.4]);
model.geom('geom1').feature('ls2').set('coord2', [-1.75 1.7]);
model.geom('geom1').run('ls2');
model.geom('geom1').create('csol2', 'ConvertToSolid');
model.geom('geom1').feature('csol2').selection('input').set({'ls1' 'ls2' 'qb2' 'qb3'});
model.geom('geom1').run('csol2');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'csol1' 'csol2'});
model.geom('geom1').feature('rot1').set('keep', true);
model.geom('geom1').feature('rot1').set('rot', 180);
model.geom('geom1').feature('rot1').set('pos', [-1.75 1.55]);
model.geom('geom1').run('rot1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'csol2' 'rot1(2)'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'csol1' 'rot1(1)'});

model.title([]);

model.description('');

model.label('chlor_alkali_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
