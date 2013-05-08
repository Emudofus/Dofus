package flashx.textLayout.property
{


   public class PropertyHandler extends Object
   {
         

      public function PropertyHandler() {
         super();
      }

      public static function createRange(rest:Array) : Object {
         var range:Object = new Object();
         var i:int = 0;
         while(i<rest.length)
         {
            range[rest[i]]=null;
            i++;
         }
         return range;
      }

      public function get customXMLStringHandler() : Boolean {
         return false;
      }

      public function toXMLString(val:Object) : String {
         return null;
      }

      public function owningHandlerCheck(newVal:*) : * {
         return undefined;
      }

      public function setHelper(newVal:*) : * {
         return newVal;
      }
   }

}