package mx.core
{
   import flash.display.SimpleButton;
   import mx.utils.NameUtil;
   
   use namespace mx_internal;
   
   public class FlexSimpleButton extends SimpleButton
   {
      
      public function FlexSimpleButton() {
         super();
         try
         {
            name = NameUtil.createUniqueName(this);
         }
         catch(e:Error)
         {
         }
      }
      
      mx_internal  static const VERSION:String = "4.6.0.23201";
      
      override public function toString() : String {
         return NameUtil.displayObjectToString(this);
      }
   }
}
