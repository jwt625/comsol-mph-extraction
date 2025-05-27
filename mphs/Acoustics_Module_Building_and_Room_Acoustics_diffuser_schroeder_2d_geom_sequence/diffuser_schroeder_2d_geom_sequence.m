function out = model
%
% diffuser_schroeder_2d_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Building_and_Room_Acoustics');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L', '0.61[m]', 'Width of the diffuser');
model.param.set('Lw', '0.09[m]', 'Width of one well');
model.param.set('Li', '0.01[m]', 'Width in between wells');
model.param.set('H', '0.3[m]', 'Height of the diffuser');
model.param.set('d1', '0.15[m]', 'Depth of well 1');
model.param.set('d2', '0.10[m]', 'Depth of well 2');
model.param.set('d3', '0.29[m]', 'Depth of well 3');
model.param.set('d4', '0.20[m]', 'Depth of well 4');
model.param.set('d5', '0.24[m]', 'Depth of well 5');
model.param.set('d6', '0.05[m]', 'Depth of well 6');
model.param.set('r_air', '1[m]', 'Radius of the air domain (for single diffuser)');
model.param.set('r0', '10[m]', 'Evaluation distance');
model.param.set('Hair', '1[m]', 'Height of the air domain');
model.param.set('Hpml', '0.2[m]', 'Thickness of the PML');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.modelNode('comp1').label('Single diffuser');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'Lw' 'd1'});
model.geom('geom1').feature('r1').set('pos', {'-L/2+Li' '-d1'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'Lw' 'd2'});
model.geom('geom1').feature('r2').set('pos', {'-L/2+2*Li+Lw' '0'});
model.geom('geom1').feature('r2').setIndex('pos', '-d2', 1);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'Lw' 'd3'});
model.geom('geom1').feature('r3').set('pos', {'-L/2+3*Li+2*Lw' '0'});
model.geom('geom1').feature('r3').setIndex('pos', '-d3', 1);
model.geom('geom1').run('r3');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'Lw' 'd4'});
model.geom('geom1').feature('r4').set('pos', {'-L/2+4*Li+3*Lw' '0'});
model.geom('geom1').feature('r4').setIndex('pos', '-d4', 1);
model.geom('geom1').run('r4');
model.geom('geom1').create('r5', 'Rectangle');
model.geom('geom1').feature('r5').set('size', {'Lw' 'd5'});
model.geom('geom1').feature('r5').set('pos', {'-L/2+5*Li+4*Lw' '0'});
model.geom('geom1').feature('r5').setIndex('pos', '-d5', 1);
model.geom('geom1').run('r5');
model.geom('geom1').create('r6', 'Rectangle');
model.geom('geom1').feature('r6').set('size', {'Lw' 'd6'});
model.geom('geom1').feature('r6').set('pos', {'-L/2+6*Li+5*Lw' '0'});
model.geom('geom1').feature('r6').setIndex('pos', '-d6', 1);
model.geom('geom1').nodeGroup.create('grp1');
model.geom('geom1').nodeGroup('grp1').placeAfter([]);
model.geom('geom1').nodeGroup('grp1').add('r1');
model.geom('geom1').nodeGroup('grp1').add('r2');
model.geom('geom1').nodeGroup('grp1').add('r3');
model.geom('geom1').nodeGroup('grp1').add('r4');
model.geom('geom1').nodeGroup('grp1').add('r5');
model.geom('geom1').nodeGroup('grp1').add('r6');
model.geom('geom1').nodeGroup('grp1').label('Wells');
model.geom('geom1').run('r6');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').nodeGroup('grp1').remove('c1', false);
model.geom('geom1').feature('c1').set('r', 'r_air');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').run('c1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'c1' 'r1' 'r2' 'r3' 'r4' 'r5' 'r6'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('fin');
model.geom('geom1').run('uni1');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('r', 'r0');
model.geom('geom1').feature('ca1').set('angle2', 180);
model.geom('geom1').run('fin');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.modelNode('comp2').label('5-unit arrangement');

