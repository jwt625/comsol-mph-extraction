function out = model
%
% si_quantum_dot_in_uniform_magnetic_field.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Semiconductor_Module/Quantum_Systems');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('schr', 'SchrodingerEquation', 'geom1', {'psiu' 'psid'});

model.study.create('std1');
model.study('std1').create('eigv', 'Eigenvalue');
model.study('std1').feature('eigv').set('neigs', '3');
model.study('std1').feature('eigv').set('eigunit', '');
model.study('std1').feature('eigv').set('shift', '0.1');
model.study('std1').feature('eigv').set('conrad', '1');
model.study('std1').feature('eigv').set('conradynhm', '1');
model.study('std1').feature('eigv').set('conlbdy', '0');
model.study('std1').feature('eigv').set('conubdy', '1');
model.study('std1').feature('eigv').set('linpsolnum', 'auto');
model.study('std1').feature('eigv').set('solnum', 'auto');
model.study('std1').feature('eigv').set('notsolnum', 'auto');
model.study('std1').feature('eigv').set('outputmap', {});
model.study('std1').feature('eigv').set('ngenAUX', '1');
model.study('std1').feature('eigv').set('goalngenAUX', '1');
model.study('std1').feature('eigv').set('ngenAUX', '1');
model.study('std1').feature('eigv').set('goalngenAUX', '1');
model.study('std1').feature('eigv').setSolveFor('/physics/schr', true);

model.geom('geom1').lengthUnit('nm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', [120 80 10]);
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').feature('blk1').set('pos', [0 0 -3]);
model.geom('geom1').feature('blk1').setIndex('layer', 2, 0);
model.geom('geom1').feature('blk1').set('layerbottom', false);
model.geom('geom1').feature('blk1').set('layertop', true);
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('viewscaletype', 'automatic');
model.view('view1').camera.set('autocontext', 'anisotropic');
model.view('view1').camera.set('xweight', 1.2);
model.view('view1').camera.set('yweight', 0.8);
model.view('view1').camera.set('zweight', 0.5);

model.param.set('mxy', '0.19*me_const');
model.param.descr('mxy', 'Lateral effective mass');
model.param.set('mz', '0.98*me_const');
model.param.descr('mz', 'Vertical effective mass');
model.param.set('wx', '1[meV]/hbar_const');
model.param.descr('wx', 'Trap frequency in the x direction');
model.param.set('wy', '3*wx');
model.param.descr('wy', 'Trap frequency in the y direction');
model.param.set('Fz', '10[MV/m]');
model.param.descr('Fz', 'Electric field');
model.param.set('U0', '3[eV]');
model.param.descr('U0', 'Oxide energy barrier');
model.param.set('uB', 'e_const*hbar_const/2/me_const');
model.param.descr('uB', 'Bohr magneton');
model.param.set('B', '1[T]');
model.param.descr('B', 'Magnetic field');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Ax', 'z*B/2');
model.variable('var1').descr('Ax', 'Vector potential');
model.variable('var1').set('Ay', '0[Wb/m]');
model.variable('var1').descr('Ay', 'Vector potential');
model.variable('var1').set('Az', '-x*B/2');
model.variable('var1').descr('Az', 'Vector potential');

