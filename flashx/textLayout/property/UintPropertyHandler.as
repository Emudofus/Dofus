package flashx.textLayout.property
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class UintPropertyHandler extends PropertyHandler
   {
      
      public function UintPropertyHandler() {
         super();
      }
      
      override public function get customXMLStringHandler() : Boolean {
         return true;
      }
      
      override public function toXMLString(param1:Object) : String {
         var _loc2_:String = param1.toString(16);
         if(_loc2_.length < 6)
         {
            _loc2_ = "000000".substr(0,6 - _loc2_.length) + _loc2_;
         }
         _loc2_ = "#" + _loc2_;
         return _loc2_;
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         var _loc2_:* = NaN;
         var _loc3_:String = null;
         if(param1 is uint)
         {
            return param1;
         }
         if(param1 is String)
         {
            _loc3_ = String(param1);
            if(_loc3_.substr(0,1) == "#")
            {
               _loc3_ = "0x" + _loc3_.substr(1,_loc3_.length-1);
            }
            _loc2_ = _loc3_.toLowerCase().substr(0,2) == "0x"?parseInt(_loc3_):NaN;
         }
         else
         {
            if(param1 is Number || param1 is int)
            {
               _loc2_ = Number(param1);
            }
            else
            {
               return undefined;
            }
         }
         if(isNaN(_loc2_))
         {
            return undefined;
         }
         if(_loc2_ < 0 || _loc2_ > 4.294967295E9)
         {
            return undefined;
         }
         return _loc2_;
      }
   }
}
