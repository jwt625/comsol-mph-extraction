function out = model
%
% fractured_reservoir_flow.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Subsurface_Flow_Module/Fluid_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/dl', true);

model.geom('geom1').insertFile('fractured_reservoir_flow_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.mesh.create('tempmesh1', 'geom1');
model.mesh('tempmesh1').run;

model.result.dataset.create('tempdset1', 'Mesh');
model.result.dataset('tempdset1').set('mesh', 'tempmesh1');
model.result.numerical.create('tempmin1', 'MinVolume');
model.result.numerical('tempmin1').set('data', 'tempdset1');
model.result.numerical.create('tempmax1', 'MaxVolume');
model.result.numerical('tempmax1').set('data', 'tempdset1');
model.result.numerical('tempmin1').selection.all;
model.result.numerical('tempmax1').selection.all;
model.result.numerical('tempmin1').setIndex('expr', 'x', 0);
model.result.numerical('tempmin1').setIndex('expr', 'y', 1);
model.result.numerical('tempmin1').setIndex('expr', 'z', 2);
model.result.numerical('tempmax1').setIndex('expr', 'x', 0);
model.result.numerical('tempmax1').setIndex('expr', 'y', 1);
model.result.numerical('tempmax1').setIndex('expr', 'z', 2);
model.result.numerical('tempmin1').computeResult;
model.result.numerical('tempmax1').computeResult;

model.mesh.remove('tempmesh1');
model.mesh.create('tempmesh1', 'geom1');
model.mesh('tempmesh1').run;

model.result.dataset.create('tempdset1', 'Mesh');
model.result.dataset('tempdset1').set('mesh', 'tempmesh1');
model.result.numerical.create('tempmin1', 'MinVolume');
model.result.numerical('tempmin1').set('data', 'tempdset1');
model.result.numerical.create('tempmax1', 'MaxVolume');
model.result.numerical('tempmax1').set('data', 'tempdset1');
model.result.numerical('tempmin1').selection.named('geom1_sel2');
model.result.numerical('tempmax1').selection.named('geom1_sel2');
model.result.numerical('tempmin1').setIndex('expr', 'x', 0);
model.result.numerical('tempmin1').setIndex('expr', 'y', 1);
model.result.numerical('tempmin1').setIndex('expr', 'z', 2);
model.result.numerical('tempmax1').setIndex('expr', 'x', 0);
model.result.numerical('tempmax1').setIndex('expr', 'y', 1);
model.result.numerical('tempmax1').setIndex('expr', 'z', 2);
model.result.numerical('tempmin1').computeResult;
model.result.numerical('tempmax1').computeResult;

model.mesh.remove('tempmesh1');

model.geom.create('dfnpart1', 'Part', 3);
model.geom('dfnpart1').label('3D Fracture Network 1');

model.param.set('dfn_fractureSize', '5[m]');
model.param.set('dfn_fractureSizeMin', '200[m]');
model.param.set('dfn_fractureSizeMax', '500[m]');
model.param.set('dfn_size_x', '1000.00');
model.param.set('dfn_size_y', '1000.00');
model.param.set('dfn_size_z', '354.68');
model.param.set('dfn_strike', '30[deg]');
model.param.set('dfn_dip', '85[deg]');

model.geom('dfnpart1').create('dfnpart1wp1', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp1').label('Fracture 1');
model.geom('dfnpart1').feature('dfnpart1wp1').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp1').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp1').set('transdispl', [950.8948292356945 915.8850293688172 169.16047535651083]);
model.geom('dfnpart1').feature('dfnpart1wp1').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp1').set('transeulerang', [-15.616630161333092 81.39237476696654 0]);
model.geom('dfnpart1').feature('dfnpart1wp1').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp1').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp1').geom.feature('e1').set('semiaxes', [426.87497827209967 464.4543955044729]);
model.geom('dfnpart1').create('dfnpart1wp2', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp2').label('Fracture 2');
model.geom('dfnpart1').feature('dfnpart1wp2').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp2').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp2').set('transdispl', [379.08785836512646 55.18796153371896 289.27973680540674]);
model.geom('dfnpart1').feature('dfnpart1wp2').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp2').set('transeulerang', [-23.42599208190939 73.48805632013988 0]);
model.geom('dfnpart1').feature('dfnpart1wp2').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp2').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp2').geom.feature('e1').set('semiaxes', [371.6183187548705 200]);
model.geom('dfnpart1').create('dfnpart1wp3', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp3').label('Fracture 3');
model.geom('dfnpart1').feature('dfnpart1wp3').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp3').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp3').set('transdispl', [162.16221529528318 788.5519233236041 257.47294838116767]);
model.geom('dfnpart1').feature('dfnpart1wp3').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp3').set('transeulerang', [-21.70082071401351 72.79381308722472 0]);
model.geom('dfnpart1').feature('dfnpart1wp3').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp3').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp3').geom.feature('e1').set('semiaxes', [254.87160985959213 186.80386257734045]);
model.geom('dfnpart1').create('dfnpart1wp4', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp4').label('Fracture 4');
model.geom('dfnpart1').feature('dfnpart1wp4').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp4').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp4').set('transdispl', [920.2550763776844 600.18850427138 118.74562244087893]);
model.geom('dfnpart1').feature('dfnpart1wp4').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp4').set('transeulerang', [-7.372575980465946 82.75440396564301 0]);
model.geom('dfnpart1').feature('dfnpart1wp4').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp4').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp4').geom.feature('e1').set('semiaxes', [262.2534395863232 438.6001480563894]);
model.geom('dfnpart1').create('dfnpart1wp5', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp5').label('Fracture 5');
model.geom('dfnpart1').feature('dfnpart1wp5').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp5').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp5').set('transdispl', [492.58891991541157 436.95934165205273 162.89774614256837]);
model.geom('dfnpart1').feature('dfnpart1wp5').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp5').set('transeulerang', [-18.62121526789972 80.85799100134689 0]);
model.geom('dfnpart1').feature('dfnpart1wp5').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp5').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp5').geom.feature('e1').set('semiaxes', [500 191.4541832506475]);
model.geom('dfnpart1').create('dfnpart1wp6', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp6').label('Fracture 6');
model.geom('dfnpart1').feature('dfnpart1wp6').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp6').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp6').set('transdispl', [605.1435647826094 997.7416537202641 347.98559481189534]);
model.geom('dfnpart1').feature('dfnpart1wp6').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp6').set('transeulerang', [-25.556786302852316 80.46937465406336 0]);
model.geom('dfnpart1').feature('dfnpart1wp6').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp6').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp6').geom.feature('e1').set('semiaxes', [500 428.84955944033453]);
model.geom('dfnpart1').create('dfnpart1wp7', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp7').label('Fracture 7');
model.geom('dfnpart1').feature('dfnpart1wp7').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp7').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp7').set('transdispl', [847.1635293264042 275.35375561855477 259.29864466565476]);
model.geom('dfnpart1').feature('dfnpart1wp7').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp7').set('transeulerang', [-10.49200855705342 77.02785174756511 0]);
model.geom('dfnpart1').feature('dfnpart1wp7').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp7').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp7').geom.feature('e1').set('semiaxes', [500 156.12039770201477]);
model.geom('dfnpart1').create('dfnpart1wp8', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp8').label('Fracture 8');
model.geom('dfnpart1').feature('dfnpart1wp8').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp8').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp8').set('transdispl', [238.6680602100668 893.9536804585344 77.23467832171288]);
model.geom('dfnpart1').feature('dfnpart1wp8').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp8').set('transeulerang', [-21.534260693010005 79.2887902052268 0]);
model.geom('dfnpart1').feature('dfnpart1wp8').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp8').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp8').geom.feature('e1').set('semiaxes', [356.77400091572997 113.27329678024915]);
model.geom('dfnpart1').create('dfnpart1wp9', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp9').label('Fracture 9');
model.geom('dfnpart1').feature('dfnpart1wp9').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp9').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp9').set('transdispl', [693.2211199345265 371.9214216638455 220.77211331581037]);
model.geom('dfnpart1').feature('dfnpart1wp9').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp9').set('transeulerang', [-11.502449805079166 77.00980876232721 0]);
model.geom('dfnpart1').feature('dfnpart1wp9').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp9').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp9').geom.feature('e1').set('semiaxes', [349.2877371437199 321.1608847732125]);
model.geom('dfnpart1').create('dfnpart1wp10', 'WorkPlane');
model.geom('dfnpart1').feature('dfnpart1wp10').label('Fracture 10');
model.geom('dfnpart1').feature('dfnpart1wp10').set('unite', true);
model.geom('dfnpart1').feature('dfnpart1wp10').set('planetype', 'transformed');
model.geom('dfnpart1').feature('dfnpart1wp10').set('transdispl', [197.34206158195178 544.4790748061076 2.001953591006323]);
model.geom('dfnpart1').feature('dfnpart1wp10').set('transspecify', 'eulerang');
model.geom('dfnpart1').feature('dfnpart1wp10').set('transeulerang', [-10.150688401641219 78.83902124439926 0]);
model.geom('dfnpart1').feature('dfnpart1wp10').set('selresult', true);
model.geom('dfnpart1').feature('dfnpart1wp10').geom.create('e1', 'Ellipse');
model.geom('dfnpart1').feature('dfnpart1wp10').geom.feature('e1').set('semiaxes', [344.67453964196284 383.03559574282787]);
model.geom('dfnpart1').create('uni1', 'Union');
model.geom('dfnpart1').feature('uni1').selection('input').all;
model.geom('dfnpart1').selection.create('csel1', 'CumulativeSelection');
model.geom('dfnpart1').selection('csel1').label('Fracture network');
model.geom('dfnpart1').feature('uni1').set('contributeto', 'csel1');
model.geom('dfnpart1').run('uni1');

