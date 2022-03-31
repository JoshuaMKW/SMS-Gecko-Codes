.set setPlayerVelocity, 0x80255734
.set scale_Vec3, 0x8001128C
.set PSVECNormalize, 0x8034A5D0
.set PSVECDotProduct 0x8034A650
.set PSVECMag, 0x8034A614

__push_stack r27, 0x50, TRUE
stfd f31, 0x48 (sp)
stfd f30, 0x40 (sp)
stfd f29, 0x38 (sp)

mr r30, r3
lwz r29, 0xDC (r30)
cmpwi r29, 0
fmr f31, f1
beq- call_velocity

bl down_vec

.float 0.0, -1.0, 0.0

down_vec:
mflr r28
addi r27, sp, 32

addi r3, r29, 0x34
mr r4, r27
__call r12, PSVECNormalize

mr r3, r27
mr r4, r28
__call r12, PSVECDotProduct

mr r3, r27
fmr f30, f1
__call r12, PSVECMag

mr r3, r28
fmr f29, f1
__call r12, PSVECMag

lfs f0, 0xB0 (r30)
fmuls f1, f1, f29
fsubs f0, f0, f31
fmuls f0, f30, f0
fdivs f0, f0, f1
fadds f1, f0, f31

call_velocity:
mr r3, r30
__call r12, setPlayerVelocity


lfd f31, 0x48 (sp)
lfd f30, 0x40 (sp)
lfd f29, 0x38 (sp)

__pop_stack r27, 0x50, TRUE
