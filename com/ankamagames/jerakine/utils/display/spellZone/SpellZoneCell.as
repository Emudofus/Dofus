package com.ankamagames.jerakine.utils.display.spellZone
{
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;

    public class SpellZoneCell extends Sprite
    {
        private var _cellWidth:uint;
        private var _cellHeight:uint;
        private var _cellId:uint;
        private var _defaultColor:uint = 16777215;
        private var _alpha:Number = 0.5;
        private var _spriteCell:Class;
        public var posX:int;
        public var posY:int;
        public var isRangedCell:Boolean = false;

        public function SpellZoneCell(param1:uint, param2:uint, param3:uint)
        {
            this._cellWidth = param1;
            this._cellHeight = param2;
            this._cellId = param3;
            width = this._cellWidth;
            height = this._cellHeight;
            return;
        }// end function

        public function set defaultColor(param1:uint) : void
        {
            this._defaultColor = param1;
            return;
        }// end function

        private function addListeners() : void
        {
            addEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
            addEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }// end function

        private function removeListeners() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
            removeEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
            removeEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }// end function

        public function setNormalCell() : void
        {
            this.removeListeners();
            this._defaultColor = 0;
            this.changeColorToDefault();
            this.isRangedCell = false;
            return;
        }// end function

        public function get cellId() : uint
        {
            return this._cellId;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = new SpellZoneEvent(SpellZoneEvent.CELL_ROLLOVER);
            _loc_2.cell = this;
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            this.colorCell(this._defaultColor);
            var _loc_2:* = new SpellZoneEvent(SpellZoneEvent.CELL_ROLLOUT);
            _loc_2.cell = this;
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            return;
        }// end function

        public function colorCell(param1:uint, param2:Boolean = false) : void
        {
            var _loc_3:* = new Color(param1);
            this.filters = [new ColorMatrixFilter([_loc_3.red / 255, 0, 0, 0, 0, 0, _loc_3.green / 255, 0, 0, 0, 0, 0, _loc_3.blue / 255, 0, 0, 0, 0, 0, this._alpha, 0])];
            if (param2)
            {
                this._defaultColor = param1;
            }
            return;
        }// end function

        public function changeColorToDefault() : void
        {
            this.colorCell(this._defaultColor, true);
            return;
        }// end function

        public function setRangeCell() : void
        {
            this.colorCell(SpellZoneCellManager.RANGE_COLOR, true);
            this.addListeners();
            this.isRangedCell = true;
            return;
        }// end function

        public function setSpellCell() : void
        {
            this.colorCell(SpellZoneCellManager.SPELL_COLOR, false);
            return;
        }// end function

    }
}
