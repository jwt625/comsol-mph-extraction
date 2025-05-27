function out = model
%
% sedimentation_ptmm_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Multiphase_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'TurbulentFlowkeps', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'CompressibleMALT03');
model.physics.create('phtr', 'PhaseTransport', 'geom1', {'s1' 's2'});

model.multiphysics.create('mfmm1', 'MultiphaseFlowMixtureModel', 'geom1', 2);
model.multiphysics('mfmm1').set('multiphaseflow_physics', 'phtr');
model.multiphysics('mfmm1').set('fluidflow_physics', 'spf');
model.multiphysics('mfmm1').selection.all;

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 12, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 12, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', -3.3, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 2, 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', -4, 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0.5, 4, 0);
model.geom('geom1').feature('pol1').setIndex('table', -7, 4, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0.5, 5, 0);
model.geom('geom1').feature('pol1').setIndex('table', -7.4, 5, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 6, 0);
model.geom('geom1').feature('pol1').setIndex('table', -7.4, 6, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 7, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 7, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').set('type', 'open');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', '0 0.4 0.4 0.4');
model.geom('geom1').feature('pol2').set('y', '-5.4 -5.4 -5.4 -3.4');
model.geom('geom1').run('pol2');
model.geom('geom1').create('ca1', 'CircularArc');
model.geom('geom1').feature('ca1').set('specify', 'endsangle1');
model.geom('geom1').feature('ca1').set('point1', [1.6 -2.2]);
model.geom('geom1').feature('ca1').set('point2', [0.4 -3.4]);
model.geom('geom1').feature('ca1').set('angle1', 90);
model.geom('geom1').run('ca1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', [1.6 0]);
model.geom('geom1').feature('ls1').set('coord2', [1.6 0]);
model.geom('geom1').feature('ls1').set('coord1', [1.6 -2.2]);
model.geom('geom1').feature('ls1').set('coord2', [1.6 -2]);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ca2', 'CircularArc');
model.geom('geom1').feature('ca2').set('specify', 'endsangle1');
model.geom('geom1').feature('ca2').set('point1', [1.6 -2]);
model.geom('geom1').feature('ca2').set('point2', [0.2 -3.4]);
model.geom('geom1').feature('ca2').set('angle1', 90);
model.geom('geom1').run('ca2');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'table');
model.geom('geom1').feature('pol3').set('type', 'open');
model.geom('geom1').feature('pol3').set('source', 'vectors');
model.geom('geom1').feature('pol3').set('x', '0.2 0.2 0.2 0 0 0');
model.geom('geom1').feature('pol3').set('y', '-3.4 -5.2 -5.2 -5.2 -5.2 -5.4');
model.geom('geom1').run('pol3');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'ca1' 'ca2' 'ls1' 'pol2' 'pol3'});
model.geom('geom1').run('csol1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 0.05);
model.geom('geom1').feature('c1').set('pos', [0 -3.4]);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [0.4 0.4]);
model.geom('geom1').feature('r1').set('pos', [11.2 -0.4]);
model.geom('geom1').run('r1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'pol1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1' 'csol1' 'r1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [1 0.5]);
model.geom('geom1').feature('r2').set('pos', [11.6 0]);
model.geom('geom1').run('r2');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('r2', [3 4]);
model.geom('geom1').feature('fil1').set('radius', 0.5);
model.geom('geom1').run('fil1');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').set('r', 0.1);
model.geom('geom1').feature('c2').set('pos', [12.1 0]);
model.geom('geom1').run('c2');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'dif1' 'fil1'});
model.geom('geom1').feature('dif2').selection('input2').set({'c2'});
model.geom('geom1').feature('dif2').set('intbnd', false);
model.geom('geom1').run('dif2');
model.geom('geom1').create('pol4', 'Polygon');
model.geom('geom1').feature('pol4').set('source', 'table');
model.geom('geom1').feature('pol4').setIndex('table', 0.19, 0, 0);
model.geom('geom1').feature('pol4').setIndex('table', -3.22, 0, 1);
model.geom('geom1').feature('pol4').setIndex('table', 0.2, 1, 0);
model.geom('geom1').feature('pol4').setIndex('table', -2.9, 1, 1);
model.geom('geom1').run('pol4');
model.geom('geom1').create('pol5', 'Polygon');
model.geom('geom1').feature('pol5').set('source', 'table');
model.geom('geom1').feature('pol5').setIndex('table', 0.2, 0, 0);
model.geom('geom1').feature('pol5').setIndex('table', -2.9, 0, 1);
model.geom('geom1').feature('pol5').setIndex('table', 0.35, 1, 0);
model.geom('geom1').feature('pol5').setIndex('table', -0.25, 1, 1);
model.geom('geom1').run('pol5');
model.geom('geom1').create('pol6', 'Polygon');
model.geom('geom1').feature('pol6').set('source', 'table');
model.geom('geom1').feature('pol6').setIndex('table', 0.2, 0, 0);
model.geom('geom1').feature('pol6').setIndex('table', -0.1, 0, 1);
model.geom('geom1').feature('pol6').setIndex('table', 7.6, 1, 0);
model.geom('geom1').feature('pol6').setIndex('table', -0.6, 1, 1);
model.geom('geom1').run('pol6');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('sedimentation_ptmm_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