model.physics('schr').feature('meff1').set('meffe_psiu', {'mxy' '0' '0' '0' 'mxy' '0' '0' '0' 'mz'});
model.physics('schr').feature('meff1').set('meffe_psid', {'mxy' '0' '0' '0' 'mxy' '0' '0' '0' 'mz'});
model.physics('schr').feature('ve1').label('Electron Potential Energy 1 - Lateral harmonic confinement');
model.physics('schr').feature('ve1').set('Ve_psiu', '0.5*mxy*(wx^2*x^2+wy^2*y^2)');
model.physics('schr').feature('ve1').set('Ve_psid', '0.5*mxy*(wx^2*x^2+wy^2*y^2)');
model.physics('schr').create('ve2', 'ElectronPotentialEnergy', 3);
model.physics('schr').feature('ve2').label('Electron Potential Energy 2 - E field');
model.physics('schr').feature('ve2').selection.all;
model.physics('schr').feature('ve2').set('Ve_psiu', 'schr.q*Fz*z');
model.physics('schr').feature('ve2').set('Ve_psid', 'schr.q*Fz*z');
model.physics('schr').create('ve3', 'ElectronPotentialEnergy', 3);
model.physics('schr').feature('ve3').label('Electron Potential Energy 3 - Oxide energy barrier');
model.physics('schr').feature('ve3').selection.set([2]);
model.physics('schr').feature('ve3').set('Ve_psiu', 'U0');
model.physics('schr').feature('ve3').set('Ve_psid', 'U0');
model.physics('schr').create('lorf1', 'LorentzForce_schr', 3);
model.physics('schr').feature('lorf1').selection.all;
model.physics('schr').feature('lorf1').set('A', {'Ax' 'Ay' 'Az'});
model.physics('schr').create('H0th1', 'ZerothOrderHamiltonianSemicond', 3);
model.physics('schr').feature('H0th1').label('Zeroth Order Hamiltonian 1 - Spin');
model.physics('schr').feature('H0th1').selection.all;
model.physics('schr').feature('H0th1').setIndex('n', 2, 0, 0);
model.physics('schr').feature('H0th1').setIndex('H0', '-i*uB*B/(hbar_const^2/2/me_const)', 0, 0);
model.physics('schr').feature('H0th1').setIndex('desc', 'H12', 0, 0);
model.physics('schr').feature('H0th1').setIndex('m', 1, 1, 0);
model.physics('schr').feature('H0th1').setIndex('n', 1, 1, 0);
model.physics('schr').feature('H0th1').setIndex('H0', 0, 1, 0);
model.physics('schr').feature('H0th1').setIndex('desc', 'Description', 1, 0);
model.physics('schr').feature('H0th1').setIndex('n', 1, 1, 0);
model.physics('schr').feature('H0th1').setIndex('H0', 0, 1, 0);
model.physics('schr').feature('H0th1').setIndex('desc', 'Description', 1, 0);
model.physics('schr').feature('H0th1').setIndex('m', 1, 1, 0);
model.physics('schr').feature('H0th1').setIndex('n', 1, 1, 0);
model.physics('schr').feature('H0th1').setIndex('H0', 0, 1, 0);
model.physics('schr').feature('H0th1').setIndex('desc', 'Description', 1, 0);
model.physics('schr').feature('H0th1').setIndex('m', 2, 1, 0);
model.physics('schr').feature('H0th1').setIndex('H0', '+i*uB*B/(hbar_const^2/2/me_const)', 1, 0);
model.physics('schr').feature('H0th1').setIndex('desc', 'H21', 1, 0);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([7]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.all;
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 20);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.set([2]);
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.set([1]);
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 10);
model.mesh('mesh1').run;

model.study('std1').feature('eigv').set('neigs', 9);
model.study('std1').feature('eigv').set('shift', '0.037');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eigv');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eigv');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('neigs', 6);
model.sol('sol1').feature('e1').set('shift', '0');
model.sol('sol1').feature('e1').set('rtol', 1.0E-10);
model.sol('sol1').feature('e1').set('transform', 'none');
model.sol('sol1').feature('e1').set('eigref', '0.1');
model.sol('sol1').feature('e1').set('eigvfunscale', 'average');
model.sol('sol1').feature('e1').set('control', 'eigv');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Eigenvalue');
model.result.numerical('gev1').set('showlooplevelinput', {'off' 'off' 'off'});
model.result.numerical('gev1').set('expr', {'schr.Ei' 'schr.int(schr.Pr)'});
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').set('descr', {'Eigenenergy' 'Total probability'});
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond2/pcond5/gev1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Normalized Wave Function (schr)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond4/pcond1/pcond7/pg10');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', 'schr.Psi_psiu');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Normalized Wave Function (schr) 1');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond4/pcond1/pcond7/pg11');
model.result('pg2').feature.create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('expr', 'imag(schr.Psi_psiu)');
model.result('pg2').feature('mslc1').set('smooth', 'internal');
model.result('pg2').feature('mslc1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Probability Density (schr)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond4/pg10');
model.result('pg3').feature.create('mslc1', 'Multislice');
model.result('pg3').feature('mslc1').set('expr', 'schr.Pr');
model.result('pg3').feature('mslc1').set('smooth', 'internal');
model.result('pg3').feature('mslc1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Potential Energy (schr)');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond4/pg9');
model.result('pg4').feature.create('mslc1', 'Multislice');
model.result('pg4').feature('mslc1').set('expr', 'schr.V_psiu');
model.result('pg4').feature('mslc1').set('unit', 'eV');
model.result('pg4').feature('mslc1').set('smooth', 'internal');
model.result('pg4').feature('mslc1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Effective Mass (schr)');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 1, 0);
model.result('pg5').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond4/pg8');
model.result('pg5').feature.create('mslc1', 'Multislice');
model.result('pg5').feature('mslc1').set('expr', 'schr.meff_psiuXX/me_const');
model.result('pg5').feature('mslc1').set('smooth', 'internal');
model.result('pg5').feature('mslc1').set('data', 'parent');
model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Eigenvalue');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg1').run;
model.result('pg1').stepNext(0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').stepNext(0);
model.result('pg2').run;
model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset('cpt1').set('pointx', 0);
model.result.dataset('cpt1').set('pointy', 0);
model.result.dataset('cpt1').set('pointz', -2);
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Evaluation Group 1 - Wave functions');
model.result.evaluationGroup('eg1').set('data', 'cpt1');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'manualindices', 0);
model.result.evaluationGroup('eg1').setIndex('looplevelindices', '1 2', 0);
model.result.evaluationGroup('eg1').create('pev1', 'EvalPoint');
model.result.evaluationGroup('eg1').feature('pev1').setIndex('expr', 'schr.Psi_psiu/3.56575008131e11', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('descr', 'up', 0);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('expr', 'schr.Psi_psid/3.56575008131e11', 1);
model.result.evaluationGroup('eg1').feature('pev1').setIndex('descr', 'down', 1);
model.result.evaluationGroup('eg1').run;
model.result.evaluationGroup.create('eg2', 'EvaluationGroup');
model.result.evaluationGroup('eg2').label('Evaluation Group 2 - Compare energy difference');
model.result.evaluationGroup('eg2').setIndex('looplevelinput', 'first', 0);
model.result.evaluationGroup('eg2').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', 'withsol(''sol1'',schr.Ei,setind(lambda,2))-schr.Ei', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('unit', 'meV', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('descr', 'Computed energy difference', 0);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('expr', '2*uB*B', 1);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('unit', 'meV', 1);
model.result.evaluationGroup('eg2').feature('gev1').setIndex('descr', 'Expected energy difference', 1);
model.result.evaluationGroup('eg2').run;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('quickplane', 'xz');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Supplementary Figure 1');
model.result('pg6').set('showlegendsmaxmin', true);
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'schr.Pr');
model.result('pg6').feature('surf1').set('unit', '1/cm^3');
model.result('pg6').feature('surf1').set('coloring', 'gradient');
model.result('pg6').feature('surf1').set('topcolor', 'blue');
model.result('pg6').feature('surf1').set('bottomcolor', 'gray');
model.result('pg6').run;
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').set('planecoordsys', 'cartesian');
model.result('pg6').feature('arws1').set('expr', {'' '' ''});
model.result('pg6').feature('arws1').set('descr', '');
model.result('pg6').feature('arws1').set('expr', {'schr.PiX' 'schr.PiY' 'schr.PiZ'});
model.result('pg6').feature('arws1').set('descr', 'Kinetic momentum density');
model.result('pg6').feature('arws1').set('xnumber', 30);
model.result('pg6').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg6').feature('arws1').set('scaleactive', true);
model.result('pg6').feature('arws1').set('scale', '1e5');

