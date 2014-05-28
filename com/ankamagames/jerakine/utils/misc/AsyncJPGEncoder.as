package com.ankamagames.jerakine.utils.misc
{
   import flash.utils.ByteArray;
   import flash.display.BitmapData;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   
   public class AsyncJPGEncoder extends Object
   {
      
      public function AsyncJPGEncoder(quality:int = 50) {
         this.ZigZag = Vector.<int>([0,1,5,6,14,15,27,28,2,4,7,13,16,26,29,42,3,8,12,17,25,30,41,43,9,11,18,24,31,40,44,53,10,19,23,32,39,45,52,54,20,22,33,38,46,51,55,60,21,34,37,47,50,56,59,61,35,36,48,49,57,58,62,63]);
         this.YTable = new Vector.<int>(64,true);
         this.UVTable = new Vector.<int>(64,true);
         this.outputfDCTQuant = new Vector.<int>(64,true);
         this.fdtbl_Y = new Vector.<Number>(64,true);
         this.fdtbl_UV = new Vector.<Number>(64,true);
         this.aasf = Vector.<Number>([1,1.387039845,1.306562965,1.175875602,1,0.785694958,0.5411961,0.275899379]);
         this.YQT = Vector.<int>([16,11,10,16,24,40,51,61,12,12,14,19,26,58,60,55,14,13,16,24,40,57,69,56,14,17,22,29,51,87,80,62,18,22,37,56,68,109,103,77,24,35,55,64,81,104,113,92,49,64,78,87,103,121,120,101,72,92,95,98,112,100,103,99]);
         this.UVQT = Vector.<int>([17,18,24,47,99,99,99,99,18,21,26,66,99,99,99,99,24,26,56,99,99,99,99,99,47,66,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99]);
         this.std_dc_luminance_nrcodes = Vector.<int>([0,0,1,5,1,1,1,1,1,1,0,0,0,0,0,0,0]);
         this.std_dc_luminance_values = Vector.<int>([0,1,2,3,4,5,6,7,8,9,10,11]);
         this.std_ac_luminance_nrcodes = Vector.<int>([0,0,2,1,3,3,2,4,3,5,5,4,4,0,0,1,125]);
         this.std_ac_luminance_values = Vector.<int>([1,2,3,0,4,17,5,18,33,49,65,6,19,81,97,7,34,113,20,50,129,145,161,8,35,66,177,193,21,82,209,240,36,51,98,114,130,9,10,22,23,24,25,26,37,38,39,40,41,42,52,53,54,55,56,57,58,67,68,69,70,71,72,73,74,83,84,85,86,87,88,89,90,99,100,101,102,103,104,105,106,115,116,117,118,119,120,121,122,131,132,133,134,135,136,137,138,146,147,148,149,150,151,152,153,154,162,163,164,165,166,167,168,169,170,178,179,180,181,182,183,184,185,186,194,195,196,197,198,199,200,201,202,210,211,212,213,214,215,216,217,218,225,226,227,228,229,230,231,232,233,234,241,242,243,244,245,246,247,248,249,250]);
         this.std_dc_chrominance_nrcodes = Vector.<int>([0,0,3,1,1,1,1,1,1,1,1,1,0,0,0,0,0]);
         this.std_dc_chrominance_values = Vector.<int>([0,1,2,3,4,5,6,7,8,9,10,11]);
         this.std_ac_chrominance_nrcodes = Vector.<int>([0,0,2,1,2,4,4,3,4,7,5,4,4,0,1,2,119]);
         this.std_ac_chrominance_values = Vector.<int>([0,1,2,3,17,4,5,33,49,6,18,65,81,7,97,113,19,34,50,129,8,20,66,145,161,177,193,9,35,51,82,240,21,98,114,209,10,22,36,52,225,37,241,23,24,25,26,38,39,40,41,42,53,54,55,56,57,58,67,68,69,70,71,72,73,74,83,84,85,86,87,88,89,90,99,100,101,102,103,104,105,106,115,116,117,118,119,120,121,122,130,131,132,133,134,135,136,137,138,146,147,148,149,150,151,152,153,154,162,163,164,165,166,167,168,169,170,178,179,180,181,182,183,184,185,186,194,195,196,197,198,199,200,201,202,210,211,212,213,214,215,216,217,218,226,227,228,229,230,231,232,233,234,242,243,244,245,246,247,248,249,250]);
         this.bitcode = new Vector.<BitString>(65535,true);
         this.category = new Vector.<int>(65535,true);
         this.DU = new Vector.<int>(64,true);
         this.YDU = new Vector.<Number>(64,true);
         this.UDU = new Vector.<Number>(64,true);
         this.VDU = new Vector.<Number>(64,true);
         super();
         if(quality <= 0)
         {
            quality = 1;
         }
         if(quality > 100)
         {
            quality = 100;
         }
         this.sf = quality < 50?int(5000 / quality):int(200 - (quality << 1));
         this.init();
      }
      
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
      
      private function initQuantTables(sf:int) : void {
         var i:* = 0;
         var t:* = 0;
         var u:* = 0;
         var col:* = 0;
         var I64:int = 64;
         var I8:int = 8;
         i = 0;
         while(i < I64)
         {
            t = int((this.YQT[i] * sf + 50) * 0.01);
            if(t < 1)
            {
               t = 1;
            }
            else if(t > 255)
            {
               t = 255;
            }
            
            this.YTable[this.ZigZag[i]] = t;
            i++;
         }
         i = 0;
         while(i < I64)
         {
            u = int((this.UVQT[i] * sf + 50) * 0.01);
            if(u < 1)
            {
               u = 1;
            }
            else if(u > 255)
            {
               u = 255;
            }
            
            this.UVTable[this.ZigZag[i]] = u;
            i++;
         }
         i = 0;
         var row:int = 0;
         while(row < I8)
         {
            col = 0;
            while(col < I8)
            {
               this.fdtbl_Y[i] = 1 / (this.YTable[this.ZigZag[i]] * this.aasf[row] * this.aasf[col] * I8);
               this.fdtbl_UV[i] = 1 / (this.UVTable[this.ZigZag[i]] * this.aasf[row] * this.aasf[col] * I8);
               i++;
               col++;
            }
            row++;
         }
      }
      
      private var YDC_HT:Vector.<BitString>;
      
      private var UVDC_HT:Vector.<BitString>;
      
      private var YAC_HT:Vector.<BitString>;
      
      private var UVAC_HT:Vector.<BitString>;
      
      private function computeHuffmanTbl(nrcodes:Vector.<int>, std_table:Vector.<int>) : Vector.<BitString> {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private var std_dc_luminance_nrcodes:Vector.<int>;
      
      private var std_dc_luminance_values:Vector.<int>;
      
      private var std_ac_luminance_nrcodes:Vector.<int>;
      
      private var std_ac_luminance_values:Vector.<int>;
      
      private var std_dc_chrominance_nrcodes:Vector.<int>;
      
      private var std_dc_chrominance_values:Vector.<int>;
      
      private var std_ac_chrominance_nrcodes:Vector.<int>;
      
      private var std_ac_chrominance_values:Vector.<int>;
      
      private function initHuffmanTbl() : void {
         this.YDC_HT = this.computeHuffmanTbl(this.std_dc_luminance_nrcodes,this.std_dc_luminance_values);
         this.UVDC_HT = this.computeHuffmanTbl(this.std_dc_chrominance_nrcodes,this.std_dc_chrominance_values);
         this.YAC_HT = this.computeHuffmanTbl(this.std_ac_luminance_nrcodes,this.std_ac_luminance_values);
         this.UVAC_HT = this.computeHuffmanTbl(this.std_ac_chrominance_nrcodes,this.std_ac_chrominance_values);
      }
      
      private var bitcode:Vector.<BitString>;
      
      private var category:Vector.<int>;
      
      private function initCategoryNumber() : void {
         var bitString:BitString = null;
         var pos:* = 0;
         var nr:* = 0;
         var nrneg:* = 0;
         var nrlower:int = 1;
         var nrupper:int = 2;
         var I15:int = 15;
         var cat:int = 1;
         while(true)
         {
            nr = nrlower;
            while(nr < nrupper)
            {
               pos = int(32767 + nr);
               this.category[pos] = cat;
               this.bitcode[pos] = bitString = new BitString();
               bitString.len = cat;
               bitString.val = nr;
               nr++;
            }
            nrneg = -(nrupper - 1);
            while(nrneg <= -nrlower)
            {
               pos = int(32767 + nrneg);
               this.category[pos] = cat;
               this.bitcode[pos] = bitString = new BitString();
               bitString.len = cat;
               bitString.val = nrupper - 1 + nrneg;
               nrneg++;
            }
            nrlower = nrlower << 1;
            nrupper = nrupper << 1;
            cat++;
         }
      }
      
      private var byteout:ByteArray;
      
      private var bytenew:int = 0;
      
      private var bytepos:int = 7;
      
      private function writeBits(bs:BitString) : void {
         var value:int = bs.val;
         var posval:int = bs.len - 1;
         while(posval >= 0)
         {
            if(value & uint(1 << posval))
            {
               this.bytenew = this.bytenew | uint(1 << this.bytepos);
            }
            posval--;
            this.bytepos--;
            if(this.bytepos < 0)
            {
               if(this.bytenew == 255)
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
      }
      
      private function fDCTQuant(data:Vector.<Number>, fdtbl:Vector.<Number>) : Vector.<int> {
         var d0:* = NaN;
         var d1:* = NaN;
         var d2:* = NaN;
         var d3:* = NaN;
         var d4:* = NaN;
         var d5:* = NaN;
         var d6:* = NaN;
         var d7:* = NaN;
         var i:* = 0;
         var fDCTQuant:* = NaN;
         var tmp0:* = NaN;
         var tmp7:* = NaN;
         var tmp1:* = NaN;
         var tmp6:* = NaN;
         var tmp2:* = NaN;
         var tmp5:* = NaN;
         var tmp3:* = NaN;
         var tmp4:* = NaN;
         var tmp10:* = NaN;
         var tmp13:* = NaN;
         var tmp11:* = NaN;
         var tmp12:* = NaN;
         var z1:* = NaN;
         var z5:* = NaN;
         var z2:* = NaN;
         var z4:* = NaN;
         var z3:* = NaN;
         var z11:* = NaN;
         var z13:* = NaN;
         var tmp0p2:* = NaN;
         var tmp7p2:* = NaN;
         var tmp1p2:* = NaN;
         var tmp6p2:* = NaN;
         var tmp2p2:* = NaN;
         var tmp5p2:* = NaN;
         var tmp3p2:* = NaN;
         var tmp4p2:* = NaN;
         var tmp10p2:* = NaN;
         var tmp13p2:* = NaN;
         var tmp11p2:* = NaN;
         var tmp12p2:* = NaN;
         var z1p2:* = NaN;
         var z5p2:* = NaN;
         var z2p2:* = NaN;
         var z4p2:* = NaN;
         var z3p2:* = NaN;
         var z11p2:* = NaN;
         var z13p2:* = NaN;
         var dataOff:int = 0;
         var I8:int = 8;
         var I64:int = 64;
         i = 0;
         while(i < I8)
         {
            d0 = data[int(dataOff)];
            d1 = data[int(dataOff + 1)];
            d2 = data[int(dataOff + 2)];
            d3 = data[int(dataOff + 3)];
            d4 = data[int(dataOff + 4)];
            d5 = data[int(dataOff + 5)];
            d6 = data[int(dataOff + 6)];
            d7 = data[int(dataOff + 7)];
            tmp0 = d0 + d7;
            tmp7 = d0 - d7;
            tmp1 = d1 + d6;
            tmp6 = d1 - d6;
            tmp2 = d2 + d5;
            tmp5 = d2 - d5;
            tmp3 = d3 + d4;
            tmp4 = d3 - d4;
            tmp10 = tmp0 + tmp3;
            tmp13 = tmp0 - tmp3;
            tmp11 = tmp1 + tmp2;
            tmp12 = tmp1 - tmp2;
            data[int(dataOff)] = tmp10 + tmp11;
            data[int(dataOff + 4)] = tmp10 - tmp11;
            z1 = (tmp12 + tmp13) * 0.707106781;
            data[int(dataOff + 2)] = tmp13 + z1;
            data[int(dataOff + 6)] = tmp13 - z1;
            tmp10 = tmp4 + tmp5;
            tmp11 = tmp5 + tmp6;
            tmp12 = tmp6 + tmp7;
            z5 = (tmp10 - tmp12) * 0.382683433;
            z2 = 0.5411961 * tmp10 + z5;
            z4 = 1.306562965 * tmp12 + z5;
            z3 = tmp11 * 0.707106781;
            z11 = tmp7 + z3;
            z13 = tmp7 - z3;
            data[int(dataOff + 5)] = z13 + z2;
            data[int(dataOff + 3)] = z13 - z2;
            data[int(dataOff + 1)] = z11 + z4;
            data[int(dataOff + 7)] = z11 - z4;
            dataOff = dataOff + 8;
            i++;
         }
         dataOff = 0;
         i = 0;
         while(i < I8)
         {
            d0 = data[int(dataOff)];
            d1 = data[int(dataOff + 8)];
            d2 = data[int(dataOff + 16)];
            d3 = data[int(dataOff + 24)];
            d4 = data[int(dataOff + 32)];
            d5 = data[int(dataOff + 40)];
            d6 = data[int(dataOff + 48)];
            d7 = data[int(dataOff + 56)];
            tmp0p2 = d0 + d7;
            tmp7p2 = d0 - d7;
            tmp1p2 = d1 + d6;
            tmp6p2 = d1 - d6;
            tmp2p2 = d2 + d5;
            tmp5p2 = d2 - d5;
            tmp3p2 = d3 + d4;
            tmp4p2 = d3 - d4;
            tmp10p2 = tmp0p2 + tmp3p2;
            tmp13p2 = tmp0p2 - tmp3p2;
            tmp11p2 = tmp1p2 + tmp2p2;
            tmp12p2 = tmp1p2 - tmp2p2;
            data[int(dataOff)] = tmp10p2 + tmp11p2;
            data[int(dataOff + 32)] = tmp10p2 - tmp11p2;
            z1p2 = (tmp12p2 + tmp13p2) * 0.707106781;
            data[int(dataOff + 16)] = tmp13p2 + z1p2;
            data[int(dataOff + 48)] = tmp13p2 - z1p2;
            tmp10p2 = tmp4p2 + tmp5p2;
            tmp11p2 = tmp5p2 + tmp6p2;
            tmp12p2 = tmp6p2 + tmp7p2;
            z5p2 = (tmp10p2 - tmp12p2) * 0.382683433;
            z2p2 = 0.5411961 * tmp10p2 + z5p2;
            z4p2 = 1.306562965 * tmp12p2 + z5p2;
            z3p2 = tmp11p2 * 0.707106781;
            z11p2 = tmp7p2 + z3p2;
            z13p2 = tmp7p2 - z3p2;
            data[int(dataOff + 40)] = z13p2 + z2p2;
            data[int(dataOff + 24)] = z13p2 - z2p2;
            data[int(dataOff + 8)] = z11p2 + z4p2;
            data[int(dataOff + 56)] = z11p2 - z4p2;
            dataOff++;
            i++;
         }
         i = 0;
         while(i < I64)
         {
            fDCTQuant = data[int(i)] * fdtbl[int(i)];
            this.outputfDCTQuant[int(i)] = fDCTQuant > 0.0?int(fDCTQuant + 0.5):int(fDCTQuant - 0.5);
            i++;
         }
         return this.outputfDCTQuant;
      }
      
      private function writeAPP0() : void {
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
      }
      
      private function writeSOF0(width:int, height:int) : void {
         this.byteout.writeShort(65472);
         this.byteout.writeShort(17);
         this.byteout.writeByte(8);
         this.byteout.writeShort(height);
         this.byteout.writeShort(width);
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
      }
      
      private function writeDQT() : void {
         var i:* = 0;
         this.byteout.writeShort(65499);
         this.byteout.writeShort(132);
         this.byteout.writeByte(0);
         var I64:int = 64;
         i = 0;
         while(i < I64)
         {
            this.byteout.writeByte(this.YTable[i]);
            i++;
         }
         this.byteout.writeByte(1);
         i = 0;
         while(i < I64)
         {
            this.byteout.writeByte(this.UVTable[i]);
            i++;
         }
      }
      
      private function writeDHT() : void {
         var i:* = 0;
         this.byteout.writeShort(65476);
         this.byteout.writeShort(418);
         this.byteout.writeByte(0);
         var I11:int = 11;
         var I16:int = 16;
         var I161:int = 161;
         i = 0;
         while(i < I16)
         {
            this.byteout.writeByte(this.std_dc_luminance_nrcodes[int(i + 1)]);
            i++;
         }
         i = 0;
         while(i <= I11)
         {
            this.byteout.writeByte(this.std_dc_luminance_values[int(i)]);
            i++;
         }
         this.byteout.writeByte(16);
         i = 0;
         while(i < I16)
         {
            this.byteout.writeByte(this.std_ac_luminance_nrcodes[int(i + 1)]);
            i++;
         }
         i = 0;
         while(i <= I161)
         {
            this.byteout.writeByte(this.std_ac_luminance_values[int(i)]);
            i++;
         }
         this.byteout.writeByte(1);
         i = 0;
         while(i < I16)
         {
            this.byteout.writeByte(this.std_dc_chrominance_nrcodes[int(i + 1)]);
            i++;
         }
         i = 0;
         while(i <= I11)
         {
            this.byteout.writeByte(this.std_dc_chrominance_values[int(i)]);
            i++;
         }
         this.byteout.writeByte(17);
         i = 0;
         while(i < I16)
         {
            this.byteout.writeByte(this.std_ac_chrominance_nrcodes[int(i + 1)]);
            i++;
         }
         i = 0;
         while(i <= I161)
         {
            this.byteout.writeByte(this.std_ac_chrominance_values[int(i)]);
            i++;
         }
      }
      
      private function writeSOS() : void {
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
      }
      
      var DU:Vector.<int>;
      
      private function processDU(CDU:Vector.<Number>, fdtbl:Vector.<Number>, DC:Number, HTDC:Vector.<BitString>, HTAC:Vector.<BitString>) : Number {
         var pos:* = 0;
         var lng:* = 0;
         var startpos:* = 0;
         var nrzeroes:* = 0;
         var nrmarker:* = 0;
         var EOB:BitString = HTAC[0];
         var M16zeroes:BitString = HTAC[240];
         var I16:int = 16;
         var I63:int = 63;
         var I64:int = 64;
         var DU_DCT:Vector.<int> = this.fDCTQuant(CDU,fdtbl);
         var j:int = 0;
         while(j < I64)
         {
            this.DU[this.ZigZag[j]] = DU_DCT[j];
            j++;
         }
         var Diff:int = this.DU[0] - DC;
         var DC:Number = this.DU[0];
         if(Diff == 0)
         {
            this.writeBits(HTDC[0]);
         }
         else
         {
            pos = int(32767 + Diff);
            this.writeBits(HTDC[this.category[pos]]);
            this.writeBits(this.bitcode[pos]);
         }
         var end0pos:int = 63;
         while((end0pos > 0) && (this.DU[end0pos] == 0))
         {
            end0pos--;
         }
         if(end0pos == 0)
         {
            this.writeBits(EOB);
            return DC;
         }
         var i:int = 1;
         while(i <= end0pos)
         {
            startpos = i;
            while((this.DU[i] == 0) && (i <= end0pos))
            {
               i++;
            }
            nrzeroes = i - startpos;
            if(nrzeroes >= I16)
            {
               lng = nrzeroes >> 4;
               nrmarker = 1;
               while(nrmarker <= lng)
               {
                  this.writeBits(M16zeroes);
                  nrmarker++;
               }
               nrzeroes = int(nrzeroes & 15);
            }
            pos = int(32767 + this.DU[i]);
            this.writeBits(HTAC[int((nrzeroes << 4) + this.category[pos])]);
            this.writeBits(this.bitcode[pos]);
            i++;
         }
         if(end0pos != I63)
         {
            this.writeBits(EOB);
         }
         return DC;
      }
      
      private var YDU:Vector.<Number>;
      
      private var UDU:Vector.<Number>;
      
      private var VDU:Vector.<Number>;
      
      private function RGB2YUV(img:BitmapData, xpos:int, ypos:int) : void {
         var x:* = 0;
         var P:uint = 0;
         var R:* = 0;
         var G:* = 0;
         var B:* = 0;
         var pos:int = 0;
         var I8:int = 8;
         var y:int = 0;
         while(true)
         {
            x = 0;
            while(x < I8)
            {
               P = img.getPixel32(xpos + x,ypos + y);
               R = P >> 16 & 255;
               G = P >> 8 & 255;
               B = P & 255;
               this.YDU[int(pos)] = 0.299 * R + 0.587 * G + 0.114 * B - 128;
               this.UDU[int(pos)] = -0.16874 * R + -0.33126 * G + 0.5 * B;
               this.VDU[int(pos)] = 0.5 * R + -0.41869 * G + -0.08131 * B;
               pos++;
               x++;
            }
            y++;
         }
      }
      
      private function init() : void {
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
      }
      
      private function process(e:Event) : void {
         FpsManager.getInstance().startTracking("processJPG",1243644);
         var currentTime:int = getTimer();
         while(true)
         {
            this.RGB2YUV(this._image,this._xpos,this._ypos);
            this._DCY = this.processDU(this.YDU,this.fdtbl_Y,this._DCY,this.YDC_HT,this.YAC_HT);
            this._DCU = this.processDU(this.UDU,this.fdtbl_UV,this._DCU,this.UVDC_HT,this.UVAC_HT);
            this._DCV = this.processDU(this.VDU,this.fdtbl_UV,this._DCV,this.UVDC_HT,this.UVAC_HT);
            this._xpos = this._xpos + 8;
            if(this._xpos >= this._width)
            {
               this._xpos = 0;
               this._ypos = this._ypos + 8;
               if(this._ypos >= this._height)
               {
                  break;
               }
            }
            if(getTimer() - currentTime > this._maxTime)
            {
               lastTime = currentTime - this._lastFrame;
               this._lastFrame = currentTime;
               if(lastTime > 20)
               {
                  this._maxTime = this._maxTime - 2;
                  if(this._maxTime < 1)
                  {
                     this._maxTime = 1;
                  }
               }
               else
               {
                  this._maxTime++;
               }
               FpsManager.getInstance().stopTracking("processJPG");
               return;
            }
         }
         EnterFrameDispatcher.removeEventListener(this.process);
         this.endProcess();
      }
      
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
      
      public function encode(image:BitmapData, callBack:Function, param:Object) : void {
         EnterFrameDispatcher.addEventListener(this.process,"jpgEncoder");
         this._image = image;
         this._callBack = callBack;
         this._param = param;
         this._maxTime = 10;
         this.byteout = new ByteArray();
         this.bytenew = 0;
         this.bytepos = 7;
         this.byteout.writeShort(65496);
         this.writeAPP0();
         this.writeDQT();
         this.writeSOF0(image.width,image.height);
         this.writeDHT();
         this.writeSOS();
         this._DCY = 0;
         this._DCU = 0;
         this._DCV = 0;
         this.bytenew = 0;
         this.bytepos = 7;
         this._width = image.width;
         this._height = image.height;
         this._ypos = 0;
         this._xpos = 0;
      }
      
      private function endProcess() : void {
         var fillbits:BitString = null;
         if(this.bytepos >= 0)
         {
            fillbits = new BitString();
            fillbits.len = this.bytepos + 1;
            fillbits.val = (1 << this.bytepos + 1) - 1;
            this.writeBits(fillbits);
         }
         this.byteout.writeShort(65497);
         this._callBack(this.byteout,this._param);
      }
   }
}
final class BitString extends Object
{
   
   function BitString() {
      super();
   }
   
   public var len:int = 0;
   
   public var val:int = 0;
}
