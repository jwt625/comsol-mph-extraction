function out = model
%
% pinched_flow_fractionation_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.label('Geometry parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Li', '0.6[mm]', 'Length of inlets');
model.param.set('Wi', '0.1[mm]', 'Width of inlets');
model.param.set('Ai', '60[deg]', 'Angle between two inlets');
model.param.set('HAi', '0.5*Ai', 'Half of the angle between two inlets');
model.param.set('Lc', '140[um]', 'Length of micro channel');
model.param.set('Wc', '20[um]', 'Width of micro channel');
model.param.set('HWc', '0.5*Wc', 'Half of the micro channel width');
model.param.set('Lb', '1[mm]', 'Length of each outlet branch');
model.param.set('Wb', '0.1[mm]', 'Width of each outlet branch');
model.param.set('Nb', '12', 'Number of outlet branches');
model.param.set('Ldbr', '0.5', 'Ratio of drain to branch length');
model.param.set('Ld', '(1-Ldbr)*Lb', 'Length of drain channel');
model.param.set('Pc', 'cos(HAi)*Li-HWc*tan(Ai)', 'Left corner vertex of channel');
model.param.set('Pb', 'Pc+Lc', 'Left corner vertex of first outlet branch');
model.param.set('Cr', 'Pb+0.5*Wb', 'Center of rotation of outlet branch');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'Li' 'Wi'});
model.geom('geom1').feature('r1').set('pos', {'0' '-sin(HAi)*Li'});
model.geom('geom1').feature('r1').set('rot', 'HAi');
model.geom('geom1').run('r1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'r1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('axis', [0 1]);
model.geom('geom1').run('mir1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '-0.1*Wi*cos(Ai)', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'sin(HAi)*Li-0.1*Wi*sin(Ai)', 1);
model.geom('geom1').run('pt1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', '-0.9*Wi*cos(Ai)', 0);
model.geom('geom1').feature('pt2').setIndex('p', 'sin(HAi)*Li-0.9*Wi*sin(Ai)', 1);
model.geom('geom1').run('pt2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'mir1' 'pt1' 'pt2' 'r1'});
model.geom('geom1').run('uni1');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init;
model.geom('geom1').feature('del1').selection('input').init(1);
model.geom('geom1').feature('del1').selection('input').set('uni1', [9 10 11 13 15 16]);
model.geom('geom1').run('del1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'Pc' 'HWc'});
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord2', {'Pc' '-HWc'});
model.geom('geom1').run('ls1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'del1'});
model.geom('geom1').feature('par1').selection('tool').set({'ls1'});
model.geom('geom1').run('par1');
model.geom('geom1').feature.create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init;
model.geom('geom1').feature('del2').selection('input').init(2);
model.geom('geom1').feature('del2').selection('input').set('par1', 2);
model.geom('geom1').run('del2');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'Lc' 'Wc'});
model.geom('geom1').feature('r2').set('pos', {'Pc' '-HWc'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'Wb' 'Lb'});
model.geom('geom1').feature('r3').set('pos', {'Pb' '0'});
model.geom('geom1').run('r3');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'r3'});
model.geom('geom1').feature('rot1').set('rot', 'range(0,-180/Nb,-180)');
model.geom('geom1').feature('rot1').set('pos', {'Cr' '0'});
model.geom('geom1').feature('rot1').set('selresult', true);
model.geom('geom1').feature('rot1').set('selresultshow', false);
model.geom('geom1').run('rot1');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').named('rot1');
model.geom('geom1').feature('uni2').set('intbnd', false);
model.geom('geom1').run('uni2');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'Wb' 'Ld+0.01*Lb'});
model.geom('geom1').feature('r4').set('pos', {'Pb' '-Lb*1.01'});
model.geom('geom1').run('r4');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'uni2'});
model.geom('geom1').feature('dif1').selection('input2').set({'r4'});
model.geom('geom1').run('dif1');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('pinched_flow_fractionation_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