model.param.remove('dfn_size_x');
model.param.remove('dfn_size_y');
model.param.remove('dfn_size_z');
model.param.remove('dfn_fractureSize');
model.param.remove('dfn_fractureSizeMin');
model.param.remove('dfn_fractureSizeMax');
model.param.remove('dfn_strike');
model.param.remove('dfn_dip');

model.geom('geom1').runPre('fin');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('dfnpi1', 'PartInstance');
model.geom('geom1').feature('dfnpi1').set('part', 'dfnpart1');
model.geom('geom1').feature('dfnpi1').set('displ', {'-0.00' '-0.00' '-247.35'});
model.geom('geom1').run('dfnpi1');
model.geom('geom1').feature.create('dfnpar1', 'PartitionDomains');
model.geom('geom1').feature('dfnpar1').selection('domain').named('sel2');
model.geom('geom1').feature('dfnpar1').set('partitionwith', 'objects');
model.geom('geom1').feature('dfnpar1').selection('object').named('dfnpi1_csel1');
model.geom('geom1').feature('dfnpar1').set('keepobject', false);
model.geom('geom1').run;

model.nodeGroup.create('apgrp1', 'Definitions', 'comp1');
model.nodeGroup('apgrp1').label('Aperture Data 1');

model.variable.create('apgrp1fvar1');
model.variable.apgrp1fvar1.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar1');

