package com.ankamagames.jerakine.utils.misc
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class AsyncJPGEncoder extends Object
    {
        private const ZigZag:Vector.<int>;
        private var YTable:Vector.<int>;
        private var UVTable:Vector.<int>;
        private var outputfDCTQuant:Vector.<int>;
        private var fdtbl_Y:Vector.<Number>;
        private var fdtbl_UV:Vector.<Number>;
        private var sf:int;
        private const aasf:Vector.<Number>;
        private var YQT:Vector.<int>;
        private const UVQT:Vector.<int>;
        private var YDC_HT:Vector.<BitString>;
        private var UVDC_HT:Vector.<BitString>;
        private var YAC_HT:Vector.<BitString>;
        private var UVAC_HT:Vector.<BitString>;
        private var std_dc_luminance_nrcodes:Vector.<int>;
        private var std_dc_luminance_values:Vector.<int>;
        private var std_ac_luminance_nrcodes:Vector.<int>;
        private var std_ac_luminance_values:Vector.<int>;
        private var std_dc_chrominance_nrcodes:Vector.<int>;
        private var std_dc_chrominance_values:Vector.<int>;
        private var std_ac_chrominance_nrcodes:Vector.<int>;
        private var std_ac_chrominance_values:Vector.<int>;
        private var bitcode:Vector.<BitString>;
        private var category:Vector.<int>;
        private var byteout:ByteArray;
        private var bytenew:int = 0;
        private var bytepos:int = 7;
        var DU:Vector.<int>;
        private var YDU:Vector.<Number>;
        private var UDU:Vector.<Number>;
        private var VDU:Vector.<Number>;
        private var _width:int;
        private var _height:int;
        private var _DCY:Number;
        private var _DCU:Number;
        private var _DCV:Number;
        private var _ypos:int;
        private var _xpos:int;
        private var _image:BitmapData;
        private var _callBack:Function;
        private var _param:Object;
        private var _lastFrame:int;
        private var _maxTime:int;

        public function AsyncJPGEncoder(param1:int = 50)
        {
            this.ZigZag = this.Vector.<int>([0, 1, 5, 6, 14, 15, 27, 28, 2, 4, 7, 13, 16, 26, 29, 42, 3, 8, 12, 17, 25, 30, 41, 43, 9, 11, 18, 24, 31, 40, 44, 53, 10, 19, 23, 32, 39, 45, 52, 54, 20, 22, 33, 38, 46, 51, 55, 60, 21, 34, 37, 47, 50, 56, 59, 61, 35, 36, 48, 49, 57, 58, 62, 63]);
            this.YTable = new Vector.<int>(64, true);
            this.UVTable = new Vector.<int>(64, true);
            this.outputfDCTQuant = new Vector.<int>(64, true);
            this.fdtbl_Y = new Vector.<Number>(64, true);
            this.fdtbl_UV = new Vector.<Number>(64, true);
            this.aasf = this.Vector.<Number>([1, 1.38704, 1.30656, 1.17588, 1, 0.785695, 0.541196, 0.275899]);
            this.YQT = this.Vector.<int>([16, 11, 10, 16, 24, 40, 51, 61, 12, 12, 14, 19, 26, 58, 60, 55, 14, 13, 16, 24, 40, 57, 69, 56, 14, 17, 22, 29, 51, 87, 80, 62, 18, 22, 37, 56, 68, 109, 103, 77, 24, 35, 55, 64, 81, 104, 113, 92, 49, 64, 78, 87, 103, 121, 120, 101, 72, 92, 95, 98, 112, 100, 103, 99]);
            this.UVQT = this.Vector.<int>([17, 18, 24, 47, 99, 99, 99, 99, 18, 21, 26, 66, 99, 99, 99, 99, 24, 26, 56, 99, 99, 99, 99, 99, 47, 66, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99]);
            this.std_dc_luminance_nrcodes = this.Vector.<int>([0, 0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]);
            this.std_dc_luminance_values = this.Vector.<int>([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
            this.std_ac_luminance_nrcodes = this.Vector.<int>([0, 0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 125]);
            this.std_ac_luminance_values = this.Vector.<int>([1, 2, 3, 0, 4, 17, 5, 18, 33, 49, 65, 6, 19, 81, 97, 7, 34, 113, 20, 50, 129, 145, 161, 8, 35, 66, 177, 193, 21, 82, 209, 240, 36, 51, 98, 114, 130, 9, 10, 22, 23, 24, 25, 26, 37, 38, 39, 40, 41, 42, 52, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250]);
            this.std_dc_chrominance_nrcodes = this.Vector.<int>([0, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0]);
            this.std_dc_chrominance_values = this.Vector.<int>([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
            this.std_ac_chrominance_nrcodes = this.Vector.<int>([0, 0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 119]);
            this.std_ac_chrominance_values = this.Vector.<int>([0, 1, 2, 3, 17, 4, 5, 33, 49, 6, 18, 65, 81, 7, 97, 113, 19, 34, 50, 129, 8, 20, 66, 145, 161, 177, 193, 9, 35, 51, 82, 240, 21, 98, 114, 209, 10, 22, 36, 52, 225, 37, 241, 23, 24, 25, 26, 38, 39, 40, 41, 42, 53, 54, 55, 56, 57, 58, 67, 68, 69, 70, 71, 72, 73, 74, 83, 84, 85, 86, 87, 88, 89, 90, 99, 100, 101, 102, 103, 104, 105, 106, 115, 116, 117, 118, 119, 120, 121, 122, 130, 131, 132, 133, 134, 135, 136, 137, 138, 146, 147, 148, 149, 150, 151, 152, 153, 154, 162, 163, 164, 165, 166, 167, 168, 169, 170, 178, 179, 180, 181, 182, 183, 184, 185, 186, 194, 195, 196, 197, 198, 199, 200, 201, 202, 210, 211, 212, 213, 214, 215, 216, 217, 218, 226, 227, 228, 229, 230, 231, 232, 233, 234, 242, 243, 244, 245, 246, 247, 248, 249, 250]);
            this.bitcode = new Vector.<BitString>(65535, true);
            this.category = new Vector.<int>(65535, true);
            this.DU = new Vector.<int>(64, true);
            this.YDU = new Vector.<Number>(64, true);
            this.UDU = new Vector.<Number>(64, true);
            this.VDU = new Vector.<Number>(64, true);
            if (param1 <= 0)
            {
                param1 = 1;
            }
            if (param1 > 100)
            {
                param1 = 100;
            }
            this.sf = param1 < 50 ? (int(5000 / param1)) : (int(200 - (param1 << 1)));
            this.init();
            return;
        }// end function

        private function initQuantTables(param1:int) : void
        {
            var _loc_2:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_3:int = 64;
            var _loc_4:int = 8;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_6 = int((this.YQT[_loc_2] * param1 + 50) * 0.01);
                if (_loc_6 < 1)
                {
                    _loc_6 = 1;
                }
                else if (_loc_6 > 255)
                {
                    _loc_6 = 255;
                }
                this.YTable[this.ZigZag[_loc_2]] = _loc_6;
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_7 = int((this.UVQT[_loc_2] * param1 + 50) * 0.01);
                if (_loc_7 < 1)
                {
                    _loc_7 = 1;
                }
                else if (_loc_7 > 255)
                {
                    _loc_7 = 255;
                }
                this.UVTable[this.ZigZag[_loc_2]] = _loc_7;
                _loc_2++;
            }
            _loc_2 = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = 0;
                while (_loc_8 < _loc_4)
                {
                    
                    this.fdtbl_Y[_loc_2] = 1 / (this.YTable[this.ZigZag[_loc_2]] * this.aasf[_loc_5] * this.aasf[_loc_8] * _loc_4);
                    this.fdtbl_UV[_loc_2] = 1 / (this.UVTable[this.ZigZag[_loc_2]] * this.aasf[_loc_5] * this.aasf[_loc_8] * _loc_4);
                    _loc_2++;
                    _loc_8++;
                }
                _loc_5++;
            }
            return;
        }// end function

        private function computeHuffmanTbl(param1:Vector.<int>, param2:Vector.<int>) : Vector.<BitString>
        {
            var _loc_6:BitString = null;
            var _loc_8:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:* = new Vector.<BitString>(251, true);
            var _loc_7:int = 1;
            while (_loc_7 <= 16)
            {
                
                _loc_8 = 1;
                while (_loc_8 <= param1[_loc_7])
                {
                    
                    var _loc_9:* = new BitString();
                    _loc_6 = new BitString();
                    _loc_5[param2[_loc_4]] = _loc_9;
                    _loc_6.val = _loc_3;
                    _loc_6.len = _loc_7;
                    _loc_4++;
                    _loc_3++;
                    _loc_8++;
                }
                _loc_3 = _loc_3 << 1;
                _loc_7++;
            }
            return _loc_5;
        }// end function

        private function initHuffmanTbl() : void
        {
            this.YDC_HT = this.computeHuffmanTbl(this.std_dc_luminance_nrcodes, this.std_dc_luminance_values);
            this.UVDC_HT = this.computeHuffmanTbl(this.std_dc_chrominance_nrcodes, this.std_dc_chrominance_values);
            this.YAC_HT = this.computeHuffmanTbl(this.std_ac_luminance_nrcodes, this.std_ac_luminance_values);
            this.UVAC_HT = this.computeHuffmanTbl(this.std_ac_chrominance_nrcodes, this.std_ac_chrominance_values);
            return;
        }// end function

        private function initCategoryNumber() : void
        {
            var _loc_3:BitString = null;
            var _loc_5:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_1:int = 1;
            var _loc_2:int = 2;
            var _loc_4:int = 15;
            var _loc_6:int = 1;
            while (_loc_6 <= _loc_4)
            {
                
                _loc_7 = _loc_1;
                while (_loc_7 < _loc_2)
                {
                    
                    _loc_5 = int(32767 + _loc_7);
                    this.category[_loc_5] = _loc_6;
                    var _loc_9:* = new BitString();
                    _loc_3 = new BitString();
                    this.bitcode[_loc_5] = _loc_9;
                    _loc_3.len = _loc_6;
                    _loc_3.val = _loc_7;
                    _loc_7++;
                }
                _loc_8 = -(_loc_2 - 1);
                while (_loc_8 <= -_loc_1)
                {
                    
                    _loc_5 = int(32767 + _loc_8);
                    this.category[_loc_5] = _loc_6;
                    var _loc_9:* = new BitString();
                    _loc_3 = new BitString();
                    this.bitcode[_loc_5] = _loc_9;
                    _loc_3.len = _loc_6;
                    _loc_3.val = (_loc_2 - 1) + _loc_8;
                    _loc_8++;
                }
                _loc_1 = _loc_1 << 1;
                _loc_2 = _loc_2 << 1;
                _loc_6++;
            }
            return;
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
                var _loc_4:String = this;
                var _loc_5:* = this.bytepos - 1;
                _loc_4.bytepos = _loc_5;
                if (this.bytepos < 0)
                {
                    if (this.bytenew == 255)
                    {
                        this.byteout.writeByte(255);
                        this.byteout.writeByte(0);
                    }
                    else
                    {
                        this.byteout.writeByte(this.bytenew);
                    }
                    this.bytepos = 7;
                    this.bytenew = 0;
                }
            }
            return;
        }// end function

        private function fDCTQuant(param1:Vector.<Number>, param2:Vector.<Number>) : Vector.<int>
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:int = 0;
            var _loc_15:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:Number = NaN;
            var _loc_22:Number = NaN;
            var _loc_23:Number = NaN;
            var _loc_24:Number = NaN;
            var _loc_25:Number = NaN;
            var _loc_26:Number = NaN;
            var _loc_27:Number = NaN;
            var _loc_28:Number = NaN;
            var _loc_29:Number = NaN;
            var _loc_30:Number = NaN;
            var _loc_31:Number = NaN;
            var _loc_32:Number = NaN;
            var _loc_33:Number = NaN;
            var _loc_34:Number = NaN;
            var _loc_35:Number = NaN;
            var _loc_36:Number = NaN;
            var _loc_37:Number = NaN;
            var _loc_38:Number = NaN;
            var _loc_39:Number = NaN;
            var _loc_40:Number = NaN;
            var _loc_41:Number = NaN;
            var _loc_42:Number = NaN;
            var _loc_43:Number = NaN;
            var _loc_44:Number = NaN;
            var _loc_45:Number = NaN;
            var _loc_46:Number = NaN;
            var _loc_47:Number = NaN;
            var _loc_48:Number = NaN;
            var _loc_49:Number = NaN;
            var _loc_50:Number = NaN;
            var _loc_51:Number = NaN;
            var _loc_52:Number = NaN;
            var _loc_53:Number = NaN;
            var _loc_3:int = 0;
            var _loc_13:int = 8;
            var _loc_14:int = 64;
            _loc_12 = 0;
            while (_loc_12 < _loc_13)
            {
                
                _loc_4 = param1[int(_loc_3)];
                _loc_5 = param1[int((_loc_3 + 1))];
                _loc_6 = param1[int(_loc_3 + 2)];
                _loc_7 = param1[int(_loc_3 + 3)];
                _loc_8 = param1[int(_loc_3 + 4)];
                _loc_9 = param1[int(_loc_3 + 5)];
                _loc_10 = param1[int(_loc_3 + 6)];
                _loc_11 = param1[int(_loc_3 + 7)];
                _loc_16 = _loc_4 + _loc_11;
                _loc_17 = _loc_4 - _loc_11;
                _loc_18 = _loc_5 + _loc_10;
                _loc_19 = _loc_5 - _loc_10;
                _loc_20 = _loc_6 + _loc_9;
                _loc_21 = _loc_6 - _loc_9;
                _loc_22 = _loc_7 + _loc_8;
                _loc_23 = _loc_7 - _loc_8;
                _loc_24 = _loc_16 + _loc_22;
                _loc_25 = _loc_16 - _loc_22;
                _loc_26 = _loc_18 + _loc_20;
                _loc_27 = _loc_18 - _loc_20;
                param1[int(_loc_3)] = _loc_24 + _loc_26;
                param1[int(_loc_3 + 4)] = _loc_24 - _loc_26;
                _loc_28 = (_loc_27 + _loc_25) * 0.707107;
                param1[int(_loc_3 + 2)] = _loc_25 + _loc_28;
                param1[int(_loc_3 + 6)] = _loc_25 - _loc_28;
                _loc_24 = _loc_23 + _loc_21;
                _loc_26 = _loc_21 + _loc_19;
                _loc_27 = _loc_19 + _loc_17;
                _loc_29 = (_loc_24 - _loc_27) * 0.382683;
                _loc_30 = 0.541196 * _loc_24 + _loc_29;
                _loc_31 = 1.30656 * _loc_27 + _loc_29;
                _loc_32 = _loc_26 * 0.707107;
                _loc_33 = _loc_17 + _loc_32;
                _loc_34 = _loc_17 - _loc_32;
                param1[int(_loc_3 + 5)] = _loc_34 + _loc_30;
                param1[int(_loc_3 + 3)] = _loc_34 - _loc_30;
                param1[int((_loc_3 + 1))] = _loc_33 + _loc_31;
                param1[int(_loc_3 + 7)] = _loc_33 - _loc_31;
                _loc_3 = _loc_3 + 8;
                _loc_12++;
            }
            _loc_3 = 0;
            _loc_12 = 0;
            while (_loc_12 < _loc_13)
            {
                
                _loc_4 = param1[int(_loc_3)];
                _loc_5 = param1[int(_loc_3 + 8)];
                _loc_6 = param1[int(_loc_3 + 16)];
                _loc_7 = param1[int(_loc_3 + 24)];
                _loc_8 = param1[int(_loc_3 + 32)];
                _loc_9 = param1[int(_loc_3 + 40)];
                _loc_10 = param1[int(_loc_3 + 48)];
                _loc_11 = param1[int(_loc_3 + 56)];
                _loc_35 = _loc_4 + _loc_11;
                _loc_36 = _loc_4 - _loc_11;
                _loc_37 = _loc_5 + _loc_10;
                _loc_38 = _loc_5 - _loc_10;
                _loc_39 = _loc_6 + _loc_9;
                _loc_40 = _loc_6 - _loc_9;
                _loc_41 = _loc_7 + _loc_8;
                _loc_42 = _loc_7 - _loc_8;
                _loc_43 = _loc_35 + _loc_41;
                _loc_44 = _loc_35 - _loc_41;
                _loc_45 = _loc_37 + _loc_39;
                _loc_46 = _loc_37 - _loc_39;
                param1[int(_loc_3)] = _loc_43 + _loc_45;
                param1[int(_loc_3 + 32)] = _loc_43 - _loc_45;
                _loc_47 = (_loc_46 + _loc_44) * 0.707107;
                param1[int(_loc_3 + 16)] = _loc_44 + _loc_47;
                param1[int(_loc_3 + 48)] = _loc_44 - _loc_47;
                _loc_43 = _loc_42 + _loc_40;
                _loc_45 = _loc_40 + _loc_38;
                _loc_46 = _loc_38 + _loc_36;
                _loc_48 = (_loc_43 - _loc_46) * 0.382683;
                _loc_49 = 0.541196 * _loc_43 + _loc_48;
                _loc_50 = 1.30656 * _loc_46 + _loc_48;
                _loc_51 = _loc_45 * 0.707107;
                _loc_52 = _loc_36 + _loc_51;
                _loc_53 = _loc_36 - _loc_51;
                param1[int(_loc_3 + 40)] = _loc_53 + _loc_49;
                param1[int(_loc_3 + 24)] = _loc_53 - _loc_49;
                param1[int(_loc_3 + 8)] = _loc_52 + _loc_50;
                param1[int(_loc_3 + 56)] = _loc_52 - _loc_50;
                _loc_3++;
                _loc_12++;
            }
            _loc_12 = 0;
            while (_loc_12 < _loc_14)
            {
                
                _loc_15 = param1[int(_loc_12)] * param2[int(_loc_12)];
                this.outputfDCTQuant[int(_loc_12)] = _loc_15 > 0 ? (int(_loc_15 + 0.5)) : (int(_loc_15 - 0.5));
                _loc_12++;
            }
            return this.outputfDCTQuant;
        }// end function

        private function writeAPP0() : void
        {
            this.byteout.writeShort(65504);
            this.byteout.writeShort(16);
            this.byteout.writeByte(74);
            this.byteout.writeByte(70);
            this.byteout.writeByte(73);
            this.byteout.writeByte(70);
            this.byteout.writeByte(0);
            this.byteout.writeByte(1);
            this.byteout.writeByte(1);
            this.byteout.writeByte(0);
            this.byteout.writeShort(1);
            this.byteout.writeShort(1);
            this.byteout.writeByte(0);
            this.byteout.writeByte(0);
            return;
        }// end function

        private function writeSOF0(param1:int, param2:int) : void
        {
            this.byteout.writeShort(65472);
            this.byteout.writeShort(17);
            this.byteout.writeByte(8);
            this.byteout.writeShort(param2);
            this.byteout.writeShort(param1);
            this.byteout.writeByte(3);
            this.byteout.writeByte(1);
            this.byteout.writeByte(17);
            this.byteout.writeByte(0);
            this.byteout.writeByte(2);
            this.byteout.writeByte(17);
            this.byteout.writeByte(1);
            this.byteout.writeByte(3);
            this.byteout.writeByte(17);
            this.byteout.writeByte(1);
            return;
        }// end function

        private function writeDQT() : void
        {
            var _loc_1:int = 0;
            this.byteout.writeShort(65499);
            this.byteout.writeShort(132);
            this.byteout.writeByte(0);
            var _loc_2:int = 64;
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this.byteout.writeByte(this.YTable[_loc_1]);
                _loc_1++;
            }
            this.byteout.writeByte(1);
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this.byteout.writeByte(this.UVTable[_loc_1]);
                _loc_1++;
            }
            return;
        }// end function

        private function writeDHT() : void
        {
            var _loc_1:int = 0;
            this.byteout.writeShort(65476);
            this.byteout.writeShort(418);
            this.byteout.writeByte(0);
            var _loc_2:int = 11;
            var _loc_3:int = 16;
            var _loc_4:int = 161;
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this.byteout.writeByte(this.std_dc_luminance_nrcodes[int((_loc_1 + 1))]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= _loc_2)
            {
                
                this.byteout.writeByte(this.std_dc_luminance_values[int(_loc_1)]);
                _loc_1++;
            }
            this.byteout.writeByte(16);
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this.byteout.writeByte(this.std_ac_luminance_nrcodes[int((_loc_1 + 1))]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= _loc_4)
            {
                
                this.byteout.writeByte(this.std_ac_luminance_values[int(_loc_1)]);
                _loc_1++;
            }
            this.byteout.writeByte(1);
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this.byteout.writeByte(this.std_dc_chrominance_nrcodes[int((_loc_1 + 1))]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= _loc_2)
            {
                
                this.byteout.writeByte(this.std_dc_chrominance_values[int(_loc_1)]);
                _loc_1++;
            }
            this.byteout.writeByte(17);
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this.byteout.writeByte(this.std_ac_chrominance_nrcodes[int((_loc_1 + 1))]);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 <= _loc_4)
            {
                
                this.byteout.writeByte(this.std_ac_chrominance_values[int(_loc_1)]);
                _loc_1++;
            }
            return;
        }// end function

        private function writeSOS() : void
        {
            this.byteout.writeShort(65498);
            this.byteout.writeShort(12);
            this.byteout.writeByte(3);
            this.byteout.writeByte(1);
            this.byteout.writeByte(0);
            this.byteout.writeByte(2);
            this.byteout.writeByte(17);
            this.byteout.writeByte(3);
            this.byteout.writeByte(17);
            this.byteout.writeByte(0);
            this.byteout.writeByte(63);
            this.byteout.writeByte(0);
            return;
        }// end function

        private function processDU(param1:Vector.<Number>, param2:Vector.<Number>, param3:Number, param4:Vector.<BitString>, param5:Vector.<BitString>) : Number
        {
            var _loc_8:int = 0;
            var _loc_17:int = 0;
            var _loc_18:int = 0;
            var _loc_19:int = 0;
            var _loc_20:int = 0;
            var _loc_6:* = param5[0];
            var _loc_7:* = param5[240];
            var _loc_9:int = 16;
            var _loc_10:int = 63;
            var _loc_11:int = 64;
            var _loc_12:* = this.fDCTQuant(param1, param2);
            var _loc_13:int = 0;
            while (_loc_13 < _loc_11)
            {
                
                this.DU[this.ZigZag[_loc_13]] = _loc_12[_loc_13];
                _loc_13++;
            }
            var _loc_14:* = this.DU[0] - param3;
            param3 = this.DU[0];
            if (_loc_14 == 0)
            {
                this.writeBits(param4[0]);
            }
            else
            {
                _loc_8 = int(32767 + _loc_14);
                this.writeBits(param4[this.category[_loc_8]]);
                this.writeBits(this.bitcode[_loc_8]);
            }
            var _loc_15:int = 63;
            while (_loc_15 > 0 && this.DU[_loc_15] == 0)
            {
                
                _loc_15 = _loc_15 - 1;
            }
            if (_loc_15 == 0)
            {
                this.writeBits(_loc_6);
                return param3;
            }
            var _loc_16:int = 1;
            while (_loc_16 <= _loc_15)
            {
                
                _loc_18 = _loc_16;
                while (this.DU[_loc_16] == 0 && _loc_16 <= _loc_15)
                {
                    
                    _loc_16++;
                }
                _loc_19 = _loc_16 - _loc_18;
                if (_loc_19 >= _loc_9)
                {
                    _loc_17 = _loc_19 >> 4;
                    _loc_20 = 1;
                    while (_loc_20 <= _loc_17)
                    {
                        
                        this.writeBits(_loc_7);
                        _loc_20++;
                    }
                    _loc_19 = int(_loc_19 & 15);
                }
                _loc_8 = int(32767 + this.DU[_loc_16]);
                this.writeBits(param5[int((_loc_19 << 4) + this.category[_loc_8])]);
                this.writeBits(this.bitcode[_loc_8]);
                _loc_16++;
            }
            if (_loc_15 != _loc_10)
            {
                this.writeBits(_loc_6);
            }
            return param3;
        }// end function

        private function RGB2YUV(param1:BitmapData, param2:int, param3:int) : void
        {
            var _loc_7:int = 0;
            var _loc_8:uint = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 8;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    _loc_8 = param1.getPixel32(param2 + _loc_7, param3 + _loc_6);
                    _loc_9 = _loc_8 >> 16 & 255;
                    _loc_10 = _loc_8 >> 8 & 255;
                    _loc_11 = _loc_8 & 255;
                    this.YDU[int(_loc_4)] = 0.299 * _loc_9 + 0.587 * _loc_10 + 0.114 * _loc_11 - 128;
                    this.UDU[int(_loc_4)] = -0.16874 * _loc_9 + -0.33126 * _loc_10 + 0.5 * _loc_11;
                    this.VDU[int(_loc_4)] = 0.5 * _loc_9 + -0.41869 * _loc_10 + -0.08131 * _loc_11;
                    _loc_4++;
                    _loc_7++;
                }
                _loc_6++;
            }
            return;
        }// end function

        private function init() : void
        {
            this.ZigZag.fixed = true;
            this.aasf.fixed = true;
            this.YQT.fixed = true;
            this.UVQT.fixed = true;
            this.std_ac_chrominance_nrcodes.fixed = true;
            this.std_ac_chrominance_values.fixed = true;
            this.std_ac_luminance_nrcodes.fixed = true;
            this.std_ac_luminance_values.fixed = true;
            this.std_dc_chrominance_nrcodes.fixed = true;
            this.std_dc_chrominance_values.fixed = true;
            this.std_dc_luminance_nrcodes.fixed = true;
            this.std_dc_luminance_values.fixed = true;
            this.initHuffmanTbl();
            this.initCategoryNumber();
            this.initQuantTables(this.sf);
            return;
        }// end function

        private function process(event:Event) : void
        {
            FpsManager.getInstance().startTracking("processJPG", 1243644);
            var _loc_2:* = getTimer();
            while (true)
            {
                
                this.RGB2YUV(this._image, this._xpos, this._ypos);
                this._DCY = this.processDU(this.YDU, this.fdtbl_Y, this._DCY, this.YDC_HT, this.YAC_HT);
                this._DCU = this.processDU(this.UDU, this.fdtbl_UV, this._DCU, this.UVDC_HT, this.UVAC_HT);
                this._DCV = this.processDU(this.VDU, this.fdtbl_UV, this._DCV, this.UVDC_HT, this.UVAC_HT);
                this._xpos = this._xpos + 8;
                if (this._xpos >= this._width)
                {
                    this._xpos = 0;
                    this._ypos = this._ypos + 8;
                    if (this._ypos >= this._height)
                    {
                        EnterFrameDispatcher.removeEventListener(this.process);
                        this.endProcess();
                        return;
                    }
                }
                if (getTimer() - _loc_2 > this._maxTime)
                {
                    break;
                }
            }
            var _loc_3:* = _loc_2 - this._lastFrame;
            this._lastFrame = _loc_2;
            if (_loc_3 > 20)
            {
                this._maxTime = this._maxTime - 2;
                if (this._maxTime < 1)
                {
                    this._maxTime = 1;
                }
            }
            else
            {
                var _loc_4:String = this;
                var _loc_5:* = this._maxTime + 1;
                _loc_4._maxTime = _loc_5;
            }
            FpsManager.getInstance().stopTracking("processJPG");
            return;
        }// end function

        public function encode(param1:BitmapData, param2:Function, param3:Object) : void
        {
            EnterFrameDispatcher.addEventListener(this.process, "jpgEncoder");
            this._image = param1;
            this._callBack = param2;
            this._param = param3;
            this._maxTime = 10;
            this.byteout = new ByteArray();
            this.bytenew = 0;
            this.bytepos = 7;
            this.byteout.writeShort(65496);
            this.writeAPP0();
            this.writeDQT();
            this.writeSOF0(param1.width, param1.height);
            this.writeDHT();
            this.writeSOS();
            this._DCY = 0;
            this._DCU = 0;
            this._DCV = 0;
            this.bytenew = 0;
            this.bytepos = 7;
            this._width = param1.width;
            this._height = param1.height;
            this._ypos = 0;
            this._xpos = 0;
            return;
        }// end function

        private function endProcess() : void
        {
            var _loc_1:BitString = null;
            if (this.bytepos >= 0)
            {
                _loc_1 = new BitString();
                _loc_1.len = this.bytepos + 1;
                _loc_1.val = (1 << (this.bytepos + 1)) - 1;
                this.writeBits(_loc_1);
            }
            this.byteout.writeShort(65497);
            this._callBack(this.byteout, this._param);
            return;
        }// end function

    }
}

class BitString extends Object
{
    public var len:int = 0;
    public var val:int = 0;

    function BitString()
    {
        return;
    }// end function

}

