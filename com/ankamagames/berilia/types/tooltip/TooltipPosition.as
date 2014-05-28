package com.ankamagames.berilia.types.tooltip
{
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   
   public class TooltipPosition extends Object
   {
      
      public function TooltipPosition(pTooltip:UiRootContainer, pTarget:IRectangle, pCellId:uint) {
         super();
         this._tooltip = pTooltip;
         this._target = pTarget;
         this._cellId = pCellId;
         this._rect = new Rectangle2(this._tooltip.x,this._tooltip.y,this._tooltip.width,this._tooltip.height);
         this._originalX = this._tooltip.x;
         this._originalY = this._tooltip.y;
      }
      
      private var _tooltip:UiRootContainer;
      
      private var _target:IRectangle;
      
      private var _cellId:uint;
      
      private var _rect:Rectangle2;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      public function get tooltip() : UiRootContainer {
         return this._tooltip;
      }
      
      public function get target() : IRectangle {
         return this._target;
      }
      
      public function set target(pTarget:IRectangle) : void {
         this._target = pTarget;
      }
      
      public function get cellId() : uint {
         return this._cellId;
      }
      
      public function get mapRow() : int {
         return this._cellId / 14;
      }
      
      public function get rect() : Rectangle2 {
         this._rect.y = this._tooltip.y;
         this._rect.x = this._tooltip.x;
         this._rect.width = this._tooltip.width;
         this._rect.height = this._tooltip.height;
         return this._rect;
      }
      
      public function get originalX() : Number {
         return this._originalX;
      }
      
      public function get originalY() : Number {
         return this._originalY;
      }
   }
}
