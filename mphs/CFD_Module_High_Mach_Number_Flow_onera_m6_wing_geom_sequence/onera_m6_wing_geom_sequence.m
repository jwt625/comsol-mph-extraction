function out = model
%
% onera_m6_wing_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/High_Mach_Number_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('C0', '0.8059[m]');
model.param.descr('C0', 'Chord length at the wing base');
model.param.set('B', '1.1963[m]');
model.param.descr('B', 'Span of the wing');
model.param.set('D', '10*C0');
model.param.descr('D', 'Distance to far-field boundaries');
model.param.set('YbyB_1', '0.20[1]');
model.param.descr('YbyB_1', 'Wing section 1');
model.param.set('YbyB_2', '0.44[1]');
model.param.descr('YbyB_2', 'Wing section 2');
model.param.set('YbyB_3', '0.65[1]');
model.param.descr('YbyB_3', 'Wing section 3');
model.param.set('YbyB_4', '0.80[1]');
model.param.descr('YbyB_4', 'Wing section 4');
model.param.set('YbyB_5', '0.90[1]');
model.param.descr('YbyB_5', 'Wing section 5');
model.param.set('YbyB_6', '0.95[1]');
model.param.descr('YbyB_6', 'Wing section 6');
model.param.set('YbyB_7', '0.99[1]');
model.param.descr('YbyB_7', 'Wing section 7');
model.param.set('ALPHA', '3.06[deg]');
model.param.descr('ALPHA', 'Angle of attack');

model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'D');
model.geom('geom1').feature('wp1').geom.feature('c1').set('angle', 180);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'-C0/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('c1').set('rot', -90);
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').feature('rev1').set('pos', {'-C0/2' '0'});
model.geom('geom1').run('rev1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yz');
model.geom('geom1').feature('wp2').set('quickx', '-D');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'D');
model.geom('geom1').feature('wp2').geom.feature('c1').set('angle', 180);
model.geom('geom1').feature('wp2').geom.feature('c1').set('rot', -90);
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp2');
model.geom('geom1').feature('ext1').selection('input').set({'wp2'});
model.geom('geom1').feature('ext1').setIndex('distance', 'D-C0/2', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'onera_m6_wing.igs');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickplane', 'xz');
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 'D');
model.geom('geom1').feature('wp3').geom.feature('c1').set('angle', 180);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', {'-C0/2' '0'});
model.geom('geom1').feature('wp3').geom.feature('c1').set('rot', -90);
model.geom('geom1').run('wp3');
model.geom('geom1').create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('csol1').selection('input').set({'imp1' 'wp3'});
model.geom('geom1').run('csol1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'csol1'});
model.geom('geom1').feature('rot1').set('axistype', 'y');
model.geom('geom1').feature('rot1').set('rot', 'ALPHA');
model.geom('geom1').run('rot1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'rev1'});
model.geom('geom1').feature('dif1').selection('input2').set({'rot1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('quickplane', 'xz');
model.geom('geom1').feature('wp4').set('quicky', 'YbyB_1*B');
model.geom('geom1').feature('wp4').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r1').set('size', [1.5 0.5]);
model.geom('geom1').feature('wp4').geom.feature('r1').set('pos', [0 -0.25]);
model.geom('geom1').run('wp4');
model.geom('geom1').create('int1', 'Intersection');
model.geom('geom1').feature('int1').selection('input').set({'dif1' 'wp4'});
model.geom('geom1').feature('int1').set('keep', true);
model.geom('geom1').feature.duplicate('wp5', 'wp4');
model.geom('geom1').feature('wp5').set('quicky', 'YbyB_2*B');
model.geom('geom1').run('wp5');
model.geom('geom1').create('int2', 'Intersection');
model.geom('geom1').feature('int2').selection('input').set({'dif1' 'wp5'});
model.geom('geom1').feature('int2').set('keep', true);
model.geom('geom1').feature.duplicate('wp6', 'wp5');
model.geom('geom1').feature('wp6').set('quicky', 'YbyB_3*B');
model.geom('geom1').run('wp6');
model.geom('geom1').create('int3', 'Intersection');
model.geom('geom1').feature('int3').selection('input').set({'dif1' 'wp6'});
model.geom('geom1').feature('int3').set('keep', true);
model.geom('geom1').feature.duplicate('wp7', 'wp6');
model.geom('geom1').feature('wp7').set('quicky', 'YbyB_4*B');
model.geom('geom1').run('wp7');
model.geom('geom1').create('int4', 'Intersection');
model.geom('geom1').feature('int4').selection('input').set({'dif1' 'wp7'});
model.geom('geom1').feature('int4').set('keep', true);
model.geom('geom1').feature.duplicate('wp8', 'wp7');
model.geom('geom1').feature('wp8').set('quicky', 'YbyB_5*B');
model.geom('geom1').run('wp8');
model.geom('geom1').create('int5', 'Intersection');
model.geom('geom1').feature('int5').selection('input').set({'dif1' 'wp8'});
model.geom('geom1').feature('int5').set('keep', true);
model.geom('geom1').feature.duplicate('wp9', 'wp8');
model.geom('geom1').feature('wp9').set('quicky', 'YbyB_6*B');
model.geom('geom1').run('wp9');
model.geom('geom1').create('int6', 'Intersection');
model.geom('geom1').feature('int6').selection('input').set({'dif1' 'wp9'});
model.geom('geom1').feature('int6').set('keep', true);
model.geom('geom1').feature.duplicate('wp10', 'wp9');
model.geom('geom1').feature('wp10').set('quicky', 'YbyB_7*B');
model.geom('geom1').run('wp10');
model.geom('geom1').create('int7', 'Intersection');
model.geom('geom1').feature('int7').selection('input').set({'dif1' 'wp10'});
model.geom('geom1').feature('int7').set('keep', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('igf1', 'IgnoreFaces');
model.geom('geom1').feature('igf1').selection('input').set('fin', 6);
model.geom('geom1').run('igf1');
model.geom('geom1').create('igf2', 'IgnoreFaces');
model.geom('geom1').feature('igf2').selection('input').set('igf1', [7 8 9 10 11 12 13]);
model.geom('geom1').run('igf2');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('igf2', 5);
model.geom('geom1').run('ige1');
model.geom('geom1').create('igf3', 'IgnoreFaces');
model.geom('geom1').feature('igf3').selection('input').set('ige1', [9 12 15 18 21 24 27]);
model.geom('geom1').feature('igf3').set('ignoreadj', false);
model.geom('geom1').run('igf3');

model.title([]);

model.description('');

model.label('onera_m6_wing_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
