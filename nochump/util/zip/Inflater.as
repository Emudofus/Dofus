package nochump.util.zip
{
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.getTimer;
   import flash.events.ProgressEvent;
   import flash.utils.setTimeout;
   
   public class Inflater extends EventDispatcher
   {
      
      public function Inflater() {
         super();
      }
      
      private static const MAXBITS:int = 15;
      
      private static const MAXLCODES:int = 286;
      
      private static const MAXDCODES:int = 30;
      
      private static const MAXCODES:int = MAXLCODES + MAXDCODES;
      
      private static const FIXLCODES:int = 288;
      
      private static const LENS:Array = [3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258];
      
      private static const LEXT:Array = [0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0];
      
      private static const DISTS:Array = [1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577];
      
      private static const DEXT:Array = [0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13];
      
      private var inbuf:ByteArray;
      
      private var incnt:uint;
      
      private var bitbuf:int;
      
      private var bitcnt:int;
      
      private var lencode:Object;
      
      private var distcode:Object;
      
      public function setInput(param1:ByteArray) : void {
         this.inbuf = param1;
         this.inbuf.endian = Endian.LITTLE_ENDIAN;
      }
      
      private var _running:Boolean;
      
      public function inflate(param1:ByteArray, param2:Function) : uint {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         if(!this._running)
         {
            this.incnt = this.bitbuf = this.bitcnt = 0;
         }
         this._running = true;
         var _loc3_:* = !(param2 == null);
         var _loc4_:Number = getTimer();
         var _loc5_:* = 0;
         var _loc6_:uint = param1.length;
         do
         {
               if((_loc3_) && getTimer() - _loc4_ > 24)
               {
                  dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,param1.length));
                  setTimeout(this.inflate,1,param1,param2);
                  return 0;
               }
               _loc7_ = this.bits(1);
               _loc8_ = this.bits(2);
               if(_loc8_ == 0)
               {
                  this.stored(param1);
               }
               else
               {
                  if(_loc8_ == 3)
                  {
                     throw new Error("invalid block type (type == 3)",-1);
                  }
                  else
                  {
                     this.lencode = 
                        {
                           "count":[],
                           "symbol":[]
                        };
                     this.distcode = 
                        {
                           "count":[],
                           "symbol":[]
                        };
                     if(_loc8_ == 1)
                     {
                        this.constructFixedTables();
                     }
                     else
                     {
                        if(_loc8_ == 2)
                        {
                           _loc5_ = this.constructDynamicTables();
                        }
                     }
                     if(_loc5_ != 0)
                     {
                        return _loc5_;
                     }
                     _loc5_ = this.codes(param1);
                  }
               }
               if(_loc5_ != 0)
               {
                  break;
               }
            }while(!_loc7_);
            
            this._running = false;
            if(_loc3_)
            {
               param2(param1);
            }
            return _loc5_;
         }
         
         private function bits(param1:int) : int {
            var _loc2_:int = this.bitbuf;
            while(this.bitcnt < param1)
            {
               if(this.incnt == this.inbuf.length)
               {
                  throw new Error("available inflate data did not terminate",2);
               }
               else
               {
                  _loc2_ = _loc2_ | this.inbuf[this.incnt++] << this.bitcnt;
                  this.bitcnt = this.bitcnt + 8;
                  continue;
               }
            }
            this.bitbuf = _loc2_ >> param1;
            this.bitcnt = this.bitcnt - param1;
            return _loc2_ & 1 << param1-1;
         }
         
         private function construct(param1:Object, param2:Array, param3:int) : int {
            var _loc4_:Array = [];
            var _loc5_:* = 0;
            while(_loc5_ <= MAXBITS)
            {
               param1.count[_loc5_] = 0;
               _loc5_++;
            }
            var _loc6_:* = 0;
            while(_loc6_ < param3)
            {
               param1.count[param2[_loc6_]]++;
               _loc6_++;
            }
            if(param1.count[0] == param3)
            {
               return 0;
            }
            var _loc7_:* = 1;
            _loc5_ = 1;
            while(_loc5_ <= MAXBITS)
            {
               _loc7_ = _loc7_ << 1;
               _loc7_ = _loc7_ - param1.count[_loc5_];
               if(_loc7_ < 0)
               {
                  return _loc7_;
               }
               _loc5_++;
            }
            _loc4_[1] = 0;
            _loc5_ = 1;
            while(_loc5_ < MAXBITS)
            {
               _loc4_[_loc5_ + 1] = _loc4_[_loc5_] + param1.count[_loc5_];
               _loc5_++;
            }
            _loc6_ = 0;
            while(_loc6_ < param3)
            {
               if(param2[_loc6_] != 0)
               {
                  param1.symbol[_loc4_[param2[_loc6_]]++] = _loc6_;
               }
               _loc6_++;
            }
            return _loc7_;
         }
         
         private function decode(param1:Object) : int {
            var _loc6_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:* = 1;
            while(_loc5_ <= MAXBITS)
            {
               _loc2_ = _loc2_ | this.bits(1);
               _loc6_ = param1.count[_loc5_];
               if(_loc2_ < _loc3_ + _loc6_)
               {
                  return param1.symbol[_loc4_ + (_loc2_ - _loc3_)];
               }
               _loc4_ = _loc4_ + _loc6_;
               _loc3_ = _loc3_ + _loc6_;
               _loc3_ = _loc3_ << 1;
               _loc2_ = _loc2_ << 1;
               _loc5_++;
            }
            return -9;
         }
         
         private function codes(param1:ByteArray) : int {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:uint = 0;
            while(true)
            {
               _loc2_ = this.decode(this.lencode);
               if(_loc2_ < 0)
               {
                  break;
               }
               if(_loc2_ < 256)
               {
                  param1[param1.length] = _loc2_;
               }
               else
               {
                  if(_loc2_ > 256)
                  {
                     _loc2_ = _loc2_ - 257;
                     if(_loc2_ >= 29)
                     {
                        throw new Error("invalid literal/length or distance code in fixed or dynamic block",-9);
                     }
                     else
                     {
                        _loc3_ = LENS[_loc2_] + this.bits(LEXT[_loc2_]);
                        _loc2_ = this.decode(this.distcode);
                        if(_loc2_ < 0)
                        {
                           return _loc2_;
                        }
                        _loc4_ = DISTS[_loc2_] + this.bits(DEXT[_loc2_]);
                        if(_loc4_ > param1.length)
                        {
                           throw new Error("distance is too far back in fixed or dynamic block",-10);
                        }
                        else
                        {
                           while(_loc3_--)
                           {
                              param1[param1.length] = param1[param1.length - _loc4_];
                           }
                        }
                     }
                  }
               }
               if(_loc2_ == 256)
               {
                  return 0;
               }
            }
            return _loc2_;
         }
         
         private function stored(param1:ByteArray) : void {
            this.bitbuf = 0;
            this.bitcnt = 0;
            if(this.incnt + 4 > this.inbuf.length)
            {
               throw new Error("available inflate data did not terminate",2);
            }
            else
            {
               _loc2_ = this.inbuf[this.incnt++];
               _loc2_ = _loc2_ | this.inbuf[this.incnt++] << 8;
               if(!(this.inbuf[this.incnt++] == (~_loc2_ & 255)) || !(this.inbuf[this.incnt++] == (~_loc2_ >> 8 & 255)))
               {
                  throw new Error("stored block length did not match one\'s complement",-2);
               }
               else
               {
                  if(this.incnt + _loc2_ > this.inbuf.length)
                  {
                     throw new Error("available inflate data did not terminate",2);
                  }
                  else
                  {
                     while(_loc2_--)
                     {
                        param1[param1.length] = this.inbuf[this.incnt++];
                     }
                     return;
                  }
               }
            }
         }
         
         private function constructFixedTables() : void {
            var _loc1_:Array = [];
            var _loc2_:* = 0;
            while(_loc2_ < 144)
            {
               _loc1_[_loc2_] = 8;
               _loc2_++;
            }
            while(_loc2_ < 256)
            {
               _loc1_[_loc2_] = 9;
               _loc2_++;
            }
            while(_loc2_ < 280)
            {
               _loc1_[_loc2_] = 7;
               _loc2_++;
            }
            while(_loc2_ < FIXLCODES)
            {
               _loc1_[_loc2_] = 8;
               _loc2_++;
            }
            this.construct(this.lencode,_loc1_,FIXLCODES);
            _loc2_ = 0;
            while(_loc2_ < MAXDCODES)
            {
               _loc1_[_loc2_] = 5;
               _loc2_++;
            }
            this.construct(this.distcode,_loc1_,MAXDCODES);
         }
         
         private function constructDynamicTables() : int {
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            var _loc1_:Array = [];
            var _loc2_:Array = [16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15];
            var _loc3_:int = this.bits(5) + 257;
            var _loc4_:int = this.bits(5) + 1;
            var _loc5_:int = this.bits(4) + 4;
            if(_loc3_ > MAXLCODES || _loc4_ > MAXDCODES)
            {
               throw new Error("dynamic block code description: too many length or distance codes",-3);
            }
            else
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc1_[_loc2_[_loc6_]] = this.bits(3);
                  _loc6_++;
               }
               while(_loc6_ < 19)
               {
                  _loc1_[_loc2_[_loc6_]] = 0;
                  _loc6_++;
               }
               _loc7_ = this.construct(this.lencode,_loc1_,19);
               if(_loc7_ != 0)
               {
                  throw new Error("dynamic block code description: code lengths codes incomplete",-4);
               }
               else
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc3_ + _loc4_)
                  {
                     _loc8_ = this.decode(this.lencode);
                     if(_loc8_ < 16)
                     {
                        _loc1_[_loc6_++] = _loc8_;
                        continue;
                     }
                     _loc9_ = 0;
                     if(_loc8_ == 16)
                     {
                        if(_loc6_ == 0)
                        {
                           throw new Error("dynamic block code description: repeat lengths with no first length",-5);
                        }
                        else
                        {
                           _loc9_ = _loc1_[_loc6_-1];
                           _loc8_ = 3 + this.bits(2);
                        }
                     }
                     else
                     {
                        if(_loc8_ == 17)
                        {
                           _loc8_ = 3 + this.bits(3);
                        }
                        else
                        {
                           _loc8_ = 11 + this.bits(7);
                        }
                     }
                     if(_loc6_ + _loc8_ > _loc3_ + _loc4_)
                     {
                        throw new Error("dynamic block code description: repeat more than specified lengths",-6);
                     }
                     else
                     {
                        while(_loc8_--)
                        {
                           _loc1_[_loc6_++] = _loc9_;
                        }
                        continue;
                     }
                  }
                  _loc7_ = this.construct(this.lencode,_loc1_,_loc3_);
                  if(_loc7_ < 0 || _loc7_ > 0 && !(_loc3_ - this.lencode.count[0] == 1))
                  {
                     throw new Error("dynamic block code description: invalid literal/length code lengths",-7);
                  }
                  else
                  {
                     _loc7_ = this.construct(this.distcode,_loc1_.slice(_loc3_),_loc4_);
                     if(_loc7_ < 0 || _loc7_ > 0 && !(_loc4_ - this.distcode.count[0] == 1))
                     {
                        throw new Error("dynamic block code description: invalid distance code lengths",-8);
                     }
                     else
                     {
                        return _loc7_;
                     }
                  }
               }
            }
         }
      }
   }
