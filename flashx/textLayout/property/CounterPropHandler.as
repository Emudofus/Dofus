package flashx.textLayout.property
{
   public class CounterPropHandler extends PropertyHandler
   {
      
      public function CounterPropHandler(param1:int) {
         super();
         this._defaultNumber = param1;
      }
      
      private static const _orderedPattern:RegExp = new RegExp("^\\s*ordered(\\s+-?\\d+){0,1}\\s*$");
      
      private static const _orderedBeginPattern:RegExp = new RegExp("^\\s*ordered\\s*","g");
      
      private var _defaultNumber:int;
      
      public function get defaultNumber() : int {
         return this._defaultNumber;
      }
      
      override public function get customXMLStringHandler() : Boolean {
         return true;
      }
      
      override public function toXMLString(param1:Object) : String {
         return param1["ordered"] == 1?"ordered":"ordered " + param1["ordered"];
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         return param1 is String && (_orderedPattern.test(param1)) || (param1.hasOwnProperty("ordered"))?param1:undefined;
      }
      
      override public function setHelper(param1:*) : * {
         var _loc2_:String = param1 as String;
         if(_loc2_ == null)
         {
            return param1;
         }
         _orderedBeginPattern.lastIndex = 0;
         _orderedBeginPattern.test(_loc2_);
         var _loc3_:int = _orderedBeginPattern.lastIndex != _loc2_.length?parseInt(_loc2_.substr(_orderedBeginPattern.lastIndex)):this._defaultNumber;
         return {"ordered":_loc3_};
      }
   }
}