model.variable('apgrp1fvar1').selection.geom('geom1', 2);
model.variable('apgrp1fvar1').selection.named('geom1_dfnpi1_dfnpart1wp1_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar1').set('df', 0.004268749782720997, 'Aperture');
model.variable.create('apgrp1fvar2');
model.variable.apgrp1fvar2.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar2');

model.variable('apgrp1fvar2').selection.geom('geom1', 2);
model.variable('apgrp1fvar2').selection.named('geom1_dfnpi1_dfnpart1wp2_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar2').set('df', 0.003716183187548705, 'Aperture');
model.variable.create('apgrp1fvar3');
model.variable.apgrp1fvar3.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar3');

model.variable('apgrp1fvar3').selection.geom('geom1', 2);
model.variable('apgrp1fvar3').selection.named('geom1_dfnpi1_dfnpart1wp3_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar3').set('df', 0.0025487160985959213, 'Aperture');
model.variable.create('apgrp1fvar4');
model.variable.apgrp1fvar4.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar4');

model.variable('apgrp1fvar4').selection.geom('geom1', 2);
model.variable('apgrp1fvar4').selection.named('geom1_dfnpi1_dfnpart1wp4_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar4').set('df', 0.0026225343958632325, 'Aperture');
model.variable.create('apgrp1fvar5');
model.variable.apgrp1fvar5.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar5');

model.variable('apgrp1fvar5').selection.geom('geom1', 2);
model.variable('apgrp1fvar5').selection.named('geom1_dfnpi1_dfnpart1wp5_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar5').set('df', 0.005, 'Aperture');
model.variable.create('apgrp1fvar6');
model.variable.apgrp1fvar6.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar6');

model.variable('apgrp1fvar6').selection.geom('geom1', 2);
model.variable('apgrp1fvar6').selection.named('geom1_dfnpi1_dfnpart1wp6_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar6').set('df', 0.005, 'Aperture');
model.variable.create('apgrp1fvar7');
model.variable.apgrp1fvar7.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar7');

