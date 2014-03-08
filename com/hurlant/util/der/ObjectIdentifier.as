package com.hurlant.util.der
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class ObjectIdentifier extends Object implements IAsn1Type
   {
      
      {
         registerClassAlias("com.hurlant.util.der.ObjectIdentifier",ObjectIdentifier);
      }
      
      public function ObjectIdentifier(param1:uint=0, param2:uint=0, param3:*=null) {
         super();
         this.type = param1;
         this.len = param2;
         if(param3 is ByteArray)
         {
            this.parse(param3 as ByteArray);
         }
         else
         {
            if(param3 is String)
            {
               this.generate(param3 as String);
            }
            else
            {
               throw new Error("Invalid call to new ObjectIdentifier");
            }
         }
      }
      
      private var type:uint;
      
      private var len:uint;
      
      private var oid:Array;
      
      private function generate(param1:String) : void {
         this.oid = param1.split(".");
      }
      
      private function parse(param1:ByteArray) : void {
         var _loc5_:* = false;
         var _loc2_:uint = param1.readUnsignedByte();
         var _loc3_:Array = [];
         _loc3_.push(uint(_loc2_ / 40));
         _loc3_.push(uint(_loc2_ % 40));
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > 0)
         {
            _loc2_ = param1.readUnsignedByte();
            _loc5_ = (_loc2_ & 128) == 0;
            _loc2_ = _loc2_ & 127;
            _loc4_ = _loc4_ * 128 + _loc2_;
            if(_loc5_)
            {
               _loc3_.push(_loc4_);
               _loc4_ = 0;
            }
         }
         this.oid = _loc3_;
      }
      
      public function getLength() : uint {
         return this.len;
      }
      
      public function getType() : uint {
         return this.type;
      }
      
      public function toDER() : ByteArray {
         var _loc4_:* = 0;
         var _loc1_:Array = [];
         _loc1_[0] = this.oid[0] * 40 + this.oid[1];
         var _loc2_:* = 2;
         while(_loc2_ < this.oid.length)
         {
            _loc4_ = parseInt(this.oid[_loc2_]);
            if(_loc4_ < 128)
            {
               _loc1_.push(_loc4_);
            }
            else
            {
               if(_loc4_ < 128 * 128)
               {
                  _loc1_.push(_loc4_ >> 7 | 128);
                  _loc1_.push(_loc4_ & 127);
               }
               else
               {
                  if(_loc4_ < 128 * 128 * 128)
                  {
                     _loc1_.push(_loc4_ >> 14 | 128);
                     _loc1_.push(_loc4_ >> 7 & 127 | 128);
                     _loc1_.push(_loc4_ & 127);
                  }
                  else
                  {
                     if(_loc4_ < 128 * 128 * 128 * 128)
                     {
                        _loc1_.push(_loc4_ >> 21 | 128);
                        _loc1_.push(_loc4_ >> 14 & 127 | 128);
                        _loc1_.push(_loc4_ >> 7 & 127 | 128);
                        _loc1_.push(_loc4_ & 127);
                     }
                     else
                     {
                        throw new Error("OID element bigger than we thought. :(");
                     }
                  }
               }
            }
            _loc2_++;
         }
         this.len = _loc1_.length;
         if(this.type == 0)
         {
            this.type = 6;
         }
         _loc1_.unshift(this.len);
         _loc1_.unshift(this.type);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_[_loc2_] = _loc1_[_loc2_];
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function toString() : String {
         return DER.indent + this.oid.join(".");
      }
      
      public function dump() : String {
         return "OID[" + this.type + "][" + this.len + "][" + this.toString() + "]";
      }
   }
}
