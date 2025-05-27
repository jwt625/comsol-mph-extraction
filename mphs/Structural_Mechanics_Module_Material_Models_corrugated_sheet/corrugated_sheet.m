function out = model
%
% corrugated_sheet.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Material_Models');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('shell', 'Shell', 'geom1');
model.physics('shell').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/shell', true);

model.param.label('Geometric Properties');
model.param.set('theta', '45[deg]');
model.param.descr('theta', 'Angle of corrugation profile for trapezoidal corrugated sheet');
model.param.set('R', '0.0254[m]');
model.param.descr('R', 'Radius of corrugation for round corrugated sheet');
model.param.create('par2');
model.param('par2').label('Common Geometric and Material Properties');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('case', '1', 'Boolean for trapezoidal sheet geometry');
model.param('par2').set('th', '0.00635[m]', 'Thickness of corrugated sheet');
model.param('par2').set('c', '0.0508[m]', 'Half wavelength of corrugation');
model.param('par2').set('f', '0.0127[m]', 'Amplitude of corrugation');
model.param('par2').set('d', '0.1016[m]', 'Depth of corrugated sheet');
model.param('par2').set('lh', '2*f/sin(theta)+c-2*f/tan(theta)', 'Half length of corrugated sheet');
model.param('par2').set('I0c', '4*f*cot(theta)*(cos(theta)-1)+2*c', 'Length parameter');
model.param('par2').set('I0s', '4*f*sin(theta)', 'Length parameter');
model.param('par2').set('I2', '4*f^3/(3*(sin(theta)))+2*f^2*(c-2*f/tan(theta))', 'Moment of inertia');
model.param('par2').set('Iy', '0.04598132*c^2*th', 'Moment of inertia');
model.param('par2').set('EE', '21[GPa]', 'Young''s modulus');
model.param('par2').set('Nu', '0.3', 'Poisson''s ratio');
model.param('par2').set('L', '1[m]', 'Reference length');
model.param('par2').paramCase.create('case1');
model.param('par2').paramCase('case1').label('Trapezoidal Corrugation');
model.param('par2').paramCase.create('case2');
model.param('par2').paramCase('case2').label('Round Corrugation');
model.param('par2').paramCase('case2').set('case', '2');
model.param('par2').paramCase('case2').set('c', '2*R');
model.param('par2').paramCase('case2').set('f', 'R');
model.param('par2').paramCase('case2').set('lh', 'pi*R');
model.param('par2').paramCase('case2').set('I0c', '2*pi*R');
model.param('par2').paramCase('case2').set('I0s', 'I0c');
model.param('par2').paramCase('case2').set('I2', 'pi*R^3');
model.param('par2').paramCase('case2').set('Iy', '0.19635*c^2*th');

model.geom.load({'part1'}, 'COMSOL_Multiphysics/Unit_Cells_and_RVEs/Corrugated_Sheets/trapezoidal_corrugation.mph', {'part1'});
model.geom.load({'part2'}, 'COMSOL_Multiphysics/Unit_Cells_and_RVEs/Corrugated_Sheets/round_corrugation.mph', {'part1'});
model.geom('geom1').create('if1', 'If');
model.geom('geom1').feature.createAfter('endif1', 'EndIf', 'if1');
model.geom('geom1').feature('if1').set('condition', 'case==1');
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'c', 'c');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'f', 'f');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'theta', 'theta');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd', 'd');
model.geom('geom1').run('pi1');
model.geom('geom1').create('if2', 'If');
model.geom('geom1').feature.createAfter('endif2', 'EndIf', 'if2');
model.geom('geom1').feature.move('endif2', 4);
model.geom('geom1').feature.move('if2', 3);
model.geom('geom1').feature('if2').set('condition', 'case==2');
model.geom('geom1').run('if2');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'R', 'R');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd', 'd');
model.geom('geom1').run('fin');

model.view('view1').set('showgrid', false);

model.param('par2').set('case', '2');

model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd', '0.1016[m]');
model.geom('geom1').runPre('fin');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd', 'd');

model.param('par2').set('case', '1');

