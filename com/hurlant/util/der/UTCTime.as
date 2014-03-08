package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public class UTCTime extends Object implements IAsn1Type
   {
      
      public function UTCTime(param1:uint, param2:uint) {
         super();
         this.type = param1;
         this.len = param2;
      }
      
      protected var type:uint;
      
      protected var len:uint;
      
      public var date:Date;
      
      public function getLength() : uint {
         return this.len;
      }
      
      public function getType() : uint {
         return this.type;
      }
      
      public function setUTCTime(param1:String) : void {
         var _loc2_:uint = parseInt(param1.substr(0,2));
         if(_loc2_ < 50)
         {
            _loc2_ = _loc2_ + 2000;
         }
         else
         {
            _loc2_ = _loc2_ + 1900;
         }
         var _loc3_:uint = parseInt(param1.substr(2,2));
         var _loc4_:uint = parseInt(param1.substr(4,2));
         var _loc5_:uint = parseInt(param1.substr(6,2));
         var _loc6_:uint = parseInt(param1.substr(8,2));
         this.date = new Date(_loc2_,_loc3_-1,_loc4_,_loc5_,_loc6_);
      }
      
      public function toString() : String {
         return DER.indent + "UTCTime[" + this.type + "][" + this.len + "][" + this.date + "]";
      }
      
      public function toDER() : ByteArray {
         return null;
      }
   }
}
