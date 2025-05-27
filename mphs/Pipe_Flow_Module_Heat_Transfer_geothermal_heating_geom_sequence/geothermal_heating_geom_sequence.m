function out = model
%
% geothermal_heating_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('pc1', 'ParametricCurve');
model.geom('geom1').feature('pc1').set('parmax', 24);
model.geom('geom1').feature('pc1').set('coord', {'cos(pi*s)' 'sin(pi*s)' ''});
model.geom('geom1').feature('pc1').setIndex('coord', '0.1*s', 2);
model.geom('geom1').run('pc1');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 1, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', 1.1, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 2);
model.geom('geom1').feature('pol1').setIndex('table', 1.1, 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 2.6, 2, 2);
model.geom('geom1').feature('pol1').setIndex('table', 1.1, 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 1.5, 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 2.6, 3, 2);
model.geom('geom1').run('pol1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').setIndex('table', 1, 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 2.4, 0, 2);
model.geom('geom1').feature('pol2').setIndex('table', 1, 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 1.5, 1, 1);
model.geom('geom1').feature('pol2').setIndex('table', 2.4, 1, 2);
model.geom('geom1').run('pol2');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'pc1' 'pol1' 'pol2'});
model.geom('geom1').feature('mir1').set('pos', [0 1.5 0]);
model.geom('geom1').feature('mir1').set('axis', [0 1 0]);
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').set({'mir1' 'pc1' 'pol1' 'pol2'});
model.geom('geom1').feature('arr1').set('fullsize', [4 1 1]);
model.geom('geom1').feature('arr1').set('displ', [-3 0 0]);
model.geom('geom1').run('arr1');
model.geom('geom1').create('pol3', 'Polygon');
model.geom('geom1').feature('pol3').set('source', 'table');
model.geom('geom1').feature('pol3').setIndex('table', 1, 0, 0);
model.geom('geom1').feature('pol3').setIndex('table', 1.5, 0, 1);
model.geom('geom1').feature('pol3').setIndex('table', 2.4, 0, 2);
model.geom('geom1').feature('pol3').setIndex('table', -15, 1, 0);
model.geom('geom1').feature('pol3').setIndex('table', 1.5, 1, 1);
model.geom('geom1').feature('pol3').setIndex('table', 2.4, 1, 2);
model.geom('geom1').run('pol3');
model.geom('geom1').create('pol4', 'Polygon');
model.geom('geom1').feature('pol4').set('source', 'table');
model.geom('geom1').feature('pol4').setIndex('table', 1.1, 0, 0);
model.geom('geom1').feature('pol4').setIndex('table', 1.5, 0, 1);
model.geom('geom1').feature('pol4').setIndex('table', 2.6, 0, 2);
model.geom('geom1').feature('pol4').setIndex('table', -15, 1, 0);
model.geom('geom1').feature('pol4').setIndex('table', 1.5, 1, 1);
model.geom('geom1').feature('pol4').setIndex('table', 2.6, 1, 2);
model.geom('geom1').run('pol4');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').set({'arr1' 'pol3' 'pol4'});
model.geom('geom1').feature('arr2').set('fullsize', [1 2 1]);
model.geom('geom1').feature('arr2').set('displ', [0 10 0]);
model.geom('geom1').run('arr2');
model.geom('geom1').create('pol5', 'Polygon');
model.geom('geom1').feature('pol5').set('source', 'table');
model.geom('geom1').feature('pol5').setIndex('table', -15, 0, 0);
model.geom('geom1').feature('pol5').setIndex('table', 1.5, 0, 1);
model.geom('geom1').feature('pol5').setIndex('table', 2.4, 0, 2);
model.geom('geom1').feature('pol5').setIndex('table', -15, 1, 0);
model.geom('geom1').feature('pol5').setIndex('table', 11.5, 1, 1);
model.geom('geom1').feature('pol5').setIndex('table', 2.4, 1, 2);
model.geom('geom1').feature('pol5').setIndex('table', -28, 2, 0);
model.geom('geom1').feature('pol5').setIndex('table', 11.5, 2, 1);
model.geom('geom1').feature('pol5').setIndex('table', 6, 2, 2);
model.geom('geom1').feature('pol5').setIndex('table', -35, 3, 0);
model.geom('geom1').feature('pol5').setIndex('table', 11.5, 3, 1);
model.geom('geom1').feature('pol5').setIndex('table', 10, 3, 2);
model.geom('geom1').feature('pol5').setIndex('table', -45, 4, 0);
model.geom('geom1').feature('pol5').setIndex('table', 9, 4, 1);
model.geom('geom1').feature('pol5').setIndex('table', 10, 4, 2);
model.geom('geom1').run('pol5');
model.geom('geom1').create('pol6', 'Polygon');
model.geom('geom1').feature('pol6').set('source', 'table');
model.geom('geom1').feature('pol6').setIndex('table', -15, 0, 0);
model.geom('geom1').feature('pol6').setIndex('table', 1.5, 0, 1);
model.geom('geom1').feature('pol6').setIndex('table', 2.6, 0, 2);
model.geom('geom1').feature('pol6').setIndex('table', -15, 1, 0);
model.geom('geom1').feature('pol6').setIndex('table', 11.5, 1, 1);
model.geom('geom1').feature('pol6').setIndex('table', 2.6, 1, 2);
model.geom('geom1').feature('pol6').setIndex('table', -28, 2, 0);
model.geom('geom1').feature('pol6').setIndex('table', 11.5, 2, 1);
model.geom('geom1').feature('pol6').setIndex('table', 6.2, 2, 2);
model.geom('geom1').feature('pol6').setIndex('table', -35, 3, 0);
model.geom('geom1').feature('pol6').setIndex('table', 11.5, 3, 1);
model.geom('geom1').feature('pol6').setIndex('table', 10.2, 3, 2);
model.geom('geom1').feature('pol6').setIndex('table', -45, 4, 0);
model.geom('geom1').feature('pol6').setIndex('table', 9, 4, 1);
model.geom('geom1').feature('pol6').setIndex('table', 10.2, 4, 2);
model.geom('geom1').run('pol6');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'arr2(1,2,1,1)' 'arr2(1,2,1,10)' 'arr2(1,2,1,11)' 'arr2(1,2,1,12)' 'arr2(1,2,1,13)' 'arr2(1,2,1,14)' 'arr2(1,2,1,15)' 'arr2(1,2,1,16)' 'arr2(1,2,1,17)' 'arr2(1,2,1,18)'  ...
'arr2(1,2,1,19)' 'arr2(1,2,1,2)' 'arr2(1,2,1,20)' 'arr2(1,2,1,21)' 'arr2(1,2,1,22)' 'arr2(1,2,1,23)' 'arr2(1,2,1,24)' 'arr2(1,2,1,25)' 'arr2(1,2,1,26)' 'arr2(1,2,1,3)'  ...
'arr2(1,2,1,4)' 'arr2(1,2,1,5)' 'arr2(1,2,1,6)' 'arr2(1,2,1,7)' 'arr2(1,2,1,8)' 'arr2(1,2,1,9)'});
model.geom('geom1').feature('rot1').set('rot', 30);
model.geom('geom1').feature('rot1').set('pos', [-15 11.5 0]);
model.geom('geom1').run('rot1');

model.title([]);

model.description('');

model.label('geothermal_heating_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