model.geom('geom1').run('fin');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Pair 1, Source');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'pi1_boxsel1' 'pi2_boxsel1'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Pair 1, Destination');
model.geom('geom1').feature('unisel2').set('entitydim', 1);
model.geom('geom1').feature('unisel2').set('input', {'pi1_boxsel2' 'pi2_boxsel2'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('Pair 2, Source');
model.geom('geom1').feature('unisel3').set('entitydim', 1);
model.geom('geom1').feature('unisel3').set('input', {'pi1_boxsel3' 'pi2_boxsel3'});
model.geom('geom1').run('unisel3');
model.geom('geom1').create('unisel4', 'UnionSelection');
model.geom('geom1').feature('unisel4').label('Pair 2, Destination');
model.geom('geom1').feature('unisel4').set('entitydim', 1);
model.geom('geom1').feature('unisel4').set('input', {'pi1_boxsel4' 'pi2_boxsel4'});
model.geom('geom1').run('unisel4');
model.geom('geom1').create('ballsel1', 'BallSelection');
model.geom('geom1').feature('ballsel1').set('entitydim', 0);
model.geom('geom1').feature('ballsel1').set('posx', 'c');
model.geom('geom1').feature('ballsel1').set('r', '1e-5*c');
model.geom('geom1').run('ballsel1');
model.geom('geom1').create('ballsel2', 'BallSelection');
model.geom('geom1').feature('ballsel2').set('entitydim', 0);
model.geom('geom1').feature('ballsel2').set('posx', 'c');
model.geom('geom1').feature('ballsel2').set('posy', 'd');
model.geom('geom1').feature('ballsel2').set('r', '1e-5*c');
model.geom('geom1').run('ballsel2');
model.geom('geom1').create('unisel5', 'UnionSelection');
model.geom('geom1').feature('unisel5').set('entitydim', 0);
model.geom('geom1').feature('unisel5').set('input', {'ballsel1' 'ballsel2'});
model.geom('geom1').run('unisel5');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.named('geom1_unisel1');
model.cpl('intop1').set('method', 'summation');
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').selection.geom('geom1', 1);
model.cpl('intop2').selection.named('geom1_unisel3');
model.cpl('intop2').set('method', 'summation');
model.cpl.create('intop3', 'Integration', 'geom1');
model.cpl('intop3').set('axisym', true);
model.cpl('intop3').selection.geom('geom1', 0);
model.cpl('intop3').selection.named('geom1_ballsel1');
model.cpl('intop3').set('method', 'summation');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Analytical Stiffness Components by Xia et al.');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('DA11_Xia', '2*c/(I0c/intop3(shell.DA11)+I2/intop3(shell.DD11))', 'Equivalent extensional stiffness matrix, 11-component');
model.variable('var1').set('DA12_Xia', 'intop3(shell.DA12/shell.DA11)*DA11_Xia', 'Equivalent extensional stiffness matrix, 12-component');
model.variable('var1').set('DA22_Xia', 'intop3(shell.DA12)*DA12_Xia/intop3(shell.DA11)+lh/c*intop3((shell.DA11*shell.DA22-shell.DA12^2)/shell.DA11)', 'Equivalent extensional stiffness matrix, 22-component');
model.variable('var1').set('DA33_Xia', 'c/lh*intop3(shell.DA33)', 'Equivalent extensional stiffness matrix, 33-component');
model.variable('var1').set('DD11_Xia', 'c/lh*intop3(shell.DD11)', 'Equivalent bending stiffness matrix, 11-component');
model.variable('var1').set('DD12_Xia', 'intop3(shell.DD12/shell.DD11)*DD11_Xia', 'Equivalent bending stiffness matrix, 12-component');
model.variable('var1').set('DD22_Xia', '1/(2*c)*(I2*intop3(shell.DA22)+I0c*intop3(shell.DD22))', 'Equivalent bending stiffness matrix, 22-component');
model.variable('var1').set('DD33_Xia', 'lh/c*intop3(shell.DD33)', 'Equivalent bending stiffness matrix, 33-component');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Analytical Stiffness Components by Park et al.');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('DA11_Park', '2*c/(I0c/intop3(shell.DA11)+I0s/(5/6*intop3(shell.DAs11))+I2/intop3(shell.DD11))', 'Equivalent extensional stiffness matrix, 11-component');
model.variable('var2').set('DA12_Park', 'intop3(shell.DA12/shell.DA11)*DA11_Park', 'Equivalent extensional stiffness matrix, 12-component');
model.variable('var2').set('DA22_Park', 'intop3(shell.DA12)*DA12_Park/intop3(shell.DA11)+lh/c*intop3((shell.DA11*shell.DA22-shell.DA12^2)/shell.DA11)', 'Equivalent extensional stiffness matrix, 22-component');
model.variable('var2').set('DA33_Park', 'c/lh*intop3(shell.DA33)', 'Equivalent extensional stiffness matrix, 33-component');
model.variable('var2').set('DD11_Park', 'c/lh*intop3(shell.DD11)', 'Equivalent bending stiffness matrix, 11-component');
model.variable('var2').set('DD12_Park', 'intop3(shell.DD12/shell.DD11)*DD11_Park', 'Equivalent bending stiffness matrix, 12-component');
model.variable('var2').set('DD22_Park', '1/(2*c)*(I2*intop3(shell.DA22)+I0c*intop3(shell.DD22))', 'Equivalent bending stiffness matrix, 22-component');
model.variable('var2').set('DD33_Park', 'lh/c*intop3(shell.DD33)', 'Equivalent bending stiffness matrix, 33-component');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Analytical Stiffness Components by Ye et al.');

% To import content from file, use:
% model.variable('var3').loadFile('FILENAME');
model.variable('var3').set('DA11_Ye', 'EE*th^4/(12*(1-Nu^2)*Iy)', 'Equivalent extensional stiffness matrix, 11-component');
model.variable('var3').set('DA12_Ye', 'Nu*DA11_Ye', 'Equivalent extensional stiffness matrix, 12-component');
model.variable('var3').set('DA22_Ye', 'EE*th*lh/(c)', 'Equivalent extensional stiffness matrix, 22-component');
model.variable('var3').set('DA33_Ye', 'EE*th*c/(2*(1+Nu)*lh)', 'Equivalent extensional stiffness matrix, 33-component');
model.variable('var3').set('DD11_Ye', 'EE*th^3*2*c/(12*(1-Nu^2)*2*lh)', 'Equivalent bending stiffness matrix, 11-component');
model.variable('var3').set('DD12_Ye', 'Nu*DD11_Ye', 'Equivalent bending stiffness matrix, 12-component');
model.variable('var3').set('DD22_Ye', 'EE*Iy', 'Equivalent bending stiffness matrix, 22-component');
model.variable('var3').set('DD33_Ye', 'EE*th^3*lh/(24*(1+Nu)*c)', 'Equivalent bending stiffness matrix, 33-component');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').label('Numerical Stiffness Components Based on Reaction Forces');

% To import content from file, use:
% model.variable('var4').loadFile('FILENAME');
model.variable('var4').set('DA11_R', 'intop1(-shell.RFx/d)', 'Equivalent extensional stiffness matrix, 11-component');
model.variable('var4').set('DA12_R', 'intop1(-shell.RFx/d)', 'Equivalent extensional stiffness matrix, 12-component');
model.variable('var4').set('DA21_R', 'intop2(-shell.RFy/(2*c))', 'Equivalent extensional stiffness matrix, 21-component');
model.variable('var4').set('DA22_R', 'intop2(-shell.RFy/(2*c))', 'Equivalent extensional stiffness matrix, 22-component');
model.variable('var4').set('DA33_R', 'intop1(-shell.RFy/d)', 'Equivalent extensional stiffness matrix, 33-component');
model.variable('var4').set('DD11_R', 'intop1(shell.RMy/d)*L', 'Equivalent bending stiffness matrix, 11-component');
model.variable('var4').set('DD12_R', 'intop1(shell.RMy/d)*L', 'Equivalent bending stiffness matrix, 12-component');
model.variable('var4').set('DD21_R', 'intop2(-shell.RMx/(2*c))*L', 'Equivalent bending stiffness matrix, 21-component');
model.variable('var4').set('DD22_R', 'intop2(-shell.RMx/(2*c))*L', 'Equivalent bending stiffness matrix, 22-component');
model.variable('var4').set('DD33_R', '0.5*(intop1(shell.RMx/(d))+intop2(-shell.RMy/(2*c)))*L', 'Equivalent bending stiffness matrix, 33-component');
model.variable.create('var5');
model.variable('var5').model('comp1');
model.variable('var5').label('Numerical Stiffness Components Based on Energy Equivalence');

% To import content from file, use:
% model.variable('var5').loadFile('FILENAME');
model.variable('var5').set('DA11_E', 'shell.Ws_tot/(d*c)', 'Equivalent extensional stiffness matrix, 11-component');
model.variable('var5').set('DA22_E', 'shell.Ws_tot/(d*c)', 'Equivalent extensional stiffness matrix, 22-component');
model.variable('var5').set('DA33_E', 'shell.Ws_tot/(d*c)', 'Equivalent extensional stiffness matrix, 33-component');
model.variable('var5').set('DD11_E', 'shell.Ws_tot/(d*c)*L^2', 'Equivalent bending stiffness matrix, 11-component');
model.variable('var5').set('DD22_E', 'shell.Ws_tot/(d*c)*L^2', 'Equivalent bending stiffness matrix, 22-component');
model.variable('var5').set('DD33_E', 'shell.Ws_tot/(d*c)*L^2', 'Equivalent bending stiffness matrix, 33-component');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'EE'});
model.material('mat1').propertyGroup('Enu').set('nu', {'Nu'});
model.material('mat1').propertyGroup('def').set('density', {'1'});

