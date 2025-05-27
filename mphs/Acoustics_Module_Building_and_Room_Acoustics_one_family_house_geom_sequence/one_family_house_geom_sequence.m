function out = model
%
% one_family_house_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Building_and_Room_Acoustics');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('x_s', '-2[m]', 'Source x-coordinate');
model.param.set('y_s', '4[m]', 'Source y-coordinate');
model.param.set('z_s', '0.4[m]', 'Source z-coordinate');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'one_family_house.mphbin');
model.geom('geom1').feature('imp1').importData;

model.view('view1').set('renderwireframe', true);

model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', 'x_s', 0);
model.geom('geom1').feature('pt1').setIndex('p', 'y_s', 1);
model.geom('geom1').feature('pt1').setIndex('p', 'z_s', 2);
model.geom('geom1').run('pt1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [9 5 5]);
model.geom('geom1').feature('blk1').set('pos', [-4.5 4.695 0.3]);
model.geom('geom1').run('blk1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.geom('geom1').feature('dif1').selection('input2').set({'imp1'});
model.geom('geom1').feature('dif1').set('keepsubtract', true);
model.geom('geom1').feature('dif1').set('intbnd', false);
model.geom('geom1').run('dif1');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').selection('vertex1').set('dif1', 6);
model.geom('geom1').feature('ls1').selection('vertex2').set('dif1', 7);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').selection('vertex1').set('dif1', 27);
model.geom('geom1').feature('ls2').selection('vertex2').set('dif1', 29);
model.geom('geom1').run('ls2');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').selection('vertex1').set('dif1', 54);
model.geom('geom1').feature('ls3').selection('vertex2').set('dif1', 55);
model.geom('geom1').run('ls3');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Windows');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('imp1', [1 2 6 37 42 48 104 105 140 156 208 251 252]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Wooden Floors');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('imp1', [8 13 17 26 56 95 118 135 144 191]);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Stairs');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('imp1', [82 128 129 130 153 154 155 170 171 177 179 180 200 201 202 203 213 214 215 216 221 222 223 224 226 227 228 229 230 231 232 233 234]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Ceilings');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('imp1', [14 18 22 27 39 40 57 83 96 119 136 145 186 187 188 192]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Door 1');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('imp1', [107 109]);
model.geom('geom1').nodeGroup.create('grp1');
model.geom('geom1').nodeGroup('grp1').placeAfter('sel4');
model.geom('geom1').nodeGroup('grp1').add('sel5');
model.geom('geom1').nodeGroup('grp1').label('Room Separations');
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Door 2');
model.geom('geom1').feature('sel6').selection('selection').init(2);
model.geom('geom1').feature('sel6').selection('selection').set('imp1', [79 85]);
model.geom('geom1').run('sel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('Door 3');
model.geom('geom1').feature('sel7').selection('selection').init(2);
model.geom('geom1').feature('sel7').selection('selection').set('imp1', [78 80]);
model.geom('geom1').run('sel7');
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').label('Door 4');
model.geom('geom1').feature('sel8').selection('selection').init(2);
model.geom('geom1').feature('sel8').selection('selection').set('imp1', [162 164]);
model.geom('geom1').run('sel8');
model.geom('geom1').create('sel9', 'ExplicitSelection');
model.geom('geom1').feature('sel9').label('Door 5');
model.geom('geom1').feature('sel9').selection('selection').init(2);
model.geom('geom1').feature('sel9').selection('selection').set('imp1', [141 142]);
model.geom('geom1').run('sel9');
model.geom('geom1').create('sel10', 'ExplicitSelection');
model.geom('geom1').feature('sel10').label('Door 6');
model.geom('geom1').feature('sel10').selection('selection').init(2);
model.geom('geom1').feature('sel10').selection('selection').set('imp1', [31 33]);
model.geom('geom1').run('sel10');
model.geom('geom1').create('sel11', 'ExplicitSelection');
model.geom('geom1').feature('sel11').label('Door 7');
model.geom('geom1').feature('sel11').selection('selection').init(2);
model.geom('geom1').feature('sel11').selection('selection').set('imp1', [185 189]);
model.geom('geom1').run('sel11');
model.geom('geom1').create('sel12', 'ExplicitSelection');
model.geom('geom1').feature('sel12').label('Door 8');
model.geom('geom1').feature('sel12').selection('selection').init(2);
model.geom('geom1').feature('sel12').selection('selection').set('imp1', [60 62]);
model.geom('geom1').run('sel12');
model.geom('geom1').create('sel13', 'ExplicitSelection');
model.geom('geom1').feature('sel13').label('Door 9');
model.geom('geom1').feature('sel13').selection('selection').init(2);
model.geom('geom1').feature('sel13').selection('selection').set('imp1', 127);
model.geom('geom1').run('sel13');
model.geom('geom1').create('sel14', 'ExplicitSelection');
model.geom('geom1').feature('sel14').label('Wall Partition');
model.geom('geom1').feature('sel14').selection('selection').init(2);
model.geom('geom1').feature('sel14').selection('selection').set('imp1', [76 93]);
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('one_family_house_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
