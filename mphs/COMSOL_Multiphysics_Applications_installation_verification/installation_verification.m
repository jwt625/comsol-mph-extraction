function out = model
%
% installation_verification.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Applications');

app.form('mainForm').formObject('collection2').setIndex('vertscroll', false, 0);
app.form('mainForm').formObject('collection2').setIndex('vertscroll', false, 1);
app.form('mainForm').formObject('collection2').setIndex('vertscroll', false, 2);

model.title('Installation Verification');

model.description(['The installation verification application can be used to help verify that your COMSOL Multiphysics' native2unicode(hex2dec({'00' 'ae'}), 'unicode') ' or COMSOL Server' native2unicode(hex2dec({'21' '22'}), 'unicode') ' installation works as expected on your hardware platforms and operating systems. The app automatically loads and runs a suite of test models and compares the results with stored expected values. One set of tests compares the currently computed results with published results obtained from either experiments or other types of computations or analytical results. Another set of tests compares the computed results with previously computed stored results, usually with a refined mesh. The most computationally demanding test models may require up to 32' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'GB of RAM.']);

model.label('installation_verification.mph');

model.modelNode.label('Components');

out = model;
