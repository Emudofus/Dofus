package flashx.textLayout.property
{


   public class FormatPropertyHandler extends PropertyHandler
   {
         

      public function FormatPropertyHandler() {
         super();
      }



      private var _converter:Function;

      public function get converter() : Function {
         return this._converter;
      }

      public function set converter(val:Function) : void {
         this._converter=val;
      }

      override public function owningHandlerCheck(newVal:*) : * {
         return newVal is String?undefined:newVal;
      }

      override public function setHelper(newVal:*) : * {
         return this._converter(newVal);
      }
   }

}