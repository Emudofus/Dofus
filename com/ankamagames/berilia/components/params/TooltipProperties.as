package com.ankamagames.berilia.components.params
{
   import com.ankamagames.berilia.utils.UiProperties;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class TooltipProperties extends UiProperties
   {
      
      public function TooltipProperties(param1:Tooltip, param2:Boolean, param3:IRectangle, param4:uint, param5:uint, param6:int, param7:*, param8:Object, param9:Number=1, param10:Boolean=true) {
         super();
         this.position = param3;
         this.tooltip = param1;
         this.autoHide = param2;
         this.point = param4;
         this.relativePoint = param5;
         this.offset = param6;
         this.data = param7;
         this.makerName = param1.makerName;
         this.makerParam = param8;
         this.zoom = param9;
         this.alwaysDisplayed = param10;
      }
      
      public var position:IRectangle;
      
      public var tooltip:Tooltip;
      
      public var autoHide:Boolean;
      
      public var point:uint = 0;
      
      public var relativePoint:uint = 2;
      
      public var offset:int = 3;
      
      public var data = null;
      
      public var makerName:String;
      
      public var makerParam:Object;
      
      public var zoom:Number;
      
      public var alwaysDisplayed:Boolean;
   }
}