model.geom('geom2').nodeGroup.copy('grp1', 'geom1/grp1');
model.geom('geom2').nodeGroup.duplicate('grp2', 'grp1');
model.geom('geom2').nodeGroup('grp2').label('Wells 1 to the left');
model.geom('geom2').feature('r7').set('pos', {'-3*L/2+Li' '-d1'});
model.geom('geom2').feature('r8').set('pos', {'-3*L/2+2*Li+Lw' '-d2'});
model.geom('geom2').feature('r9').set('pos', {'-3*L/2+3*Li+2*Lw' '-d3'});
model.geom('geom2').feature('r10').set('pos', {'-3*L/2+4*Li+3*Lw' '-d4'});
model.geom('geom2').feature('r11').set('pos', {'-3*L/2+5*Li+4*Lw' '-d5'});
model.geom('geom2').feature('r12').set('pos', {'-3*L/2+6*Li+5*Lw' '-d6'});
model.geom('geom2').nodeGroup.duplicate('grp3', 'grp1');
model.geom('geom2').nodeGroup('grp3').label('Wells 2 to the left');
model.geom('geom2').feature('r13').set('pos', {'-5*L/2+Li' '-d1'});
model.geom('geom2').feature('r14').set('pos', {'-5*L/2+2*Li+Lw' '-d2'});
model.geom('geom2').feature('r15').set('pos', {'-5*L/2+3*Li+2*Lw' '-d3'});
model.geom('geom2').feature('r16').set('pos', {'-5*L/2+4*Li+3*Lw' '-d4'});
model.geom('geom2').feature('r17').set('pos', {'-5*L/2+5*Li+4*Lw' '-d5'});
model.geom('geom2').feature('r18').set('pos', {'-5*L/2+6*Li+5*Lw' '-d6'});
model.geom('geom2').nodeGroup.duplicate('grp4', 'grp1');
model.geom('geom2').nodeGroup('grp4').label('Wells 1 to the right');
model.geom('geom2').feature('r19').set('pos', {'L/2+Li' '-d1'});
model.geom('geom2').feature('r20').set('pos', {'L/2+2*Li+Lw' '-d2'});
model.geom('geom2').feature('r21').set('pos', {'L/2+3*Li+2*Lw' '-d3'});
model.geom('geom2').feature('r22').set('pos', {'L/2+4*Li+3*Lw' '-d4'});
model.geom('geom2').feature('r23').set('pos', {'L/2+5*Li+4*Lw' '-d5'});
model.geom('geom2').feature('r24').set('pos', {'L/2+6*Li+5*Lw' '-d6'});
model.geom('geom2').nodeGroup.duplicate('grp5', 'grp1');
model.geom('geom2').nodeGroup('grp5').label('Wells 2 to the right');
model.geom('geom2').feature('r25').set('pos', {'3*L/2+Li' '-d1'});
model.geom('geom2').feature('r26').set('pos', {'3*L/2+2*Li+Lw' '-d2'});
model.geom('geom2').feature('r27').set('pos', {'3*L/2+3*Li+2*Lw' '-d3'});
model.geom('geom2').feature('r28').set('pos', {'3*L/2+4*Li+3*Lw' '-d4'});
model.geom('geom2').feature('r29').set('pos', {'3*L/2+5*Li+4*Lw' '-d5'});
model.geom('geom2').feature('r30').set('pos', {'3*L/2+6*Li+5*Lw' '-d6'});
model.geom('geom2').run('r30');
model.geom('geom2').create('c1', 'Circle');
model.geom('geom2').nodeGroup('grp5').remove('c1', false);
model.geom('geom2').feature('c1').set('r', '3*r_air');
model.geom('geom2').feature('c1').set('angle', 180);
model.geom('geom2').run('c1');
model.geom('geom2').create('uni1', 'Union');
model.geom('geom2').feature('uni1').selection('input').set({'c1' 'r1' 'r10' 'r11' 'r12' 'r13' 'r14' 'r15' 'r16' 'r17'  ...
'r18' 'r19' 'r2' 'r20' 'r21' 'r22' 'r23' 'r24' 'r25' 'r26'  ...
'r27' 'r28' 'r29' 'r3' 'r30' 'r4' 'r5' 'r6' 'r7' 'r8'  ...
'r9'});
model.geom('geom2').feature('uni1').set('intbnd', false);
model.geom('geom2').run('fin');
model.geom('geom2').run('uni1');
model.geom('geom2').create('ca1', 'CircularArc');
model.geom('geom2').feature('ca1').set('r', 'r0');
model.geom('geom2').feature('ca1').set('angle2', 180);
model.geom('geom2').run('fin');

model.modelNode.create('comp3', true);

model.geom.create('geom3', 2);
model.geom('geom3').model('comp3');

model.mesh.create('mesh3', 'geom3');

model.modelNode('comp3').label('Infinite arrangement');

model.geom('geom3').nodeGroup.copy('grp1', 'geom1/grp1');
model.geom('geom3').run('r6');
model.geom('geom3').create('r7', 'Rectangle');
model.geom('geom3').nodeGroup('grp1').remove('r7', false);
model.geom('geom3').feature('r7').set('size', {'L' 'Hair'});
model.geom('geom3').feature('r7').set('pos', {'-L/2' '0'});
model.geom('geom3').run('r7');
model.geom('geom3').create('uni1', 'Union');
model.geom('geom3').feature('uni1').selection('input').set({'r1' 'r2' 'r3' 'r4' 'r5' 'r6' 'r7'});
model.geom('geom3').feature('uni1').set('intbnd', false);
model.geom('geom3').run('fin');

model.title([]);

model.description('');

model.label('diffuser_schroeder_2d_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
