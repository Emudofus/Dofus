package com.ankamagames.jerakine.handlers
{
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;

    public class HumanInputHandler extends MessageDispatcher
    {
        private var _handler:MessageHandler;
        private var _keyPoll:KeyPoll;
        private var _lastTarget:WeakReference;
        private var _lastDoucleClick:int;
        private var _lastSingleClick:int;
        private var _appleDown:Boolean;
        private var _appleKeyboardEvent:KeyboardEvent;
        private static var _self:HumanInputHandler;
        private static const DOUBLE_CLICK_DELAY:uint = 500;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanInputHandler));

        public function HumanInputHandler()
        {
            if (_self != null)
            {
                throw new SingletonError("HumanInputHandler constructor should not be called directly.");
            }
            this.initialize();
            return;
        }// end function

        public function get handler() : MessageHandler
        {
            return this._handler;
        }// end function

        public function set handler(param1:MessageHandler) : void
        {
            this._handler = param1;
            return;
        }// end function

        public function getKeyboardPoll() : KeyPoll
        {
            return this._keyPoll;
        }// end function

        public function resetClick() : void
        {
            this._lastTarget = null;
            return;
        }// end function

        private function initialize() : void
        {
            this._keyPoll = new KeyPoll();
            this.registerListeners();
            return;
        }// end function

        public function unregisterListeners(param1:Stage = null) : void
        {
            var target:* = param1;
            if (target == null)
            {
                target = StageShareManager.stage;
            }
            target.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onDoubleClick, true);
            target.removeEventListener(MouseEvent.CLICK, this.onClick, true);
            target.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel, true);
            target.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, true);
            target.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, true);
            target.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown, true);
            target.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp, true);
            try
            {
                target.removeEventListener(MouseEvent.MIDDLE_CLICK, this.onMiddleClick, true);
                target.removeEventListener(MouseEvent.RIGHT_CLICK, this.onRightClick, true);
            }
            catch (e:TypeError)
            {
                _log.error("RIGHT_CLICK / MIDDLE_CLICK non supporté");
            }
            target.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
            target.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false);
            return;
        }// end function

        public function registerListeners(param1:Stage = null) : void
        {
            var target:* = param1;
            if (target == null)
            {
                target = StageShareManager.stage;
            }
            target.addEventListener(MouseEvent.DOUBLE_CLICK, this.onDoubleClick, true, 1, true);
            target.addEventListener(MouseEvent.CLICK, this.onClick, true, 1, true);
            target.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel, true, 1, true);
            target.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, true, 1, true);
            target.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, true, 1, true);
            target.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown, true, 1, true);
            target.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp, true, 1, true);
            try
            {
                target.addEventListener(MouseEvent.MIDDLE_CLICK, this.onMiddleClick, true, 1, true);
                target.addEventListener(MouseEvent.RIGHT_CLICK, this.onRightClick, true, 1, true);
            }
            catch (e:TypeError)
            {
                _log.error("RIGHT_CLICK / MIDDLE_CLICK non supporté");
            }
            target.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 1, true);
            target.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 1, true);
            return;
        }// end function

        private function onDoubleClick(event:MouseEvent) : void
        {
            this._handler.process(new MouseDoubleClickMessage(InteractiveObject(event.target), event));
            this._lastDoucleClick = getTimer();
            return;
        }// end function

        private function onClick(event:MouseEvent) : void
        {
            _log.debug("[DEBUG MODO] CLICK : " + event.target.name);
            var _loc_2:* = getTimer();
            if (_loc_2 - this._lastDoucleClick < DOUBLE_CLICK_DELAY)
            {
                this._lastSingleClick = _loc_2;
                this._lastDoucleClick = 0;
            }
            else if (_loc_2 - this._lastSingleClick < DOUBLE_CLICK_DELAY)
            {
                this._handler.process(new MouseDoubleClickMessage(InteractiveObject(event.target), event));
                this._lastDoucleClick = _loc_2;
            }
            else
            {
                this._handler.process(new MouseClickMessage(InteractiveObject(event.target), event));
            }
            return;
        }// end function

        private function onMouseWheel(event:MouseEvent) : void
        {
            this._handler.process(new MouseWheelMessage(InteractiveObject(event.target), event));
            return;
        }// end function

        private function onMouseOver(event:MouseEvent) : void
        {
            this._handler.process(new MouseOverMessage(InteractiveObject(event.target), event));
            return;
        }// end function

        private function onMouseOut(event:MouseEvent) : void
        {
            this._handler.process(new MouseOutMessage(InteractiveObject(event.target), event));
            return;
        }// end function

        private function onMiddleClick(event:MouseEvent) : void
        {
            this._handler.process(new MouseMiddleClickMessage(InteractiveObject(event.target), event));
            return;
        }// end function

        private function onRightClick(event:MouseEvent) : void
        {
            if (this._lastTarget != null && this._lastTarget.object != event.target)
            {
                this._handler.process(new MouseRightClickOutsideMessage(InteractiveObject(this._lastTarget.object), event));
            }
            this._lastTarget = new WeakReference(event.target);
            this._handler.process(new MouseRightClickMessage(InteractiveObject(event.target), event));
            return;
        }// end function

        private function onMouseDown(event:MouseEvent) : void
        {
            this._lastTarget = new WeakReference(event.target);
            this._handler.process(new MouseDownMessage(InteractiveObject(event.target), event));
            return;
        }// end function

        private function onMouseUp(event:MouseEvent) : void
        {
            if (this._lastTarget != null && this._lastTarget.object != event.target)
            {
                this._handler.process(new MouseReleaseOutsideMessage(InteractiveObject(this._lastTarget.object), event));
            }
            FocusHandler.getInstance().setFocus(InteractiveObject(event.target));
            this._handler.process(new MouseUpMessage(InteractiveObject(event.target), event));
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == Keyboard.ESCAPE)
            {
                event.preventDefault();
            }
            if (event.keyCode == 15)
            {
                this._appleDown = true;
            }
            if (this._appleDown)
            {
                this._appleKeyboardEvent = event;
            }
            else
            {
                this._appleKeyboardEvent = null;
            }
            this._handler.process(new KeyboardKeyDownMessage(FocusHandler.getInstance().getFocus(), event));
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            if (this._appleDown)
            {
                if (event.keyCode == 15 && this._appleKeyboardEvent)
                {
                    this._handler.process(new KeyboardKeyUpMessage(FocusHandler.getInstance().getFocus(), this._appleKeyboardEvent));
                }
                this._appleDown = false;
            }
            this._handler.process(new KeyboardKeyUpMessage(FocusHandler.getInstance().getFocus(), event));
            return;
        }// end function

        public static function getInstance() : HumanInputHandler
        {
            if (_self == null)
            {
                _self = new HumanInputHandler;
            }
            return _self;
        }// end function

    }
}
