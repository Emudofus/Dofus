package flashx.textLayout.property
{
   public class EnumPropertyHandler extends PropertyHandler
   {
      
      public function EnumPropertyHandler(param1:Array) {
         super();
         this._range = PropertyHandler.createRange(param1);
      }
      
      private var _range:Object;
      
      public function get range() : Object {
         return Property.shallowCopy(this._range);
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         return this._range.hasOwnProperty(param1)?param1:undefined;
      }
   }
}
