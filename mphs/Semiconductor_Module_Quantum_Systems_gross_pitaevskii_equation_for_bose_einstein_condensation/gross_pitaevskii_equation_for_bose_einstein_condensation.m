function out = model
%
% gross_pitaevskii_equation_for_bose_einstein_condensation.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Semiconductor_Module/Quantum_Systems');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('schr', 'SchrodingerEquation', 'geom1', {'psi'});

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

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);

model.param.set('w0', '2*pi*10[Hz]');
model.param.descr('w0', 'Trap frequency');
model.param.set('ma', '86.909[g/mol]/N_A_const');
model.param.descr('ma', 'Atomic mass of Rb-87');
model.param.set('as', '5.2[nm]');
model.param.descr('as', 'Scattering length');
model.param.set('U0', '4*pi*hbar_const^2*as/ma');
model.param.descr('U0', 'Interaction strength');
model.param.set('N0', '1');
model.param.descr('N0', 'Number of atoms');
model.param.set('wr', 'w0*sqrt(3)');
model.param.descr('wr', 'Transverse trap frequency');
model.param.set('Rr0', '(15*U0*w0*N0/(4*pi*ma*wr^3))^0.2');
model.param.descr('Rr0', 'Transverse T-F size');
model.param.set('Rz0', '(15*U0*wr^2*N0/(4*pi*ma*w0^4))^0.2');
model.param.descr('Rz0', 'Longitudinal T-F size');
model.param.set('rho0', '15*N0/(8*pi*Rr0^2*Rz0)');
model.param.descr('rho0', 'T-F peak density');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 50);
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('schr').prop('ModelProperties').set('lambda_scale', '1[nK]*k_B_const');
model.physics('schr').feature('meff1').label('Atomic Mass');
model.physics('schr').feature('meff1').set('meffe_psi', {'ma' '0' '0' '0' 'ma' '0' '0' '0' 'ma'});
model.physics('schr').feature('ve1').label('Trap Potential Energy');
model.physics('schr').feature('ve1').set('Ve_src', 'userdef');
model.physics('schr').feature('ve1').set('Ve', '0.5*ma*w0^2*(3*r^2+z^2)');

model.mesh('mesh1').autoMeshSize(2);
model.mesh('mesh1').run;

model.study('std1').label('Study 1: Eigenvalue for Initial Condition');
model.study('std1').feature('eigv').set('neigs', 1);

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
model.result.numerical('gev1').set('expr', {'schr.Ei' 'schr.int(2*schr.Pr*pi*R)'});
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').set('descr', {'Eigenenergy' 'Total probability'});
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').setIndex('unit', 'eV', 0);
model.result.numerical('gev1').set('data', 'dset1');
model.result.numerical('gev1').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond2/pcond5/gev1');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Normalized Wave Function (schr)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pcond1/pcond6/pg7');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Real Part');
model.result('pg1').feature('surf1').set('expr', 'schr.Psi_psi');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature('surf1').feature.create('hght1', 'Height');
model.result('pg1').feature.create('surf2', 'Surface');
model.result('pg1').feature('surf2').label('Imaginary Part');
model.result('pg1').feature('surf2').set('expr', 'imag(schr.Psi_psi)');
model.result('pg1').feature('surf2').set('smooth', 'internal');
model.result('pg1').feature('surf2').set('data', 'parent');
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').feature('surf2').feature.create('hght1', 'Height');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Probability Density (schr)');
model.result('pg2').set('dataisaxisym', 'off');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pg7');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'schr.Pr');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('hght1', 'Height');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Potential Energy (schr)');
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pg6');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'schr.V_psi');
model.result('pg3').feature('surf1').set('unit', 'eV');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature('surf1').feature.create('hght1', 'Height');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Effective Mass (schr)');
model.result('pg4').set('dataisaxisym', 'off');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 1, 0);
model.result('pg4').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pg5');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'schr.meff_psiRR/me_const');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature('surf1').feature.create('hght1', 'Height');
model.result('pg1').run;