model.variable('apgrp1fvar7').selection.geom('geom1', 2);
model.variable('apgrp1fvar7').selection.named('geom1_dfnpi1_dfnpart1wp7_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar7').set('df', 0.005, 'Aperture');
model.variable.create('apgrp1fvar8');
model.variable.apgrp1fvar8.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar8');

model.variable('apgrp1fvar8').selection.geom('geom1', 2);
model.variable('apgrp1fvar8').selection.named('geom1_dfnpi1_dfnpart1wp8_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar8').set('df', 0.0035677400091573, 'Aperture');
model.variable.create('apgrp1fvar9');
model.variable.apgrp1fvar9.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar9');

model.variable('apgrp1fvar9').selection.geom('geom1', 2);
model.variable('apgrp1fvar9').selection.named('geom1_dfnpi1_dfnpart1wp9_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar9').set('df', 0.0034928773714371993, 'Aperture');
model.variable.create('apgrp1fvar10');
model.variable.apgrp1fvar10.model('comp1');

model.nodeGroup('apgrp1').add('variable', 'apgrp1fvar10');

model.variable('apgrp1fvar10').selection.geom('geom1', 2);
model.variable('apgrp1fvar10').selection.named('geom1_dfnpi1_dfnpart1wp10_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp1fvar10').set('df', 0.0034467453964196287, 'Aperture');

model.param.remove('dfn_d_f');
model.param.remove('dfn_d_f_max');
model.param.remove('dfn_d_f_min');

model.physics('dl').create('dfn1', 'Fracture', 2);
model.physics('dl').feature('dfn1').selection.named('geom1_dfnpi1_csel1_bnd');
model.physics('dl').feature('dfn1').set('df', 'df');
model.physics('dl').feature('dfn1').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('dfn1').feature('pm1').set('epsilon', '0.7');
model.physics('dl').feature('dfn1').feature('pm1').set('permeabilityModelType', 'cubicLaw');
model.physics('dl').feature('dfn1').feature('pm1').set('ff', '1');

model.geom('geom1').feature('dfnpi1').active(false);
model.geom('geom1').feature('dfnpar1').active(false);

model.mesh.create('tempmesh1', 'geom1');
model.mesh('tempmesh1').run;

model.result.dataset.create('tempdset1', 'Mesh');
model.result.dataset('tempdset1').set('mesh', 'tempmesh1');
model.result.numerical.create('tempmin1', 'MinVolume');
model.result.numerical('tempmin1').set('data', 'tempdset1');
model.result.numerical.create('tempmax1', 'MaxVolume');
model.result.numerical('tempmax1').set('data', 'tempdset1');
model.result.numerical('tempmin1').selection.named('geom1_sel2');
model.result.numerical('tempmax1').selection.named('geom1_sel2');
model.result.numerical('tempmin1').setIndex('expr', 'x', 0);
model.result.numerical('tempmin1').setIndex('expr', 'y', 1);
model.result.numerical('tempmin1').setIndex('expr', 'z', 2);
model.result.numerical('tempmax1').setIndex('expr', 'x', 0);
model.result.numerical('tempmax1').setIndex('expr', 'y', 1);
model.result.numerical('tempmax1').setIndex('expr', 'z', 2);
model.result.numerical('tempmin1').computeResult;
model.result.numerical('tempmax1').computeResult;

model.geom('geom1').feature('dfnpi1').active(true);
model.geom('geom1').feature('dfnpar1').active(true);

model.mesh.remove('tempmesh1');

model.geom('geom1').run;

model.view('view1').set('renderwireframe', true);

model.geom.create('dfnpart2', 'Part', 3);
model.geom('dfnpart2').label('3D Fracture Network 2');

model.param.set('dfn_fractureSize', '5[m]');
model.param.set('dfn_fractureSizeMin', '200[m]');
model.param.set('dfn_fractureSizeMax', '500[m]');
model.param.set('dfn_size_x', '1000.00');
model.param.set('dfn_size_y', '1000.00');
model.param.set('dfn_size_z', '354.68');
model.param.set('dfn_strike', '125[deg]');
model.param.set('dfn_dip', '70[deg]');

