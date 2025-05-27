function out = model
%
% loudspeaker_spider_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Shape_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '8[mm]');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('pos', {'74[mm]' '0'});
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', '1.5[mm]', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'42[mm]' '35[mm]'});
model.geom('geom1').feature('r1').set('pos', {'6[mm]' '-87[mm]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'35.5[mm]' '20[mm]'});
model.geom('geom1').feature('r2').set('pos', {'15.5[mm]' '-80[mm]'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'1.2[mm]' '8[mm]'});
model.geom('geom1').feature('r3').set('pos', {'17.8[mm]' '-60[mm]'});
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'26[mm]' '20[mm]'});
model.geom('geom1').feature('r4').set('pos', {'25[mm]' '-80[mm]'});
model.geom('geom1').run('r4');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '48[mm] 36[mm] 36[mm] 48[mm]');
model.geom('geom1').feature('pol1').set('y', '-82[mm] -87[mm] -87[mm] -87[mm]');
model.geom('geom1').run('pol1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'pol1' 'r2' 'r3'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'0.2[mm]' '25[mm]'});
model.geom('geom1').feature('r5').set('pos', {'18.2[mm]' '-64[mm]'});
model.geom('geom1').feature('r5').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r5').setIndex('layer', '1.26[mm]', 0);
model.geom('geom1').feature('r5').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('r5').setIndex('layer', '3.84[mm]', 1);
model.geom('geom1').feature('r5').setIndex('layername', 'Layer 3', 2);
model.geom('geom1').feature('r5').setIndex('layer', '0.4[mm]', 2);
model.geom('geom1').feature('r5').set('layerbottom', false);
model.geom('geom1').feature('r5').set('layertop', true);
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', {'0.6[mm]' '9.4[mm]'});
model.geom('geom1').feature('r6').set('pos', {'18.2[mm]' '-60.7[mm]'});
model.geom('geom1').run('r6');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', '18.4 [mm] 23[mm] 26[mm] 26[mm] 32[mm] 32[mm] 38[mm] 38[mm] 44[mm] 44[mm] 50[mm] 50[mm] 56[mm] 56[mm] 59[mm] 66[mm] 66[mm] 59[mm] 56[mm] 56[mm] 50[mm] 50[mm] 44[mm] 44[mm] 38[mm] 38[mm] 32[mm] 32[mm] 26[mm] 26[mm] 23[mm] 18.4 [mm]');
model.geom('geom1').feature('pol2').set('y', '-44.1[mm] -44.1[mm] -42.1[mm] -42.1[mm] -46.1[mm] -46.1[mm] -42.1[mm] -42.1[mm] -46.1[mm] -46.1[mm]  -42.1[mm] -42.1[mm] -46.1[mm] -46.1[mm] -44.1[mm] -44.1[mm] -44.5[mm] -44.5[mm] -46.5[mm] -46.5[mm]  -42.5[mm] -42.5[mm] -46.5[mm] -46.5[mm]  -42.5[mm] -42.5[mm] -46.5[mm] -46.5[mm]  -42.5[mm] -42.5[mm] -44.5[mm] -44.5[mm]');
model.geom('geom1').run('pol2');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'vectors');
model.geom('geom1').feature('pol3').set('x', '18.4[mm] 66[mm] 66[mm] 67.5[mm] 67.5[mm] 18.4[mm] 18.4[mm] 18.4[mm]');
model.geom('geom1').feature('pol3').set('y', '-39[mm] 0 0 0 0 -40.26[mm] -40.26[mm] -39[mm]');
model.geom('geom1').run('pol3');
model.geom('geom1').create('qb1', 'QuadraticBezier');
model.geom('geom1').feature('qb1').setIndex('p', '-18.2[mm]', 0, 0);
model.geom('geom1').feature('qb1').setIndex('p', '18.2[mm]', 0, 2);
model.geom('geom1').feature('qb1').setIndex('p', '-39[mm]', 1, 0);
model.geom('geom1').feature('qb1').setIndex('p', '-23.5[mm]', 1, 1);
model.geom('geom1').feature('qb1').setIndex('p', '-39[mm]', 1, 2);
model.geom('geom1').feature('qb1').set('w', [1 1 1]);
model.geom('geom1').run('qb1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'18.2[mm]' '0'});
model.geom('geom1').feature('ls1').set('coord2', {'18.2[mm]' '0'});
model.geom('geom1').feature('ls1').set('coord1', {'18.2[mm]' '-39[mm]'});
model.geom('geom1').feature('ls1').set('coord2', {'18.2[mm]' '-40.26[mm]'});
model.geom('geom1').run('ls1');
model.geom('geom1').create('qb2', 'QuadraticBezier');
model.geom('geom1').feature('qb2').setIndex('p', '18.2[mm]', 0, 0);
model.geom('geom1').feature('qb2').setIndex('p', '-18.2[mm]', 0, 2);
model.geom('geom1').feature('qb2').setIndex('p', '-40.26[mm]', 1, 0);
model.geom('geom1').feature('qb2').setIndex('p', '-24.26[mm]', 1, 1);
model.geom('geom1').feature('qb2').setIndex('p', '-40.26[mm]', 1, 2);
model.geom('geom1').feature('qb2').set('w', [1 1 1]);
model.geom('geom1').run('qb2');
model.geom('geom1').create('r7', 'Rectangle');
model.geom('geom1').feature('r7').set('size', {'18.2 [mm]' '20 [mm]'});
model.geom('geom1').feature('r7').set('pos', {'0 [mm]' '-40.26 [mm]'});
model.geom('geom1').run('r7');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'qb1' 'qb2' 'r7'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('c1', [2 3]);
model.geom('geom1').feature('del1').selection('input').set('uni1', [1 2 4 5 7 8 9]);
model.geom('geom1').run('del1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('dif1', [5 6 7 8]);
model.geom('geom1').feature('fil1').set('radius', '0.2[mm]');
model.geom('geom1').run('fil1');
model.geom('geom1').create('r8', 'Rectangle');
model.geom('geom1').feature('r8').set('size', {'47.8 [mm]' '0.4 [mm]'});
model.geom('geom1').feature('r8').set('pos', {'18.2 [mm]' '-49.7 [mm]'});
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Voice Coil');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 11);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Composite');
model.geom('geom1').feature('sel2').selection('selection').set('fin', [1 10 14]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Cloth');
model.geom('geom1').feature('sel3').selection('selection').set('fin', [12 13]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Former');
model.geom('geom1').feature('sel4').selection('selection').set('fin', [3 4 5 6 7 8 9]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Foam');
model.geom('geom1').feature('sel5').selection('selection').set('fin', [17 18]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Shape Optimization');
model.geom('geom1').feature('sel6').selection('selection').set('fin', 12);
model.geom('geom1').run('sel6');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Structural Domains');
model.geom('geom1').feature('unisel1').set('input', {'sel1' 'sel2' 'sel3' 'sel4' 'sel5'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('Fixed Boundaries 1');
model.geom('geom1').feature('sel7').selection('selection').init(1);
model.geom('geom1').feature('sel7').selection('selection').set('fin', [72 75]);
model.geom('geom1').run('sel7');
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').label('Fixed Boundaries 2');
model.geom('geom1').feature('sel8').selection('selection').init(1);
model.geom('geom1').feature('sel8').selection('selection').set('fin', [71 75]);
model.geom('geom1').run('sel8');

model.title([]);

model.description('');

model.label('loudspeaker_spider_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
