package flashx.textLayout.property
{
   public class PropertyHandler extends Object
   {
      
      public function PropertyHandler() {
         super();
      }
      
      public static function createRange(param1:Array) : Object {
         var _loc2_:Object = new Object();
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[param1[_loc3_]] = null;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get customXMLStringHandler() : Boolean {
         return false;
      }
      
      public function toXMLString(param1:Object) : String {
         return null;
      }
      
      public function owningHandlerCheck(param1:*) : * {
         return undefined;
      }
      
      public function setHelper(param1:*) : * {
         return param1;
      }
   }
}
