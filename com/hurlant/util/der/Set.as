package com.hurlant.util.der
{
   public dynamic class Set extends Sequence implements IAsn1Type
   {
      
      public function Set(param1:uint = 49, param2:uint = 0)
      {
         super(param1,param2);
      }
      
      override public function toString() : String
      {
         var _loc1_:String = null;
         _loc1_ = DER.indent;
         DER.indent = DER.indent + "    ";
         var _loc2_:String = join("\n");
         DER.indent = _loc1_;
         return DER.indent + "Set[" + type + "][" + len + "][\n" + _loc2_ + "\n" + _loc1_ + "]";
      }
   }
}
