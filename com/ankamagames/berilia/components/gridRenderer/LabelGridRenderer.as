package com.ankamagames.berilia.components.gridRenderer
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class LabelGridRenderer extends Object implements IGridRenderer
    {
        protected var _log:Logger;
        private var _grid:Grid;
        private var _bgColor1:ColorTransform;
        private var _bgColor2:ColorTransform;
        private var _selectedColor:ColorTransform;
        private var _overColor:ColorTransform;
        private var _cssUri:Uri;
        private var _shapeIndex:Dictionary;

        public function LabelGridRenderer(param1:String)
        {
            var _loc_2:* = null;
            this._log = Log.getLogger(getQualifiedClassName(LabelGridRenderer));
            this._shapeIndex = new Dictionary(true);
            if (param1)
            {
                _loc_2 = param1.length ? (param1.split(",")) : (null);
                if (_loc_2[0] && _loc_2[0].length)
                {
                    this._cssUri = new Uri(_loc_2[0]);
                }
                if (_loc_2[1] && _loc_2[1].length)
                {
                    this._bgColor1 = new ColorTransform();
                    this._bgColor1.color = parseInt(_loc_2[1], 16);
                }
                if (_loc_2[2] && _loc_2[2].length)
                {
                    this._bgColor2 = new ColorTransform();
                    this._bgColor2.color = parseInt(_loc_2[2], 16);
                }
                if (_loc_2[3] && _loc_2[3].length)
                {
                    this._overColor = new ColorTransform();
                    this._overColor.color = parseInt(_loc_2[3], 16);
                }
                if (_loc_2[4] && _loc_2[4].length)
                {
                    this._selectedColor = new ColorTransform();
                    this._selectedColor.color = parseInt(_loc_2[4], 16);
                }
            }
            return;
        }// end function

        public function set grid(param1:Grid) : void
        {
            this._grid = param1;
            return;
        }// end function

        public function render(param1, param2:uint, param3:Boolean, param4:uint = 0) : DisplayObject
        {
            var _loc_5:* = new Label();
            new Label().mouseEnabled = true;
            _loc_5.useHandCursor = true;
            _loc_5.mouseEnabled = true;
            _loc_5.width = this._grid.slotWidth - 6;
            _loc_5.height = this._grid.slotHeight;
            _loc_5.verticalAlign = "CENTER";
            _loc_5.name = this._grid.getUi().name + "::" + this._grid.name + "::item" + param2;
            if (param1 is String || param1 == null)
            {
                _loc_5.text = param1;
            }
            else
            {
                _loc_5.text = param1.label;
            }
            if (this._cssUri)
            {
                _loc_5.css = this._cssUri;
            }
            this.updateBackground(_loc_5, param2, param3);
            _loc_5.finalize();
            _loc_5.addEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
            _loc_5.addEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
            return _loc_5;
        }// end function

        public function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:uint = 0) : void
        {
            var _loc_6:* = null;
            if (param3 is Label)
            {
                _loc_6 = param3 as Label;
                if (param1 is String || param1 == null)
                {
                    _loc_6.text = param1;
                }
                else
                {
                    _loc_6.text = param1.label;
                }
                this.updateBackground(_loc_6, param2, param4);
            }
            else
            {
                this._log.warn("Can\'t update, " + param3.name + " is not a Label component");
            }
            return;
        }// end function

        public function getDataLength(param1, param2:Boolean) : uint
        {
            return 1;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            var _loc_2:* = null;
            if (param1 is Label)
            {
                _loc_2 = param1 as Label;
                if (_loc_2.parent)
                {
                    _loc_2.parent.removeChild(param1);
                }
                _loc_2.removeEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
                _loc_2.removeEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
            }
            return;
        }// end function

        public function destroy() : void
        {
            this._grid = null;
            this._shapeIndex = null;
            return;
        }// end function

        public function renderModificator(param1:Array) : Array
        {
            return param1;
        }// end function

        public function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String
        {
            return param2;
        }// end function

        private function updateBackground(param1:Label, param2:uint, param3:Boolean) : void
        {
            var _loc_5:* = null;
            if (!this._shapeIndex[param1])
            {
                _loc_5 = new Shape();
                _loc_5.graphics.beginFill(16777215);
                _loc_5.graphics.drawRect(0, 0, this._grid.slotWidth, (this._grid.slotHeight + 1));
                param1.getStrata(0).addChild(_loc_5);
                this._shapeIndex[param1] = {trans:new Transform(_loc_5), shape:_loc_5};
            }
            var _loc_4:* = param2 % 2 ? (this._bgColor1) : (this._bgColor2);
            if (param3 && this._selectedColor)
            {
                _loc_4 = this._selectedColor;
            }
            this._shapeIndex[param1].currentColor = _loc_4;
            DisplayObject(this._shapeIndex[param1].shape).visible = _loc_4 != null;
            if (_loc_4)
            {
                Transform(this._shapeIndex[param1].trans).colorTransform = _loc_4;
            }
            return;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget as Label;
            if (this._overColor && _loc_2.text.length > 0)
            {
                _loc_3 = this._shapeIndex[_loc_2];
                if (_loc_3)
                {
                    Transform(_loc_3.trans).colorTransform = this._overColor;
                    DisplayObject(_loc_3.shape).visible = true;
                }
            }
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget as Label;
            if (_loc_2.text.length > 0)
            {
                _loc_3 = this._shapeIndex[_loc_2];
                if (_loc_3)
                {
                    if (_loc_3.currentColor)
                    {
                        Transform(_loc_3.trans).colorTransform = _loc_3.currentColor;
                    }
                    DisplayObject(_loc_3.shape).visible = _loc_3.currentColor != null;
                }
            }
            return;
        }// end function

    }
}
