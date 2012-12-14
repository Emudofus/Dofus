package mx.graphics.codec
{
    import flash.display.*;
    import flash.utils.*;
    import mx.graphics.codec.*;

    public class JPEGEncoder extends Object implements IImageEncoder
    {
        private const std_dc_luminance_nrcodes:Array;
        private const std_dc_luminance_values:Array;
        private const std_dc_chrominance_nrcodes:Array;
        private const std_dc_chrominance_values:Array;
        private const std_ac_luminance_nrcodes:Array;
        private const std_ac_luminance_values:Array;
        private const std_ac_chrominance_nrcodes:Array;
        private const std_ac_chrominance_values:Array;
        private const ZigZag:Array;
        private var YDC_HT:Array;
        private var UVDC_HT:Array;
        private var YAC_HT:Array;
        private var UVAC_HT:Array;
        private var category:Array;
        private var bitcode:Array;
        private var YTable:Array;
        private var UVTable:Array;
        private var fdtbl_Y:Array;
        private var fdtbl_UV:Array;
        private var byteout:ByteArray;
        private var bytenew:int = 0;
        private var bytepos:int = 7;
        private var DU:Array;
        private var YDU:Array;
        private var UDU:Array;
        private var VDU:Array;
        static const VERSION:String = "4.6.0.23201";
        private static const CONTENT_TYPE:String = "image/jpeg";

        public function JPEGEncoder(param1:Number = 50)
        {
            this.std_dc_luminance_nrcodes = [0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0];
            this.std_dc_luminance_values = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
            this.std_dc_chrominance_nrcodes = [0, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0];
            this.std_dc_chrominance_values = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
            this.std_ac_luminance_nrcodes = [0, 0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 125];
            this.std_ac_luminance_values = [1, 2, 3, 0, 4, 17, 5, 18, 33, 49, 65, 6, 19, 81, 97, 7, 34, 113, 20, 50, 129, 145, 161, 8, 35, 66, 177, 193, 21, 82, 209, 240, 36, 51, 98, 114, 130, 9, 10, 22, 23, 24, 25, 26, 37, 38, 39, 40, 41, 42, 52, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250];
            this.std_ac_chrominance_nrcodes = [0, 0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 119];
            this.std_ac_chrominance_values = [0, 1, 2, 3, 17, 4, 5, 33, 49, 6, 18, 65, 81, 7, 97, 113, 19, 34, 50, 129, 8, 20, 66, 145, 161, 177, 193, 9, 35, 51, 82, 240, 21, 98, 114, 209, 10, 22, 36, 52, 225, 37, 241, 23, 24, 25, 26, 38, 39, 40, 41, 42, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 130, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 226, 227, 228, 229, 230, 231, 232, 233, 234, 242, 243, 244, 245, 246, 247, 248, 249, 250];
            this.ZigZag = [0, 1, 5, 6, 14, 15, 27, 28, 2, 4, 7, 13, 16, 26, 29, 42, 3, 8, 12, 17, 25, 30, 41, 43, 9, 11, 18, 24, 31, 40, 44, 53, 10, 19, 23, 32, 39, 45, 52, 54, 20, 22, 33, 38, 46, 51, 55, 60, 21, 34, 37, 47, 50, 56, 59, 61, 35, 36, 48, 49, 57, 58, 62, 63];
            this.category = new Array(65535);
            this.bitcode = new Array(65535);
            this.YTable = new Array(64);
            this.UVTable = new Array(64);
            this.fdtbl_Y = new Array(64);
            this.fdtbl_UV = new Array(64);
            this.DU = new Array(64);
            this.YDU = new Array(64);
            this.UDU = new Array(64);
            this.VDU = new Array(64);
            if (param1 <= 0)
            {
                param1 = 1;
            }
            if (param1 > 100)
            {
                param1 = 100;
            }
            var _loc_2:* = 0;
            if (param1 < 50)
            {
                _loc_2 = int(5000 / param1);
            }
            else
            {
                _loc_2 = int(200 - param1 * 2);
            }
            this.initHuffmanTbl();
            this.initCategoryNumber();
            this.initQuantTables(_loc_2);
            return;
        }// end function

        public function get contentType() : String
        {
            return CONTENT_TYPE;
        }// end function

        public function encode(param1:BitmapData) : ByteArray
        {
            return this.internalEncode(param1, param1.width, param1.height, param1.transparent);
        }// end function

        public function encodeByteArray(param1:ByteArray, param2:int, param3:int, param4:Boolean = true) : ByteArray
        {
            return this.internalEncode(param1, param2, param3, param4);
        }// end function

        private function initHuffmanTbl() : void
        {
            this.YDC_HT = this.computeHuffmanTbl(this.std_dc_luminance_nrcodes, this.std_dc_luminance_values);
            this.UVDC_HT = this.computeHuffmanTbl(this.std_dc_chrominance_nrcodes, this.std_dc_chrominance_values);
            this.YAC_HT = this.computeHuffmanTbl(this.std_ac_luminance_nrcodes, this.std_ac_luminance_values);
            this.UVAC_HT = this.computeHuffmanTbl(this.std_ac_chrominance_nrcodes, this.std_ac_chrominance_values);
            return;
        }// end function

        private function computeHuffmanTbl(param1:Array, param2:Array) : Array
        {
            var _loc_7:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = [];
            var _loc_6:* = 1;
            while (_loc_6 <= 16)
            {
                
                _loc_7 = 1;
                while (_loc_7 <= param1[_loc_6])
                {
                    
                    _loc_5[param2[_loc_4]] = new BitString();
                    _loc_5[param2[_loc_4]].val = _loc_3;
                    _loc_5[param2[_loc_4]].len = _loc_6;
                    _loc_4++;
                    _loc_3++;
                    _loc_7++;
                }
                _loc_3 = _loc_3 * 2;
                _loc_6++;
            }
            return _loc_5;
        }// end function

        private function initCategoryNumber() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 1;
            var _loc_3:* = 2;
            var _loc_4:* = 1;
            while (_loc_4 <= 15)
            {
                
                _loc_1 = _loc_2;
                while (_loc_1 < _loc_3)
                {
                    
                    this.category[32767 + _loc_1] = _loc_4;
                    this.bitcode[32767 + _loc_1] = new BitString();
                    this.bitcode[32767 + _loc_1].len = _loc_4;
                    this.bitcode[32767 + _loc_1].val = _loc_1;
                    _loc_1++;
                }
                _loc_1 = -(_loc_3 - 1);
                while (_loc_1 <= -_loc_2)
                {
                    
                    this.category[32767 + _loc_1] = _loc_4;
                    this.bitcode[32767 + _loc_1] = new BitString();
                    this.bitcode[32767 + _loc_1].len = _loc_4;
                    this.bitcode[32767 + _loc_1].val = (_loc_3 - 1) + _loc_1;
                    _loc_1++;
                }
                _loc_2 = _loc_2 << 1;
                _loc_3 = _loc_3 << 1;
                _loc_4++;
            }
            return;
        }// end function

        private function initQuantTables(param1:int) : void
        {
            var _loc_3:* = NaN;
            var _loc_8:* = 0;
            var _loc_2:* = 0;
            var _loc_4:* = [16, 11, 10, 16, 24, 40, 51, 61, 12, 12, 14, 19, 26, 58, 60, 55, 14, 13, 16, 24, 40, 57, 69, 56, 14, 17, 22, 29, 51, 87, 80, 62, 18, 22, 37, 56, 68, 109, 103, 77, 24, 35, 55, 64, 81, 104, 113, 92, 49, 64, 78, 87, 103, 121, 120, 101, 72, 92, 95, 98, 112, 100, 103, 99];
            _loc_2 = 0;
            while (_loc_2 < 64)
            {
                
                _loc_3 = Math.floor((_loc_4[_loc_2] * param1 + 50) / 100);
                if (_loc_3 < 1)
                {
                    _loc_3 = 1;
                }
                else if (_loc_3 > 255)
                {
                    _loc_3 = 255;
                }
                this.YTable[this.ZigZag[_loc_2]] = _loc_3;
                _loc_2++;
            }
            var _loc_5:* = [17, 18, 24, 47, 99, 99, 99, 99, 18, 21, 26, 66, 99, 99, 99, 99, 24, 26, 56, 99, 99, 99, 99, 99, 47, 66, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99];
            _loc_2 = 0;
            while (_loc_2 < 64)
            {
                
                _loc_3 = Math.floor((_loc_5[_loc_2] * param1 + 50) / 100);
                if (_loc_3 < 1)
                {
                    _loc_3 = 1;
                }
                else if (_loc_3 > 255)
                {
                    _loc_3 = 255;
                }
                this.UVTable[this.ZigZag[_loc_2]] = _loc_3;
                _loc_2++;
            }
            var _loc_6:* = [1, 1.38704, 1.30656, 1.17588, 1, 0.785695, 0.541196, 0.275899];
            _loc_2 = 0;
            var _loc_7:* = 0;
            while (_loc_7 < 8)
            {
                
                _loc_8 = 0;
                while (_loc_8 < 8)
                {
                    
                    this.fdtbl_Y[_loc_2] = 1 / (this.YTable[this.ZigZag[_loc_2]] * _loc_6[_loc_7] * _loc_6[_loc_8] * 8);
                    this.fdtbl_UV[_loc_2] = 1 / (this.UVTable[this.ZigZag[_loc_2]] * _loc_6[_loc_7] * _loc_6[_loc_8] * 8);
                    _loc_2++;
                    _loc_8++;
                }
                _loc_7++;
            }
            return;
        }// end function

        private function internalEncode(param1:Object, param2:int, param3:int, param4:Boolean = true) : ByteArray
        {
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_5:* = param1 as BitmapData;
            var _loc_6:* = param1 as ByteArray;
            this.byteout = new ByteArray();
            this.bytenew = 0;
            this.bytepos = 7;
            this.writeWord(65496);
            this.writeAPP0();
            this.writeDQT();
            this.writeSOF0(param2, param3);
            this.writeDHT();
            this.writeSOS();
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this.bytenew = 0;
            this.bytepos = 7;
            var _loc_10:* = 0;
            while (_loc_10 < param3)
            {
                
                _loc_11 = 0;
                while (_loc_11 < param2)
                {
                    
                    this.RGB2YUV(_loc_5, _loc_6, _loc_11, _loc_10, param2, param3);
                    _loc_7 = this.processDU(this.YDU, this.fdtbl_Y, _loc_7, this.YDC_HT, this.YAC_HT);
                    _loc_8 = this.processDU(this.UDU, this.fdtbl_UV, _loc_8, this.UVDC_HT, this.UVAC_HT);
                    _loc_9 = this.processDU(this.VDU, this.fdtbl_UV, _loc_9, this.UVDC_HT, this.UVAC_HT);
                    _loc_11 = _loc_11 + 8;
                }
                _loc_10 = _loc_10 + 8;
            }
            if (this.bytepos >= 0)
            {
                _loc_12 = new BitString();
                _loc_12.len = this.bytepos + 1;
                _loc_12.val = (1 << (this.bytepos + 1)) - 1;
                this.writeBits(_loc_12);
            }
            this.writeWord(65497);
            return this.byteout;
        }// end function

        private function RGB2YUV(param1:BitmapData, param2:ByteArray, param3:int, param4:int, param5:int, param6:int) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            while (_loc_8 < 8)
            {
                
                _loc_9 = param4 + _loc_8;
                if (_loc_9 >= param6)
                {
                    _loc_9 = param6 - 1;
                }
                _loc_10 = 0;
                while (_loc_10 < 8)
                {
                    
                    _loc_11 = param3 + _loc_10;
                    if (_loc_11 >= param5)
                    {
                        _loc_11 = param5 - 1;
                    }
                    if (param1)
                    {
                        _loc_12 = param1.getPixel32(_loc_11, _loc_9);
                    }
                    else
                    {
                        param2.position = 4 * (_loc_9 * param5 + _loc_11);
                        _loc_12 = param2.readUnsignedInt();
                    }
                    _loc_13 = Number(_loc_12 >> 16 & 255);
                    _loc_14 = Number(_loc_12 >> 8 & 255);
                    _loc_15 = Number(_loc_12 & 255);
                    this.YDU[_loc_7] = 0.299 * _loc_13 + 0.587 * _loc_14 + 0.114 * _loc_15 - 128;
                    this.UDU[_loc_7] = -0.16874 * _loc_13 - 0.33126 * _loc_14 + 0.5 * _loc_15;
                    this.VDU[_loc_7] = 0.5 * _loc_13 - 0.41869 * _loc_14 - 0.08131 * _loc_15;
                    _loc_7++;
                    _loc_10++;
                }
                _loc_8++;
            }
            return;
        }// end function

        private function processDU(param1:Array, param2:Array, param3:Number, param4:Array, param5:Array) : Number
        {
            var _loc_8:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_6:* = param5[0];
            var _loc_7:* = param5[240];
            var _loc_9:* = this.fDCTQuant(param1, param2);
            _loc_8 = 0;
            while (_loc_8 < 64)
            {
                
                this.DU[this.ZigZag[_loc_8]] = _loc_9[_loc_8];
                _loc_8++;
            }
            var _loc_10:* = this.DU[0] - param3;
            param3 = this.DU[0];
            if (_loc_10 == 0)
            {
                this.writeBits(param4[0]);
            }
            else
            {
                this.writeBits(param4[this.category[32767 + _loc_10]]);
                this.writeBits(this.bitcode[32767 + _loc_10]);
            }
            var _loc_11:* = 63;
            while (_loc_11 > 0 && this.DU[_loc_11] == 0)
            {
                
                _loc_11 = _loc_11 - 1;
            }
            if (_loc_11 == 0)
            {
                this.writeBits(_loc_6);
                return param3;
            }
            _loc_8 = 1;
            while (_loc_8 <= _loc_11)
            {
                
                _loc_12 = _loc_8;
                while (this.DU[_loc_8] == 0 && _loc_8 <= _loc_11)
                {
                    
                    _loc_8++;
                }
                _loc_13 = _loc_8 - _loc_12;
                if (_loc_13 >= 16)
                {
                    _loc_14 = 1;
                    while (_loc_14 <= _loc_13 / 16)
                    {
                        
                        this.writeBits(_loc_7);
                        _loc_14++;
                    }
                    _loc_13 = int(_loc_13 & 15);
                }
                this.writeBits(param5[_loc_13 * 16 + this.category[32767 + this.DU[_loc_8]]]);
                this.writeBits(this.bitcode[32767 + this.DU[_loc_8]]);
                _loc_8++;
            }
            if (_loc_11 != 63)
            {
                this.writeBits(_loc_6);
            }
            return param3;
        }// end function

        private function fDCTQuant(param1:Array, param2:Array) : Array
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_3:* = 0;
            _loc_4 = 0;
            while (_loc_4 < 8)
            {
                
                _loc_5 = param1[_loc_3 + 0] + param1[_loc_3 + 7];
                _loc_6 = param1[_loc_3 + 0] - param1[_loc_3 + 7];
                _loc_7 = param1[(_loc_3 + 1)] + param1[_loc_3 + 6];
                _loc_8 = param1[(_loc_3 + 1)] - param1[_loc_3 + 6];
                _loc_9 = param1[_loc_3 + 2] + param1[_loc_3 + 5];
                _loc_10 = param1[_loc_3 + 2] - param1[_loc_3 + 5];
                _loc_11 = param1[_loc_3 + 3] + param1[_loc_3 + 4];
                _loc_12 = param1[_loc_3 + 3] - param1[_loc_3 + 4];
                _loc_13 = _loc_5 + _loc_11;
                _loc_14 = _loc_5 - _loc_11;
                _loc_15 = _loc_7 + _loc_9;
                _loc_16 = _loc_7 - _loc_9;
                param1[_loc_3 + 0] = _loc_13 + _loc_15;
                param1[_loc_3 + 4] = _loc_13 - _loc_15;
                _loc_17 = (_loc_16 + _loc_14) * 0.707107;
                param1[_loc_3 + 2] = _loc_14 + _loc_17;
                param1[_loc_3 + 6] = _loc_14 - _loc_17;
                _loc_13 = _loc_12 + _loc_10;
                _loc_15 = _loc_10 + _loc_8;
                _loc_16 = _loc_8 + _loc_6;
                _loc_18 = (_loc_13 - _loc_16) * 0.382683;
                _loc_19 = 0.541196 * _loc_13 + _loc_18;
                _loc_20 = 1.30656 * _loc_16 + _loc_18;
                _loc_21 = _loc_15 * 0.707107;
                _loc_22 = _loc_6 + _loc_21;
                _loc_23 = _loc_6 - _loc_21;
                param1[_loc_3 + 5] = _loc_23 + _loc_19;
                param1[_loc_3 + 3] = _loc_23 - _loc_19;
                param1[(_loc_3 + 1)] = _loc_22 + _loc_20;
                param1[_loc_3 + 7] = _loc_22 - _loc_20;
                _loc_3 = _loc_3 + 8;
                _loc_4++;
            }
            _loc_3 = 0;
            _loc_4 = 0;
            while (_loc_4 < 8)
            {
                
                _loc_5 = param1[_loc_3 + 0] + param1[_loc_3 + 56];
                _loc_6 = param1[_loc_3 + 0] - param1[_loc_3 + 56];
                _loc_7 = param1[_loc_3 + 8] + param1[_loc_3 + 48];
                _loc_8 = param1[_loc_3 + 8] - param1[_loc_3 + 48];
                _loc_9 = param1[_loc_3 + 16] + param1[_loc_3 + 40];
                _loc_10 = param1[_loc_3 + 16] - param1[_loc_3 + 40];
                _loc_11 = param1[_loc_3 + 24] + param1[_loc_3 + 32];
                _loc_12 = param1[_loc_3 + 24] - param1[_loc_3 + 32];
                _loc_13 = _loc_5 + _loc_11;
                _loc_14 = _loc_5 - _loc_11;
                _loc_15 = _loc_7 + _loc_9;
                _loc_16 = _loc_7 - _loc_9;
                param1[_loc_3 + 0] = _loc_13 + _loc_15;
                param1[_loc_3 + 32] = _loc_13 - _loc_15;
                _loc_17 = (_loc_16 + _loc_14) * 0.707107;
                param1[_loc_3 + 16] = _loc_14 + _loc_17;
                param1[_loc_3 + 48] = _loc_14 - _loc_17;
                _loc_13 = _loc_12 + _loc_10;
                _loc_15 = _loc_10 + _loc_8;
                _loc_16 = _loc_8 + _loc_6;
                _loc_18 = (_loc_13 - _loc_16) * 0.382683;
                _loc_19 = 0.541196 * _loc_13 + _loc_18;
                _loc_20 = 1.30656 * _loc_16 + _loc_18;
                _loc_21 = _loc_15 * 0.707107;
                _loc_22 = _loc_6 + _loc_21;
                _loc_23 = _loc_6 - _loc_21;
                param1[_loc_3 + 40] = _loc_23 + _loc_19;
                param1[_loc_3 + 24] = _loc_23 - _loc_19;
                param1[_loc_3 + 8] = _loc_22 + _loc_20;
                param1[_loc_3 + 56] = _loc_22 - _loc_20;
                _loc_3++;
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < 64)
            {
                
                param1[_loc_4] = Math.round(param1[_loc_4] * param2[_loc_4]);
                _loc_4++;
            }
            return param1;
        }// end function

        private function writeBits(param1:BitString) : void
        {
            var _loc_2:* = param1.val;
            var _loc_3:* = param1.len - 1;
            while (_loc_3 >= 0)
            {
                
                if (_loc_2 & uint(1 << _loc_3))
                {
                    this.bytenew = this.bytenew | uint(1 << this.bytepos);
                }
                _loc_3 = _loc_3 - 1;
                var _loc_4:* = this;
                var _loc_5:* = this.bytepos - 1;
                _loc_4.bytepos = _loc_5;
                if (this.bytepos < 0)
                {
                    if (this.bytenew == 255)
                    {
                        this.writeByte(255);
                        this.writeByte(0);
                    }
                    else
                    {
                        this.writeByte(this.bytenew);
                    }
                    this.bytepos = 7;
                    this.bytenew = 0;
                }
            }
            return;
        }// end function

        private function writeByte(param1:int) : void
        {
            this.byteout.writeByte(param1);
            return;
        }// end function

        private function writeWord(param1:int) : void
        {
            this.writeByte(param1 >> 8 & 255);
            this.writeByte(param1 & 255);
            return;
        }// end function

        private function writeAPP0() : void
        {
            this.writeWord(65504);
            this.writeWord(16);
            this.writeByte(74);
            this.writeByte(70);
            this.writeByte(73);
            this.writeByte(70);
            this.writeByte(0);
            this.writeByte(1);
            this.writeByte(1);
            this.writeByte(0);
            this.writeWord(1);
            this.writeWord(1);
            this.writeByte(0);
            this.writeByte(0);
            return;
        }// end function

        private function writeDQT() : void
        {
            var _loc_1:* = 0;
            this.writeWord(65499);
            this.writeWord(132);
            this.writeByte(0);
            _loc_1 = 0;
            while (_loc_1 < 64)
            {
                
                this.writeByte(this.YTable[_loc_1]);
                _loc_1++;
            }
            this.writeByte(1);
            _loc_1 = 0;
            while (_loc_1 < 64)
            {
                
                this.writeByte(this.UVTable[_loc_1]);
                _loc_1++;
            }
            return;
        }// end function

        private function writeSOF0(param1:int, param2:int) : void
        {
            this.writeWord(65472);
            this.writeWord(17);
            this.writeByte(8);
            this.writeWord(param2);
            this.writeWord(param1);
            this.writeByte(3);
            this.writeByte(1);
            this.writeByte(17);
            this.writeByte(0);
            this.writeByte(2);
            this.writeByte(17);
            this.writeByte(1);
            this.writeByte(3);
            this.writeByte(17);
            this.writeByte(1);
            return;
        }// end function

        private function writeDHT() : void
        {
            var _loc_1:* = 0;
            this.writeWord(65476);
            this.writeWord(418);
            this.writeByte(0);
            _loc_1 = 0;
            while (_loc_1 < 16)
            {
                
                this.writeByte(this.std_dc_luminance_nrcodes[(_loc_1 + 1)]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= 11)
            {
                
                this.writeByte(this.std_dc_luminance_values[_loc_1]);
                _loc_1++;
            }
            this.writeByte(16);
            _loc_1 = 0;
            while (_loc_1 < 16)
            {
                
                this.writeByte(this.std_ac_luminance_nrcodes[(_loc_1 + 1)]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= 161)
            {
                
                this.writeByte(this.std_ac_luminance_values[_loc_1]);
                _loc_1++;
            }
            this.writeByte(1);
            _loc_1 = 0;
            while (_loc_1 < 16)
            {
                
                this.writeByte(this.std_dc_chrominance_nrcodes[(_loc_1 + 1)]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= 11)
            {
                
                this.writeByte(this.std_dc_chrominance_values[_loc_1]);
                _loc_1++;
            }
            this.writeByte(17);
            _loc_1 = 0;
            while (_loc_1 < 16)
            {
                
                this.writeByte(this.std_ac_chrominance_nrcodes[(_loc_1 + 1)]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= 161)
            {
                
                this.writeByte(this.std_ac_chrominance_values[_loc_1]);
                _loc_1++;
            }
            return;
        }// end function

        private function writeSOS() : void
        {
            this.writeWord(65498);
            this.writeWord(12);
            this.writeByte(3);
            this.writeByte(1);
            this.writeByte(0);
            this.writeByte(2);
            this.writeByte(17);
            this.writeByte(3);
            this.writeByte(17);
            this.writeByte(0);
            this.writeByte(63);
            this.writeByte(0);
            return;
        }// end function

    }
}

import flash.display.*;

import flash.utils.*;

import mx.graphics.codec.*;

final class BitString extends Object
{
    public var len:int = 0;
    public var val:int = 0;

    function BitString()
    {
        return;
    }// end function

}

