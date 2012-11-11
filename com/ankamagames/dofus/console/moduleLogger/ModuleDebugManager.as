package com.ankamagames.dofus.console.moduleLogger
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    final public class ModuleDebugManager extends Object
    {
        private static const WIDTH:int = 200;
        private static const HEIGHT:int = 40;
        private static var _ui:Sprite;
        private static var _fpsShape:Shape;
        private static var _textField:TextField;
        private static var _lastSecond:int;
        private static var _numImages:int;
        private static var _offSetX:int;
        private static var _offSetY:int;
        private static var _valuesList:Vector.<int> = new Vector.<int>;
        private static var _lastValue:int = 0;
        private static var _console1:ConsoleIcon;
        private static var _console2:ConsoleIcon;

        public function ModuleDebugManager()
        {
            return;
        }// end function

        public static function display(param1:Boolean) : void
        {
            if (param1)
            {
                if (!_ui)
                {
                    createUI();
                }
                StageShareManager.stage.addChild(_ui);
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, loop);
            }
            else if (_ui && _ui.parent)
            {
                _ui.parent.removeChild(_ui);
            }
            return;
        }// end function

        private static function loop(event:Event) : void
        {
            if (!_ui.stage)
            {
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, loop);
                return;
            }
            var _loc_2:* = getTimer();
            if (_loc_2 - _lastSecond > 1000)
            {
                _textField.htmlText = "<font color=\'#7C87D1\'>fps : " + _numImages + "</font>\n<font color=\'#00BBBB\'>mem : " + int(System.totalMemory / 100000) / 10 + " mb</font>";
                _numImages = 0;
                _lastSecond = _loc_2;
            }
            else
            {
                var _loc_7:* = _numImages + 1;
                _numImages = _loc_7;
            }
            var _loc_3:* = _loc_2 - _lastValue;
            _valuesList.push(-_loc_3);
            if (_valuesList.length > WIDTH)
            {
                _valuesList.shift();
            }
            _lastValue = _loc_2;
            _fpsShape.graphics.clear();
            _fpsShape.graphics.lineStyle(1, 16777215, 1, true);
            _fpsShape.graphics.moveTo(0, _valuesList[0]);
            var _loc_4:* = _valuesList.length;
            var _loc_5:* = 0;
            while (++_loc_5 < _loc_4)
            {
                
                _fpsShape.graphics.lineTo(_loc_5, _valuesList[_loc_5]);
            }
            return;
        }// end function

        private static function createUI() : void
        {
            if (_ui)
            {
                throw new Error();
            }
            _ui = new Sprite();
            var _loc_3:* = 100;
            _ui.y = 100;
            _ui.x = _loc_3;
            _fpsShape = new Shape();
            _ui.addChild(_fpsShape);
            _fpsShape.y = 20;
            var _loc_1:* = new Sprite();
            _ui.addChild(_loc_1);
            _loc_1.graphics.beginFill(0, 0.7);
            _loc_1.graphics.lineTo(0, HEIGHT);
            _loc_1.graphics.lineTo(WIDTH, HEIGHT);
            _loc_1.graphics.lineTo(WIDTH, 0);
            _loc_1.graphics.endFill();
            _loc_1.graphics.lineStyle(2);
            _loc_1.graphics.moveTo(0, 0);
            _loc_1.graphics.lineTo(0, HEIGHT);
            _loc_1.graphics.lineTo(WIDTH, HEIGHT);
            _loc_1.graphics.lineTo(WIDTH, 0);
            _textField = new TextField();
            _ui.addChild(_textField);
            _textField.multiline = true;
            _textField.wordWrap = false;
            _textField.mouseEnabled = false;
            _textField.width = WIDTH;
            _textField.height = HEIGHT;
            var _loc_2:* = new TextFormat("Courier New", 15, 12763866);
            _loc_2.leading = -2;
            _textField.defaultTextFormat = _loc_2;
            _console1 = new ConsoleIcon("screen");
            _console1.x = WIDTH - (_console1.width + 2);
            _console1.y = HEIGHT - (_console1.height * 2 + 4);
            _console1.addEventListener(MouseEvent.MOUSE_DOWN, onOpenConsole);
            _ui.addChild(_console1);
            _console2 = new ConsoleIcon("terminal");
            _console2.x = WIDTH - (_console2.width + 2);
            _console2.y = HEIGHT - (_console2.height + 2);
            _console2.addEventListener(MouseEvent.MOUSE_DOWN, onOpenLogConsole);
            _ui.addChild(_console2);
            _loc_1.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            return;
        }// end function

        private static function onOpenLogConsole(event:Event) : void
        {
            KernelEventsManager.getInstance().processCallback(HookList.ToggleConsole);
            return;
        }// end function

        private static function onOpenConsole(event:Event) : void
        {
            Console.getInstance().toggleDisplay();
            return;
        }// end function

        private static function onMouseDown(event:Event) : void
        {
            _offSetX = _ui.mouseX;
            _offSetY = _ui.mouseY;
            _ui.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            _ui.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            return;
        }// end function

        private static function onMouseUp(event:Event) : void
        {
            _ui.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            _ui.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            return;
        }// end function

        private static function onMouseMove(event:MouseEvent) : void
        {
            _ui.x = _ui.stage.mouseX - _offSetX;
            _ui.y = _ui.stage.mouseY - _offSetY;
            event.updateAfterEvent();
            return;
        }// end function

    }
}