model.geom('dfnpart2').create('dfnpart2wp1', 'WorkPlane');
model.geom('dfnpart2').feature('dfnpart2wp1').label('Fracture 1');
model.geom('dfnpart2').feature('dfnpart2wp1').set('unite', true);
model.geom('dfnpart2').feature('dfnpart2wp1').set('planetype', 'transformed');
model.geom('dfnpart2').feature('dfnpart2wp1').set('transdispl', [950.9844110078994 746.3406186469402 321.56738786395675]);
model.geom('dfnpart2').feature('dfnpart2wp1').set('transspecify', 'eulerang');
model.geom('dfnpart2').feature('dfnpart2wp1').set('transeulerang', [-109.53615553129684 67.256689828219 0]);
model.geom('dfnpart2').feature('dfnpart2wp1').set('selresult', true);
model.geom('dfnpart2').feature('dfnpart2wp1').geom.create('e1', 'Ellipse');
model.geom('dfnpart2').feature('dfnpart2wp1').geom.feature('e1').set('semiaxes', [313.08663041079274 200]);
model.geom('dfnpart2').create('dfnpart2wp2', 'WorkPlane');
model.geom('dfnpart2').feature('dfnpart2wp2').label('Fracture 2');
model.geom('dfnpart2').feature('dfnpart2wp2').set('unite', true);
model.geom('dfnpart2').feature('dfnpart2wp2').set('planetype', 'transformed');
model.geom('dfnpart2').feature('dfnpart2wp2').set('transdispl', [160.46698003579297 907.7325871762005 117.88222643306746]);
model.geom('dfnpart2').feature('dfnpart2wp2').set('transspecify', 'eulerang');
model.geom('dfnpart2').feature('dfnpart2wp2').set('transeulerang', [-117.97741425690148 64.01058654470668 0]);
model.geom('dfnpart2').feature('dfnpart2wp2').set('selresult', true);
model.geom('dfnpart2').feature('dfnpart2wp2').geom.create('e1', 'Ellipse');
model.geom('dfnpart2').feature('dfnpart2wp2').geom.feature('e1').set('semiaxes', [500 323.32417631701213]);
model.geom('dfnpart2').create('dfnpart2wp3', 'WorkPlane');
model.geom('dfnpart2').feature('dfnpart2wp3').label('Fracture 3');
model.geom('dfnpart2').feature('dfnpart2wp3').set('unite', true);
model.geom('dfnpart2').feature('dfnpart2wp3').set('planetype', 'transformed');
model.geom('dfnpart2').feature('dfnpart2wp3').set('transdispl', [903.3784297240001 998.5688079279425 283.47545608997535]);
model.geom('dfnpart2').feature('dfnpart2wp3').set('transspecify', 'eulerang');
model.geom('dfnpart2').feature('dfnpart2wp3').set('transeulerang', [-118.34848549124906 63.76221470876157 0]);
model.geom('dfnpart2').feature('dfnpart2wp3').set('selresult', true);
model.geom('dfnpart2').feature('dfnpart2wp3').geom.create('e1', 'Ellipse');
model.geom('dfnpart2').feature('dfnpart2wp3').geom.feature('e1').set('semiaxes', [359.38270964408616 256.57807315079845]);
model.geom('dfnpart2').create('dfnpart2wp4', 'WorkPlane');
model.geom('dfnpart2').feature('dfnpart2wp4').label('Fracture 4');
model.geom('dfnpart2').feature('dfnpart2wp4').set('unite', true);
model.geom('dfnpart2').feature('dfnpart2wp4').set('planetype', 'transformed');
model.geom('dfnpart2').feature('dfnpart2wp4').set('transdispl', [902.432138306579 885.0914760566283 283.34853960044387]);
model.geom('dfnpart2').feature('dfnpart2wp4').set('transspecify', 'eulerang');
model.geom('dfnpart2').feature('dfnpart2wp4').set('transeulerang', [-115.1953648480043 66.69352947858648 0]);
model.geom('dfnpart2').feature('dfnpart2wp4').set('selresult', true);
model.geom('dfnpart2').feature('dfnpart2wp4').geom.create('e1', 'Ellipse');
model.geom('dfnpart2').feature('dfnpart2wp4').geom.feature('e1').set('semiaxes', [239.93001646684715 259.477361279871]);
model.geom('dfnpart2').create('dfnpart2wp5', 'WorkPlane');
model.geom('dfnpart2').feature('dfnpart2wp5').label('Fracture 5');
model.geom('dfnpart2').feature('dfnpart2wp5').set('unite', true);
model.geom('dfnpart2').feature('dfnpart2wp5').set('planetype', 'transformed');
model.geom('dfnpart2').feature('dfnpart2wp5').set('transdispl', [117.78007336099749 636.2729204660882 123.8242253556841]);
model.geom('dfnpart2').feature('dfnpart2wp5').set('transspecify', 'eulerang');
model.geom('dfnpart2').feature('dfnpart2wp5').set('transeulerang', [-105.35912566955328 66.5997896620567 0]);
model.geom('dfnpart2').feature('dfnpart2wp5').set('selresult', true);
model.geom('dfnpart2').feature('dfnpart2wp5').geom.create('e1', 'Ellipse');
model.geom('dfnpart2').feature('dfnpart2wp5').geom.feature('e1').set('semiaxes', [500 99.16636320578041]);
model.geom('dfnpart2').create('dfnpart2wp6', 'WorkPlane');
model.geom('dfnpart2').feature('dfnpart2wp6').label('Fracture 6');
model.geom('dfnpart2').feature('dfnpart2wp6').set('unite', true);
model.geom('dfnpart2').feature('dfnpart2wp6').set('planetype', 'transformed');
model.geom('dfnpart2').feature('dfnpart2wp6').set('transdispl', [459.95352532275336 153.37922571080165 23.058962070642295]);
model.geom('dfnpart2').feature('dfnpart2wp6').set('transspecify', 'eulerang');
model.geom('dfnpart2').feature('dfnpart2wp6').set('transeulerang', [-121.28850912859671 63.20253145122541 0]);
model.geom('dfnpart2').feature('dfnpart2wp6').set('selresult', true);
model.geom('dfnpart2').feature('dfnpart2wp6').geom.create('e1', 'Ellipse');
model.geom('dfnpart2').feature('dfnpart2wp6').geom.feature('e1').set('semiaxes', [318.09455942002353 148.78931516315652]);
model.geom('dfnpart2').create('uni1', 'Union');
model.geom('dfnpart2').feature('uni1').selection('input').all;
model.geom('dfnpart2').selection.create('csel1', 'CumulativeSelection');
model.geom('dfnpart2').selection('csel1').label('Fracture network');
model.geom('dfnpart2').feature('uni1').set('contributeto', 'csel1');
model.geom('dfnpart2').run('uni1');

