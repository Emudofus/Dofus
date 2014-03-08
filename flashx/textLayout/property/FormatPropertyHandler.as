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
      
      public function set converter(param1:Function) : void {
         this._converter = param1;
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         return param1 is String?undefined:param1;
      }
      
      override public function setHelper(param1:*) : * {
         return this._converter(param1);
      }
   }
}
