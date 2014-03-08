package com.ankamagames.berilia.components.params
{
   import com.ankamagames.berilia.utils.UiProperties;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class TooltipProperties extends UiProperties
   {
      
      public function TooltipProperties(tooltip:Tooltip, autoHide:Boolean, position:IRectangle, point:uint, relativePoint:uint, offset:int, data:*, makerParam:Object, zoom:Number=1, alwaysDisplayed:Boolean=true) {
         super();
         this.position = position;
         this.tooltip = tooltip;
         this.autoHide = autoHide;
         this.point = point;
         this.relativePoint = relativePoint;
         this.offset = offset;
         this.data = data;
         this.makerName = tooltip.makerName;
         this.makerParam = makerParam;
         this.zoom = zoom;
         this.alwaysDisplayed = alwaysDisplayed;
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
