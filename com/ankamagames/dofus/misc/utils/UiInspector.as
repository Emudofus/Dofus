package com.ankamagames.dofus.misc.utils
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;

    public class UiInspector extends Object
    {
        private var _highlightShape:Shape;
        private var _highlightShape2:Shape;
        private var _highlightEffect:ColorTransform;
        private var _normalEffect:ColorTransform;
        private var _tooltipTf:TextField;
        private var _tooltip:Sprite;
        private var _enable:Boolean;
        private var _lastTarget:GraphicContainer;
        private var _uiRoot:UiRootContainer;

        public function UiInspector()
        {
            this._highlightEffect = new ColorTransform(1.2, 1.2, 1.2);
            this._normalEffect = new ColorTransform(1, 1, 1);
            this._tooltipTf = new TextField();
            this._tooltip = new Sprite();
            this._highlightShape = new Shape();
            this._highlightShape2 = new Shape();
            this._tooltip.mouseEnabled = false;
            this._tooltipTf.mouseEnabled = false;
            var _loc_1:* = new TextFormat("Verdana");
            this._tooltipTf.defaultTextFormat = _loc_1;
            this._tooltipTf.multiline = true;
            this._tooltipTf.width = 100;
            this._tooltipTf.height = 100;
            this._tooltip.addChild(this._tooltipTf);
            this._tooltipTf.autoSize = TextFieldAutoSize.LEFT;
            return;
        }// end function

        public function set enable(param1:Boolean) : void
        {
            if (param1)
            {
                StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER, this.onRollover);
                StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OUT, this.onRollout);
                StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            }
            else
            {
                StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER, this.onRollover);
                StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OUT, this.onRollout);
                StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
                this.onRollout(this._lastTarget);
            }
            this._enable = param1;
            return;
        }// end function

        public function get enable() : Boolean
        {
            return this._enable;
        }// end function

        private function onRollout(param1) : void
        {
            var _loc_3:* = null;
            if (this._highlightShape2.parent)
            {
                StageShareManager.stage.removeChild(this._highlightShape2);
            }
            if (this._highlightShape.parent)
            {
                StageShareManager.stage.removeChild(this._highlightShape);
            }
            if (this._tooltip.parent)
            {
                StageShareManager.stage.removeChild(this._tooltip);
            }
            var _loc_2:* = this.getBeriliaElement(param1 is DisplayObject ? (param1) : (param1.target));
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3 is UiRootContainer)
                {
                    _loc_3.transform.colorTransform = this._normalEffect;
                }
            }
            return;
        }// end function

        private function onRollover(event:MouseEvent) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = this.getBeriliaElement(event.target as DisplayObject);
            for each (_loc_6 in _loc_2)
            {
                
                if (_loc_6 is UiRootContainer)
                {
                    if (!_loc_4)
                    {
                        _loc_4 = true;
                        StageShareManager.stage.addChild(this._highlightShape2);
                        _loc_5 = _loc_6.getBounds(StageShareManager.stage);
                        this._highlightShape2.graphics.clear();
                        this._highlightShape2.graphics.lineStyle(2, 255, 0.7);
                        this._highlightShape2.graphics.beginFill(255, 0);
                        this._highlightShape2.graphics.drawRect(_loc_5.left, _loc_5.top, _loc_5.width, _loc_5.height);
                        this._highlightShape2.graphics.endFill();
                        this._uiRoot = _loc_6 as UiRootContainer;
                    }
                    continue;
                }
                if (!_loc_3)
                {
                    this._lastTarget = _loc_6;
                    _loc_3 = true;
                    StageShareManager.stage.addChild(this._highlightShape);
                    _loc_5 = _loc_6.getBounds(StageShareManager.stage);
                    this._highlightShape.graphics.clear();
                    this._highlightShape.graphics.lineStyle(3, 0, 0.7);
                    this._highlightShape.graphics.beginFill(16711680, 0.4);
                    this._highlightShape.graphics.drawRect(_loc_5.left, _loc_5.top, _loc_5.width, _loc_5.height);
                    this._highlightShape.graphics.endFill();
                }
            }
            this.buildTooltip(_loc_2);
            return;
        }// end function

        private function getBeriliaElement(param1:DisplayObject) : Array
        {
            var _loc_2:* = [];
            while (param1 && !(param1 is Stage) && param1.parent)
            {
                
                if (param1 is UiRootContainer || param1 is GraphicContainer)
                {
                    _loc_2.push(param1);
                }
                param1 = param1.parent;
            }
            return _loc_2;
        }// end function

        private function buildTooltip(param1:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = "";
            var _loc_3:* = "";
            if (param1.length)
            {
                _loc_2 = _loc_2 + "<font size=\'16\'><b>Elément</b></font><br/>";
                _loc_2 = _loc_2 + ("<b>Nom : </b>" + param1[0].name + "<br/>");
                _loc_2 = _loc_2 + ("<b>Type : </b>" + getQualifiedClassName(param1[0]).split("::").pop() + "<br/>");
                _loc_4 = UiSoundManager.getInstance().getAllSoundUiElement(param1[0]);
                _loc_2 = _loc_2 + ("<b>Sons : </b>" + (_loc_4.length ? ("") : ("Aucun")) + "<br/>");
                if (_loc_4.length)
                {
                    for each (_loc_5 in _loc_4)
                    {
                        
                        _loc_2 = _loc_2 + ("&nbsp;&nbsp;&nbsp; - " + _loc_5.hook + " : " + _loc_5.file + "<br/>");
                    }
                }
                _loc_3 = "<br/>---------- AIDE ---------<br/>";
                _loc_3 = _loc_3 + "[Ctrl + c] : Copier ses informations<br/>";
                _loc_3 = _loc_3 + "[Ctrl + Shift + s] : Copier la commande son au survol<br/>";
                _loc_3 = _loc_3 + "[Ctrl + Shift + c] : Copier la commande son au click";
                _loc_3 = _loc_3 + "[Ctrl + Shift + i] : Copier la commande inspecter element";
            }
            if (this._uiRoot && this._uiRoot.uiData)
            {
                if (param1.length)
                {
                    _loc_2 = _loc_2 + "<br/>";
                }
                _loc_2 = _loc_2 + "<font size=\'16\'><b>Interface</b></font><br/>";
                _loc_2 = _loc_2 + ("<b>Nom : </b>" + this._uiRoot.uiData.name + "<br/>");
                _loc_2 = _loc_2 + ("<b>Script : </b>" + this._uiRoot.uiData.uiClassName + "<br/>");
            }
            _loc_2 = _loc_2 + _loc_3;
            if (_loc_2.length)
            {
                this._tooltipTf.htmlText = _loc_2;
                this._tooltip.graphics.clear();
                this._tooltip.graphics.beginFill(16777215, 0.9);
                this._tooltip.graphics.lineStyle(1, 0, 0.7);
                this._tooltip.graphics.drawRect(-5, -5, this._tooltipTf.textWidth + 10, this._tooltipTf.textHeight + 10);
                this._tooltip.graphics.endFill();
                if (param1.length)
                {
                    _loc_6 = param1[0].getBounds(StageShareManager.stage);
                    this._tooltip.x = _loc_6.left;
                    this._tooltip.y = _loc_6.top - this._tooltip.height - 5;
                    if (this._tooltip.y < 0)
                    {
                        this._tooltip.y = _loc_6.top + _loc_6.height + 5;
                    }
                    if (this._tooltip.y > StageShareManager.startHeight)
                    {
                        this._tooltip.y = 0;
                    }
                }
                else
                {
                    var _loc_7:* = 0;
                    this._tooltip.y = 0;
                    this._tooltip.x = _loc_7;
                }
                StageShareManager.stage.addChild(this._tooltip);
            }
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            if (event.ctrlKey && event.keyCode == Keyboard.C)
            {
                if (this._lastTarget)
                {
                    if (!event.shiftKey)
                    {
                        Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, this._tooltipTf.text);
                    }
                    else
                    {
                        Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, "/adduisoundelement " + this._lastTarget.getUi().uiData.name + " " + this._lastTarget.name + " onRelease [ID_SON]");
                    }
                }
            }
            if (event.ctrlKey && event.keyCode == Keyboard.S)
            {
                Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, "/adduisoundelement " + this._lastTarget.getUi().uiData.name + " " + this._lastTarget.name + " onRollOver [ID_SON]");
            }
            if (event.ctrlKey && event.keyCode == Keyboard.I)
            {
                Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, "/inspectuielement " + this._lastTarget.getUi().uiData.name + " " + this._lastTarget.name);
                this.enable = false;
            }
            return;
        }// end function

    }
}
