package mx.core
{
   import flash.display.Sprite;
   import mx.utils.NameUtil;
   
   use namespace mx_internal;
   
   public class FlexSprite extends Sprite
   {
      
      public function FlexSprite() {
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
