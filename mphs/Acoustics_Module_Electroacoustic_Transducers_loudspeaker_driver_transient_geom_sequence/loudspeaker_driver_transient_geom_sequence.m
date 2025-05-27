function out = model
%
% loudspeaker_driver_transient_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Electroacoustic_Transducers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '130[mm]');
model.geom('geom1').feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c1').setIndex('layer', '15[mm]', 0);
model.geom('geom1').run('c1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', '8[mm]');
model.geom('geom1').feature('c2').set('angle', 180);
model.geom('geom1').feature('c2').set('pos', {'74[mm]' '0'});
model.geom('geom1').feature('c2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('c2').setIndex('layer', '1.5[mm]', 0);
model.geom('geom1').run('c2');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('c2', [2 3 4]);
model.geom('geom1').feature('del1').set('selresult', true);
model.geom('geom1').run('del1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'70[mm]' '1[mm]'});
model.geom('geom1').feature('r1').set('pos', {'80.5[mm]' '-1[mm]'});
model.geom('geom1').run('r1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('dif1').selection('input2').set({'r1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'42[mm]' '35[mm]'});
model.geom('geom1').feature('r2').set('pos', {'6[mm]' '-87[mm]'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'35.5[mm]' '20[mm]'});
model.geom('geom1').feature('r3').set('pos', {'15.5[mm]' '-80[mm]'});
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'1.2[mm]' '8[mm]'});
model.geom('geom1').feature('r4').set('pos', {'17.8[mm]' '-60[mm]'});
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'26[mm]' '20[mm]'});
model.geom('geom1').feature('r5').set('pos', {'25[mm]' '-80[mm]'});
model.geom('geom1').run('r5');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '48[mm] 36[mm] 36[mm] 48[mm]');
model.geom('geom1').feature('pol1').set('y', '-82[mm] -87[mm] -87[mm] -87[mm]');
model.geom('geom1').run('pol1');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'r2'});
model.geom('geom1').feature('dif2').selection('input2').set({'pol1' 'r3' 'r4'});
model.geom('geom1').feature('dif2').set('selresult', true);
model.geom('geom1').run('dif2');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', {'0.2[mm]' '25[mm]'});
model.geom('geom1').feature('r6').set('pos', {'18.2[mm]' '-64[mm]'});
model.geom('geom1').feature('r6').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r6').setIndex('layer', '1.26[mm]', 0);
model.geom('geom1').feature('r6').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('r6').setIndex('layer', '3.84[mm]', 1);
model.geom('geom1').feature('r6').setIndex('layername', 'Layer 3', 2);
model.geom('geom1').feature('r6').setIndex('layer', '0.4[mm]', 2);
model.geom('geom1').feature('r6').set('layerbottom', false);
model.geom('geom1').feature('r6').set('layertop', true);
model.geom('geom1').run('r6');
model.geom('geom1').create('r7', 'Rectangle');
model.geom('geom1').feature('r7').set('size', {'0.6[mm]' '9.4[mm]'});
model.geom('geom1').feature('r7').set('pos', {'18.2[mm]' '-60.7[mm]'});
model.geom('geom1').run('r7');
model.geom('geom1').create('r8', 'Rectangle');
model.geom('geom1').feature('r8').set('size', {'4.6[mm]' '0.4[mm]'});
model.geom('geom1').feature('r8').set('pos', {'18.4[mm]' '-44.5[mm]'});
model.geom('geom1').run('r8');
model.geom('geom1').create('r9', 'Rectangle');
model.geom('geom1').feature('r9').set('size', {'7[mm]' '0.4[mm]'});
model.geom('geom1').feature('r9').set('pos', {'59[mm]' '-44.5[mm]'});
model.geom('geom1').run('r9');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', '23[mm] 26[mm] 26[mm] 32[mm] 32[mm] 38[mm] 38[mm] 44[mm] 44[mm] 50[mm] 50[mm] 56[mm] 56[mm] 59[mm] 59[mm] 59[mm] 59[mm] 56[mm] 56[mm] 50[mm] 50[mm] 44[mm] 44[mm] 38[mm] 38[mm] 32[mm] 32[mm] 26[mm] 26[mm] 23[mm] 23[mm] 23[mm]');
model.geom('geom1').feature('pol2').set('y', '-44.1[mm] -42.1[mm] -42.1[mm] -46.1[mm] -46.1[mm] -42.1[mm] -42.1[mm] -46.1[mm] -46.1[mm]  -42.1[mm] -42.1[mm] -46.1[mm] -46.1[mm] -44.1[mm] -44.1[mm] -44.5[mm] -44.5[mm] -46.5[mm] -46.5[mm]  -42.5[mm] -42.5[mm] -46.5[mm] -46.5[mm]  -42.5[mm] -42.5[mm] -46.5[mm] -46.5[mm]  -42.5[mm] -42.5[mm] -44.5[mm] -44.5[mm] -44.1');
model.geom('geom1').run('pol2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'pol2' 'r8' 'r9'});
model.geom('geom1').feature('uni1').set('selresult', true);
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
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
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord1', {'-18.2[mm]' '0'});
model.geom('geom1').feature('ls2').set('coord2', {'-18.2[mm]' '0'});
model.geom('geom1').feature('ls2').set('coord1', {'-18.2[mm]' '-40.26[mm]'});
model.geom('geom1').feature('ls2').set('coord2', {'-18.2[mm]' '-39[mm]'});
model.geom('geom1').run('ls2');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'ls1' 'ls2' 'qb1' 'qb2'});
model.geom('geom1').run('csol1');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('ls3').set('coord1', {'0' '-52[mm]'});
model.geom('geom1').feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('ls3').set('coord2', {'sqrt((115[mm])^2 - (52[mm])^2)' '0'});
model.geom('geom1').feature('ls3').setIndex('coord2', '-52[mm]', 1);
model.geom('geom1').feature('ls3').set('selresult', true);
model.geom('geom1').run('ls3');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').set({'csol1' 'del1' 'dif1' 'dif2' 'ls3' 'pol3' 'r5' 'r6' 'r7' 'uni1'});
model.geom('geom1').run('uni2');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').set('uni2', [13 19 33 45]);
model.geom('geom1').run('del2');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('del2', [14 15 35 36]);
model.geom('geom1').feature('fil1').set('radius', '0.2[mm]');
model.geom('geom1').feature('fin').set('repairtoltype', 'relative');
model.geom('geom1').run('fin');
model.geom('geom1').create('igv1', 'IgnoreVertices');
model.geom('geom1').feature('igv1').selection('input').set('fin', [18 26 33]);
model.geom('geom1').run('igv1');

model.title([]);

model.description('');

model.label('loudspeaker_driver_transient_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
