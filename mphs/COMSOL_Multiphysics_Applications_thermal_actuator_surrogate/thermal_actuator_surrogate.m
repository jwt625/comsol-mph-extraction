function out = model
%
% thermal_actuator_surrogate.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Applications');

model.label('thermal_actuator_surrogate.mph');

model.title('Thermal Actuator Surrogate Model Application');

model.description('The Thermal Actuator Surrogate Model application demonstrates how to accelerate computation for multiphysics analysis using a surrogate model for a fully parametric geometry model. A surrogate model is a simpler, usually computationally cheaper model, that is used to approximate the behavior of a more complex, and often more computationally expensive, model. The faster model evaluation offered by the surrogate model provides the user of the app a more interactive user experience and makes it easier to spread the use of simulations in an organization. This example illustrates how a surrogate model can be created and used in an app for a multiphysics simulation where the geometry is based on a parametric CAD model.');

model.param.set('d', '3[um]', 'Height of the hot arm');
model.param.set('dw', '15[um]', 'Height of the cold arm');
model.param.set('gap', '3[um]', 'Gap between arms');
model.param.set('wb', '10[um]', 'Width of the base');
model.param.set('wv', '25[um]', 'Difference in length between hot arms');
model.param.set('L', '240[um]', 'Actuator length');
model.param.set('L1', 'L-wb', 'Length of the longest hot arm');
model.param.set('L2', 'L-wb-wv', 'Length of the shortest hot arm');
model.param.set('L3', 'L-2*wb-wv-L/48-L/6', 'Length of the cold arm, thick part');
model.param.set('L4', 'L/6', 'Length of the cold arm, thin part');
model.param.set('htc_s', '0.04[W/(m*K)]/2[um]', 'Heat transfer coefficient');
model.param.set('htc_us', '0.04[W/(m*K)]/100[um]', 'Heat transfer coefficient, upper surface');
model.param.set('DV', '5[V]', 'Applied voltage');
model.param.set('alphaps', '2.6e-6[1/K]', 'Coefficient of thermal expansion');
model.param.set('T0', '293.15[K]', 'Strain reference temperature');
model.param.set('noa', '3', 'Number of arms');
model.param.group.create('par2');
model.param('par2').set('min_dw', '15', 'Height of the cold arm, min bound');
model.param('par2').set('max_dw', '40', 'Height of the cold arm, max bound');
model.param('par2').set('min_gap', '2.5', 'Gap between arms, min bound');
model.param('par2').set('max_gap', '7', 'Gap between arms, max bound');
model.param('par2').set('min_wv', '0', 'Difference in length between hot arms, min bound');
model.param('par2').set('max_wv', '50', 'Difference in length between hot arms, max bound');
model.param('par2').set('min_L', '150', 'Actuator length, min bound');
model.param('par2').set('max_L', '400', 'Actuator length, max bound');
model.param('par2').set('min_DV', '0.5', 'Applied voltage, min bound');
model.param('par2').set('max_DV', '10', 'Applied voltage, max bound');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.modelNode('comp1').label('Thermal Actuator');

model.result.table.create('tbl3', 'Table');
model.result.table.create('tbl1', 'Table');
model.result.table.create('tbl2', 'Table');
model.result.table.create('tbl4', 'Table');
model.result.table.create('tbl5', 'Table');

