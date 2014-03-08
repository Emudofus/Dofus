package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.UIComponent;
   
   public class InternalComponentAccess extends Object
   {
      
      public function InternalComponentAccess() {
         super();
      }
      
      public static function getProperty(param1:UIComponent, param2:String) : * {
         return param1[param2];
      }
      
      public static function setProperty(param1:UIComponent, param2:String, param3:*) : void {
         param1[param2] = param3;
      }
   }
}
