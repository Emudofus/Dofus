package flashx.textLayout.property
{


   public class EnumPropertyHandler extends PropertyHandler
   {
         

      public function EnumPropertyHandler(propArray:Array) {
         super();
         this._range=PropertyHandler.createRange(propArray);
      }



      private var _range:Object;

      public function get range() : Object {
         return Property.shallowCopy(this._range);
      }

      override public function owningHandlerCheck(newVal:*) : * {
         return this._range.hasOwnProperty(newVal)?newVal:undefined;
      }
   }

}