model.func.create('dnn1', 'DNN');
model.func('dnn1').set('outfeatures', [64 64 32 16 32]);
model.func('dnn1').set('activation', {'tanh' 'tanh' 'tanh' 'tanh' 'tanh'});
model.func('dnn1').set('layertype', {'dense' 'dense' 'dense' 'dense' 'dense'});
model.func('dnn1').set('filecolumns', 14);
model.func('dnn1').set('fileheaders', {'x' 'y' 'z' ['dw (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)'] ['gap (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)'] ['wv (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)'] ['L (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)'] 'DV (V)' 'V (V)' 'T (K)'  ...
['u (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)'] ['v (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)'] ['w (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)'] 'solid.misesGp (N/m^2)'});
model.func('dnn1').set('filename', 'thermal_actuator_surrogate_data.txt');
model.func('dnn1').set('columnKeys', {'col1' 'col2' 'col3' 'col4' 'col5' 'col6' 'col7' 'col8' 'col9' 'col10'  ...
'col11' 'col12' 'col13' 'col14'});
model.func('dnn1').set('columnType', {'col1' 'arg' 'col2' 'arg' 'col3' 'arg' 'col4' 'arg' 'col5' 'arg'  ...
'col6' 'arg' 'col7' 'arg' 'col8' 'arg' 'col9' 'value' 'col10' 'value'  ...
'col11' 'value' 'col12' 'value' 'col13' 'value' 'col14' 'value'});
model.func('dnn1').set('funcs', {'col1' 'dnn1_col1' 'col2' 'dnn1_col2' 'col3' 'dnn1_col3' 'col4' 'dnn1_col4' 'col5' 'dnn1_col5'  ...
'col6' 'dnn1_col6' 'col7' 'dnn1_col7' 'col8' 'dnn1_col8' 'col9' 'dnn1_V' 'col10' 'dnn1_T'  ...
'col11' 'dnn1_u' 'col12' 'dnn1_v' 'col13' 'dnn1_w' 'col14' 'dnn1_mises'});
model.func('dnn1').set('unit', {'col1' 'um' 'col2' 'um' 'col3' 'um' 'col4' 'um' 'col5' 'um'  ...
'col6' 'um' 'col7' 'um' 'col8' 'V' 'col9' 'V' 'col10' 'K'  ...
'col11' 'um' 'col12' 'um' 'col13' 'um' 'col14' 'N/m^2'});
model.func('dnn1').set('plotfuncname', 'dnn1_V');
model.func('dnn1').set('plotaxis', {'on' 'on' 'on' 'off' 'off' 'off' 'off' 'off'});
model.func('dnn1').set('plotfixedvalue', {'199.981[um]' '53.2943[um]' '0[um]' '27.4988[um]' '4.75042[um]' '25.0024[um]' '274.992[um]' '5.25065'});
model.func('dnn1').set('plotargs', {'x1' '0[um]' '399.963[um]';  ...
'x2' '0[um]' '106.589[um]';  ...
'x3' '-2[um]' '2[um]';  ...
'x4' '15.002[um]' '39.9956[um]';  ...
'x5' '2.50099[um]' '6.99985[um]';  ...
'x6' '0.00927074[um]' '49.9956[um]';  ...
'x7' '150.021[um]' '399.963[um]';  ...
'x8' '0.501504' '9.99981'});
model.func('dnn1').run;

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').geomRep('comsol');
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Ground');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Applied Voltage');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Third');
model.geom('geom1').selection.create('csel4', 'CumulativeSelection');
model.geom('geom1').selection('csel4').label('Upper Surface');
model.geom('geom1').selection.create('csel5', 'CumulativeSelection');
model.geom('geom1').selection('csel5').label('Other Surface');
model.geom('geom1').selection.create('csel6', 'CumulativeSelection');
model.geom('geom1').selection('csel6').label('Tip');
model.geom('geom1').selection.create('csel7', 'CumulativeSelection');
model.geom('geom1').selection('csel7').label('Dimples');
model.geom('geom1').create('if1', 'If');
model.geom('geom1').feature('if1').set('condition', '(noa==3)');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'L-L3' '0'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L3' 'dw'});
model.geom('geom1').feature('wp1').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'L-L3-L4' 'dw-d'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'L4' 'd'});
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('pos', {'L-L3-L4-wb' '0'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'wb' 'dw'});
model.geom('geom1').feature('wp1').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r4').set('pos', {'L-L2' 'dw+gap'});
model.geom('geom1').feature('wp1').geom.feature('r4').set('size', {'L2' 'd'});
model.geom('geom1').feature('wp1').geom.create('r5', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r5').set('pos', {'L-L2-wb' '0'});
model.geom('geom1').feature('wp1').geom.feature('r5').set('size', {'wb' 'dw+gap+d'});
model.geom('geom1').feature('wp1').geom.create('r6', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r6').set('pos', {'L-L1' 'dw+d+2*gap'});
model.geom('geom1').feature('wp1').geom.feature('r6').set('size', {'L1' 'd'});
model.geom('geom1').feature('wp1').geom.create('r7', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r7').set('pos', {'0' 'dw+d+2*gap'});
model.geom('geom1').feature('wp1').geom.feature('r7').set('size', {'wb' 'dw+gap+d'});
model.geom('geom1').feature('wp1').geom.create('r8', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r8').set('pos', {'L-d' 'dw+gap+d'});
model.geom('geom1').feature('wp1').geom.feature('r8').set('size', {'d' 'gap'});
model.geom('geom1').feature('wp1').geom.create('r9', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r9').set('pos', {'L-d' 'dw'});
model.geom('geom1').feature('wp1').geom.feature('r9').set('size', {'d' 'gap'});
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'r1' 'r2' 'r3' 'r4' 'r5' 'r6' 'r7' 'r8' 'r9'});
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'd/3');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('uni1(1)', [1 2 4 5 6 7 8 9 11 12 13 14 16 17 19 20 21 22 23 28]);
model.geom('geom1').create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', '2', 0);
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('pos', {'d' '(dw+d+2*gap)+(dw+gap+d)-2.5*(wb-2*d)-d'});
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'wb-2*d' '2.5*(wb-2*d)'});
model.geom('geom1').feature('wp2').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r2').set('pos', {'L-L2-wb+d' 'd'});
model.geom('geom1').feature('wp2').geom.feature('r2').set('size', {'wb-2*d' '2.5*(wb-2*d)'});
model.geom('geom1').feature('wp2').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r3').set('pos', {'L-L3-L4-wb+d' 'd'});
model.geom('geom1').feature('wp2').geom.feature('r3').set('size', {'wb-2*d' '2.5*(wb-2*d)'});
model.geom('geom1').feature('wp2').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp2').geom.feature('fil1').set('radius', 'd/3');
model.geom('geom1').feature('wp2').geom.feature('fil1').selection('point').set('r1(1)', [1 2 3 4]);
model.geom('geom1').feature('wp2').geom.feature('fil1').selection('point').set('r2(1)', [1 2 3 4]);
model.geom('geom1').feature('wp2').geom.feature('fil1').selection('point').set('r3(1)', [1 2 3 4]);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('pos', {'L-L3/4' 'dw/2'});
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'd/2');
model.geom('geom1').feature('wp2').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c2').set('pos', {'L-L3/2' 'dw/2'});
model.geom('geom1').feature('wp2').geom.feature('c2').set('r', 'd/2');
model.geom('geom1').feature('wp2').geom.create('c3', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c3').set('pos', {'L-3*L3/4' 'dw/2'});
model.geom('geom1').feature('wp2').geom.feature('c3').set('r', 'd/2');
model.geom('geom1').create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').setIndex('distance', '2', 0);
model.geom('geom1').feature('ext2').set('reverse', true);
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').feature('uni1').selection('input').set({'ext1' 'ext2'});
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('uni1(1)', 10);
model.geom('geom1').feature('sel1').set('selkeep', false);
model.geom('geom1').feature('sel1').set('contributeto', 'csel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('uni1(1)', 29);
model.geom('geom1').feature('sel2').set('selkeep', false);
model.geom('geom1').feature('sel2').set('contributeto', 'csel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('uni1(1)', 48);
model.geom('geom1').feature('sel3').set('selkeep', false);
model.geom('geom1').feature('sel3').set('contributeto', 'csel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('uni1(1)', 4);
model.geom('geom1').feature('sel4').set('selkeep', false);
model.geom('geom1').feature('sel4').set('contributeto', 'csel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('uni1(1)', [1 2 3 5 6 7 8 9 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92]);
model.geom('geom1').feature('sel5').set('selkeep', false);
model.geom('geom1').feature('sel5').set('contributeto', 'csel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').selection('selection').init(0);
model.geom('geom1').feature('sel6').selection('selection').set('uni1(1)', 154);
model.geom('geom1').feature('sel6').set('selkeep', false);
model.geom('geom1').feature('sel6').set('contributeto', 'csel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').selection('selection').init(2);
model.geom('geom1').feature('sel7').selection('selection').set('uni1(1)', [67 72 77]);
model.geom('geom1').feature('sel7').set('selkeep', false);
model.geom('geom1').feature('sel7').set('contributeto', 'csel7');
model.geom('geom1').create('endif1', 'EndIf');
model.geom('geom1').create('if2', 'If');
model.geom('geom1').feature('if2').set('condition', '(noa==2)');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r1').set('pos', {'L-L3' '0'});
model.geom('geom1').feature('wp3').geom.feature('r1').set('size', {'L3' 'dw'});
model.geom('geom1').feature('wp3').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r2').set('pos', {'L-L3-L4' 'dw-d'});
model.geom('geom1').feature('wp3').geom.feature('r2').set('size', {'L4' 'd'});
model.geom('geom1').feature('wp3').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r3').set('pos', {'L-L3-L4-wb' '0'});
model.geom('geom1').feature('wp3').geom.feature('r3').set('size', {'wb' 'dw'});
model.geom('geom1').feature('wp3').geom.create('r4', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r4').set('pos', {'L-L2' 'dw+gap'});
model.geom('geom1').feature('wp3').geom.feature('r4').set('size', {'L2' 'd'});
model.geom('geom1').feature('wp3').geom.create('r5', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r5').set('pos', {'L-L2-wb' '0'});
model.geom('geom1').feature('wp3').geom.feature('r5').set('size', {'wb' 'dw+gap+d'});
model.geom('geom1').feature('wp3').geom.create('r6', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r6').active(false);
model.geom('geom1').feature('wp3').geom.feature('r6').set('pos', {'L-L1' 'dw+d+2*gap'});
model.geom('geom1').feature('wp3').geom.feature('r6').set('size', {'L1' 'd'});
model.geom('geom1').feature('wp3').geom.create('r7', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r7').active(false);
model.geom('geom1').feature('wp3').geom.feature('r7').set('pos', {'0' 'dw+d+2*gap'});
model.geom('geom1').feature('wp3').geom.feature('r7').set('size', {'wb' 'dw+gap+d'});
model.geom('geom1').feature('wp3').geom.create('r8', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r8').active(false);
model.geom('geom1').feature('wp3').geom.feature('r8').set('pos', {'L-d' 'dw+gap+d'});
model.geom('geom1').feature('wp3').geom.feature('r8').set('size', {'d' 'gap'});
model.geom('geom1').feature('wp3').geom.create('r9', 'Rectangle');
model.geom('geom1').feature('wp3').geom.feature('r9').set('pos', {'L-d' 'dw'});
model.geom('geom1').feature('wp3').geom.feature('r9').set('size', {'d' 'gap'});
model.geom('geom1').feature('wp3').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp3').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp3').geom.feature('uni1').selection('input').set({'r1' 'r2' 'r3' 'r4' 'r5' 'r6' 'r7' 'r8' 'r9'});
model.geom('geom1').feature('wp3').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp3').geom.feature('fil1').set('radius', 'd/3');
model.geom('geom1').feature('wp3').geom.feature('fil1').selection('point').set('uni1(1)', [1 2 4 5 6 7 8 9 11 12 13 14 16 17 19]);
model.geom('geom1').create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').setIndex('distance', '2', 0);
model.geom('geom1').feature('ext3').selection('input').set({'wp3'});
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r1').active(false);
model.geom('geom1').feature('wp4').geom.feature('r1').set('pos', {'d' '(dw+d+2*gap)+(dw+gap+d)-2.5*(wb-2*d)-d'});
model.geom('geom1').feature('wp4').geom.feature('r1').set('size', {'wb-2*d' '2.5*(wb-2*d)'});
model.geom('geom1').feature('wp4').geom.create('r2', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r2').set('pos', {'L-L2-wb+d' 'd'});
model.geom('geom1').feature('wp4').geom.feature('r2').set('size', {'wb-2*d' '2.5*(wb-2*d)'});
model.geom('geom1').feature('wp4').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r3').set('pos', {'L-L3-L4-wb+d' 'd'});
model.geom('geom1').feature('wp4').geom.feature('r3').set('size', {'wb-2*d' '2.5*(wb-2*d)'});
model.geom('geom1').feature('wp4').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp4').geom.feature('fil1').set('radius', 'd/3');
model.geom('geom1').feature('wp4').geom.feature('fil1').selection('point').set('r1(1)', [1 2 3 4]);
model.geom('geom1').feature('wp4').geom.feature('fil1').selection('point').set('r2(1)', [1 2 3 4]);
model.geom('geom1').feature('wp4').geom.feature('fil1').selection('point').set('r3(1)', [1 2 3 4]);
model.geom('geom1').feature('wp4').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp4').geom.feature('c1').set('pos', {'L-L3/4' 'dw/2'});
model.geom('geom1').feature('wp4').geom.feature('c1').set('r', 'd/2');
model.geom('geom1').feature('wp4').geom.create('c2', 'Circle');
model.geom('geom1').feature('wp4').geom.feature('c2').set('pos', {'L-L3/2' 'dw/2'});
model.geom('geom1').feature('wp4').geom.feature('c2').set('r', 'd/2');
model.geom('geom1').feature('wp4').geom.create('c3', 'Circle');
model.geom('geom1').feature('wp4').geom.feature('c3').set('pos', {'L-3*L3/4' 'dw/2'});
model.geom('geom1').feature('wp4').geom.feature('c3').set('r', 'd/2');
model.geom('geom1').create('ext4', 'Extrude');
model.geom('geom1').feature('ext4').setIndex('distance', '2', 0);
model.geom('geom1').feature('ext4').set('reverse', true);
model.geom('geom1').feature('ext4').selection('input').set({'wp4'});
model.geom('geom1').create('uni2', 'Union');
model.geom('geom1').feature('uni2').set('intbnd', false);
model.geom('geom1').feature('uni2').selection('input').set({'ext3' 'ext4'});
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').selection('selection').init(2);
model.geom('geom1').feature('sel8').selection('selection').set('uni2(1)', 28);
model.geom('geom1').feature('sel8').set('selkeep', false);
model.geom('geom1').feature('sel8').set('contributeto', 'csel1');
model.geom('geom1').create('sel9', 'ExplicitSelection');
model.geom('geom1').feature('sel9').selection('selection').init(2);
model.geom('geom1').feature('sel9').selection('selection').set('uni2(1)', 10);
model.geom('geom1').feature('sel9').set('selkeep', false);
model.geom('geom1').feature('sel9').set('contributeto', 'csel2');
model.geom('geom1').create('sel10', 'ExplicitSelection');
model.geom('geom1').feature('sel10').selection('selection').init(2);
model.geom('geom1').feature('sel10').selection('selection').set('uni2(1)', 4);
model.geom('geom1').feature('sel10').set('selkeep', false);
model.geom('geom1').feature('sel10').set('contributeto', 'csel4');
model.geom('geom1').create('sel11', 'ExplicitSelection');
model.geom('geom1').feature('sel11').selection('selection').init(2);
model.geom('geom1').feature('sel11').selection('selection').set('uni2(1)', [1 2 3 5 6 7 8 9 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66]);
model.geom('geom1').feature('sel11').set('selkeep', false);
model.geom('geom1').feature('sel11').set('contributeto', 'csel5');
model.geom('geom1').create('sel12', 'ExplicitSelection');
model.geom('geom1').feature('sel12').selection('selection').init(0);
model.geom('geom1').feature('sel12').selection('selection').set('uni2(1)', 108);
model.geom('geom1').feature('sel12').set('selkeep', false);
model.geom('geom1').feature('sel12').set('contributeto', 'csel6');
model.geom('geom1').create('sel13', 'ExplicitSelection');
model.geom('geom1').feature('sel13').selection('selection').init(2);
model.geom('geom1').feature('sel13').selection('selection').set('uni2(1)', [47 52 57]);
model.geom('geom1').feature('sel13').set('selkeep', false);
model.geom('geom1').feature('sel13').set('contributeto', 'csel7');
model.geom('geom1').create('endif2', 'EndIf');
model.geom('geom1').run;
model.geom('geom1').run('fin');

model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').label('Surface Contact');
model.selection('uni1').set('input', {'geom1_csel1_bnd' 'geom1_csel2_bnd' 'geom1_csel3_bnd'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('sigma', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('alpha', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Analytic');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');
model.physics('ec').create('pot1', 'ElectricPotential', 2);
model.physics('ec').feature('pot1').selection.named('geom1_csel2_bnd');
model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.named('geom1_csel1_bnd');
model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').selection.named('geom1_csel5_bnd');
model.physics('ht').create('hf2', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf2').selection.named('geom1_csel4_bnd');
model.physics('ht').create('temp1', 'TemperatureBoundary', 2);
model.physics('ht').feature('temp1').selection.named('uni1');
model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('uni1');
model.physics('solid').create('roll1', 'Roller', 2);
model.physics('solid').feature('roll1').selection.named('geom1_csel7_bnd');

model.multiphysics.create('emh1', 'ElectromagneticHeating', 'geom1', 3);

model.mesh('mesh1').autoMeshSize(7);

model.result.table('tbl3').label('Design Data');
model.result.table('tbl1').comments('Point Evaluation 1');
model.result.table('tbl2').comments('Volume Maximum 1');
model.result.table('tbl4').label('Accumulated Probe Table 4');
model.result.table('tbl5').label('Accumulated Probe Table 5');

model.view('view2').axis.set('xmin', -12);
model.view('view2').axis.set('xmax', 252);
model.view('view2').axis.set('ymin', -66.92748260498047);
model.view('view2').axis.set('ymax', 111.92748260498047);
model.view('view3').axis.set('xmin', -12);
model.view('view3').axis.set('xmax', 252);
model.view('view3').axis.set('ymin', -66.92748260498047);
model.view('view3').axis.set('ymax', 111.92748260498047);
model.view('view4').axis.set('xmin', -1.3595505952835083);
model.view('view4').axis.set('xmax', 1.3595505952835083);

model.material('mat1').label('Polysilicon');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat1').set('diffuse', 'custom');
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('ambient', 'custom');
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.7);
model.material('mat1').set('roughness', 0.5);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').func('sigma').set('expr', '1/(2e-5*(1+1.25e-3*(T-298.15)))');
model.material('mat1').propertyGroup('def').func('sigma').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('sigma').set('dermethod', 'manual');
model.material('mat1').propertyGroup('def').func('sigma').set('argders', {'T' 'd(1/(2e-5*(1+1.25e-3*(T-298.15))), T)'});
model.material('mat1').propertyGroup('def').func('sigma').set('fununit', 'S/m');
model.material('mat1').propertyGroup('def').func('sigma').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('sigma').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('sigma').set('plotargs', {'T' '273.15' '500'});
model.material('mat1').propertyGroup('def').func('alpha').set('expr', '(3.725*(1-exp(-5.88e-3*(T-125)))+5.548e-4*T)*1e-6');
model.material('mat1').propertyGroup('def').func('alpha').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('alpha').set('dermethod', 'manual');
model.material('mat1').propertyGroup('def').func('alpha').set('argders', {'T' 'd((3.725*(1-exp(-5.88e-3*(T-125)))+5.548e-4*T)*1e-6, T)'});
model.material('mat1').propertyGroup('def').func('alpha').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('alpha').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('alpha').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('alpha').set('plotargs', {'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('expr', '1/(-2.2e-11*T^3 + 9e-8*T^2 - 1e-5*T + 0.014)');
model.material('mat1').propertyGroup('def').func('k').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('k').set('dermethod', 'manual');
model.material('mat1').propertyGroup('def').func('k').set('argders', {'T' 'd(1/(-2.2e-11*T^3 + 9e-8*T^2 - 1e-5*T + 0.014), T)'});
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('k').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('k').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('k').set('plotargs', {'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'sigma(T)' '0' '0' '0' 'sigma(T)' '0' '0' '0' 'sigma(T)'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha(T)' '0' '0' '0' 'alpha(T)' '0' '0' '0' 'alpha(T)'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '678[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.5' '0' '0' '0' '4.5' '0' '0' '0' '4.5'});
model.material('mat1').propertyGroup('def').set('density', '2320[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('Enu').set('E', '169[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.22');
model.material('mat1').propertyGroup('linzRes').set('rho0', '2e-5');
model.material('mat1').propertyGroup('linzRes').set('alpha', '1.25e-3');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298.15[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');

model.cpl.remove('builder_integrate49');
model.cpl.remove('builder_integrate50');
model.cpl.remove('builder_integrate51');
model.cpl.remove('builder_integrate52');
model.cpl.remove('builder_integrate53');
model.cpl.remove('builder_integrate54');
model.cpl.remove('builder_integrate55');
model.cpl.remove('builder_integrate56');
model.cpl.remove('builder_integrate57');
model.cpl.remove('builder_integrate58');
model.cpl.remove('builder_integrate59');
model.cpl.remove('builder_integrate60');
model.cpl.remove('builder_integrate61');
model.cpl.remove('builder_integrate62');
model.cpl.remove('builder_integrate63');
model.cpl.remove('builder_integrate64');
model.cpl.remove('builder_integrate65');
model.cpl.remove('builder_integrate66');
model.cpl.remove('builder_integrate67');
model.cpl.remove('builder_integrate68');
model.cpl.remove('builder_integrate69');
model.cpl.remove('builder_integrate70');
model.cpl.remove('builder_integrate71');
model.cpl.remove('builder_integrate72');
model.cpl.remove('builder_integrate73');
model.cpl.remove('builder_integrate74');
model.cpl.remove('builder_integrate75');
model.cpl.remove('builder_integrate76');
model.cpl.remove('builder_integrate77');
model.cpl.remove('builder_integrate78');
model.cpl.remove('builder_integrate79');
model.cpl.remove('builder_integrate80');
model.cpl.remove('builder_integrate81');
model.cpl.remove('builder_integrate82');
model.cpl.remove('builder_integrate83');
model.cpl.remove('builder_integrate84');

model.physics('ec').feature('pot1').set('V0', 'DV');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'htc_s');
model.physics('ht').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf2').set('h', 'htc_us');
model.physics('solid').feature('lemm1').featureInfo('info').set('solid.eXX', {'uX-alphaps*(T-T0)'});
model.physics('solid').feature('lemm1').featureInfo('info').set('solid.eYY', {'vY-alphaps*(T-T0)'});
model.physics('solid').feature('lemm1').featureInfo('info').set('solid.eZZ', {'wZ-alphaps*(T-T0)'});

model.study.create('std1');
model.study('std1').create('sm', 'SurrogateModelTraining');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'ec' 'off' 'ht' 'off' 'solid' 'off' 'frame:spatial1' 'on' 'frame:material1' 'on'});
model.study('std1').feature('stat').set('activateCoupling', {'emh1' 'off'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').create('d2', 'Direct');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').create('i3', 'Iterative');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch.create('pd1', 'DesignofExperiments');
model.batch('pd1').create('so1', 'Solutionseq');
model.batch('pd1').create('ex1', 'Exportseq');
model.batch('pd1').study('std1');

model.result.param.set('DV2', '5[V]', 'Voltage');
model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical.create('max1', 'MaxVolume');
model.result.numerical('pev1').selection.named('geom1_csel6_pnt');
model.result.numerical('max1').selection.all;
model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup3D');
model.result.create('pg3', 'PlotGroup3D');
model.result.create('pg4', 'PlotGroup3D');
model.result.create('pg5', 'PlotGroup3D');
model.result.create('pg6', 'PlotGroup3D');
model.result.create('pg7', 'PlotGroup3D');
model.result.create('pg8', 'PlotGroup3D');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').create('vol2', 'Volume');
model.result('pg1').feature('vol2').set('expr', 'dnn1_V(x,y,z,dw,gap,wv,L,DV2)');
model.result('pg2').create('mslc1', 'Multislice');
model.result('pg2').create('strmsl1', 'StreamlineMultislice');
model.result('pg2').feature('mslc1').set('expr', 'ec.normE');
model.result('pg2').feature('strmsl1').create('col1', 'Color');
model.result('pg2').feature('strmsl1').create('filt1', 'Filter');
model.result('pg2').feature('strmsl1').feature('col1').set('expr', 'ec.normE');
model.result('pg2').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg3').create('vol1', 'Volume');
model.result('pg3').create('vol2', 'Volume');
model.result('pg3').feature('vol1').set('expr', 'T');
model.result('pg3').feature('vol1').create('def1', 'Deform');
model.result('pg3').feature('vol2').set('expr', 'dnn1_T(x,y,z,dw,gap,wv,L,DV2)');
model.result('pg3').feature('vol2').create('def1', 'Deform');
model.result('pg4').create('vol1', 'Volume');
model.result('pg4').create('vol2', 'Volume');
model.result('pg4').feature('vol1').set('expr', 'solid.misesGp');
model.result('pg4').feature('vol1').create('def', 'Deform');
model.result('pg4').feature('vol2').set('expr', 'dnn1_mises(x,y,z,dw,gap,wv,L,DV2)');
model.result('pg4').feature('vol2').create('def', 'Deform');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('vol1', 'Volume');
model.result('pg6').set('data', 'dset2');
model.result('pg6').create('mslc1', 'Multislice');
model.result('pg6').create('strmsl1', 'StreamlineMultislice');
model.result('pg6').feature('mslc1').set('expr', 'ec.normE');
model.result('pg6').feature('strmsl1').create('col1', 'Color');
model.result('pg6').feature('strmsl1').create('filt1', 'Filter');
model.result('pg6').feature('strmsl1').feature('col1').set('expr', 'ec.normE');
model.result('pg6').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg7').set('data', 'dset2');
model.result('pg7').create('vol1', 'Volume');
model.result('pg7').feature('vol1').set('expr', 'T');
model.result('pg8').set('data', 'dset2');
model.result('pg8').create('vol1', 'Volume');
model.result('pg8').feature('vol1').set('expr', 'solid.misesGp');
model.result('pg8').feature('vol1').create('def', 'Deform');
model.result.export.create('data1', 'Data');

model.nodeGroup.create('de1', 'Results');
model.nodeGroup('de1').set('type', 'table');
model.nodeGroup('de1').placeAfter([]);

model.study('std1').feature('sm').active(false);
model.study('std1').feature('sm').set('objgrp', 'de1');
model.study('std1').feature('sm').set('qoiexpression', {'1'});
model.study('std1').feature('sm').set('descr', {''});
model.study('std1').feature('sm').set('qoisolutionindv', {'parent'});
model.study('std1').feature('sm').set('pname', {'dw' 'gap' 'wv' 'L' 'DV'});
model.study('std1').feature('sm').set('lboundselection', {'col1' 'min_dw' 'col2' 'min_gap' 'col3' 'min_wv' 'col4' 'min_L' 'col5' 'min_DV'});
model.study('std1').feature('sm').set('uboundselection', {'col1' 'max_dw' 'col2' 'max_gap' 'col3' 'max_wv' 'col4' 'max_L' 'col5' 'max_DV'});
model.study('std1').feature('sm').set('punitselection', {'col1' 'um' 'col2' 'um' 'col3' 'um' 'col4' 'um' 'col5' 'V'});
model.study('std1').feature('sm').set('columnlabels', {['sqrteps(real(dnn1_u(x,y,z,dw,gap,wv,L,DV2))^2+real(dnn1_v(x,y,z,dw,gap,wv,L,DV2))^2+real(dnn1_w(x,y,z,dw,gap,wv,L,DV2))^2) (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm), Point: 154']});
model.study('std1').feature('sm').set('nsolvenonadp', 4000);
model.study('std1').feature('sm').set('errorhandling', 'later');
model.study('std1').feature('stat').set('probesel', 'none');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label('Compile Equations: Stationary');
model.sol('sol1').feature('v1').label('Dependent Variables 1.1');
model.sol('sol1').feature('s1').label('Stationary Solver 1.1');
model.sol('sol1').feature('s1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('dDef').label('Direct 3');
model.sol('sol1').feature('s1').feature('aDef').label('Advanced 1');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('se1').label('Segregated 1.1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Electric Currents');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_V'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Temperature');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_T'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdamp', '0.8');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').label('Solid Mechanics');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_u'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'd2');
model.sol('sol1').feature('s1').feature('se1').feature('ll1').label('Lower Limit 1.1');
model.sol('sol1').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('s1').feature('i1').label('Iterative 1.1');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').feature('ilDef').label('Incomplete LU 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').label('Multigrid 1.1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('coarseningmethod', 'classic');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').label('Presmoother 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').label('Postsmoother 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').label('Coarse Solver 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d2').label('Suggested Direct Solver (solid)');
model.sol('sol1').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d2').set('pivotperturb', 1.0E-9);
model.sol('sol1').feature('s1').feature('i2').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').feature('ilDef').label('Incomplete LU 1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').label('Multigrid 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').label('Presmoother 1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('soDef').label('SOR 2');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').label('SOR 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').label('Postsmoother 1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('soDef').label('SOR 2');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').label('SOR 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').label('Coarse Solver 1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('dDef').label('Direct 2');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').label('Direct 1.1');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('i3').label('Suggested Iterative Solver (solid)');
model.sol('sol1').feature('s1').feature('i3').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i3').feature('ilDef').label('Incomplete LU 1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').label('Multigrid 1.1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').label('Presmoother 1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('soDef').label('SOR 2');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('so1').label('SOR 1.1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('pr').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').label('Postsmoother 1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('soDef').label('SOR 2');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('so1').label('SOR 1.1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('po').feature('so1').set('relax', 0.8);
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').label('Coarse Solver 1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').feature('dDef').label('Direct 2');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').label('Direct 1.1');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-9);
model.sol('sol1').runAll;

model.batch('pd1').set('control', 'sm');
model.batch('pd1').set('objgrp', 'de1');
model.batch('pd1').set('qoiexpression', {'1'});
model.batch('pd1').set('outputdescr', {''});
model.batch('pd1').set('qoisolutionindv', {'parent'});
model.batch('pd1').set('pname', {'dw' 'gap' 'wv' 'L' 'DV'});
model.batch('pd1').set('columnlabels', {['Displacement magnitude (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm), Point: 108'] ['Displacement magnitude (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm), Point: 154']});
model.batch('pd1').set('nsolvenonadp', 4000);
model.batch('pd1').set('lhssettings', 'auto');
model.batch('pd1').set('useaccumtable', true);
model.batch('pd1').set('accumtable', 'tbl5');
model.batch('pd1').set('param', {'"dw","2.2949E-5","gap","4.928E-6","wv","2.4226E-5","L","1.5016E-4","DV","22.788"' '"dw","2.9456E-5","gap","4.5956E-6","wv","4.0265E-5","L","1.5495E-4","DV","23.583"' '"dw","2.0145E-5","gap","2.8733E-6","wv","4.0211E-5","L","1.6214E-4","DV","23.117"' '"dw","3.5538E-5","gap","2.5772E-6","wv","4.2283E-5","L","1.6673E-4","DV","23.059"'});
model.batch('pd1').set('convinfo', false);
model.batch('pd1').feature('so1').set('seq', 'sol1');
model.batch('pd1').feature('so1').set('psol', 'sol2');
model.batch('pd1').feature('so1').set('param', {'"dw","3.97029230867171E-5","gap","4.81425209178553E-6","wv","4.36977985222859E-5","L","3.12574321220714E-4","DV","9.82874314927022"'});
model.batch('pd1').feature('ex1').set('clear', false);
model.batch('pd1').feature('ex1').set('paramfilename', false);
model.batch('pd1').feature('ex1').set('param', {'"dw","3.9703E-5","gap","4.8143E-6","wv","4.3698E-5","L","3.1257E-4","DV","9.8287"'});
model.batch('pd1').run;

model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').set('expr', {'sqrteps(real(dnn1_u(x,y,z,dw,gap,wv,L,DV2))^2+real(dnn1_v(x,y,z,dw,gap,wv,L,DV2))^2+real(dnn1_w(x,y,z,dw,gap,wv,L,DV2))^2)'});
model.result.numerical('pev1').set('unit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']});
model.result.numerical('pev1').set('descr', {''});
model.result.numerical('pev1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result.numerical('max1').set('table', 'tbl2');
model.result.numerical('max1').set('expr', {'dnn1_T(x,y,z,dw,gap,wv,L,DV2)'});
model.result.numerical('max1').set('descr', {'Deep Neural Network 1'});
model.result.numerical('max1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result.numerical('max1').set('unit', {'K'});
model.result.numerical('pev1').setResult;
model.result.numerical('max1').setResult;
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').feature('vol1').active(false);
model.result('pg1').feature('vol1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg1').feature('vol1').set('titletype', 'manual');
model.result('pg1').feature('vol1').set('title', 'Electric potential (V)');
model.result('pg1').feature('vol1').set('colortable', 'Dipole');
model.result('pg1').feature('vol1').set('resolution', 'normal');
model.result('pg1').feature('vol2').set('unit', 'V');
model.result('pg1').feature('vol2').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg1').feature('vol2').set('titletype', 'manual');
model.result('pg1').feature('vol2').set('title', 'Electric potential (V) (preview)');
model.result('pg1').feature('vol2').set('colortable', 'Dipole');
model.result('pg1').feature('vol2').set('resolution', 'normal');
model.result('pg2').label('Electric Field Norm (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').feature('mslc1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg2').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('mslc1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('mslc1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('mslc1').set('zcoord', 'ec.CPz');
model.result('pg2').feature('mslc1').set('colortable', 'Prism');
model.result('pg2').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg2').feature('mslc1').set('resolution', 'normal');
model.result('pg2').feature('strmsl1').set('expr', {'ec.Ex' 'ec.Ey' 'ec.Ez'});
model.result('pg2').feature('strmsl1').set('descr', 'Electric field (spatial frame)');
model.result('pg2').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg2').feature('strmsl1').set('xcoord', 'ec.CPx');
model.result('pg2').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg2').feature('strmsl1').set('ycoord', 'ec.CPy');
model.result('pg2').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg2').feature('strmsl1').set('zcoord', 'ec.CPz');
model.result('pg2').feature('strmsl1').set('titletype', 'none');
model.result('pg2').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg2').feature('strmsl1').set('udist', 0.02);
model.result('pg2').feature('strmsl1').set('maxlen', 0.4);
model.result('pg2').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg2').feature('strmsl1').set('inheritcolor', false);
model.result('pg2').feature('strmsl1').set('resolution', 'normal');
model.result('pg2').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg2').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg2').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').label('Temperature (ht)');
model.result('pg3').feature('vol1').active(false);
model.result('pg3').feature('vol1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg3').feature('vol1').set('titletype', 'manual');
model.result('pg3').feature('vol1').set('title', 'Temperature (K)');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('resolution', 'normal');
model.result('pg3').feature('vol1').feature('def1').set('scale', 8.671592113101143);
model.result('pg3').feature('vol1').feature('def1').set('scaleactive', false);
model.result('pg3').feature('vol2').set('unit', 'K');
model.result('pg3').feature('vol2').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg3').feature('vol2').set('titletype', 'manual');
model.result('pg3').feature('vol2').set('title', 'Temperature (K) (preview)');
model.result('pg3').feature('vol2').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol2').set('smooth', 'internal');
model.result('pg3').feature('vol2').set('resolution', 'normal');
model.result('pg3').feature('vol2').feature('def1').set('expr', {'dnn1_u(x,y,z,dw,gap,wv,L,DV)' 'dnn1_v(x,y,z,dw,gap,wv,L,DV)' 'dnn1_w(x,y,z,dw,gap,wv,L,DV)'});
model.result('pg3').feature('vol2').feature('def1').set('descr', '');
model.result('pg3').feature('vol2').feature('def1').set('scale', 8.442027114400078);
model.result('pg3').feature('vol2').feature('def1').set('scaleactive', false);
model.result('pg4').label('Stress (solid)');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').feature('vol1').active(false);
model.result('pg4').feature('vol1').set('unit', 'MPa');
model.result('pg4').feature('vol1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg4').feature('vol1').set('titletype', 'manual');
model.result('pg4').feature('vol1').set('title', 'Stress (MPa)');
model.result('pg4').feature('vol1').set('colortable', 'Prism');
model.result('pg4').feature('vol1').set('resolution', 'custom');
model.result('pg4').feature('vol1').set('refine', 2);
model.result('pg4').feature('vol1').set('threshold', 'manual');
model.result('pg4').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg4').feature('vol1').set('resolution', 'custom');
model.result('pg4').feature('vol1').set('refine', 2);
model.result('pg4').feature('vol1').feature('def').set('scale', 8.671592113101143);
model.result('pg4').feature('vol1').feature('def').set('scaleactive', false);
model.result('pg4').feature('vol2').set('unit', 'MPa');
model.result('pg4').feature('vol2').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg4').feature('vol2').set('titletype', 'manual');
model.result('pg4').feature('vol2').set('title', 'Stress (MPa) (preview)');
model.result('pg4').feature('vol2').set('colortable', 'Prism');
model.result('pg4').feature('vol2').set('resolution', 'custom');
model.result('pg4').feature('vol2').set('refine', 2);
model.result('pg4').feature('vol2').set('threshold', 'manual');
model.result('pg4').feature('vol2').set('thresholdvalue', 0.2);
model.result('pg4').feature('vol2').set('resolution', 'custom');
model.result('pg4').feature('vol2').set('refine', 2);
model.result('pg4').feature('vol2').feature('def').set('expr', {'dnn1_u(x,y,z,dw,gap,wv,L,DV)' 'dnn1_v(x,y,z,dw,gap,wv,L,DV)' 'dnn1_w(x,y,z,dw,gap,wv,L,DV)'});
model.result('pg4').feature('vol2').feature('def').set('descr', '');
model.result('pg4').feature('vol2').feature('def').set('scale', 8.610762659733327);
model.result('pg4').feature('vol2').feature('def').set('scaleactive', false);
model.result('pg5').label('Electric Potential (ec) 1');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsmaxmin', true);
model.result('pg5').feature('vol1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg5').feature('vol1').set('colortable', 'Dipole');
model.result('pg5').feature('vol1').set('resolution', 'normal');
model.result('pg6').label('Electric Field Norm (ec) 1');
model.result('pg6').set('frametype', 'spatial');
model.result('pg6').set('showlegendsmaxmin', true);
model.result('pg6').feature('mslc1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg6').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg6').feature('mslc1').set('xcoord', 'ec.CPx');
model.result('pg6').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg6').feature('mslc1').set('ycoord', 'ec.CPy');
model.result('pg6').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg6').feature('mslc1').set('zcoord', 'ec.CPz');
model.result('pg6').feature('mslc1').set('colortable', 'Prism');
model.result('pg6').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg6').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg6').feature('mslc1').set('resolution', 'normal');
model.result('pg6').feature('strmsl1').set('expr', {'ec.Ex' 'ec.Ey' 'ec.Ez'});
model.result('pg6').feature('strmsl1').set('descr', 'Electric field (spatial frame)');
model.result('pg6').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg6').feature('strmsl1').set('xcoord', 'ec.CPx');
model.result('pg6').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg6').feature('strmsl1').set('ycoord', 'ec.CPy');
model.result('pg6').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg6').feature('strmsl1').set('zcoord', 'ec.CPz');
model.result('pg6').feature('strmsl1').set('titletype', 'none');
model.result('pg6').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg6').feature('strmsl1').set('udist', 0.02);
model.result('pg6').feature('strmsl1').set('maxlen', 0.4);
model.result('pg6').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg6').feature('strmsl1').set('inheritcolor', false);
model.result('pg6').feature('strmsl1').set('resolution', 'normal');
model.result('pg6').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg6').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg6').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg6').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);
model.result('pg7').label('Temperature (ht) 1');
model.result('pg7').feature('vol1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg7').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg7').feature('vol1').set('smooth', 'internal');
model.result('pg7').feature('vol1').set('resolution', 'normal');
model.result('pg8').label('Stress (solid) 1');
model.result('pg8').set('frametype', 'spatial');
model.result('pg8').feature('vol1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result('pg8').feature('vol1').set('colortable', 'Prism');
model.result('pg8').feature('vol1').set('resolution', 'custom');
model.result('pg8').feature('vol1').set('refine', 2);
model.result('pg8').feature('vol1').set('threshold', 'manual');
model.result('pg8').feature('vol1').set('thresholdvalue', 0.2);
model.result('pg8').feature('vol1').set('resolution', 'custom');
model.result('pg8').feature('vol1').set('refine', 2);
model.result('pg8').feature('vol1').feature('def').set('scale', 1.8193905848205731);
model.result('pg8').feature('vol1').feature('def').set('scaleactive', false);
model.result.export('data1').set('expr', {'dw' 'gap' 'wv' 'L' 'DV' 'V' 'T' 'u' 'v' 'w'  ...
'solid.misesGp'});
model.result.export('data1').set('unit', {[native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] 'V' 'V' 'K' [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm'] [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']  ...
'N/m^2'});
model.result.export('data1').set('descr', {'Height of the cold arm' 'Gap between arms' 'Difference in length between hot arms' 'Actuator length' 'Applied voltage' 'Electric potential' 'Temperature' 'Displacement field, X-component' 'Displacement field, Y-component' 'Displacement field, Z-component'  ...
'von Mises stress'});
model.result.export('data1').set('const', {'solid.refpntx' '0' 'Reference point for moment computation, x-coordinate'; 'solid.refpnty' '0' 'Reference point for moment computation, y-coordinate'; 'solid.refpntz' '0' 'Reference point for moment computation, z-coordinate'});
model.result.export('data1').set('filename', 'thermal_actuator_surrogate_data.txt');
model.result.export('data1').set('ifexists', 'append');

model.nodeGroup('de1').label('Design of Experiments');
model.nodeGroup('de1').add('table', 'tbl3');

model.result('pg3').run;

model.title('Thermal Actuator Surrogate Model');

model.description('This tutorial illustrates how to model electrothermal actuation of a microdevice. It uses the Joule Heating interface to simulate the heating of an actuator caused by an electric voltage applied to the device. Thermal expansion is manually added using the equation view. This example uses the programming operation in the geometry sequence to consider different geometry cases.');

model.label('thermal_actuator_surrogate.mph');

model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').label('Electric Potential');
model.result('pg3').run;
model.result('pg3').label('Temperature');
model.result('pg4').run;
model.result('pg4').label('Stress');
model.result('pg2').run;
model.result.remove('pg2');
model.result.remove('pg5');
model.result.remove('pg6');
model.result.remove('pg7');
model.result.remove('pg8');
model.result('pg3').run;
model.result.report.create('rpt1', 'Report');
model.result.report('rpt1').set('templatesource', 'brief');
model.result.report('rpt1').set('format', 'docx');
model.result.report('rpt1').set('imagesize', 'large');
model.result.report('rpt1').feature.create('tp1', 'TitlePage');
model.result.report('rpt1').feature('tp1').set('summary', 'The Thermal Actuator Surrogate Model application demonstrates how to accelerate computation for multiphysics analysis using a surrogate model for a fully parametric geometry model. A surrogate model is a simpler, usually computationally cheaper model, which is used to approximate the behavior of a more complex, and often more computationally expensive, model. The faster model evaluation offered by the surrogate model provides the user of the app a more interactive user experience and makes it easier to spread the use of simulations in an organization. This example illustrates how a surrogate model can be created and used in an app for a multiphysics simulation where the geometry is based on a parametric CAD model.');
model.result.report('rpt1').feature.create('toc1', 'TableOfContents');
model.result.report('rpt1').feature('toc1').label('Table of Contents');
model.result.report('rpt1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').label('Global Definitions');
model.result.report('rpt1').feature('sec1').feature.create('root1', 'Model');
model.result.report('rpt1').feature('sec1').feature('root1').label('Root');
model.result.report('rpt1').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').feature('sec1').label('Parameters');
model.result.report('rpt1').feature('sec1').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('sec1').label('Parameters 1');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('sec1').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec1').feature('sec1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('sec2').label('Parameters 2');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('sec2').set('source', 'firstchild');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('sec2').feature.create('param1', 'Parameter');
model.result.report('rpt1').feature('sec1').feature('sec1').feature('sec2').feature('param1').set('noderef', 'par2');
model.result.report('rpt1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').label('Thermal Actuator');
model.result.report('rpt1').feature('sec2').feature.create('comp1', 'ModelNode');
model.result.report('rpt1').feature('sec2').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec1').label('Definitions');
model.result.report('rpt1').feature('sec2').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').label('Selections');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').feature('sec1').label('Surface Contact');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').feature('sec1').feature.create('sel1', 'Selection');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').feature('sec1').feature('sel1').set('imagesize', 'medium');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').feature('sec1').feature('sel1').set('noderef', 'uni1');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec1').feature('sec1').feature('sel1').set('includeimage', true);
model.result.report('rpt1').feature('sec2').feature('sec1').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec2').label('Coordinate Systems');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec2').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec2').feature('sec1').label('Boundary System 1');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec2').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec1').feature('sec2').feature('sec1').feature.create('csys1', 'CoordinateSystem');
model.result.report('rpt1').feature('sec2').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec2').label('Geometry 1');
model.result.report('rpt1').feature('sec2').feature('sec2').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec2').feature.create('geom1', 'Geometry');
model.result.report('rpt1').feature('sec2').feature('sec2').feature('geom1').set('children', {'if1' 'off';  ...
'wp1' 'off';  ...
'ext1' 'off';  ...
'wp2' 'off';  ...
'ext2' 'off';  ...
'uni1' 'off';  ...
'sel1' 'off';  ...
'sel2' 'off';  ...
'sel3' 'off';  ...
'sel4' 'off';  ...
'sel5' 'off';  ...
'sel6' 'off';  ...
'sel7' 'off';  ...
'endif1' 'off';  ...
'if2' 'off';  ...
'wp3' 'off';  ...
'ext3' 'off';  ...
'wp4' 'off';  ...
'ext4' 'off';  ...
'uni2' 'off';  ...
'sel8' 'off';  ...
'sel9' 'off';  ...
'sel10' 'off';  ...
'sel11' 'off';  ...
'sel12' 'off';  ...
'sel13' 'off';  ...
'endif2' 'off';  ...
'fin' 'off'});
model.result.report('rpt1').feature('sec2').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec3').label('Materials');
model.result.report('rpt1').feature('sec2').feature('sec3').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec3').feature('sec1').label('Polysilicon');
model.result.report('rpt1').feature('sec2').feature('sec3').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec3').feature('sec1').feature.create('mat1', 'Material');
model.result.report('rpt1').feature('sec2').feature('sec3').feature('sec1').feature('mat1').set('includeimage', false);
model.result.report('rpt1').feature('sec2').feature('sec3').feature('sec1').feature('mat1').set('children', {'def' 'off' 'off'; 'Enu' 'off' 'off'; 'linzRes' 'off' 'off'});
model.result.report('rpt1').feature('sec2').feature.create('sec4', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec4').label('Electric Currents');
model.result.report('rpt1').feature('sec2').feature('sec4').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec4').feature.create('phys1', 'Physics');
model.result.report('rpt1').feature('sec2').feature('sec4').feature('phys1').set('includeimage', false);
model.result.report('rpt1').feature('sec2').feature('sec4').feature('phys1').set('children', {'cucn1' 'off' 'off' 'off';  ...
'ein1' 'off' 'off' 'off';  ...
'init1' 'off' 'off' 'off';  ...
'dcont1' 'off' 'off' 'off';  ...
'pot1' 'off' 'off' 'off';  ...
'gnd1' 'off' 'off' 'off'});
model.result.report('rpt1').feature('sec2').feature.create('sec5', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec5').label('Heat Transfer in Solids');
model.result.report('rpt1').feature('sec2').feature('sec5').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec5').feature.create('phys1', 'Physics');
model.result.report('rpt1').feature('sec2').feature('sec5').feature('phys1').set('noderef', 'ht');
model.result.report('rpt1').feature('sec2').feature('sec5').feature('phys1').set('includeimage', false);
model.result.report('rpt1').feature('sec2').feature('sec5').feature('phys1').set('children', {'solid1' 'off' 'off' 'off';  ...
'init1' 'off' 'off' 'off';  ...
'ins1' 'off' 'off' 'off';  ...
'idi1' 'off' 'off' 'off';  ...
'ltneb1' 'off' 'off' 'off';  ...
'os1' 'off' 'off' 'off';  ...
'cib1' 'off' 'off' 'off';  ...
'dcont1' 'off' 'off' 'off';  ...
'hf1' 'off' 'off' 'off';  ...
'hf2' 'off' 'off' 'off';  ...
'temp1' 'off' 'off' 'off'});
model.result.report('rpt1').feature('sec2').feature.create('sec6', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec6').label('Solid Mechanics');
model.result.report('rpt1').feature('sec2').feature('sec6').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec6').feature.create('phys1', 'Physics');
model.result.report('rpt1').feature('sec2').feature('sec6').feature('phys1').set('noderef', 'solid');
model.result.report('rpt1').feature('sec2').feature('sec6').feature('phys1').set('includeimage', false);
model.result.report('rpt1').feature('sec2').feature('sec6').feature('phys1').set('children', {'lemm1' 'off' 'off' 'off';  ...
'free1' 'off' 'off' 'off';  ...
'init1' 'off' 'off' 'off';  ...
'dcnt1' 'off' 'off' 'off';  ...
'dcont1' 'off' 'off' 'off';  ...
'fix1' 'off' 'off' 'off';  ...
'roll1' 'off' 'off' 'off'});
model.result.report('rpt1').feature('sec2').feature.create('sec7', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec7').label('Multiphysics');
model.result.report('rpt1').feature('sec2').feature('sec7').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec7').feature('sec1').label('Electromagnetic Heating 1');
model.result.report('rpt1').feature('sec2').feature('sec7').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec7').feature('sec1').feature.create('mph1', 'Multiphysics');
model.result.report('rpt1').feature('sec2').feature('sec7').feature('sec1').feature('mph1').set('includeimage', false);
model.result.report('rpt1').feature('sec2').feature.create('sec8', 'Section');
model.result.report('rpt1').feature('sec2').feature('sec8').label('Mesh 1');
model.result.report('rpt1').feature('sec2').feature('sec8').set('source', 'firstchild');
model.result.report('rpt1').feature('sec2').feature('sec8').feature.create('mesh1', 'Mesh');
model.result.report('rpt1').feature('sec2').feature('sec8').feature('mesh1').set('children', {'size' 'off'; 'ftet1' 'off'});
model.result.report('rpt1').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec3').label('Study 1');
model.result.report('rpt1').feature('sec3').feature.create('std1', 'Study');
model.result.report('rpt1').feature.create('sec4', 'Section');
model.result.report('rpt1').feature('sec4').label('Results');
model.result.report('rpt1').feature('sec4').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec1').label('Parameters');
model.result.report('rpt1').feature('sec4').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec4').feature('sec1').feature.create('param1', 'ResultParameter');
model.result.report('rpt1').feature('sec4').feature('sec1').feature('param1').label('Parameters');
model.result.report('rpt1').feature('sec4').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec2').label('Derived Values');
model.result.report('rpt1').feature('sec4').feature('sec2').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec2').feature('sec1').label('Point Evaluation 1');
model.result.report('rpt1').feature('sec4').feature('sec2').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec4').feature('sec2').feature('sec1').feature.create('num1', 'DerivedValues');
model.result.report('rpt1').feature('sec4').feature('sec2').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec2').feature('sec2').label('Volume Maximum 1');
model.result.report('rpt1').feature('sec4').feature('sec2').feature('sec2').set('source', 'firstchild');
model.result.report('rpt1').feature('sec4').feature('sec2').feature('sec2').feature.create('num1', 'DerivedValues');
model.result.report('rpt1').feature('sec4').feature('sec2').feature('sec2').feature('num1').set('noderef', 'max1');
model.result.report('rpt1').feature('sec4').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec3').label('Tables');
model.result.report('rpt1').feature('sec4').feature('sec3').feature.create('mtbl1', 'Table');
model.result.report('rpt1').feature('sec4').feature('sec3').feature('mtbl1').set('noderef', 'tbl1');
model.result.report('rpt1').feature('sec4').feature('sec3').feature.create('mtbl2', 'Table');
model.result.report('rpt1').feature('sec4').feature('sec3').feature('mtbl2').set('noderef', 'tbl2');
model.result.report('rpt1').feature('sec4').feature.create('sec4', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec4').label('Plot Groups');
model.result.report('rpt1').feature('sec4').feature('sec4').feature.create('sec1', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec1').label('Electric Potential (ec)');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec1').set('source', 'firstchild');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec1').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec4').feature('sec4').feature.create('sec2', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec2').label('Temperature (ht)');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec2').set('source', 'firstchild');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec2').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec2').feature('pg1').set('noderef', 'pg3');
model.result.report('rpt1').feature('sec4').feature('sec4').feature.create('sec3', 'Section');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec3').label('Stress (solid)');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec3').set('source', 'firstchild');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec3').feature.create('pg1', 'PlotGroup');
model.result.report('rpt1').feature('sec4').feature('sec4').feature('sec3').feature('pg1').set('noderef', 'pg4');

model.title('Thermal Actuator Surrogate Model Application');

model.description('The Thermal Actuator Surrogate Model application demonstrates how to accelerate computation for multiphysics analysis using a surrogate model for a fully parametric geometry model. A surrogate model is a simpler, usually computationally cheaper model, that is used to approximate the behavior of a more complex, and often more computationally expensive, model. The faster model evaluation offered by the surrogate model provides the user of the app a more interactive user experience and makes it easier to spread the use of simulations in an organization. This example illustrates how a surrogate model can be created and used in an app for a multiphysics simulation where the geometry is based on a parametric CAD model.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('thermal_actuator_surrogate.mph');

model.modelNode.label('Components');

out = model;
