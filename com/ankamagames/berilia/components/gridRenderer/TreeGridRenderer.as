package com.ankamagames.berilia.components.gridRenderer
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TreeGridRenderer extends Object implements IGridRenderer
    {
        protected var _log:Logger;
        private var _grid:Grid;
        private var _bgColor1:ColorTransform;
        private var _bgColor2:ColorTransform;
        private var _selectedColor:ColorTransform;
        private var _overColor:ColorTransform;
        private var _cssUri:Uri;
        private var _expendBtnUri:Uri;
        private var _simpleItemUri:Uri;
        private var _endItemUri:Uri;
        private var _shapeIndex:Dictionary;
        private var _indexRef:Dictionary;
        private var _uriRef:Array;

        public function TreeGridRenderer(param1:String)
        {
            var _loc_2:* = null;
            this._log = Log.getLogger(getQualifiedClassName(LabelGridRenderer));
            this._shapeIndex = new Dictionary(true);
            this._indexRef = new Dictionary(true);
            this._uriRef = new Array();
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
                if (_loc_2[5] && _loc_2[5].length)
                {
                    this._expendBtnUri = new Uri(_loc_2[5]);
                }
                if (_loc_2[6] && _loc_2[6].length)
                {
                    this._simpleItemUri = new Uri(_loc_2[6]);
                }
                if (_loc_2[7] && _loc_2[7].length)
                {
                    this._endItemUri = new Uri(_loc_2[7]);
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
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_5 = new Sprite();
            _loc_5.mouseEnabled = false;
            this._indexRef[_loc_5] = param1;
            _loc_6 = param1;
            var _loc_7:* = new Texture();
            new Texture().mouseEnabled = true;
            _loc_7.width = 10;
            _loc_7.height = this._grid.slotHeight + 1;
            _loc_7.y = (this._grid.slotHeight - 18) / 2;
            if (_loc_6)
            {
                _loc_7.x = _loc_6.depth * _loc_7.width;
                if (_loc_6.children && _loc_6.children.length)
                {
                    _loc_7.uri = this._expendBtnUri;
                    _loc_7.buttonMode = true;
                }
                else if (_loc_6.parent.children.indexOf(_loc_6) == (_loc_6.parent.children.length - 1))
                {
                    _loc_7.uri = this._endItemUri;
                }
                else
                {
                    _loc_7.uri = this._simpleItemUri;
                }
                if (_loc_6.expend)
                {
                    _loc_7.gotoAndStop = "selected";
                }
                else
                {
                    _loc_7.gotoAndStop = "normal";
                }
            }
            _loc_7.finalize();
            var _loc_8:* = new Label();
            new Label().mouseEnabled = true;
            _loc_8.useHandCursor = true;
            _loc_8.x = _loc_7.x + _loc_7.width + 3;
            _loc_8.width = this._grid.slotWidth - _loc_8.x;
            _loc_8.height = this._grid.slotHeight;
            if (param1 && param1.hasOwnProperty("css"))
            {
                if (param1.css is String)
                {
                    if (!this._uriRef[param1.css])
                    {
                        this._uriRef[param1.css] = new Uri(param1.css);
                    }
                    _loc_8.css = this._uriRef[param1.css];
                }
                else
                {
                    _loc_8.css = param1.css;
                }
            }
            if (param1 is String || param1 == null)
            {
                _loc_8.text = param1;
            }
            else
            {
                _loc_8.text = param1.label;
            }
            if (this._cssUri)
            {
                _loc_8.css = this._cssUri;
            }
            this.updateBackground(_loc_5, param2, param3);
            _loc_8.addEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
            _loc_8.addEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
            _loc_7.addEventListener(MouseEvent.CLICK, this.onRelease);
            _loc_8.finalize();
            _loc_5.addChild(_loc_7);
            _loc_5.addChild(_loc_8);
            return _loc_5;
        }// end function

        public function getDataLength(param1, param2:Boolean) : uint
        {
            return 1;
        }// end function

        public function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:uint = 0) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param3 is Sprite)
            {
                _loc_6 = param1;
                this._indexRef[param3] = _loc_6;
                _loc_7 = Sprite(param3).getChildAt(1) as Texture;
                _loc_8 = Sprite(param3).getChildAt(2) as Label;
                if (_loc_6 != null)
                {
                    _loc_7.x = _loc_6.depth * 10 + 3;
                    if (_loc_6.children && _loc_6.children.length)
                    {
                        _loc_7.uri = this._expendBtnUri;
                        if (_loc_6.expend)
                        {
                            _loc_7.gotoAndStop = "selected";
                        }
                        else
                        {
                            _loc_7.gotoAndStop = "normal";
                        }
                    }
                    else if (_loc_6.parent.children.indexOf(_loc_6) == (_loc_6.parent.children.length - 1))
                    {
                        _loc_7.uri = this._endItemUri;
                    }
                    else
                    {
                        _loc_7.uri = this._simpleItemUri;
                    }
                    _loc_8.x = _loc_7.x + _loc_7.width + 3;
                    _loc_8.width = this._grid.slotWidth - _loc_8.x;
                    if (param1 && param1.value.hasOwnProperty("css"))
                    {
                        if (param1.value.css is String)
                        {
                            if (!this._uriRef[param1.value.css])
                            {
                                this._uriRef[param1.value.css] = new Uri(param1.value.css);
                            }
                            _loc_8.css = this._uriRef[param1.value.css];
                        }
                        else
                        {
                            _loc_8.css = param1.value.css;
                        }
                    }
                    else
                    {
                        _loc_8.css = this._cssUri;
                    }
                    _loc_8.text = _loc_6.label;
                    _loc_8.finalize();
                }
                else
                {
                    _loc_8.text = "";
                    _loc_7.uri = null;
                }
                this.updateBackground(param3 as Sprite, param2, param4);
            }
            else
            {
                this._log.warn("Can\'t update, " + param3.name + " is not a Sprite");
            }
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            var _loc_2:* = null;
            this._indexRef[param1] = null;
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

        private function updateBackground(param1:Sprite, param2:uint, param3:Boolean) : void
        {
            var _loc_5:* = null;
            if (!this._shapeIndex[param1])
            {
                _loc_5 = new Shape();
                _loc_5.graphics.beginFill(16777215);
                _loc_5.graphics.drawRect(0, 0, this._grid.slotWidth, (this._grid.slotHeight + 1));
                param1.addChildAt(_loc_5, 0);
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
            var _loc_2:* = null;
            if (event.target.name.indexOf("extension") == -1 && event.target.text.length)
            {
                _loc_2 = event.target.parent as Sprite;
                if (this._overColor)
                {
                    Transform(this._shapeIndex[_loc_2].trans).colorTransform = this._overColor;
                    DisplayObject(this._shapeIndex[_loc_2].shape).visible = true;
                }
            }
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.target.name.indexOf("extension") == -1)
            {
                _loc_2 = event.target.parent as Sprite;
                if (this._shapeIndex[_loc_2])
                {
                    if (this._shapeIndex[_loc_2].currentColor)
                    {
                        Transform(this._shapeIndex[_loc_2].trans).colorTransform = this._shapeIndex[_loc_2].currentColor;
                    }
                    DisplayObject(this._shapeIndex[_loc_2].shape).visible = this._shapeIndex[_loc_2].currentColor != null;
                }
            }
            return;
        }// end function

        private function onRelease(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._indexRef[event.target.parent];
            _loc_2.expend = !_loc_2.expend;
            Tree(this._grid).rerender();
            for each (_loc_3 in Berilia.getInstance().UISoundListeners)
            {
                
                _loc_3.playUISound("16004");
            }
            return;
        }// end function

    }
}