model.param.remove('dfn_size_x');
model.param.remove('dfn_size_y');
model.param.remove('dfn_size_z');
model.param.remove('dfn_fractureSize');
model.param.remove('dfn_fractureSizeMin');
model.param.remove('dfn_fractureSizeMax');
model.param.remove('dfn_strike');
model.param.remove('dfn_dip');

model.geom('geom1').runPre('fin');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('dfnpi2', 'PartInstance');
model.geom('geom1').feature('dfnpi2').set('part', 'dfnpart2');
model.geom('geom1').feature('dfnpi2').set('displ', {'-0.00' '-0.00' '-247.35'});
model.geom('geom1').run('dfnpi2');
model.geom('geom1').feature.create('dfnpar2', 'PartitionDomains');
model.geom('geom1').feature('dfnpar2').selection('domain').named('sel2');
model.geom('geom1').feature('dfnpar2').set('partitionwith', 'objects');
model.geom('geom1').feature('dfnpar2').selection('object').named('dfnpi2_csel1');
model.geom('geom1').feature('dfnpar2').set('keepobject', false);
model.geom('geom1').run;

model.nodeGroup.create('apgrp2', 'Definitions', 'comp1');
model.nodeGroup('apgrp2').label('Aperture Data 2');

model.variable.create('apgrp2fvar1');
model.variable.apgrp2fvar1.model('comp1');

model.nodeGroup('apgrp2').add('variable', 'apgrp2fvar1');

model.variable('apgrp2fvar1').selection.geom('geom1', 2);
model.variable('apgrp2fvar1').selection.named('geom1_dfnpi2_dfnpart2wp1_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp2fvar1').set('df', 0.0031308663041079276, 'Aperture');
model.variable.create('apgrp2fvar2');
model.variable.apgrp2fvar2.model('comp1');

model.nodeGroup('apgrp2').add('variable', 'apgrp2fvar2');

model.variable('apgrp2fvar2').selection.geom('geom1', 2);
model.variable('apgrp2fvar2').selection.named('geom1_dfnpi2_dfnpart2wp2_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp2fvar2').set('df', 0.005, 'Aperture');
model.variable.create('apgrp2fvar3');
model.variable.apgrp2fvar3.model('comp1');

model.nodeGroup('apgrp2').add('variable', 'apgrp2fvar3');