model.physics('shell').feature('to1').set('d', 'th');

model.nodeGroup.create('grp1', 'Physics', 'shell');
model.nodeGroup('grp1').label('Load Case 1: DA11 and DA12');

model.physics('shell').create('disp1', 'Displacement1', 1);

model.nodeGroup('grp1').add('disp1');

model.physics('shell').feature('disp1').selection.named('geom1_unisel1');
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp1').setIndex('U0', '-c', 0);
model.physics('shell').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp1').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp1').setIndex('FreeRotationAround', true, 0);
model.physics('shell').create('disp2', 'Displacement1', 1);

model.nodeGroup('grp1').add('disp2');

model.physics('shell').feature('disp2').selection.named('geom1_unisel2');
model.physics('shell').feature('disp2').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp2').setIndex('U0', 'c', 0);
model.physics('shell').feature('disp2').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp2').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp2').setIndex('FreeRotationAround', true, 0);
model.physics('shell').create('disp3', 'Displacement1', 1);

model.nodeGroup('grp1').add('disp3');

model.physics('shell').feature('disp3').selection.named('geom1_unisel3');
model.physics('shell').feature('disp3').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp3').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp3').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp4', 'Displacement1', 1);

model.nodeGroup('grp1').add('disp4');

model.physics('shell').feature('disp4').selection.named('geom1_unisel4');
model.physics('shell').feature('disp4').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp4').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp4').setIndex('FreeRotationAround', true, 1);

model.nodeGroup.create('grp2', 'Physics', 'shell');
model.nodeGroup('grp2').label('Load Case 2: DA21 and DA22');

model.physics('shell').create('disp5', 'Displacement1', 1);

model.nodeGroup('grp2').add('disp5');

model.physics('shell').feature('disp5').selection.named('geom1_unisel1');
model.physics('shell').feature('disp5').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp5').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp5').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp5').setIndex('FreeRotationAround', true, 0);
model.physics('shell').create('disp6', 'Displacement1', 1);

model.nodeGroup('grp2').add('disp6');

model.physics('shell').feature('disp6').selection.named('geom1_unisel2');
model.physics('shell').feature('disp6').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp6').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp6').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp6').setIndex('FreeRotationAround', true, 0);
model.physics('shell').create('disp7', 'Displacement1', 1);

model.nodeGroup('grp2').add('disp7');

model.physics('shell').feature('disp7').selection.named('geom1_unisel3');
model.physics('shell').feature('disp7').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp7').setIndex('U0', '-0.5*d', 1);
model.physics('shell').feature('disp7').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp7').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp8', 'Displacement1', 1);

model.nodeGroup('grp2').add('disp8');

model.physics('shell').feature('disp8').selection.named('geom1_unisel4');
model.physics('shell').feature('disp8').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp8').setIndex('U0', '0.5*d', 1);
model.physics('shell').feature('disp8').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp8').setIndex('FreeRotationAround', true, 1);

model.nodeGroup.create('grp3', 'Physics', 'shell');
model.nodeGroup('grp3').label('Load Case 3: DA33');

model.physics('shell').create('disp9', 'Displacement1', 1);

model.nodeGroup('grp3').add('disp9');

model.physics('shell').feature('disp9').selection.named('geom1_unisel1');
model.physics('shell').feature('disp9').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp9').setIndex('U0', '-0.5*c', 1);
model.physics('shell').feature('disp9').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp9').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp9').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp10', 'Displacement1', 1);

model.nodeGroup('grp3').add('disp10');

model.physics('shell').feature('disp10').selection.named('geom1_unisel2');
model.physics('shell').feature('disp10').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp10').setIndex('U0', '0.5*c', 1);
model.physics('shell').feature('disp10').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp10').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp10').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp11', 'Displacement1', 1);

model.nodeGroup('grp3').add('disp11');

model.physics('shell').feature('disp11').selection.named('geom1_unisel3');
model.physics('shell').feature('disp11').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp11').setIndex('U0', '-0.25*d', 0);
model.physics('shell').feature('disp11').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp11').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp11').setIndex('FreeRotationAround', true, 0);
model.physics('shell').create('disp12', 'Displacement1', 1);

model.nodeGroup('grp3').add('disp12');

model.physics('shell').feature('disp12').selection.named('geom1_unisel4');
model.physics('shell').feature('disp12').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp12').setIndex('U0', '0.25*d', 0);
model.physics('shell').feature('disp12').setIndex('Direction', 'prescribed', 2);
model.physics('shell').feature('disp12').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp12').setIndex('FreeRotationAround', true, 0);

model.nodeGroup.create('grp4', 'Physics', 'shell');
model.nodeGroup('grp4').label('Load Case 4: DD11 and DD12');

model.physics('shell').create('disp13', 'Displacement1', 1);

model.nodeGroup('grp4').add('disp13');

model.physics('shell').feature('disp13').selection.named('geom1_unisel1');
model.physics('shell').feature('disp13').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp13').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp13').set('THETA_0', {'-c/L' '0'});
model.physics('shell').create('disp14', 'Displacement1', 1);

model.nodeGroup('grp4').add('disp14');

model.physics('shell').feature('disp14').selection.named('geom1_unisel2');
model.physics('shell').feature('disp14').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp14').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp14').set('THETA_0', {'-c/L' '0'});
model.physics('shell').create('disp15', 'Displacement1', 1);

model.nodeGroup('grp4').add('disp15');

model.physics('shell').feature('disp15').selection.named('geom1_unisel3');
model.physics('shell').feature('disp15').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp15').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp15').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp16', 'Displacement1', 1);

model.nodeGroup('grp4').add('disp16');

model.physics('shell').feature('disp16').selection.named('geom1_unisel4');
model.physics('shell').feature('disp16').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp16').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp16').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp17', 'Displacement0', 0);

model.nodeGroup('grp4').add('disp17');

model.physics('shell').feature('disp17').selection.named('geom1_unisel5');
model.physics('shell').feature('disp17').setIndex('Direction', 'prescribed', 2);

model.nodeGroup.create('grp5', 'Physics', 'shell');
model.nodeGroup('grp5').label('Load Case 5: DD21 and DD22');

model.physics('shell').create('disp18', 'Displacement1', 1);

model.nodeGroup('grp5').add('disp18');

model.physics('shell').feature('disp18').selection.named('geom1_unisel1');
model.physics('shell').feature('disp18').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp18').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp18').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp19', 'Displacement1', 1);

model.nodeGroup('grp5').add('disp19');

