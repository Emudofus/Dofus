package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public dynamic class Sequence extends Array implements IAsn1Type
   {
      
      public function Sequence(param1:uint=48, param2:uint=0) {
         super();
         this.type = param1;
         this.len = param2;
      }
      
      protected var type:uint;
      
      protected var len:uint;
      
      public function getLength() : uint {
         return this.len;
      }
      
      public function getType() : uint {
         return this.type;
      }
      
      public function toDER() : ByteArray {
         var _loc3_:IAsn1Type = null;
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:* = 0;
         while(_loc2_ < length)
         {
            _loc3_ = this[_loc2_];
            if(_loc3_ == null)
            {
               _loc1_.writeByte(5);
               _loc1_.writeByte(0);
            }
            else
            {
               _loc1_.writeBytes(_loc3_.toDER());
            }
            _loc2_++;
         }
         return DER.wrapDER(this.type,_loc1_);
      }
      
      public function toString() : String {
         var _loc4_:* = false;
         var _loc5_:String = null;
         var _loc1_:String = DER.indent;
         DER.indent = DER.indent + "    ";
         var _loc2_:* = "";
         var _loc3_:* = 0;
         while(_loc3_ < length)
         {
            if(this[_loc3_] != null)
            {
               _loc4_ = false;
               for (_loc5_ in this)
               {
                  if(!(_loc3_.toString() == _loc5_) && this[_loc3_] == this[_loc5_])
                  {
                     _loc2_ = _loc2_ + (_loc5_ + ": " + this[_loc3_] + "\n");
                     _loc4_ = true;
                     break;
                  }
               }
               if(!_loc4_)
               {
                  _loc2_ = _loc2_ + (this[_loc3_] + "\n");
               }
            }
            _loc3_++;
         }
         DER.indent = _loc1_;
         return DER.indent + "Sequence[" + this.type + "][" + this.len + "][\n" + _loc2_ + "\n" + _loc1_ + "]";
      }
      
      public function findAttributeValue(param1:String) : IAsn1Type {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:ObjectIdentifier = null;
         for each (_loc2_ in this)
         {
            if(_loc2_ is Set)
            {
               _loc3_ = _loc2_[0];
               if(_loc3_ is Sequence)
               {
                  _loc4_ = _loc3_[0];
                  if(_loc4_ is ObjectIdentifier)
                  {
                     _loc5_ = _loc4_ as ObjectIdentifier;
                     if(_loc5_.toString() == param1)
                     {
                        return _loc3_[1] as IAsn1Type;
                     }
                  }
               }
            }
         }
         return null;
      }
   }
}
