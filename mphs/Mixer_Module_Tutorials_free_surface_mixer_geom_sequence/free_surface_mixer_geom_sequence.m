function out = model
%
% free_surface_mixer_geom_sequence.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Mixer_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.set('C', '47.2[mm]');
model.param.descr('C', 'Agitator clearance');
model.param.set('D', '260[mm]');
model.param.descr('D', 'Agitator diameter');
model.param.set('Hliq', '700[mm]');
model.param.descr('Hliq', 'Initial liquid height');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'free_surface_mixer.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('sca1', 'Scale');
model.geom('geom1').feature('sca1').selection('input').set({'imp1'});
model.geom('geom1').feature('sca1').set('isotropic', '1e-3');
model.geom('geom1').run('sca1');
model.geom('geom1').create('cone1', 'Cone');
model.geom('geom1').feature('cone1').set('specifytop', 'radius');
model.geom('geom1').feature('cone1').set('r', 'D/2');
model.geom('geom1').feature('cone1').set('h', '2.75*C');
model.geom('geom1').feature('cone1').set('rtop', 'D*0.75');
model.geom('geom1').feature('cone1').set('axistype', 'y');
model.geom('geom1').run('cone1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'sca1'});
model.geom('geom1').feature('par1').selection('tool').set({'cone1'});
model.geom('geom1').run('par1');
model.geom('geom1').create('spl1', 'Split');
model.geom('geom1').feature('spl1').selection('input').set({'par1'});
model.geom('geom1').run('spl1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').set('quicky', 'Hliq*2/3');
model.geom('geom1').run('wp1');
model.geom('geom1').create('par2', 'Partition');
model.geom('geom1').feature('par2').selection('input').set({'spl1(1)'});
model.geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.geom('geom1').run('par2');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'xz');
model.geom('geom1').feature('wp2').set('quicky', '0.301[m]');
model.geom('geom1').run('wp2');
model.geom('geom1').create('par3', 'Partition');
model.geom('geom1').feature('par3').selection('input').set({'par2'});
model.geom('geom1').feature('par3').set('partitionwith', 'workplane');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');
model.geom('geom1').create('clf1', 'CollapseFaces');
model.geom('geom1').feature('clf1').set('ignoremerged', true);
model.geom('geom1').feature('clf1').selection('input').set('fin', [68 76 81 87]);
model.geom('geom1').run('clf1');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('clf1', [130 131 137 138 160 161 162]);
model.geom('geom1').run('ige1');
model.geom('geom1').create('clf2', 'CollapseFaces');
model.geom('geom1').feature('clf2').set('ignoremerged', true);
model.geom('geom1').feature('clf2').selection('input').set('ige1', [68 76 78 81]);
model.geom('geom1').run('clf2');
model.geom('geom1').create('ige2', 'IgnoreEdges');
model.geom('geom1').feature('ige2').selection('input').set('clf2', [140 141 142 143 147 148 149]);
model.geom('geom1').run('ige2');
model.geom('geom1').create('clf3', 'CollapseFaces');
model.geom('geom1').feature('clf3').set('ignoremerged', true);
model.geom('geom1').feature('clf3').selection('input').set('ige2', [80 84 87 90]);
model.geom('geom1').run('clf3');
model.geom('geom1').create('ige3', 'IgnoreEdges');
model.geom('geom1').feature('ige3').selection('input').set('clf3', [168 169 173 174 179 180 181]);
model.geom('geom1').run('ige3');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('ige3', [4 5 76 77]);
model.geom('geom1').feature('cmf1').selection('input').clear('ige3');
model.geom('geom1').feature('cmf1').selection('input').set('ige3', [4 5 25 26]);
model.geom('geom1').run('cmf1');
model.geom('geom1').create('cmf2', 'CompositeFaces');
model.geom('geom1').feature('cmf2').selection('input').set('cmf1', [46 47 73 74]);
model.geom('geom1').run('cmf2');
model.geom('geom1').create('cmf3', 'CompositeFaces');
model.geom('geom1').feature('cmf3').selection('input').set('cmf2', [48 49]);
model.geom('geom1').run('cmf3');
model.geom('geom1').create('cmf4', 'CompositeFaces');
model.geom('geom1').feature('cmf4').selection('input').set('cmf3', [1 2 3 24]);
model.geom('geom1').run('cmf4');
model.geom('geom1').create('cmf5', 'CompositeFaces');
model.geom('geom1').feature('cmf5').selection('input').set('cmf4', [5 8 10 17 18 19 29 31 33 38 39 40]);
model.geom('geom1').run('cmf5');
model.geom('geom1').create('ige4', 'IgnoreEdges');
model.geom('geom1').feature('ige4').selection('input').set('cmf5', [98 101 102 103 112 113 119 120 121 122]);
model.geom('geom1').run('ige4');
model.geom('geom1').create('cmf6', 'CompositeFaces');
model.geom('geom1').feature('cmf6').selection('input').set('ige4', [53 54]);
model.geom('geom1').run('cmf6');
model.geom('geom1').create('mcf1', 'MeshControlFaces');
model.geom('geom1').feature('mcf1').selection('input').set('cmf6', 6);
model.geom('geom1').run('mcf1');

model.view('view1').set('transparency', true);
model.view('view1').camera.setIndex('position', -1.729, 0);
model.view('view1').camera.set('zoomanglefull', '16.50');
model.view('view1').camera.setIndex('position', 2.09, 1);
model.view('view1').camera.set('position', [-1.729 2.09 -4.756]);
model.view('view1').camera.set('target', [0 0.35 2.38E-6]);
model.view('view1').camera.setIndex('up', 0.105, 0);
model.view('view1').camera.setIndex('up', 0.946, 1);
model.view('view1').camera.set('up', [0.105 0.946 0.308]);
model.view('view1').camera.setIndex('rotationpoint', '0.0', 0);
model.view('view1').camera.set('rotationpoint', {'0.0' '0.35' '0.0'});
model.view('view1').camera.setIndex('viewoffset', -0.00771, 0);
model.view('view1').camera.set('viewoffset', [-0.00771 0.02485]);
model.view('view1').set('transparency', false);

model.title([]);

model.description('');

model.label('free_surface_mixer_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