model.physics('shell').feature('disp19').selection.named('geom1_unisel2');
model.physics('shell').feature('disp19').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp19').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp19').setIndex('FreeRotationAround', true, 1);
model.physics('shell').create('disp20', 'Displacement1', 1);

model.nodeGroup('grp5').add('disp20');

model.physics('shell').feature('disp20').selection.named('geom1_unisel3');
model.physics('shell').feature('disp20').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp20').setIndex('U0', '0.5*Z*d/L', 1);
model.physics('shell').feature('disp20').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp20').set('THETA_0', {'-0.5*d/L*shell.anZ' '0'});
model.physics('shell').create('disp21', 'Displacement1', 1);

model.nodeGroup('grp5').add('disp21');

model.physics('shell').feature('disp21').selection.named('geom1_unisel4');
model.physics('shell').feature('disp21').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp21').setIndex('U0', '-0.5*Z*d/L', 1);
model.physics('shell').feature('disp21').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp21').set('THETA_0', {'-0.5*d/L*shell.anZ' '0'});
model.physics('shell').create('disp22', 'Displacement0', 0);

model.nodeGroup('grp5').add('disp22');

model.physics('shell').feature('disp22').selection.named('geom1_unisel5');
model.physics('shell').feature('disp22').setIndex('Direction', 'prescribed', 2);

model.nodeGroup.create('grp6', 'Physics', 'shell');
model.nodeGroup('grp6').label('Load Case 6: DD33');

model.physics('shell').create('disp23', 'Displacement1', 1);

model.nodeGroup('grp6').add('disp23');

model.physics('shell').feature('disp23').selection.named('geom1_unisel1');
model.physics('shell').feature('disp23').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp23').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp23').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp23').setIndex('FreeRotationAround', true, 0);
model.physics('shell').feature('disp23').set('THETA_0', {'0' '0.5*c/L*shell.anZ'});
model.physics('shell').create('disp24', 'Displacement1', 1);

model.nodeGroup('grp6').add('disp24');

model.physics('shell').feature('disp24').selection.named('geom1_unisel2');
model.physics('shell').feature('disp24').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp24').setIndex('Direction', 'prescribed', 1);
model.physics('shell').feature('disp24').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp24').setIndex('FreeRotationAround', true, 0);
model.physics('shell').feature('disp24').set('THETA_0', {'0' '0.5*c/L*shell.anZ'});
model.physics('shell').create('disp25', 'Displacement1', 1);

model.nodeGroup('grp6').add('disp25');

model.physics('shell').feature('disp25').selection.named('geom1_unisel3');
model.physics('shell').feature('disp25').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp25').setIndex('U0', '-0.25*Z*d/L', 0);
model.physics('shell').feature('disp25').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp25').setIndex('FreeRotationAround', true, 0);
model.physics('shell').feature('disp25').set('THETA_0', {'0' '-0.25*d/L'});
model.physics('shell').create('disp26', 'Displacement1', 1);

model.nodeGroup('grp6').add('disp26');

model.physics('shell').feature('disp26').selection.named('geom1_unisel4');
model.physics('shell').feature('disp26').setIndex('Direction', 'prescribed', 0);
model.physics('shell').feature('disp26').setIndex('U0', '0.25*Z*d/L', 0);
model.physics('shell').feature('disp26').set('RotationType', 'RotationGroup');
model.physics('shell').feature('disp26').setIndex('FreeRotationAround', true, 0);
model.physics('shell').feature('disp26').set('THETA_0', {'0' '-0.25*d/L'});
model.physics('shell').create('disp27', 'Displacement0', 0);

model.nodeGroup('grp6').add('disp27');

model.physics('shell').feature('disp27').selection.named('geom1_unisel5');
model.physics('shell').feature('disp27').setIndex('Direction', 'prescribed', 2);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.geom('geom1');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 20);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.named('geom1_unisel3');
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 10);
model.mesh('mesh1').run('map1');

model.study('std1').label('Study: Load Case 1');
model.study('std1').setGenPlots(false);
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'switch');
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', '', 0);
model.study('std1').feature('param').setIndex('switchname', 'default', 0);
model.study('std1').feature('param').setIndex('switchcase', 'all', 0);
model.study('std1').feature('param').setIndex('switchlistarr', '', 0);
model.study('std1').feature('param').setIndex('switchname', 'par2', 0);
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'shell/disp5' 'shell/disp6' 'shell/disp7' 'shell/disp8' 'shell/disp9' 'shell/disp10' 'shell/disp11' 'shell/disp12' 'shell/disp13' 'shell/disp14'  ...
'shell/disp15' 'shell/disp16' 'shell/disp17' 'shell/disp18' 'shell/disp19' 'shell/disp20' 'shell/disp21' 'shell/disp22' 'shell/disp23' 'shell/disp24'  ...
'shell/disp25' 'shell/disp26' 'shell/disp27'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {});
model.batch('p1').set('plistarr', {});
model.batch('p1').set('sweeptype', 'switch');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/shell', true);

model.geom('geom1').run;

model.study('std2').setGenPlots(false);
model.study('std2').label('Study: Load Case 2');
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').set('sweeptype', 'switch');
model.study('std2').feature('param').setIndex('switchname', 'default', 0);
model.study('std2').feature('param').setIndex('switchcase', 'all', 0);
model.study('std2').feature('param').setIndex('switchlistarr', '', 0);
model.study('std2').feature('param').setIndex('switchname', 'default', 0);
model.study('std2').feature('param').setIndex('switchcase', 'all', 0);
model.study('std2').feature('param').setIndex('switchlistarr', '', 0);
model.study('std2').feature('param').setIndex('switchname', 'par2', 0);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'shell/disp1' 'shell/disp2' 'shell/disp3' 'shell/disp4' 'shell/disp9' 'shell/disp10' 'shell/disp11' 'shell/disp12' 'shell/disp13' 'shell/disp14'  ...
'shell/disp15' 'shell/disp16' 'shell/disp17' 'shell/disp18' 'shell/disp19' 'shell/disp20' 'shell/disp21' 'shell/disp22' 'shell/disp23' 'shell/disp24'  ...
'shell/disp25' 'shell/disp26' 'shell/disp27'});

model.sol.create('sol5');
model.sol('sol5').study('std2');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std2');
model.sol('sol5').feature('st1').set('studystep', 'stat');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol5').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol5').feature('v1').set('control', 'stat');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol5').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol5').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').attach('std2');

