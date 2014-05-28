package flashx.textLayout.property
{
   public class UndefinedPropertyHandler extends PropertyHandler
   {
      
      public function UndefinedPropertyHandler() {
         super();
      }
      
      override public function owningHandlerCheck(param1:*) : * {
         return param1 === null || param1 === undefined?true:undefined;
      }
      
      override public function setHelper(param1:*) : * {
         return undefined;
      }
   }
}
