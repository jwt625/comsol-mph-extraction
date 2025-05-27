function out = model
%
% pid_control_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Multiphysics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('specify', 'endsangle1');
model.geom('geom1').feature('ca1').set('point1', [-0.01 -0.004]);
model.geom('geom1').feature('ca1').set('point2', [-0.012 -0.002]);
model.geom('geom1').run('ca1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '-0.012 -0.014 -0.014 -0.014 -0.014 -0.012');
model.geom('geom1').feature('pol1').set('y', '-0.002 -0.002 -0.002 0 0 0');
model.geom('geom1').run('pol1');
model.geom('geom1').create('ca2', 'CircularArc');
model.geom('geom1').feature('ca2').set('specify', 'endsangle1');
model.geom('geom1').feature('ca2').set('point1', [-0.012 0]);
model.geom('geom1').feature('ca2').set('point2', [-0.01 0.002]);
model.geom('geom1').feature('ca2').set('angle1', 270);
model.geom('geom1').run('ca2');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', [-0.01 0]);
model.geom('geom1').feature('ls1').set('coord2', [-0.004 0]);
model.geom('geom1').feature('ls1').set('coord1', [-0.01 0.002]);
model.geom('geom1').feature('ls1').set('coord2', [-0.004 0.002]);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ca3', 'CircularArc');
model.geom('geom1').feature('ca3').set('specify', 'endsangle1');
model.geom('geom1').feature('ca3').set('point1', [-0.004 0.002]);
model.geom('geom1').feature('ca3').set('point2', [-0.002 0.004]);
model.geom('geom1').feature('ca3').set('angle1', 270);
model.geom('geom1').run('ca3');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', '-0.002 -0.002 -0.002 0 0 0');
model.geom('geom1').feature('pol2').set('y', '0.004 0.008 0.008 0.008 0.008 0.004');
model.geom('geom1').run('pol2');
model.geom('geom1').create('ca4', 'CircularArc');
model.geom('geom1').feature('ca4').set('specify', 'endsangle1');
model.geom('geom1').feature('ca4').set('point1', [0 0.004]);
model.geom('geom1').feature('ca4').set('point2', [0.002 0.002]);
model.geom('geom1').feature('ca4').set('angle1', 180);
model.geom('geom1').run('ca4');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'table');
model.geom('geom1').feature('pol3').set('type', 'open');
model.geom('geom1').feature('pol3').set('source', 'vectors');
model.geom('geom1').feature('pol3').set('x', '0.002 0.008 0.008');
model.geom('geom1').feature('pol3').set('y', '0.002 0.002 0');
model.geom('geom1').run('pol3');
model.geom('geom1').create('ca5', 'CircularArc');
model.geom('geom1').feature('ca5').set('specify', 'endsangle1');
model.geom('geom1').feature('ca5').set('point1', [0.008 0]);
model.geom('geom1').feature('ca5').set('point2', [0.01 -0.002]);
model.geom('geom1').feature('ca5').set('angle1', 180);
model.geom('geom1').run('ca5');
model.geom('geom1').create('pol4', 'Polygon');
model.geom('geom1').feature('pol4').set('source', 'table');
model.geom('geom1').feature('pol4').set('type', 'open');
model.geom('geom1').feature('pol4').set('source', 'vectors');
model.geom('geom1').feature('pol4').set('x', '0.01 0.012 0.012 0.012 0.012 0.008 -0.01');
model.geom('geom1').feature('pol4').set('y', '-0.002 -0.002 -0.002 -0.004 -0.004 -0.004 -0.004');
model.geom('geom1').run('pol4');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'ca1' 'ca2' 'ca3' 'ca4' 'ca5' 'ls1' 'pol1' 'pol2' 'pol3' 'pol4'});
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('pid_control_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