model.batch.create('p2', 'Parametric');
model.batch('p2').study('std2');
model.batch('p2').create('so1', 'Solutionseq');
model.batch('p2').feature('so1').set('seq', 'sol5');
model.batch('p2').feature('so1').set('store', 'on');
model.batch('p2').feature('so1').set('clear', 'on');
model.batch('p2').feature('so1').set('psol', 'none');
model.batch('p2').set('pname', {});
model.batch('p2').set('plistarr', {});
model.batch('p2').set('sweeptype', 'switch');
model.batch('p2').set('probesel', 'all');
model.batch('p2').set('probes', {});
model.batch('p2').set('plot', 'off');
model.batch('p2').set('err', 'on');
model.batch('p2').attach('std2');
model.batch('p2').set('control', 'param');

model.sol.create('sol6');
model.sol('sol6').study('std2');
model.sol('sol6').label('Parametric Solutions 2');

model.batch('p2').feature('so1').set('psol', 'sol6');
model.batch('p2').run('compute');

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/shell', true);

model.geom('geom1').run;

model.study('std3').setGenPlots(false);
model.study('std3').label('Study: Load Case 3');
model.study('std3').create('param', 'Parametric');
model.study('std3').feature('param').set('sweeptype', 'switch');
model.study('std3').feature('param').setIndex('switchname', 'default', 0);
model.study('std3').feature('param').setIndex('switchcase', 'all', 0);
model.study('std3').feature('param').setIndex('switchlistarr', '', 0);
model.study('std3').feature('param').setIndex('switchname', 'default', 0);
model.study('std3').feature('param').setIndex('switchcase', 'all', 0);
model.study('std3').feature('param').setIndex('switchlistarr', '', 0);
model.study('std3').feature('param').setIndex('switchname', 'par2', 0);
model.study('std3').feature('stat').set('useadvanceddisable', true);
model.study('std3').feature('stat').set('disabledphysics', {'shell/disp1' 'shell/disp2' 'shell/disp3' 'shell/disp4' 'shell/disp5' 'shell/disp6' 'shell/disp7' 'shell/disp8' 'shell/disp13' 'shell/disp14'  ...
'shell/disp15' 'shell/disp16' 'shell/disp17' 'shell/disp18' 'shell/disp19' 'shell/disp20' 'shell/disp21' 'shell/disp22' 'shell/disp23' 'shell/disp24'  ...
'shell/disp25' 'shell/disp26' 'shell/disp27'});

model.sol.create('sol9');
model.sol('sol9').study('std3');
model.sol('sol9').create('st1', 'StudyStep');
model.sol('sol9').feature('st1').set('study', 'std3');
model.sol('sol9').feature('st1').set('studystep', 'stat');
model.sol('sol9').create('v1', 'Variables');
model.sol('sol9').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol9').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol9').feature('v1').set('control', 'stat');
model.sol('sol9').create('s1', 'Stationary');
model.sol('sol9').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol9').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol9').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol9').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol9').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol9').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol9').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol9').feature('s1').feature.remove('fcDef');
model.sol('sol9').attach('std3');

model.batch.create('p3', 'Parametric');
model.batch('p3').study('std3');
model.batch('p3').create('so1', 'Solutionseq');
model.batch('p3').feature('so1').set('seq', 'sol9');
model.batch('p3').feature('so1').set('store', 'on');
model.batch('p3').feature('so1').set('clear', 'on');
model.batch('p3').feature('so1').set('psol', 'none');
model.batch('p3').set('pname', {});
model.batch('p3').set('plistarr', {});
model.batch('p3').set('sweeptype', 'switch');
model.batch('p3').set('probesel', 'all');
model.batch('p3').set('probes', {});
model.batch('p3').set('plot', 'off');
model.batch('p3').set('err', 'on');
model.batch('p3').attach('std3');
model.batch('p3').set('control', 'param');

model.sol.create('sol10');
model.sol('sol10').study('std3');
model.sol('sol10').label('Parametric Solutions 3');

model.batch('p3').feature('so1').set('psol', 'sol10');
model.batch('p3').run('compute');

model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').setSolveFor('/physics/shell', true);

model.geom('geom1').run;

model.study('std4').setGenPlots(false);
model.study('std4').label('Study: Load Case 4');
model.study('std4').create('param', 'Parametric');
model.study('std4').feature('param').set('sweeptype', 'switch');
model.study('std4').feature('param').setIndex('switchname', 'default', 0);
model.study('std4').feature('param').setIndex('switchcase', 'all', 0);
model.study('std4').feature('param').setIndex('switchlistarr', '', 0);
model.study('std4').feature('param').setIndex('switchname', 'default', 0);
model.study('std4').feature('param').setIndex('switchcase', 'all', 0);
model.study('std4').feature('param').setIndex('switchlistarr', '', 0);
model.study('std4').feature('param').setIndex('switchname', 'par2', 0);
model.study('std4').feature('stat').set('useadvanceddisable', true);
model.study('std4').feature('stat').set('disabledphysics', {'shell/disp1' 'shell/disp2' 'shell/disp3' 'shell/disp4' 'shell/disp5' 'shell/disp6' 'shell/disp7' 'shell/disp8' 'shell/disp9' 'shell/disp10'  ...
'shell/disp11' 'shell/disp12' 'shell/disp18' 'shell/disp19' 'shell/disp20' 'shell/disp21' 'shell/disp22' 'shell/disp23' 'shell/disp24' 'shell/disp25'  ...
'shell/disp26' 'shell/disp27'});

model.sol.create('sol13');
model.sol('sol13').study('std4');
model.sol('sol13').create('st1', 'StudyStep');
model.sol('sol13').feature('st1').set('study', 'std4');
model.sol('sol13').feature('st1').set('studystep', 'stat');
model.sol('sol13').create('v1', 'Variables');
model.sol('sol13').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol13').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol13').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol13').feature('v1').set('control', 'stat');
model.sol('sol13').create('s1', 'Stationary');
model.sol('sol13').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol13').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol13').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol13').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol13').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol13').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol13').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol13').feature('s1').feature.remove('fcDef');
model.sol('sol13').attach('std4');

model.batch.create('p4', 'Parametric');
model.batch('p4').study('std4');
model.batch('p4').create('so1', 'Solutionseq');
model.batch('p4').feature('so1').set('seq', 'sol13');
model.batch('p4').feature('so1').set('store', 'on');
model.batch('p4').feature('so1').set('clear', 'on');
model.batch('p4').feature('so1').set('psol', 'none');
model.batch('p4').set('pname', {});
model.batch('p4').set('plistarr', {});
model.batch('p4').set('sweeptype', 'switch');
model.batch('p4').set('probesel', 'all');
model.batch('p4').set('probes', {});
model.batch('p4').set('plot', 'off');
model.batch('p4').set('err', 'on');
model.batch('p4').attach('std4');
model.batch('p4').set('control', 'param');

model.sol.create('sol14');
model.sol('sol14').study('std4');
model.sol('sol14').label('Parametric Solutions 4');

model.batch('p4').feature('so1').set('psol', 'sol14');
model.batch('p4').run('compute');

