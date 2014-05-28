package com.ankamagames.jerakine.utils.display.spellZone
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.types.Color;
   import flash.filters.ColorMatrixFilter;
   
   public class SpellZoneCell extends Sprite
   {
      
      public function SpellZoneCell(pWidth:uint, pHeight:uint, pId:uint) {
         super();
         this._cellWidth = pWidth;
         this._cellHeight = pHeight;
         this._cellId = pId;
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
      
      public function set defaultColor(pColor:uint) : void {
         this._defaultColor = pColor;
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
      
      private function onRollOver(e:MouseEvent) : void {
         var event:SpellZoneEvent = new SpellZoneEvent(SpellZoneEvent.CELL_ROLLOVER);
         event.cell = this;
         dispatchEvent(event);
      }
      
      private function onRollOut(e:MouseEvent) : void {
         this.colorCell(this._defaultColor);
         var event:SpellZoneEvent = new SpellZoneEvent(SpellZoneEvent.CELL_ROLLOUT);
         event.cell = this;
         dispatchEvent(event);
      }
      
      private function onClick(e:MouseEvent) : void {
      }
      
      public function colorCell(color:uint, setDefault:Boolean = false) : void {
         var oColor:Color = new Color(color);
         this.filters = [new ColorMatrixFilter([oColor.red / 255,0,0,0,0,0,oColor.green / 255,0,0,0,0,0,oColor.blue / 255,0,0,0,0,0,this._alpha,0])];
         if(setDefault)
         {
            this._defaultColor = color;
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
