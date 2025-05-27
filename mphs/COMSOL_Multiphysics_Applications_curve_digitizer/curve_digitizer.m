function out = model
%
% curve_digitizer.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Applications');

model.title('Curve Digitizer');

model.description('Use this app to extract curves from images. It provides an easy way to digitize a variety of 1D plots with different axes in Cartesian or polar coordinate systems.');

model.mesh.clearMeshes;

model.label('curve_digitizer.mph');

model.modelNode.label('Components');

out = model;