model.study.create('std5');
model.study('std5').create('stat', 'Stationary');
model.study('std5').feature('stat').setSolveFor('/physics/shell', true);

model.geom('geom1').run;

model.study('std5').setGenPlots(false);
model.study('std5').label('Study: Load Case 5');
model.study('std5').create('param', 'Parametric');
model.study('std5').feature('param').set('sweeptype', 'switch');
model.study('std5').feature('param').setIndex('switchname', 'default', 0);
model.study('std5').feature('param').setIndex('switchcase', 'all', 0);
model.study('std5').feature('param').setIndex('switchlistarr', '', 0);
model.study('std5').feature('param').setIndex('switchname', 'default', 0);
model.study('std5').feature('param').setIndex('switchcase', 'all', 0);
model.study('std5').feature('param').setIndex('switchlistarr', '', 0);
model.study('std5').feature('param').setIndex('switchname', 'par2', 0);
model.study('std5').feature('stat').set('useadvanceddisable', true);
model.study('std5').feature('stat').set('disabledphysics', {'shell/disp1' 'shell/disp2' 'shell/disp3' 'shell/disp4' 'shell/disp5' 'shell/disp6' 'shell/disp7' 'shell/disp8' 'shell/disp9' 'shell/disp10'  ...
'shell/disp11' 'shell/disp12' 'shell/disp13' 'shell/disp14' 'shell/disp15' 'shell/disp16' 'shell/disp17' 'shell/disp23' 'shell/disp24' 'shell/disp25'  ...
'shell/disp26' 'shell/disp27'});

model.sol.create('sol17');
model.sol('sol17').study('std5');
model.sol('sol17').create('st1', 'StudyStep');
model.sol('sol17').feature('st1').set('study', 'std5');
model.sol('sol17').feature('st1').set('studystep', 'stat');
model.sol('sol17').create('v1', 'Variables');
model.sol('sol17').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol17').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol17').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol17').feature('v1').set('control', 'stat');
model.sol('sol17').create('s1', 'Stationary');
model.sol('sol17').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol17').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol17').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol17').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol17').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol17').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol17').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol17').feature('s1').feature.remove('fcDef');
model.sol('sol17').attach('std5');

model.batch.create('p5', 'Parametric');
model.batch('p5').study('std5');
model.batch('p5').create('so1', 'Solutionseq');
model.batch('p5').feature('so1').set('seq', 'sol17');
model.batch('p5').feature('so1').set('store', 'on');
model.batch('p5').feature('so1').set('clear', 'on');
model.batch('p5').feature('so1').set('psol', 'none');
model.batch('p5').set('pname', {});
model.batch('p5').set('plistarr', {});
model.batch('p5').set('sweeptype', 'switch');
model.batch('p5').set('probesel', 'all');
model.batch('p5').set('probes', {});
model.batch('p5').set('plot', 'off');
model.batch('p5').set('err', 'on');
model.batch('p5').attach('std5');
model.batch('p5').set('control', 'param');

model.sol.create('sol18');
model.sol('sol18').study('std5');
model.sol('sol18').label('Parametric Solutions 5');

model.batch('p5').feature('so1').set('psol', 'sol18');
model.batch('p5').run('compute');

model.study.create('std6');
model.study('std6').create('stat', 'Stationary');
model.study('std6').feature('stat').setSolveFor('/physics/shell', true);

model.geom('geom1').run;

model.study('std6').setGenPlots(false);
model.study('std6').label('Study: Load Case 6');
model.study('std6').create('param', 'Parametric');
model.study('std6').feature('param').set('sweeptype', 'switch');
model.study('std6').feature('param').setIndex('switchname', 'default', 0);
model.study('std6').feature('param').setIndex('switchcase', 'all', 0);
model.study('std6').feature('param').setIndex('switchlistarr', '', 0);
model.study('std6').feature('param').setIndex('switchname', 'default', 0);
model.study('std6').feature('param').setIndex('switchcase', 'all', 0);
model.study('std6').feature('param').setIndex('switchlistarr', '', 0);
model.study('std6').feature('param').setIndex('switchname', 'par2', 0);
model.study('std6').feature('stat').set('useadvanceddisable', true);
model.study('std6').feature('stat').set('disabledphysics', {'shell/disp1' 'shell/disp2' 'shell/disp3' 'shell/disp4' 'shell/disp5' 'shell/disp6' 'shell/disp7' 'shell/disp8' 'shell/disp9' 'shell/disp10'  ...
'shell/disp11' 'shell/disp12' 'shell/disp13' 'shell/disp14' 'shell/disp15' 'shell/disp16' 'shell/disp17' 'shell/disp18' 'shell/disp19' 'shell/disp20'  ...
'shell/disp21' 'shell/disp22'});

model.sol.create('sol21');
model.sol('sol21').study('std6');
model.sol('sol21').create('st1', 'StudyStep');
model.sol('sol21').feature('st1').set('study', 'std6');
model.sol('sol21').feature('st1').set('studystep', 'stat');
model.sol('sol21').create('v1', 'Variables');
model.sol('sol21').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol21').feature('v1').feature('comp1_ar').set('resscalemethod', 'parent');
model.sol('sol21').feature('v1').feature('comp1_ar').set('scaleval', '0.01');
model.sol('sol21').feature('v1').set('control', 'stat');
model.sol('sol21').create('s1', 'Stationary');
model.sol('sol21').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol21').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol21').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol21').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol21').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol21').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol21').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol21').feature('s1').feature.remove('fcDef');
model.sol('sol21').attach('std6');

model.batch.create('p6', 'Parametric');
model.batch('p6').study('std6');
model.batch('p6').create('so1', 'Solutionseq');
model.batch('p6').feature('so1').set('seq', 'sol21');
model.batch('p6').feature('so1').set('store', 'on');
model.batch('p6').feature('so1').set('clear', 'on');
model.batch('p6').feature('so1').set('psol', 'none');
model.batch('p6').set('pname', {});
model.batch('p6').set('plistarr', {});
model.batch('p6').set('sweeptype', 'switch');
model.batch('p6').set('probesel', 'all');
model.batch('p6').set('probes', {});
model.batch('p6').set('plot', 'off');
model.batch('p6').set('err', 'on');
model.batch('p6').attach('std6');
model.batch('p6').set('control', 'param');

model.sol.create('sol22');
model.sol('sol22').study('std6');
model.sol('sol22').label('Parametric Solutions 6');

