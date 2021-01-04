# LBlockUART
When we input data, we should ensure that the LSB of data is input first.
For example, when we want to input 0x01_23_45_67_89_ab_cd_ef, we should 
input:
	ef cd ab 89 67 45 23 01
and we will get:
	26 0C EE EB D8 79 71 4B DC FE EF CD AB 89 67 45 23 01
, which is the Low Bit Priority Output of {Kin, Dout}.
