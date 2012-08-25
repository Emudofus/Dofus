package com.ankamagames.dofus.console.moduleLogger
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    final public class FilterUI extends Sprite
    {
        public var excludeMode:Boolean = false;
        public var isOn:Boolean = true;
        private var _excludeText:String = "";
        private var _excludeList:Array;
        private var _includeText:String = "";
        private var _includeList:Array;
        private var _backgroundColor:uint;
        private var _title:TextField;
        private var _filterList:TextField;
        private var offsetX:int;
        private var offsetY:int;
        private static const TITLE_HEIGHT:int = 20;

        public function FilterUI(param1:uint)
        {
            this._excludeList = new Array();
            this._includeList = new Array();
            this._backgroundColor = param1;
            this.createUI();
            this._filterList.text = "";
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            return;
        }// end function

        public function isFiltered(param1:String) : Boolean
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            param1 = param1.toLocaleLowerCase();
            if (this.excludeMode)
            {
                return this._excludeList.indexOf(param1) != -1;
            }
            if (this._includeList.length)
            {
                _loc_2 = this._includeList.length;
                _loc_3 = -1;
                while (++_loc_3 < _loc_2)
                {
                    
                    if (param1.indexOf(this._includeList[_loc_3]) != -1)
                    {
                        return false;
                    }
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function addToFilter(param1:String) : void
        {
            if (this._filterList.text.toLocaleLowerCase().indexOf(param1.toLocaleLowerCase()) != -1)
            {
                return;
            }
            if (this._filterList.text)
            {
                this._filterList.appendText("\n" + param1);
            }
            else
            {
                this._filterList.appendText(param1);
            }
            this.onTextChange();
            return;
        }// end function

        public function getCurrentOptions() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.excludeMode = this.excludeMode;
            _loc_1.excludeText = this._excludeText;
            _loc_1.includeText = this._includeText;
            _loc_1.isOn = this.isOn;
            return _loc_1;
        }// end function

        public function setOptions(param1:Object) : void
        {
            this.excludeMode = param1.excludeMode;
            this._excludeText = param1.excludeText;
            this._includeText = param1.includeText;
            this.isOn = param1.isOn;
            this.updateTitleText();
            this.onTextChange();
            return;
        }// end function

        public function resize() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (this._filterList && this._title)
            {
                this._filterList.width = this._filterList.textWidth + 10;
                if (this._filterList.width < this._title.width)
                {
                    this._filterList.width = this._title.width;
                }
                this._filterList.height = this._filterList.textHeight + 10;
                if (this._title.width > this._filterList.width)
                {
                    _loc_1 = this._title.width;
                }
                else
                {
                    _loc_1 = this._filterList.width;
                }
                _loc_1 = _loc_1 + 10;
                _loc_2 = this._filterList.y + this._filterList.height;
                graphics.clear();
                graphics.beginFill(this._backgroundColor);
                graphics.drawRoundRect(0, 0, _loc_1, _loc_2, 10);
                graphics.endFill();
                this._filterList.x = 5;
                this._filterList.y = 5 + TITLE_HEIGHT;
                this._title.x = 5;
                this._title.y = 5;
                this._title.height = TITLE_HEIGHT;
            }
            return;
        }// end function

        private function createUI() : void
        {
            this._title = new TextField();
            this._title.addEventListener(TextEvent.LINK, this.onTitleClick);
            this._title.multiline = false;
            this._title.selectable = false;
            this._title.autoSize = TextFieldAutoSize.LEFT;
            this._filterList = new TextField();
            this._filterList.addEventListener(TextEvent.LINK, this.onTextClick);
            this._filterList.multiline = true;
            this._filterList.wordWrap = false;
            this._filterList.mouseWheelEnabled = false;
            this._filterList.type = TextFieldType.INPUT;
            this._filterList.addEventListener(Event.CHANGE, this.onTextChange);
            var _loc_1:* = new TextFormat();
            _loc_1.font = "Courier New";
            _loc_1.size = 14;
            _loc_1.color = 9937645;
            this._filterList.defaultTextFormat = _loc_1;
            this._title.defaultTextFormat = _loc_1;
            this._title.styleSheet = Console.CONSOLE_STYLE;
            addChild(this._title);
            addChild(this._filterList);
            this.updateTitleText();
            this.resize();
            return;
        }// end function

        private function updateTitleText() : void
        {
            if (this.excludeMode)
            {
                this._title.htmlText = "<a href=\'event:change\'><span class=\'red\'>Filter : Exclude mode</span></a>           <a href=\'event:active\'><span class=\'blue\'>(" + (this.isOn ? ("on") : ("off")) + ")</span></a>";
                this._filterList.text = this._excludeText;
            }
            else
            {
                this._title.htmlText = "<a href=\'event:change\'><span class=\'green\'>Filter : Include mode</span></a>           <a href=\'event:active\'><span class=\'blue\'>(" + (this.isOn ? ("on") : ("off")) + ")</span></a>";
                this._filterList.text = this._includeText;
            }
            return;
        }// end function

        private function onTitleClick(event:TextEvent) : void
        {
            if (event.text == "change")
            {
                this.excludeMode = !this.excludeMode;
                this.updateTitleText();
            }
            else if (event.text == "active")
            {
                this.isOn = !this.isOn;
                this.updateTitleText();
            }
            this.resize();
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        private function onTextClick(event:TextEvent) : void
        {
            return;
        }// end function

        private function onTextChange(event:Event = null) : void
        {
            if (this.excludeMode)
            {
                this._excludeText = this._filterList.text;
                this._excludeList = this._excludeText.toLocaleLowerCase().split("\r");
            }
            else
            {
                this._includeText = this._filterList.text;
                if (this._includeText)
                {
                    this._includeList = this._includeText.toLocaleLowerCase().split("\r");
                }
                else
                {
                    this._includeList = new Array();
                }
            }
            this.resize();
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        private function onMouseDown(event:Event) : void
        {
            return;
        }// end function

        private function onMouseUp(event:Event) : void
        {
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            return;
        }// end function

        private function onMouseMove(event:MouseEvent) : void
        {
            x = stage.mouseX - this.offsetX;
            y = stage.mouseY - this.offsetY;
            event.updateAfterEvent();
            return;
        }// end function

    }
}
