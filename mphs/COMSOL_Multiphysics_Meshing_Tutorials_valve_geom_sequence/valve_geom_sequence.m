function out = model
%
% valve_geom_sequence.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Meshing_Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('D', '0.1[m]');
model.param.descr('D', 'Pipe diameter');
model.param.set('L', '0.3[m]');
model.param.descr('L', 'Pipe length');
model.param.set('R_valve', '0.09[m]');
model.param.descr('R_valve', 'Radius of the valve');
model.param.set('alpha', '20[deg]');
model.param.descr('alpha', 'Opening angle of the valve');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', '-sqrt(R_valve^2-(D/2)^2)', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-D/2', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-L/2', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-D/2', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-L/2', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'D/2', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-sqrt(R_valve^2-(D/2)^2)', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'D/2', 3, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('r', 'R_valve');
model.geom('geom1').feature('ca1').set('angle1', 146.2510114041114);
model.geom('geom1').feature('ca1').set('angle2', 33.74898859588859);
model.geom('geom1').feature('ca1').set('clockwise', true);
model.geom('geom1').run('ca1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').setIndex('table', 'sqrt(R_valve^2-(D/2)^2)', 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 'D/2', 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'L/2', 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 'D/2', 1, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'L/2', 2, 0);
model.geom('geom1').feature('pol2').setIndex('table', '-D/2', 2, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'sqrt(R_valve^2-(D/2)^2)', 3, 0);
model.geom('geom1').feature('pol2').setIndex('table', '-D/2', 3, 1);
model.geom('geom1').run('pol2');
model.geom('geom1').create('ca2', 'CircularArc');
model.geom('geom1').feature('ca2').set('r', 'R_valve');
model.geom('geom1').feature('ca2').set('angle1', 326.2510114041114);
model.geom('geom1').feature('ca2').set('angle2', -146.2510114041114);
model.geom('geom1').feature('ca2').set('clockwise', true);
model.geom('geom1').run('ca2');
model.geom('geom1').feature.compositeCurves({'pol1' 'ca1' 'pol2' 'ca2'});
model.geom('geom1').feature('cc1').set('type', 'solid');
model.geom('geom1').run('cc1');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('r', 'R_valve');
model.geom('geom1').feature('ca1').set('angle1', 146.2510114041114);
model.geom('geom1').feature('ca1').set('angle2', 33.74898859588859);
model.geom('geom1').feature('ca1').set('clockwise', true);
model.geom('geom1').run('ca1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 'sqrt(R_valve^2-(D/2)^2)', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'D/2', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-sqrt(R_valve^2-(D/2)^2)', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'D/2', 1, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').feature.compositeCurves({'ca1' 'pol1'});
model.geom('geom1').feature('cc2').set('type', 'solid');
model.geom('geom1').run('cc2');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('r', 'R_valve');
model.geom('geom1').feature('ca1').set('angle1', -146.2510114041114);
model.geom('geom1').feature('ca1').set('angle2', 326.2510114041114);
model.geom('geom1').run('ca1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').setIndex('table', 'sqrt(R_valve^2-(D/2)^2)', 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-D/2', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-sqrt(R_valve^2-(D/2)^2)', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', '-D/2', 1, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').feature.compositeCurves({'ca1' 'pol1'});
model.geom('geom1').feature('cc3').set('type', 'solid');
model.geom('geom1').run('cc3');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'cc2' 'cc3'});
model.geom('geom1').feature('rot1').set('rot', 'alpha');
model.geom('geom1').run('rot1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cc1'});
model.geom('geom1').feature('dif1').selection('input2').set({'rot1'});
model.geom('geom1').run('dif1');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('valve_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