model.variable('apgrp2fvar3').selection.geom('geom1', 2);
model.variable('apgrp2fvar3').selection.named('geom1_dfnpi2_dfnpart2wp3_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp2fvar3').set('df', 0.0035938270964408618, 'Aperture');
model.variable.create('apgrp2fvar4');
model.variable.apgrp2fvar4.model('comp1');

model.nodeGroup('apgrp2').add('variable', 'apgrp2fvar4');

model.variable('apgrp2fvar4').selection.geom('geom1', 2);
model.variable('apgrp2fvar4').selection.named('geom1_dfnpi2_dfnpart2wp4_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp2fvar4').set('df', 0.0023993001646684716, 'Aperture');
model.variable.create('apgrp2fvar5');
model.variable.apgrp2fvar5.model('comp1');

model.nodeGroup('apgrp2').add('variable', 'apgrp2fvar5');

model.variable('apgrp2fvar5').selection.geom('geom1', 2);
model.variable('apgrp2fvar5').selection.named('geom1_dfnpi2_dfnpart2wp5_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp2fvar5').set('df', 0.005, 'Aperture');
model.variable.create('apgrp2fvar6');
model.variable.apgrp2fvar6.model('comp1');

model.nodeGroup('apgrp2').add('variable', 'apgrp2fvar6');

model.variable('apgrp2fvar6').selection.geom('geom1', 2);
model.variable('apgrp2fvar6').selection.named('geom1_dfnpi2_dfnpart2wp6_bnd');

model.param.set('dfn_d_f', '1[mm]');
model.param.set('dfn_d_f_min', '0.1[mm]');
model.param.set('dfn_d_f_max', '10[mm]');

model.variable('apgrp2fvar6').set('df', 0.0031809455942002356, 'Aperture');

model.param.remove('dfn_d_f');
model.param.remove('dfn_d_f_max');
model.param.remove('dfn_d_f_min');

model.physics('dl').create('dfn2', 'Fracture', 2);
model.physics('dl').feature('dfn2').selection.named('geom1_dfnpi2_csel1_bnd');
model.physics('dl').feature('dfn2').set('df', 'df');
model.physics('dl').feature('dfn2').feature('pm1').set('epsilon_mat', 'userdef');
model.physics('dl').feature('dfn2').feature('pm1').set('epsilon', '0.7');
model.physics('dl').feature('dfn2').feature('pm1').set('permeabilityModelType', 'cubicLaw');
model.physics('dl').feature('dfn2').feature('pm1').set('ff', '1');

model.geom('geom1').feature('dfnpi1').active(false);
model.geom('geom1').feature('dfnpar1').active(false);
model.geom('geom1').feature('dfnpi2').active(false);
model.geom('geom1').feature('dfnpar2').active(false);

model.mesh.create('tempmesh1', 'geom1');
model.mesh('tempmesh1').run;

model.result.dataset.create('tempdset1', 'Mesh');
model.result.dataset('tempdset1').set('mesh', 'tempmesh1');
model.result.numerical.create('tempmin1', 'MinVolume');
model.result.numerical('tempmin1').set('data', 'tempdset1');
model.result.numerical.create('tempmax1', 'MaxVolume');
model.result.numerical('tempmax1').set('data', 'tempdset1');
model.result.numerical('tempmin1').selection.named('geom1_sel2');
model.result.numerical('tempmax1').selection.named('geom1_sel2');
model.result.numerical('tempmin1').setIndex('expr', 'x', 0);
model.result.numerical('tempmin1').setIndex('expr', 'y', 1);
model.result.numerical('tempmin1').setIndex('expr', 'z', 2);
model.result.numerical('tempmax1').setIndex('expr', 'x', 0);
model.result.numerical('tempmax1').setIndex('expr', 'y', 1);
model.result.numerical('tempmax1').setIndex('expr', 'z', 2);
model.result.numerical('tempmin1').computeResult;
model.result.numerical('tempmax1').computeResult;

model.geom('geom1').feature('dfnpi1').active(true);
model.geom('geom1').feature('dfnpar1').active(true);
model.geom('geom1').feature('dfnpi2').active(true);
model.geom('geom1').feature('dfnpar2').active(true);

model.mesh.remove('tempmesh1');

model.geom('geom1').run;
model.geom('geom1').run('fin');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'dfnpi1_csel1' 'dfnpi2_csel1'});
model.geom('geom1').feature('unisel1').label('All Fractures');
model.geom('geom1').run('unisel1');

