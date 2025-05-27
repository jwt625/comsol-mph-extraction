function out = model
%
% tube_connection_geom_sequence.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Contact_and_Friction');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('pipeDiameter', '360[mm]', 'Inner diameter of pipe');
model.param.set('pipeThickness', '20[mm]', 'Pipe wall thickness');
model.param.set('pipeOuterDiameter', 'pipeDiameter+2*pipeThickness', 'Outer diameter of pipe');
model.param.set('pipeLength', '5*sqrt(pipeDiameter/2*pipeThickness)', 'Length of pipe, to avoid end effects');
model.param.set('flangeThickness', '26[mm]', 'Flange thickness');
model.param.set('flangeDiameter', '520[mm]', 'Outer diameter of flange');
model.param.set('filletRadius', '12[mm]', 'Fillet radius, flange to pipe');
model.param.set('numBolts', '8', 'Number of bolts');
model.param.set('boltHeadDiameter', '1.5*boltDiameter', 'Diameter of bolt head');
model.param.set('boltHeadThickness', '0.6*boltDiameter', 'Thickness of bolt head');
model.param.set('boltDiameter', '24[mm]', 'Bolt diameter');
model.param.set('boltHoleClearance', '2[mm]', 'Diameter clearance between bolt hole and bolt');
model.param.set('boltHoleDiameter', 'boltDiameter+boltHoleClearance', 'Bolt hole diameter');
model.param.set('boltCircle', '470[mm]', 'Diameter of bolt circle');
model.param.set('washerDiameter', 'boltHeadDiameter*1.15', 'Washer diameter');
model.param.set('washerThickness', '1.5[mm]', 'Washer thickness');
model.param.set('axialForce', '500[kN]', 'Axial Force');
model.param.set('bendingMoment', '40[kN*m]', 'Bending moment');
model.param.set('pressure', '30[bar]', 'Internal pipe pressure');
model.param.set('boltPrestressForce', '150[kN]', 'Bolt prestress force');
model.param.set('ps', '1', 'Parameter for spring relaxation');
model.param.set('lp', '0', 'Loading parameter');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'(flangeDiameter-pipeDiameter)/2' '1'});
model.geom('geom1').feature('wp1').geom.feature('r1').setIndex('size', 'pipeLength', 1);
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'pipeDiameter/2' '0'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'(flangeDiameter-pipeDiameter)/2-pipeThickness' '1'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('size', 'pipeLength-flangeThickness', 1);
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'pipeDiameter/2+pipeThickness' '0'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('pos', 'flangeThickness', 1);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('dif1', 3);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'filletRadius');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord1', {'pipeDiameter/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls1').setIndex('coord1', 'flangeThickness+filletRadius', 1);
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'pipeDiameter/2+pipeThickness' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls1').setIndex('coord2', 'flangeThickness+filletRadius', 1);
model.geom('geom1').feature('wp1').geom.feature.duplicate('ls2', 'ls1');
model.geom('geom1').feature('wp1').geom.feature('ls2').setIndex('coord1', 'pipeDiameter/2+pipeThickness+filletRadius', 0);
model.geom('geom1').feature('wp1').geom.feature('ls2').setIndex('coord1', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('ls2').setIndex('coord2', 'flangeThickness', 1);
model.geom('geom1').feature('wp1').geom.feature('ls2').setIndex('coord2', 'pipeDiameter/2+pipeThickness+filletRadius', 0);
model.geom('geom1').feature('wp1').geom.feature.duplicate('ls3', 'ls2');
model.geom('geom1').feature('wp1').geom.feature('ls3').set('coord1', {'pipeDiameter/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('ls3').setIndex('coord2', 'flangeThickness+filletRadius', 1);
model.geom('geom1').feature('wp1').geom.run('ls3');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'fil1' 'ls1' 'ls2' 'ls3'});
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('workplane', 'wp1');
model.geom('geom1').feature('rev1').selection('input').set({'wp1'});
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 180);
model.geom('geom1').run('rev1');
model.geom.load({'part1'}, 'Structural_Mechanics_Module/Bolts/simple_bolt_no_thread_drill.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'hdia', 'boltHeadDiameter');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'hthic', 'boltHeadThickness');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'ndia', 'boltDiameter');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'blen', 'flangeThickness+washerThickness');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'drill', 1);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'dhrc', 'boltHoleClearance/2');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'dhtc', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'dta', 0);
model.geom('geom1').feature('pi1').set('displ', {'boltCircle/2' '0' '0'});
model.geom('geom1').feature('pi1').set('rot', 30);
model.geom('geom1').run('pi1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'pi1(2)'});
model.geom('geom1').feature('rot1').set('rot', '360/numBolts*range(0,1,4)');
model.geom('geom1').feature('rot1').set('selresult', true);
model.geom('geom1').feature('rot1').set('selresultshow', false);
model.geom('geom1').run('rot1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'rev1'});
model.geom('geom1').feature('dif1').selection('input2').named('rot1');
model.geom('geom1').run('dif1');
model.geom('geom1').create('rot2', 'Rotate');
model.geom('geom1').feature('rot2').label('Bolts');
model.geom('geom1').feature('rot2').selection('input').set({'pi1(1)'});
model.geom('geom1').feature('rot2').set('rot', '360/numBolts*range(0,1,4)');
model.geom('geom1').feature('rot2').set('selresult', true);
model.geom('geom1').run('rot2');
model.geom.load({'part2'}, 'Structural_Mechanics_Module/Bolts/flat_washer.mph', {'part1'});
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'odia', 'washerDiameter');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'idia', 'boltDiameter+boltHoleClearance');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'thickness', 'washerThickness');
model.geom('geom1').feature('pi2').set('displ', {'boltCircle/2' '0' '0'});
model.geom('geom1').feature('pi2').setIndex('displ', 'flangeThickness', 2);
model.geom('geom1').feature('pi2').set('rot', 30);
model.geom('geom1').run('pi2');
model.geom('geom1').create('rot3', 'Rotate');
model.geom('geom1').feature('rot3').label('Washers');
model.geom('geom1').feature('rot3').selection('input').set({'pi2'});
model.geom('geom1').feature('rot3').set('rot', '360/numBolts*range(0,1,4)');
model.geom('geom1').feature('rot3').set('selresult', true);
model.geom('geom1').run('rot3');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('rot3');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').named('rot2');
model.geom('geom1').run('pard1');
model.geom('geom1').create('pard2', 'PartitionDomains');
model.geom('geom1').feature('pard2').selection('domain').named('rot3');
model.geom('geom1').run('pard2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').set('ymax', 0);
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature('boxsel1').set('selshow', false);
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').named('boxsel1');
model.geom('geom1').run('del1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'del1' 'dif1' 'pard1(2)' 'pard1(3)' 'pard1(4)'});
model.geom('geom1').feature('mir1').set('axis', [0 1 0]);
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').run('mir1');
model.geom('geom1').feature.duplicate('mir2', 'mir1');
model.geom('geom1').feature('mir2').selection('input').set({'del1' 'dif1' 'mir1' 'pard1(2)' 'pard1(3)' 'pard1(4)'});
model.geom('geom1').feature('mir2').set('axis', [0 0 1]);
model.geom('geom1').run('mir2');

model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);

model.geom('geom1').feature.remove('mir1');
model.geom('geom1').feature.remove('mir2');
model.geom('geom1').run('del1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'flangeDiameter+flangeThickness' '1'});
model.geom('geom1').feature('wp2').geom.feature('r1').setIndex('size', '(flangeDiameter+flangeThickness)/2', 1);
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', {'-(flangeDiameter+flangeThickness)/2' '0'});
model.geom('geom1').feature('wp2').geom.run('r1');
model.geom('geom1').run('wp2');
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').selection('input').named('rot2');
model.geom('geom1').run('uni2');
model.geom('geom1').create('uni3', 'Union');
model.geom('geom1').feature('uni3').selection('input').named('rot3');

model.title([]);

model.description('');

model.label('tube_connection_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