model.view('view2').axis.set('viewscaletype', 'automatic');

model.result('pg6').run;
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Eighth excited state');
model.result('pg7').stepLast(0);
model.result('pg7').run;
model.result('pg7').set('edges', false);

model.view('view1').set('showgrid', false);

model.result('pg7').set('showlegends', false);
model.result('pg7').create('iso1', 'Isosurface');
model.result('pg7').feature('iso1').set('expr', 'schr.Pr');
model.result('pg7').feature('iso1').set('unit', '1/cm^3');
model.result('pg7').feature('iso1').set('levelmethod', 'levels');
model.result('pg7').feature('iso1').set('levels', 'range(2.0e16,7.5e16,3.2e17)');
model.result('pg7').feature('iso1').create('filt1', 'Filter');
model.result('pg7').run;
model.result('pg7').feature('iso1').feature('filt1').set('expr', 'x>0.1[nm] || z<-2[nm]');
model.result('pg7').run;
model.result('pg7').feature('iso1').create('tran1', 'Transparency');
model.result('pg7').run;
model.result('pg7').feature('iso1').feature('tran1').set('transparency', 0.4);
model.result('pg7').run;
model.result('pg7').create('arwv1', 'ArrowVolume');
model.result('pg7').feature('arwv1').set('expr', {'schr.PiX' 'schr.PiY' 'schr.PiZ'});
model.result('pg7').feature('arwv1').set('descr', 'Kinetic momentum density');
model.result('pg7').feature('arwv1').set('xnumber', 26);
model.result('pg7').feature('arwv1').set('arrowymethod', 'coord');
model.result('pg7').feature('arwv1').set('ycoord', '-30 30');
model.result('pg7').feature('arwv1').set('znumber', 15);
model.result('pg7').feature('arwv1').set('scaleactive', true);
model.result('pg7').feature('arwv1').set('scale', '1e7');
model.result('pg7').feature('arwv1').set('color', 'magenta');
model.result('pg7').run;

model.title('A Silicon Quantum Dot in a Uniform Magnetic Field');

model.description(['This tutorial model solves a two-component Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger equation for the eigenstates of a simple silicon quantum dot in a uniform magnetic field, based on the paper by Jock and others on the topic of spin-orbit qubits. The built-in domain condition Lorentz Force for the Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger Equation interface is used to account for the contribution to the kinetic momentum from the vector potential. The coupling of the spin-up and spin-down components is implemented using the built-in domain condition Zeroth Order Hamiltonian. Together with the benchmark model k dot p Method for Strained Wurtzite GaN Band Structure, these examples show how to set up multiple wave-function components with the Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger Equation interface. The computed probability density and kinetic momentum density of the ground state compare well with Supplementary Figure' native2unicode(hex2dec({'00' 'a0'}), 'unicode') '1 in the paper. In addition, the computed energy difference between the first two eigenstates agrees well with the expected value from an intuitive analytic calculation.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('si_quantum_dot_in_uniform_magnetic_field.mph');

model.modelNode.label('Components');

out = model;
