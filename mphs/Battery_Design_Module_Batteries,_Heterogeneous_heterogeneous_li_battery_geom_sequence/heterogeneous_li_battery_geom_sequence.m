function out = model
%
% heterogeneous_li_battery_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Heterogeneous');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Rp', '1.5e-6[m]', 'Active material particle diameter');
model.param.set('pr_neg', '1', 'Particle rotation parameter negative');
model.param.set('pr_pos', '0', 'Particle rotation parameter positive');
model.param.set('L_sep', '25e-6', 'Separator thickness');

model.view('view1').set('transparency', true);

model.geom('geom1').create('elp1', 'Ellipsoid');
model.geom('geom1').feature('elp1').set('semiaxes', {'Rp*1.5/3*pr_pos+Rp*(1-pr_pos)' '1' '1'});
model.geom('geom1').feature('elp1').setIndex('semiaxes', 'Rp*1.5/3', 1);
model.geom('geom1').feature('elp1').setIndex('semiaxes', 'Rp*pr_pos+Rp*1.5/3*(1-pr_pos)', 2);
model.geom('geom1').feature('elp1').set('pos', {'0' '6.5e-7*pr_pos' '0'});
model.geom('geom1').feature('elp1').set('axistype', 'y');
model.geom('geom1').run('elp1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'elp1'});
model.geom('geom1').feature('copy1').set('displx', 'Rp*0.9');
model.geom('geom1').run('copy1');
model.geom('geom1').create('elp2', 'Ellipsoid');
model.geom('geom1').feature('elp2').set('semiaxes', {'Rp*1.5/3' 'Rp*1.5/3*pr_pos+Rp*(1-pr_pos)' '1'});
model.geom('geom1').feature('elp2').setIndex('semiaxes', 'Rp*pr_pos+Rp*1.5/3*(1-pr_pos)', 2);
model.geom('geom1').feature('elp2').set('pos', {'0' 'Rp*1.2+6.5e-7*pr_pos' '0'});
model.geom('geom1').run('elp2');
model.geom('geom1').create('copy2', 'Copy');
model.geom('geom1').feature('copy2').selection('input').set({'elp2'});
model.geom('geom1').feature('copy2').set('displx', 'Rp*0.9');
model.geom('geom1').run('copy2');
model.geom('geom1').create('copy3', 'Copy');
model.geom('geom1').feature('copy3').selection('input').set({'copy1' 'copy2' 'elp1' 'elp2'});
model.geom('geom1').feature('copy3').set('displz', 'Rp*1.6');
model.geom('geom1').run('copy3');
model.geom('geom1').create('copy4', 'Copy');
model.geom('geom1').feature('copy4').selection('input').set({'copy1' 'copy2' 'copy3' 'elp1' 'elp2'});
model.geom('geom1').feature('copy4').set('disply', '-Rp*1.23*2');
model.geom('geom1').run('copy4');
model.geom('geom1').create('copy5', 'Copy');
model.geom('geom1').feature('copy5').selection('input').set({'copy1' 'copy2' 'copy3' 'copy4' 'elp1' 'elp2'});
model.geom('geom1').feature('copy5').set('disply', '-Rp*1.23*4');
model.geom('geom1').run('copy5');
model.geom('geom1').create('elp3', 'Ellipsoid');
model.geom('geom1').feature('elp3').set('semiaxes', {'Rp*1.5/3*pr_neg+Rp*(1-pr_neg)' '1' '1'});
model.geom('geom1').feature('elp3').setIndex('semiaxes', 'Rp*1.5/3', 1);
model.geom('geom1').feature('elp3').setIndex('semiaxes', 'Rp*pr_neg+Rp*1.5/3*(1-pr_neg)', 2);
model.geom('geom1').feature('elp3').set('pos', {'0' 'L_sep-5e-7*(1-pr_neg)' '0'});
model.geom('geom1').feature('elp3').set('axistype', 'y');
model.geom('geom1').run('elp3');
model.geom('geom1').create('copy6', 'Copy');
model.geom('geom1').feature('copy6').selection('input').set({'elp3'});
model.geom('geom1').feature('copy6').set('displx', 'Rp*0.9');
model.geom('geom1').run('copy6');
model.geom('geom1').create('elp4', 'Ellipsoid');
model.geom('geom1').feature('elp4').set('semiaxes', {'Rp*1.5/3' 'Rp*1.5/3*pr_neg+Rp*(1-pr_neg)' '1'});
model.geom('geom1').feature('elp4').setIndex('semiaxes', 'Rp*pr_neg+Rp*1.5/3*(1-pr_neg)', 2);
model.geom('geom1').feature('elp4').set('pos', {'0' 'Rp*1.2+L_sep-5e-7*(1-pr_neg)' '0'});
model.geom('geom1').run('elp4');
model.geom('geom1').create('copy7', 'Copy');
model.geom('geom1').feature('copy7').selection('input').set({'elp4'});
model.geom('geom1').feature('copy7').set('displx', 'Rp*0.9');
model.geom('geom1').run('copy7');
model.geom('geom1').create('copy8', 'Copy');
model.geom('geom1').feature('copy8').selection('input').set({'copy6' 'copy7' 'elp3' 'elp4'});
model.geom('geom1').feature('copy8').set('displz', 'Rp*1.6');
model.geom('geom1').run('copy8');
model.geom('geom1').create('copy9', 'Copy');
model.geom('geom1').feature('copy9').selection('input').set({'copy6' 'copy7' 'copy8' 'elp3' 'elp4'});
model.geom('geom1').feature('copy9').set('disply', 'Rp*1.23*2');
model.geom('geom1').run('copy9');
model.geom('geom1').create('copy10', 'Copy');
model.geom('geom1').feature('copy10').selection('input').set({'copy6' 'copy7' 'copy8' 'copy9' 'elp3' 'elp4'});
model.geom('geom1').feature('copy10').set('disply', 'Rp*1.23*4');
model.geom('geom1').run('copy10');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'Rp*1.8' 'Rp*2.0889+L_sep+Rp*14.76' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'Rp*3.2', 2);
model.geom('geom1').feature('blk1').set('pos', {'-Rp*0.45' '-Rp*4/9-Rp*7.38' '0'});
model.geom('geom1').feature('blk1').setIndex('pos', '-Rp*0.8', 2);
model.geom('geom1').run('blk1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'blk1'});
model.geom('geom1').feature('uni1').set('repairtoltype', 'relative');
model.geom('geom1').run('uni1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'copy1' 'copy10' 'copy2' 'copy3' 'copy4' 'copy5' 'copy6' 'copy7' 'copy8' 'copy9'  ...
'elp1' 'elp2' 'elp3' 'elp4'});
model.geom('geom1').feature('dif1').set('repairtoltype', 'relative');
model.geom('geom1').run('dif1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'Rp*1.8' 'Rp*2.0889+L_sep+Rp*14.76' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'Rp*3.2', 2);
model.geom('geom1').feature('blk2').set('pos', {'-Rp*0.45' '-Rp*4/9-Rp*7.38' '0'});
model.geom('geom1').feature('blk2').setIndex('pos', '-Rp*0.8', 2);
model.geom('geom1').run('blk2');
model.geom('geom1').feature('fin').set('repairtoltype', 'relative');
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Electrolyte');
model.geom('geom1').feature('sel1').selection('selection').set('fin', 1);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Negative electrode');
model.geom('geom1').feature('sel2').selection('selection').set('fin', 3);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Positive electrode');
model.geom('geom1').feature('sel3').selection('selection').set('fin', 2);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Negative electrode surface');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('fin', [86 87 89 90 91 92 93 94 96 97 99 100 101 102 103 104 106 107 109 110 111 112 113 114 116 117 119 120 121 122 123 124 126 127 129 130 131 132 133 134 136 137 139 140 141 142 143 144 146 147 149 150 151 152 153 154 156 157 159 160 161 162 163 164 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Positive electrode surface');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('fin', [6 7 9 10 11 12 13 14 16 17 19 20 21 22 23 24 26 27 29 30 31 32 33 34 36 37 39 40 41 42 43 44 46 47 49 50 51 52 53 54 56 57 59 60 61 62 63 64 66 67 69 70 71 72 73 74 76 77 79 80 81 82 83 84 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('sel6', 'ExplicitSelection');
model.geom('geom1').feature('sel6').label('Negative current collector');
model.geom('geom1').feature('sel6').selection('selection').init(2);
model.geom('geom1').feature('sel6').selection('selection').set('fin', [184 185 460 461]);
model.geom('geom1').run('sel6');
model.geom('geom1').create('sel7', 'ExplicitSelection');
model.geom('geom1').feature('sel7').label('Positive current collector');
model.geom('geom1').feature('sel7').selection('selection').init(2);
model.geom('geom1').feature('sel7').selection('selection').set('fin', [182 183 458 459]);
model.geom('geom1').run('sel7');
model.geom('geom1').run('sel7');
model.geom('geom1').create('sel8', 'ExplicitSelection');
model.geom('geom1').feature('sel8').label('Roller condition boundaries');
model.geom('geom1').feature('sel8').selection('selection').init(2);
model.geom('geom1').feature('sel8').selection('selection').set('fin', [85 88 95 98 105 108 115 118 125 128 135 138 145 148 155 158 174 175 176 177 178 179 180 181 450 451 452 453 454 455 456 457 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622]);

model.title([]);

model.description('');

model.label('heterogeneous_li_battery_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
