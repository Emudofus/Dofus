package com.ankamagames.jerakine.utils.system
{
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;

    public class SystemPopupUI extends Sprite
    {
        private var _title:String;
        private var _content:String;
        private var _modal:Boolean;
        private var _centerContent:Boolean = true;
        private var _buttons:Array;
        private var _mainContainer:Sprite;
        private var _titleTf:TextField;
        private var _contentTf:TextField;
        private var _id:String;
        private var _style_bg_color:uint = 16777215;
        private var _style_font_color:uint = 5592405;
        private var _style_title_color:uint = 14540253;
        private var _style_border_color:uint = 11184810;
        private var _window_width:uint = 900;
        private var _callBacks:Dictionary;
        private static const _popupRef:Dictionary = new Dictionary();

        public function SystemPopupUI(param1:String)
        {
            if (_popupRef[param1])
            {
                throw new ArgumentError("A SystemPopupUI called \'" + param1 + "\' already exist, call destroy() before.");
            }
            _popupRef[param1] = this;
            this._id = param1;
            return;
        }// end function

        public function destroy() : void
        {
            if (parent)
            {
                parent.removeChild(this);
                this.buildUI(true);
                delete _popupRef[this._id];
            }
            return;
        }// end function

        public function show() : void
        {
            StageShareManager.stage.addChild(this);
            return;
        }// end function

        public function get modal() : Boolean
        {
            return this._modal;
        }// end function

        public function set modal(param1:Boolean) : void
        {
            if (param1 != this._modal)
            {
                this._modal = param1;
                graphics.clear();
                if (param1)
                {
                    graphics.beginFill(16777215, 0.7);
                    graphics.drawRect(0, 0, StageShareManager.startWidth, StageShareManager.startHeight);
                }
            }
            return;
        }// end function

        public function get buttons() : Array
        {
            return this._buttons;
        }// end function

        public function set buttons(param1:Array) : void
        {
            this._buttons = param1;
            this.buildUI();
            return;
        }// end function

        public function get content() : String
        {
            return this._content;
        }// end function

        public function set content(param1:String) : void
        {
            this._content = param1;
            this.buildUI();
            return;
        }// end function

        public function get title() : String
        {
            return this._title;
        }// end function

        public function set title(param1:String) : void
        {
            this._title = param1;
            this.buildUI();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._window_width = param1;
            this.buildUI();
            return;
        }// end function

        public function set centerContent(param1:Boolean) : void
        {
            this._centerContent = param1;
            this.buildUI();
            return;
        }// end function

        public function get centerContent() : Boolean
        {
            return this._centerContent;
        }// end function

        private function buildUI(param1:Boolean = false) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:Sprite = null;
            var _loc_5:Object = null;
            var _loc_6:DisplayObject = null;
            if (!this._title || !this._content)
            {
                return;
            }
            while (numChildren)
            {
                
                removeChildAt(0);
            }
            if (this._callBacks)
            {
                for (_loc_3 in this._callBacks)
                {
                    
                    Sprite(_loc_3).removeEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOver);
                    Sprite(_loc_3).removeEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOut);
                    Sprite(_loc_3).removeEventListener(MouseEvent.CLICK, this.onBtnClick);
                }
            }
            this._callBacks = new Dictionary();
            if (param1)
            {
                return;
            }
            this._mainContainer = new Sprite();
            addChild(this._mainContainer);
            this._titleTf = new TextField();
            this._titleTf.selectable = false;
            this._titleTf.autoSize = TextFieldAutoSize.LEFT;
            this._titleTf.height = 20;
            var _loc_2:* = new TextFormat("Verdana", 16, this._style_font_color, true);
            this._titleTf.defaultTextFormat = _loc_2;
            this._titleTf.text = this._title;
            this._mainContainer.addChild(this._titleTf);
            this._contentTf = new TextField();
            this._contentTf.width = this._window_width;
            _loc_2 = new TextFormat("Verdana", 14, this._style_font_color, null, null, null, null, null, this._centerContent ? (TextFormatAlign.CENTER) : (TextFormatAlign.LEFT));
            this._contentTf.defaultTextFormat = _loc_2;
            this._contentTf.wordWrap = true;
            this._contentTf.multiline = true;
            this._contentTf.text = this._content;
            this._contentTf.height = (this._content.split("\n").length + 1) * 23;
            this._contentTf.y = 30;
            this._mainContainer.addChild(this._contentTf);
            if (this._buttons && this._buttons.length)
            {
                _loc_4 = new Sprite();
                for each (_loc_5 in this._buttons)
                {
                    
                    _loc_6 = this.createButton(_loc_5.label);
                    this._callBacks[_loc_6] = _loc_5.callback;
                    _loc_6.x = _loc_4.width ? (_loc_4.width + 10) : (0);
                    _loc_4.addChild(_loc_6);
                }
                _loc_4.y = this._contentTf.y + this._contentTf.height + 10;
                _loc_4.x = (this._mainContainer.width - _loc_4.width) / 2;
                this._mainContainer.addChild(_loc_4);
            }
            this._mainContainer.graphics.lineStyle(1, this._style_border_color);
            this._mainContainer.graphics.beginFill(this._style_bg_color);
            this._mainContainer.graphics.drawRect(-2, -2, this._window_width + 4, this._mainContainer.height + 10);
            this._mainContainer.graphics.beginFill(this._style_title_color);
            this._mainContainer.graphics.drawRect(-2, -2, this._window_width + 4, 25);
            this._mainContainer.x = (StageShareManager.startWidth - this._mainContainer.width) / 2;
            this._mainContainer.y = (StageShareManager.startHeight - this._mainContainer.height) / 2;
            this._mainContainer.filters = [new DropShadowFilter(1, 45, 0, 0.5, 10, 10, 1, 3)];
            return;
        }// end function

        private function createButton(param1:String) : DisplayObject
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new TextField();
            var _loc_4:* = new TextFormat("Verdana", 12, this._style_font_color, true, null, null, null, null, TextFormatAlign.CENTER);
            _loc_3.defaultTextFormat = _loc_4;
            _loc_3.text = param1;
            _loc_3.height = 20;
            _loc_3.width = _loc_3.textWidth < 50 ? (50) : (_loc_3.textWidth + 10);
            _loc_3.selectable = false;
            _loc_3.mouseEnabled = false;
            _loc_2.addChild(_loc_3);
            _loc_2.graphics.lineStyle(1, this._style_border_color + 1118481);
            _loc_2.graphics.beginFill(this._style_title_color + 1118481);
            _loc_2.graphics.drawRoundRect(-2, -2, _loc_3.width + 5, 25, 2, 2);
            _loc_2.addEventListener(MouseEvent.MOUSE_OVER, this.onBtnMouseOver);
            _loc_2.addEventListener(MouseEvent.MOUSE_OUT, this.onBtnMouseOut);
            _loc_2.addEventListener(MouseEvent.CLICK, this.onBtnClick);
            _loc_2.buttonMode = true;
            return _loc_2;
        }// end function

        private function onBtnMouseOver(event:Event) : void
        {
            var _loc_2:* = event.target as Sprite;
            _loc_2.graphics.lineStyle(1, this._style_border_color);
            _loc_2.graphics.beginFill(this._style_title_color);
            _loc_2.graphics.drawRoundRect(-2, -2, (_loc_2.width - 1), 25, 2, 2);
            return;
        }// end function

        private function onBtnMouseOut(event:Event) : void
        {
            var _loc_2:* = event.target as Sprite;
            _loc_2.graphics.lineStyle(1, this._style_border_color + 1118481);
            _loc_2.graphics.beginFill(this._style_title_color + 1118481);
            _loc_2.graphics.drawRoundRect(-2, -2, (_loc_2.width - 1), 25, 2, 2);
            return;
        }// end function

        private function onBtnClick(event:Event) : void
        {
            if (this._callBacks[event.target] is Function)
            {
                var _loc_2:* = this._callBacks;
                _loc_2.this._callBacks[event.target]();
            }
            else if (this._callBacks[event.target] is Callback)
            {
                Callback(this._callBacks[event.target]).exec();
            }
            this.destroy();
            return;
        }// end function

        public static function get(param1:String) : SystemPopupUI
        {
            return _popupRef[param1];
        }// end function

    }
}
