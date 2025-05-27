function out = model
%
% angle_beam_ndt_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Ultrasound');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('alpha', '28[deg]', 'Transducer position angle');
model.param.set('W', '20[mm]', 'Wedge width');
model.param.set('H', '10[mm]', 'Wedge height');
model.param.set('L', '12[mm]', 'Wedge lateral side length');
model.param.set('D', '9[mm]', 'Transducer diameter');
model.param.set('H_pzt', '1.55[mm]', 'Piezoelectric crystal height');
model.param.set('H_match', '0.56[mm]', 'Matching layer height');
model.param.set('W_ts', '100[mm]', 'Test sample width');
model.param.set('H_ts', '15[mm]', 'Test sample height');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W' 'H'});
model.geom('geom1').run('r1');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'H-L*sin(alpha)', 1);
model.geom('geom1').run('pt1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', 'L*cos(alpha)', 0);
model.geom('geom1').feature('pt2').setIndex('p', 'H', 1);
model.geom('geom1').run('pt2');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').selection('vertex1').set('pt1', 1);
model.geom('geom1').feature('ls1').selection('vertex2').set('pt2', 1);
model.geom('geom1').run('ls1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'r1'});
model.geom('geom1').feature('par1').selection('tool').set({'ls1'});
model.geom('geom1').run('par1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').set('par1', 2);
model.geom('geom1').run('del1');
model.geom('geom1').create('pt3', 'Point');
model.geom('geom1').feature('pt3').setIndex('p', '(L-D)/2*cos(alpha)', 0);
model.geom('geom1').feature('pt3').setIndex('p', 'H-(L+D)/2*sin(alpha)', 1);
model.geom('geom1').run('pt3');
model.geom('geom1').create('pt4', 'Point');
model.geom('geom1').feature('pt4').setIndex('p', '(L+D)/2*cos(alpha)', 0);
model.geom('geom1').feature('pt4').setIndex('p', 'H-(L-D)/2*sin(alpha)', 1);
model.geom('geom1').run('pt4');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'D' 'H_pzt+H_match'});
model.geom('geom1').feature('r2').set('pos', {'(L-D)/2*cos(alpha)' '0'});
model.geom('geom1').feature('r2').setIndex('pos', 'H-(L+D)/2*sin(alpha)', 1);
model.geom('geom1').feature('r2').set('rot', 'alpha');
model.geom('geom1').feature('r2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r2').setIndex('layer', 'H_match', 0);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'L' '3.5*H_pzt'});
model.geom('geom1').feature('r3').set('pos', {'0' 'H-L*sin(alpha)'});
model.geom('geom1').feature('r3').set('rot', 'alpha');
model.geom('geom1').run('r3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r3'});
model.geom('geom1').feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('dif1').set('keepsubtract', true);
model.geom('geom1').run('dif1');
model.geom('geom1').create('spl1', 'Split');
model.geom('geom1').feature('spl1').selection('input').set({'r2'});
model.geom('geom1').run('spl1');
model.geom('geom1').create('pare1', 'PartitionEdges');
model.geom('geom1').feature('pare1').selection('edge').set('del1', 3);
model.geom('geom1').feature('pare1').set('position', 'projection');
model.geom('geom1').feature('pare1').selection('vertexproj').set('pt3', 1);
model.geom('geom1').feature('pare1').selection('vertexproj').set('pt4', 1);
model.geom('geom1').run('pare1');
model.geom('geom1').create('r4', 'Rectangle');
model.geom('geom1').feature('r4').set('size', {'W_ts' 'H_ts'});
model.geom('geom1').feature('r4').set('pos', {'-W_ts/10' '-H_ts'});
model.geom('geom1').feature('r4').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('r4').setIndex('layer', 'H_ts/2', 0);
model.geom('geom1').feature('r4').set('layerbottom', false);
model.geom('geom1').feature('r4').set('layerleft', true);
model.geom('geom1').feature('r4').set('layerright', true);
model.geom('geom1').run('r4');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0.017, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', -0.01, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0.019, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', -0.009, 1, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'pol1' 'r4'});
model.geom('geom1').run('uni1');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('imprint', true);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('angle_beam_ndt_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