model.batch('p6').feature('so1').set('psol', 'sol22');
model.batch('p6').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Displacement for Translational Load Cases');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('plotarrayenable', true);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('arraydim', '1');
model.result('pg1').feature('surf1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def1').set('scale', 0.15);
model.result('pg1').feature('surf1').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').feature('surf2').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('data', 'dset4');
model.result('pg1').feature('surf2').setIndex('looplevel', 1, 0);
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').feature('surf2').set('titletype', 'none');
model.result('pg1').feature.duplicate('surf3', 'surf2');
model.result('pg1').feature('surf3').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('surf3').set('data', 'dset6');
model.result('pg1').run;
model.result('pg1').create('tlan1', 'TableAnnotation');
model.result('pg1').feature('tlan1').set('arraydim', '1');
model.result('pg1').feature('tlan1').set('source', 'localtable');
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'c', 0, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-0.5*d', 0, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 0, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Load case 1', 0, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '3.5*c', 1, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-0.5*d', 1, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 1, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Load case 2', 1, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '6*c', 2, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-0.5*d', 2, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 2, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Load case 3', 2, 3);
model.result('pg1').feature('tlan1').set('showpoint', false);
model.result('pg1').feature('tlan1').set('anchorpoint', 'uppermiddle');
model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Total Rotations for Rotational Load Cases');
model.result('pg2').set('data', 'dset8');
model.result('pg2').feature('surf1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'shell.totrot');
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('def1').set('scale', 10);
model.result('pg2').feature('surf2').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf2').set('data', 'dset10');
model.result('pg2').feature('surf2').set('expr', 'shell.totrot');
model.result('pg2').feature('surf3').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf3').set('data', 'dset12');
model.result('pg2').feature('surf3').set('expr', 'shell.totrot');
model.result('pg2').feature('tlan1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 'Load case 4', 0, 3);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 'Load case 5', 1, 3);
model.result('pg2').feature('tlan1').setIndex('localtablematrix', 'Load case 6', 2, 3);
model.result('pg2').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Analytical Extensional Stiffness Matrix by Xia et al.');
model.result.evaluationGroup('eg1').set('data', 'dset2');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'manual', 0);
model.result.evaluationGroup('eg1').setIndex('looplevel', [1], 0);
model.result.evaluationGroup('eg1').set('includeparameters', false);
model.result.evaluationGroup('eg1').set('transpose', true);
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'DA11_Xia', 0);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'DA12_Xia', 1);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'DA22_Xia', 2);
model.result.evaluationGroup('eg1').feature('gev1').setIndex('expr', 'DA33_Xia', 3);
model.result.evaluationGroup('eg1').run;
model.result.evaluationGroup.duplicate('eg2', 'eg1');
model.result.evaluationGroup('eg2').label('Analytical Bending Stiffness Matrix by Xia et al.');
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'DD11_Xia', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'DD12_Xia', 1);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'DD22_Xia', 2);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'DD33_Xia', 3);
model.result.evaluationGroup('eg2').run;
model.result.evaluationGroup.duplicate('eg3', 'eg2');
model.result.evaluationGroup('eg3').label('Analytical Extensional Stiffness Matrix by Park et al.');
model.result.evaluationGroup('eg3').feature('gev1').setIndex('expr', 'DA11_Park', 0);
model.result.evaluationGroup('eg3').feature('gev1').setIndex('expr', 'DA12_Park', 1);
model.result.evaluationGroup('eg3').feature('gev1').setIndex('expr', 'DA22_Park', 2);
model.result.evaluationGroup('eg3').feature('gev1').setIndex('expr', 'DA33_Park', 3);
model.result.evaluationGroup('eg3').run;
model.result.evaluationGroup.duplicate('eg4', 'eg3');
model.result.evaluationGroup('eg4').label('Analytical Bending Stiffness Matrix by Park et al.');
model.result.evaluationGroup('eg4').feature('gev1').setIndex('expr', 'DD11_Park', 0);
model.result.evaluationGroup('eg4').feature('gev1').setIndex('expr', 'DD12_Park', 1);
model.result.evaluationGroup('eg4').feature('gev1').setIndex('expr', 'DD22_Park', 2);
model.result.evaluationGroup('eg4').feature('gev1').setIndex('expr', 'DD33_Park', 3);
model.result.evaluationGroup('eg4').run;
model.result.evaluationGroup.duplicate('eg5', 'eg4');
model.result.evaluationGroup('eg5').label('Analytical Extensional Stiffness Matrix by Ye et al.');
model.result.evaluationGroup('eg5').feature('gev1').setIndex('expr', 'DA11_Ye', 0);
model.result.evaluationGroup('eg5').feature('gev1').setIndex('expr', 'DA12_Ye', 1);
model.result.evaluationGroup('eg5').feature('gev1').setIndex('expr', 'DA22_Ye', 2);
model.result.evaluationGroup('eg5').feature('gev1').setIndex('expr', 'DA33_Ye', 3);
model.result.evaluationGroup('eg5').run;
model.result.evaluationGroup.duplicate('eg6', 'eg5');
model.result.evaluationGroup('eg6').label('Analytical Bending Stiffness Matrix by Ye et al.');
model.result.evaluationGroup('eg6').feature('gev1').setIndex('expr', 'DD11_Ye', 0);
model.result.evaluationGroup('eg6').feature('gev1').setIndex('expr', 'DD12_Ye', 1);
model.result.evaluationGroup('eg6').feature('gev1').setIndex('expr', 'DD22_Ye', 2);
model.result.evaluationGroup('eg6').feature('gev1').setIndex('expr', 'DD33_Ye', 3);
model.result.evaluationGroup('eg6').run;
model.result.evaluationGroup.create('eg7', 'EvaluationGroup');
model.result.evaluationGroup('eg7').label('Numerical Extensional Stiffness Matrix Based on Reaction Forces');
model.result.evaluationGroup('eg7').set('data', 'dset2');
model.result.evaluationGroup('eg7').setIndex('looplevelinput', 'manual', 0);
model.result.evaluationGroup('eg7').setIndex('looplevel', [1], 0);
model.result.evaluationGroup('eg7').set('includeparameters', false);
model.result.evaluationGroup('eg7').set('transpose', true);
model.result.evaluationGroup('eg7').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg7').feature('gev1').setIndex('expr', 'DA11_R', 0);
model.result.evaluationGroup('eg7').feature('gev1').setIndex('expr', 'DA21_R', 1);
model.result.evaluationGroup('eg7').create('gev2', 'EvalGlobal');
model.result.evaluationGroup('eg7').feature('gev2').set('data', 'dset4');
model.result.evaluationGroup('eg7').feature('gev2').setIndex('looplevelinput', 'manual', 0);
model.result.evaluationGroup('eg7').feature('gev2').setIndex('looplevel', [1], 0);
model.result.evaluationGroup('eg7').feature('gev2').setIndex('expr', 'DA12_R', 0);
model.result.evaluationGroup('eg7').feature('gev2').setIndex('expr', 'DA22_R', 1);
model.result.evaluationGroup('eg7').create('gev3', 'EvalGlobal');
model.result.evaluationGroup('eg7').feature('gev3').set('data', 'dset6');
model.result.evaluationGroup('eg7').feature('gev3').setIndex('looplevelinput', 'manual', 0);
model.result.evaluationGroup('eg7').feature('gev3').setIndex('looplevel', [1], 0);
model.result.evaluationGroup('eg7').feature('gev3').setIndex('expr', 'DA33_R', 0);
model.result.evaluationGroup('eg7').run;
model.result.evaluationGroup.duplicate('eg8', 'eg7');
model.result.evaluationGroup('eg8').label('Numerical Bending Stiffness Matrix Based on Reaction Forces');
model.result.evaluationGroup('eg8').set('data', 'dset8');
model.result.evaluationGroup('eg8').feature('gev1').setIndex('expr', 'DD11_R', 0);
model.result.evaluationGroup('eg8').feature('gev1').setIndex('expr', 'DD21_R', 1);
model.result.evaluationGroup('eg8').feature('gev2').set('data', 'dset10');
model.result.evaluationGroup('eg8').feature('gev2').setIndex('expr', 'DD12_R', 0);
model.result.evaluationGroup('eg8').feature('gev2').setIndex('expr', 'DD22_R', 1);
model.result.evaluationGroup('eg8').feature('gev3').set('data', 'dset12');
model.result.evaluationGroup('eg8').feature('gev3').setIndex('expr', 'DD33_R', 0);
model.result.evaluationGroup('eg8').run;
model.result.evaluationGroup.duplicate('eg9', 'eg7');
model.result.evaluationGroup('eg9').label('Numerical Extensional Stiffness Matrix Based on Energy Equivalence');
model.result.evaluationGroup('eg9').feature('gev1').set('expr', {});
model.result.evaluationGroup('eg9').feature('gev1').set('descr', {});
model.result.evaluationGroup('eg9').feature('gev1').setIndex('expr', 'DA11_E', 0);
model.result.evaluationGroup('eg9').feature('gev2').set('expr', {});
model.result.evaluationGroup('eg9').feature('gev2').set('descr', {});
model.result.evaluationGroup('eg9').feature('gev2').setIndex('expr', 'DA22_E', 0);
model.result.evaluationGroup('eg9').feature('gev3').set('expr', {});
model.result.evaluationGroup('eg9').feature('gev3').set('descr', {});
model.result.evaluationGroup('eg9').feature('gev3').setIndex('expr', 'DA33_E', 0);
model.result.evaluationGroup('eg9').run;
model.result.evaluationGroup.duplicate('eg10', 'eg9');
model.result.evaluationGroup('eg10').label('Numerical Bending Stiffness Matrix Based on Energy Equivalence');
model.result.evaluationGroup('eg10').set('data', 'dset8');
model.result.evaluationGroup('eg10').feature('gev1').setIndex('expr', 'DD11_E', 0);
model.result.evaluationGroup('eg10').feature('gev2').set('data', 'dset10');
model.result.evaluationGroup('eg10').feature('gev2').setIndex('expr', 'DD22_E', 0);
model.result.evaluationGroup('eg10').feature('gev3').set('data', 'dset12');
model.result.evaluationGroup('eg10').feature('gev3').setIndex('expr', 'DD33_E', 0);
model.result.evaluationGroup('eg10').run;
model.result('pg1').run;

