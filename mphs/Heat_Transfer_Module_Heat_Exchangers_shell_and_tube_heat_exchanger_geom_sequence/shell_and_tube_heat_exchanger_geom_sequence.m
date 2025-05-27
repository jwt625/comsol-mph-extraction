function out = model
%
% shell_and_tube_heat_exchanger_geom_sequence.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Heat_Exchangers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 100);
model.geom('geom1').feature('cyl1').set('h', 500);
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 50);
model.geom('geom1').feature('cyl2').set('h', 750);
model.geom('geom1').feature('cyl2').set('pos', [-125 0 0]);
model.geom('geom1').feature('cyl2').set('axistype', 'x');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 100);
model.geom('geom1').run('sph1');
model.geom('geom1').create('sph2', 'Sphere');
model.geom('geom1').feature('sph2').set('r', 100);
model.geom('geom1').feature('sph2').set('pos', [500 0 0]);
model.geom('geom1').run('sph2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 45);
model.geom('geom1').feature('cyl3').set('h', 132.5);
model.geom('geom1').feature('cyl3').set('pos', [50 0 -132.5]);
model.geom('geom1').feature.duplicate('cyl4', 'cyl3');
model.geom('geom1').feature('cyl4').set('pos', [450 0 0]);
model.geom('geom1').run('cyl4');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'cyl1' 'cyl2' 'cyl3' 'cyl4' 'sph1' 'sph2'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [500 300 300]);
model.geom('geom1').feature('blk1').set('pos', [0 -150 -150]);
model.geom('geom1').feature('blk1').set('layerright', true);
model.geom('geom1').feature('blk1').set('layerbottom', false);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('blk1').setIndex('layer', 100, 0);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 2', 1);
model.geom('geom1').feature('blk1').setIndex('layer', 100, 1);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 3', 2);
model.geom('geom1').feature('blk1').setIndex('layer', 100, 2);
model.geom('geom1').feature('blk1').setIndex('layername', 'Layer 4', 3);
model.geom('geom1').feature('blk1').setIndex('layer', 100, 3);
model.geom('geom1').run('blk1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', [500 300 65]);
model.geom('geom1').feature('blk2').set('pos', [0 -150 -32.5]);
model.geom('geom1').run('blk2');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'uni1'});
model.geom('geom1').feature('par1').selection('tool').set({'blk1' 'blk2'});
model.geom('geom1').run('par1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'yz');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 7.5);
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', [-75 -43.5]);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'c1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', [7 3]);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', [25 43.5]);
model.geom('geom1').feature('wp1').geom.feature.duplicate('c2', 'c1');
model.geom('geom1').feature('wp1').geom.feature('c2').set('pos', [-62.5 -65.25]);
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('arr2', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr2').selection('input').set({'c2'});
model.geom('geom1').feature('wp1').geom.feature('arr2').set('fullsize', [6 4]);
model.geom('geom1').feature('wp1').geom.feature('arr2').set('displ', [25 43.5]);
model.geom('geom1').feature('wp1').geom.run('arr2');
model.geom('geom1').feature('wp1').geom.feature.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init;
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set({'arr1(1,1)' 'arr1(1,3)' 'arr1(7,1)' 'arr1(7,3)' 'arr2(1,1)' 'arr2(1,4)' 'arr2(6,1)' 'arr2(6,4)'});
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('ext1').setIndex('distance', 500, 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('blk3', 'Block');
model.geom('geom1').feature('blk3').set('size', {'1[m]' '150' '400'});
model.geom('geom1').feature('blk3').set('pos', [-200 -150 -200]);
model.geom('geom1').run('blk3');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'ext1' 'par1'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk3'});
model.geom('geom1').run('fin');
model.geom('geom1').create('igf1', 'IgnoreFaces');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('igf1').selection('input').set('fin', [10 17 18 25 26 32 35 38 41 52 55 58 67 70 73 76 87 90 93 102 105 112 125 132 133 138 140 141 147 150 153 156 167 170 173 182 185 188 191 202 205 208 217 220 227 234 237 244 245 252 253 259 262 265 268 279 282 285 294 297 300 303 314 317 320 329 332 339 349 356 357 362 364 365 371 374 377 380 391 394 397 406 409 412 415 426 429 432 441 444 451 458 461 468 469 476 477 483 486 489 492 503 506 509 518 521 524 527 538 541 544 553 556 563 576 578 580 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598]);
model.geom('geom1').run('igf1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Water Domain');
model.geom('geom1').feature('sel1').selection('selection').set('igf1', 1);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Air Domain');
model.geom('geom1').feature('sel2').selection('selection').set('igf1', 2);
model.geom('geom1').run('sel2');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Water Domain, Exterior Boundaries');
model.geom('geom1').feature('adjsel1').set('input', {'sel1'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('adjsel2', 'AdjacentSelection');
model.geom('geom1').feature('adjsel2').label('Air Domain, Exterior Boundaries');
model.geom('geom1').feature('adjsel2').set('input', {'sel2'});
model.geom('geom1').run('adjsel2');
model.geom('geom1').create('adjsel3', 'AdjacentSelection');
model.geom('geom1').feature('adjsel3').label('Baffles');
model.geom('geom1').feature('adjsel3').set('input', {'sel2'});
model.geom('geom1').feature('adjsel3').set('interior', true);
model.geom('geom1').feature('adjsel3').set('exterior', false);
model.geom('geom1').run('adjsel3');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Symmetry');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('ymax', 0);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Inlet Water');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('igf1', 1);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Outlet Water');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('igf1', 339);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Inlet Air');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('igf1', 332);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Outlet Air');
model.geom('geom1').feature('sel6').selection('selection').init(2);
model.geom('geom1').feature('sel6').selection('selection').set('igf1', 89);
model.geom('geom1').run('sel6');
model.geom('geom1').create('difsel1', 'DifferenceSelection');
model.geom('geom1').feature('difsel1').label('Water Domain, Walls');
model.geom('geom1').feature('difsel1').set('entitydim', 2);
model.geom('geom1').feature('difsel1').set('add', {'adjsel1'});
model.geom('geom1').feature('difsel1').set('subtract', {'boxsel1' 'sel3' 'sel4'});
model.geom('geom1').run('difsel1');
model.geom('geom1').create('difsel2', 'DifferenceSelection');
model.geom('geom1').feature('difsel2').set('entitydim', 2);
model.geom('geom1').feature('difsel2').label('Air Domain, Walls');
model.geom('geom1').feature('difsel2').set('add', {'adjsel2' 'adjsel3'});
model.geom('geom1').feature('difsel2').set('subtract', {'boxsel1' 'sel5' 'sel6'});
model.geom('geom1').run('difsel2');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'difsel1' 'difsel2'});
model.geom('geom1').feature('unisel1').label('Walls');
model.geom('geom1').run('unisel1');
model.geom('geom1').create('intsel1', 'IntersectionSelection');
model.geom('geom1').feature('intsel1').label('Water-Air Interface');
model.geom('geom1').feature('intsel1').set('entitydim', 2);
model.geom('geom1').feature('intsel1').set('input', {'difsel1' 'difsel2'});
model.geom('geom1').run('intsel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').set('input', {'adjsel3' 'intsel1'});
model.geom('geom1').feature('unisel2').label('Interior Walls');

model.title([]);

model.description('');

model.label('shell_and_tube_heat_exchanger_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