model.view('view1').set('renderwireframe', false);
model.view('view1').set('transparency', false);
model.view('view1').set('renderwireframe', true);

model.material.create('mat1', 'Common', '');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').label('Water, liquid');
model.material('mat1').set('family', 'water');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');

model.common.create('ampr1', 'AmbientProperties', 'comp1');
model.common('ampr1').set('P0_amb', '550[mm/a]');

model.physics('dl').prop('GravityEffects').set('IncludeGravity', true);
model.physics('dl').feature('gr1').set('useRref', true);
model.physics('dl').feature('gr1').set('rref', [0 0 -300]);

model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material('pmat1').label('Highly permeable');
model.material('pmat1').set('porosity', '0.25');
model.material('pmat1').propertyGroup('def').set('hydraulicpermeability', {'1000[mD]'});
model.material('pmat1').feature.create('fluid1', 'Fluid', 'comp1');
model.material.create('pmat2', 'PorousMedia', 'comp1');
model.material('pmat2').selection.set([2]);
model.material('pmat2').selection.named('geom1_sel2');
model.material('pmat2').label('Weakly permeable');
model.material('pmat2').set('porosity', '0.1');
model.material('pmat2').propertyGroup('def').set('hydraulicpermeability', {'20[mD]'});
model.material('pmat2').feature.create('fluid1', 'Fluid', 'comp1');
model.material.create('matlnk1', 'Link', 'comp1');
model.material('matlnk1').selection.geom('geom1', 2);
model.material('matlnk1').selection.named('geom1_unisel1');

model.physics('dl').create('prec1', 'Precipitation', 2);
model.physics('dl').feature('prec1').selection.set([10]);
model.physics('dl').feature('prec1').set('item.P0_src', 'root.comp1.ampr1.P0_amb');
model.physics('dl').feature('prec1').set('slopeCorrection', true);
model.physics('dl').create('hh1', 'HydraulicHead', 2);
model.physics('dl').feature('hh1').selection.set([1 2 25 80]);
model.physics('dl').feature('hh1').set('H0', '0.5[m/km]*x');

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.named('geom1_sel2');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('ftet2', 'FreeTet');
model.mesh('mesh1').run;

model.study('std1').setGenPlots(false);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, pressure (dl)');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.numerical.create('av1', 'AvVolume');
model.result.numerical('av1').selection.named('geom1_sel2');
model.result.numerical('av1').setIndex('expr', 'dl.U', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Volume Average 1');
model.result.numerical('av1').set('table', 'tbl1');
model.result.numerical('av1').setResult;
model.result.numerical.create('av2', 'AvSurface');
model.result.numerical('av2').set('intvolume', true);
model.result.numerical('av2').selection.named('geom1_unisel1');
model.result.numerical('av2').setIndex('expr', 'dl.U', 0);
model.result.numerical('av2').set('table', 'tbl1');
model.result.numerical('av2').appendResult;
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Velocity');
model.result('pg1').set('edges', false);
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Darcy''s velocity magnitude (m/s)');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'dl.U');
model.result('pg1').feature('surf1').set('colortable', 'AuroraAustralis');
model.result('pg1').feature('surf1').set('rangecoloractive', true);
model.result('pg1').feature('surf1').set('rangecolormax', '3e-3');
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('geom1_unisel1');
model.result('pg1').run;
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').set('expr', 'dl.U');
model.result('pg1').feature('vol1').set('inheritplot', 'surf1');
model.result('pg1').feature('vol1').create('sel1', 'Selection');
model.result('pg1').feature('vol1').feature('sel1').selection.named('geom1_sel3');
model.result('pg1').run;
model.result('pg1').feature.duplicate('vol2', 'vol1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('vol2').feature('sel1').selection.named('geom1_sel1');
model.result('pg1').run;
model.result('pg1').feature('vol2').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').feature('vol2').feature('tran1').set('transparency', 0.8);
model.result('pg1').run;
model.result('pg1').create('str1', 'StreamlineSurface');
model.result('pg1').feature('str1').selection.named('geom1_unisel1');
model.result('pg1').feature('str1').set('posmethod', 'magnitude');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('color', 'white');
model.result('pg1').run;

model.title('Flow in a Fractured Reservoir');

model.description('This model demonstrates how to model flow through a fractured reservoir. The reservoir is modeled as a discrete fracture network where the fractures have a randomized distribution of position, size, orientation and aperture.');

model.label('fractured_reservoir_flow.mph');

model.modelNode.label('Components');

out = model;