model.nodeGroup.create('grp7', 'Results');
model.nodeGroup('grp7').add('plotgroup', 'pg1');
model.nodeGroup('grp7').add('plotgroup', 'pg2');
model.nodeGroup('grp7').add('evaluationgroup', 'eg1');
model.nodeGroup('grp7').add('evaluationgroup', 'eg2');
model.nodeGroup('grp7').add('evaluationgroup', 'eg3');
model.nodeGroup('grp7').add('evaluationgroup', 'eg4');
model.nodeGroup('grp7').add('evaluationgroup', 'eg5');
model.nodeGroup('grp7').add('evaluationgroup', 'eg6');
model.nodeGroup('grp7').add('evaluationgroup', 'eg7');
model.nodeGroup('grp7').add('evaluationgroup', 'eg8');
model.nodeGroup('grp7').add('evaluationgroup', 'eg9');
model.nodeGroup('grp7').add('evaluationgroup', 'eg10');
model.nodeGroup('grp7').label('Trapezoidal Corrugation');
model.nodeGroup.duplicate('grp8', 'grp7');
model.nodeGroup('grp8').label('Round Corrugation');

model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 2, 0);
model.result('pg3').feature('surf2').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf2').setIndex('looplevel', 2, 0);
model.result('pg3').feature('surf3').set('arraydim', '1');
model.result('pg3').run;
model.result('pg3').feature('surf3').setIndex('looplevel', 2, 0);
model.result('pg3').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 2, 0);
model.result('pg4').feature('surf2').set('arraydim', '1');
model.result('pg4').run;
model.result('pg4').feature('surf2').setIndex('looplevel', 2, 0);
model.result('pg4').feature('surf3').set('arraydim', '1');
model.result('pg4').run;
model.result('pg4').feature('surf3').setIndex('looplevel', 2, 0);
model.result('pg4').run;
model.result('pg4').run;
model.result.evaluationGroup('eg11').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg11').run;
model.result.evaluationGroup('eg12').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg12').run;
model.result.evaluationGroup('eg13').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg13').run;
model.result.evaluationGroup('eg14').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg14').run;
model.result.evaluationGroup('eg15').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg15').run;
model.result.evaluationGroup('eg16').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg16').run;
model.result.evaluationGroup('eg17').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg17').feature('gev2').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg17').feature('gev3').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg17').run;
model.result.evaluationGroup('eg18').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg18').feature('gev2').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg18').feature('gev3').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg18').run;
model.result.evaluationGroup('eg19').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg19').feature('gev2').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg19').feature('gev3').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg19').run;
model.result.evaluationGroup('eg20').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg20').feature('gev2').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg20').feature('gev3').setIndex('looplevel', [2], 0);
model.result.evaluationGroup('eg20').run;
model.result('pg3').run;

model.title('Homogenized Model of a Corrugated Sheet');

model.description('This example presents a homogenized numerical model of a corrugated sheet based on a unit cell, where numerically obtained equivalent stiffness matrices are compared with various analytical models. Two corrugation profiles, trapezoidal and round, are considered in this example.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;
model.sol('sol17').clearSolutionData;
model.sol('sol18').clearSolutionData;
model.sol('sol19').clearSolutionData;
model.sol('sol20').clearSolutionData;
model.sol('sol21').clearSolutionData;
model.sol('sol22').clearSolutionData;
model.sol('sol23').clearSolutionData;
model.sol('sol24').clearSolutionData;

model.label('corrugated_sheet.mph');

model.modelNode.label('Components');

out = model;
