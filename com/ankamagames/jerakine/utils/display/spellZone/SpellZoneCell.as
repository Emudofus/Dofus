package com.ankamagames.jerakine.utils.display.spellZone
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.types.Color;
   import flash.filters.ColorMatrixFilter;
   
   public class SpellZoneCell extends Sprite
   {
      
      public function SpellZoneCell(param1:uint, param2:uint, param3:uint) {
         super();
         this._cellWidth = param1;
         this._cellHeight = param2;
         this._cellId = param3;
         width = this._cellWidth;
         height = this._cellHeight;
      }
      
      private var _cellWidth:uint;
      
      private var _cellHeight:uint;
      
      private var _cellId:uint;
      
      private var _defaultColor:uint = 16777215;
      
      private var _alpha:Number = 0.5;
      
      private var _spriteCell:Class;
      
      public var posX:int;
      
      public var posY:int;
      
      public var isRangedCell:Boolean = false;
      
      public function set defaultColor(param1:uint) : void {
         this._defaultColor = param1;
      }
      
      private function addListeners() : void {
         addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListeners() : void {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
         removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function setNormalCell() : void {
         this.removeListeners();
         this._defaultColor = 0;
         this.changeColorToDefault();
         this.isRangedCell = false;
      }
      
      public function get cellId() : uint {
         return this._cellId;
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         var _loc2_:SpellZoneEvent = new SpellZoneEvent(SpellZoneEvent.CELL_ROLLOVER);
         _loc2_.cell = this;
         dispatchEvent(_loc2_);
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.colorCell(this._defaultColor);
         var _loc2_:SpellZoneEvent = new SpellZoneEvent(SpellZoneEvent.CELL_ROLLOUT);
         _loc2_.cell = this;
         dispatchEvent(_loc2_);
      }
      
      private function onClick(param1:MouseEvent) : void {
      }
      
      public function colorCell(param1:uint, param2:Boolean=false) : void {
         var _loc3_:Color = new Color(param1);
         this.filters = [new ColorMatrixFilter([_loc3_.red / 255,0,0,0,0,0,_loc3_.green / 255,0,0,0,0,0,_loc3_.blue / 255,0,0,0,0,0,this._alpha,0])];
         if(param2)
         {
            this._defaultColor = param1;
         }
      }
      
      public function changeColorToDefault() : void {
         this.colorCell(this._defaultColor,true);
      }
      
      public function setRangeCell() : void {
         this.colorCell(SpellZoneCellManager.RANGE_COLOR,true);
         this.addListeners();
         this.isRangedCell = true;
      }
      
      public function setSpellCell() : void {
         this.colorCell(SpellZoneCellManager.SPELL_COLOR,false);
      }
   }
}