model.physics('schr').feature.duplicate('ve2', 've1');
model.physics('schr').feature('ve2').label('Interaction Energy');
model.physics('schr').feature('ve2').set('Ve', 'N0*U0*schr.Pr');
model.physics('schr').create('ge1', 'GlobalEquations', -1);
model.physics('schr').feature('ge1').setIndex('name', 'E0', 0, 0);
model.physics('schr').feature('ge1').setIndex('equation', '(1-schr.int(2*pi*r*schr.Pr))', 0, 0);
model.physics('schr').feature('ge1').setIndex('initialValueU', 1, 0, 0);
model.physics('schr').prop('ModelProperties').set('E', 'E0*1[nK]*k_B_const');
model.physics('schr').feature.duplicate('init2', 'init1');
model.physics('schr').feature('init2').set('psi', 'schr.Psi');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/schr', true);
model.study('std2').feature('stat').set('useinitsol', true);
model.study('std2').feature('stat').set('initstudy', 'std1');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'w0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Hz', 0);
model.study('std2').feature('stat').setIndex('pname', 'w0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'Hz', 0);
model.study('std2').feature('stat').setIndex('pname', 'N0', 0);
model.study('std2').feature('stat').setIndex('plistarr', '1 100 1e4 1e6', 0);
model.study('std2').label('Study 2: Stationary for Condensate');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Wave Function (schr)');
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 4, 0);
model.result('pg5').set('dataisaxisym', 'off');
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevel', 4, 0);
model.result('pg5').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pcond2/pg8');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Real Part');
model.result('pg5').feature('surf1').set('expr', 'psi');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg5').feature('surf1').feature.create('hght1', 'Height');
model.result('pg5').feature.create('surf2', 'Surface');
model.result('pg5').feature('surf2').label('Imaginary Part');
model.result('pg5').feature('surf2').set('expr', 'imag(psi)');
model.result('pg5').feature('surf2').set('smooth', 'internal');
model.result('pg5').feature('surf2').set('data', 'parent');
model.result('pg5').feature('surf2').set('inheritplot', 'surf1');
model.result('pg5').feature('surf2').feature.create('hght1', 'Height');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').label('Probability Density (schr) 1');
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevel', 4, 0);
model.result('pg6').set('dataisaxisym', 'off');
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevel', 4, 0);
model.result('pg6').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pg7');
model.result('pg6').feature.create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'schr.Pr');
model.result('pg6').feature('surf1').set('smooth', 'internal');
model.result('pg6').feature('surf1').set('data', 'parent');
model.result('pg6').feature('surf1').feature.create('hght1', 'Height');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').label('Potential Energy (schr) 1');
model.result('pg7').set('data', 'dset2');
model.result('pg7').setIndex('looplevel', 4, 0);
model.result('pg7').set('dataisaxisym', 'off');
model.result('pg7').set('data', 'dset2');
model.result('pg7').setIndex('looplevel', 4, 0);
model.result('pg7').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pg6');
model.result('pg7').feature.create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'schr.V_psi');
model.result('pg7').feature('surf1').set('unit', 'eV');
model.result('pg7').feature('surf1').set('smooth', 'internal');
model.result('pg7').feature('surf1').set('data', 'parent');
model.result('pg7').feature('surf1').feature.create('hght1', 'Height');
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').label('Effective Mass (schr) 1');
model.result('pg8').set('data', 'dset2');
model.result('pg8').setIndex('looplevel', 4, 0);
model.result('pg8').set('dataisaxisym', 'off');
model.result('pg8').set('data', 'dset2');
model.result('pg8').setIndex('looplevel', 4, 0);
model.result('pg8').set('defaultPlotID', 'SchrodingerEquation/phys1/pdef1/pcond3/pg5');
model.result('pg8').feature.create('surf1', 'Surface');
model.result('pg8').feature('surf1').set('expr', 'schr.meff_psiRR/me_const');
model.result('pg8').feature('surf1').set('smooth', 'internal');
model.result('pg8').feature('surf1').set('data', 'parent');
model.result('pg8').feature('surf1').feature.create('hght1', 'Height');
model.result('pg5').run;
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').label(['Compare with Thomas' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Fermi Approximation']);
model.result('pg9').set('data', 'dset2');
model.result('pg9').setIndex('looplevelinput', 'last', 0);
model.result('pg9').set('titletype', 'manual');
model.result('pg9').set('title', ['Compare computed probability density with Thomas' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Fermi approximation in the axial and radial directions']);
model.result('pg9').set('xlabelactive', true);
model.result('pg9').set('xlabel', 'Distance from center of condensate (um)');
model.result('pg9').set('ylabelactive', true);
model.result('pg9').set('ylabel', 'Probability density (1/um<sup>3</sup>)');
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg9').feature('lngr1').set('linewidth', 'preference');
model.result('pg9').feature('lngr1').selection.set([1 2]);
model.result('pg9').feature('lngr1').set('expr', 'schr.Pr');
model.result('pg9').feature('lngr1').set('unit', '1/um^3');
model.result('pg9').feature('lngr1').set('descractive', true);
model.result('pg9').feature('lngr1').set('descr', 'axial');
model.result('pg9').feature('lngr1').set('xdata', 'expr');
model.result('pg9').feature('lngr1').set('xdataexpr', 'z');
model.result('pg9').feature('lngr1').set('legend', true);
model.result('pg9').feature('lngr1').set('autodescr', true);
model.result('pg9').feature.duplicate('lngr2', 'lngr1');
model.result('pg9').run;
model.result('pg9').feature('lngr2').set('expr', 'max(0,1-z^2/Rz0^2)*rho0/N0');
model.result('pg9').feature('lngr2').set('descr', 'axial TF');
model.result('pg9').feature('lngr2').set('linestyle', 'dashed');
model.result.dataset.create('mir1', 'Mirror2D');
model.result.dataset('mir1').set('data', 'dset2');
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'mir1');
model.result.dataset('cln1').set('bounded', false);
model.result('pg9').run;
model.result('pg9').feature.duplicate('lngr3', 'lngr1');
model.result('pg9').run;
model.result('pg9').feature('lngr3').set('data', 'cln1');
model.result('pg9').feature('lngr3').setIndex('looplevelinput', 'last', 0);
model.result('pg9').feature('lngr3').set('descr', 'radial');
model.result('pg9').feature('lngr3').set('xdataexpr', 'cln1x');
model.result('pg9').run;
model.result('pg9').feature.duplicate('lngr4', 'lngr2');
model.result('pg9').run;
model.result('pg9').feature('lngr4').set('data', 'cln1');
model.result('pg9').feature('lngr4').setIndex('looplevelinput', 'last', 0);
model.result('pg9').feature('lngr4').set('expr', 'max(0,1-r^2/Rr0^2)*rho0/N0');
model.result('pg9').feature('lngr4').set('descr', 'radial TF');
model.result('pg9').feature('lngr4').set('xdataexpr', 'cln1x');
model.result('pg9').run;
model.result('pg5').run;
model.result.duplicate('pg10', 'pg5');
model.result('pg10').run;
model.result('pg10').label('Summary Plot');
model.result('pg10').run;
model.result('pg10').feature.remove('surf2');
model.result('pg10').run;
model.result('pg10').run;
model.result('pg7').run;
model.result('pg10').run;
model.result('pg10').feature.copy('surf2', 'pg7/surf1');
model.result('pg10').run;
model.result('pg10').feature('surf2').set('coloring', 'uniform');
model.result('pg10').feature('surf2').set('color', 'gray');
model.result('pg10').run;

model.study('std1').feature('eigv').set('useadvanceddisable', true);
model.study('std1').feature('eigv').set('disabledphysics', {'schr/ve2' 'schr/ge1' 'schr/init2'});

model.result('pg10').run;

model.title(['Gross' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Pitaevskii Equation for Bose' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Einstein Condensation']);

model.description(['This tutorial model solves the Gross' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Pitaevskii Equation for the ground state of a Bose' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Einstein condensate in a harmonic trap, using the Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger Equation physics interface in the Semiconductor Module. The equation is essentially a nonlinear single-particle Schr' native2unicode(hex2dec({'00' 'f6'}), 'unicode') 'dinger Equation, with a potential energy contribution proportional to the local particle density. The eigenvalue study is not suitable for solving this kind of nonlinear eigenvalue problems. Instead, a stationary study is used with a global equation enforcing the normalization of the wave function to solve for the ground state solution. The result for a large number of particles compares well with the Thomas' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Fermi approximation as expected.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('gross_pitaevskii_equation_for_bose_einstein_condensation.mph');

model.modelNode.label('Components');

out = model;
