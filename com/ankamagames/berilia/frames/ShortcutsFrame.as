package com.ankamagames.berilia.frames
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.shortcut.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.replay.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;

    public class ShortcutsFrame extends Object implements Frame
    {
        private var _lastCtrlKey:Boolean = false;
        private var _isProcessingDirectInteraction:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ShortcutsFrame));
        public static var shiftKey:Boolean = false;
        public static var ctrlKey:Boolean = false;
        public static var altKey:Boolean = false;
        public static var shortcutsEnabled:Boolean = true;

        public function ShortcutsFrame()
        {
            return;
        }// end function

        public function get isProcessingDirectInteraction() : Boolean
        {
            return this._isProcessingDirectInteraction;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            this._isProcessingDirectInteraction = false;
            if (!shortcutsEnabled)
            {
                return false;
            }
            switch(true)
            {
                case param1 is KeyboardKeyDownMessage:
                {
                    _loc_2 = KeyboardKeyDownMessage(param1);
                    shiftKey = _loc_2.keyboardEvent.shiftKey;
                    ctrlKey = _loc_2.keyboardEvent.ctrlKey;
                    altKey = _loc_2.keyboardEvent.altKey;
                    this._lastCtrlKey = false;
                    return false;
                }
                case param1 is KeyboardKeyUpMessage:
                {
                    _loc_3 = KeyboardKeyUpMessage(param1);
                    shiftKey = _loc_3.keyboardEvent.shiftKey;
                    ctrlKey = _loc_3.keyboardEvent.ctrlKey;
                    altKey = _loc_3.keyboardEvent.altKey;
                    _loc_4 = _loc_3.keyboardEvent.keyCode;
                    if (_loc_4 == Keyboard.CONTROL)
                    {
                        this._lastCtrlKey = true;
                    }
                    else if (this._lastCtrlKey)
                    {
                        this._lastCtrlKey = false;
                        return false;
                    }
                    this._isProcessingDirectInteraction = true;
                    if (_loc_3.keyboardEvent.shiftKey && _loc_3.keyboardEvent.keyCode == 52)
                    {
                        _loc_5 = 39;
                    }
                    else if (_loc_3.keyboardEvent.shiftKey && _loc_3.keyboardEvent.keyCode == 54)
                    {
                        _loc_5 = 45;
                    }
                    else
                    {
                        _loc_5 = _loc_3.keyboardEvent.charCode;
                    }
                    _loc_6 = BindsManager.getInstance().getShortcutString(_loc_3.keyboardEvent.keyCode, _loc_5);
                    if (FocusHandler.getInstance().getFocus() is TextField && Berilia.getInstance().useIME && IME.enabled)
                    {
                        _loc_11 = FocusHandler.getInstance().getFocus() as TextField;
                        if (_loc_11.parent is Input)
                        {
                            _loc_7 = _loc_11.text != Input(_loc_11.parent).lastTextOnInput;
                            if (!_loc_7 && Input(_loc_11.parent).imeActive)
                            {
                                Input(_loc_11.parent).imeActive = false;
                                _loc_7 = true;
                            }
                            else
                            {
                                Input(_loc_11.parent).imeActive = _loc_7;
                            }
                        }
                    }
                    if (_loc_6 == null || _loc_7)
                    {
                        this._isProcessingDirectInteraction = false;
                        return true;
                    }
                    _loc_8 = new Bind(_loc_6, "", _loc_3.keyboardEvent.altKey, _loc_3.keyboardEvent.ctrlKey, _loc_3.keyboardEvent.shiftKey);
                    _loc_9 = BindsManager.getInstance().getBind(_loc_8);
                    if (_loc_9 != null)
                    {
                        _loc_10 = Shortcut.getShortcutByName(_loc_9.targetedShortcut);
                    }
                    if (BindsManager.getInstance().canBind(_loc_8) && (_loc_10 != null && !_loc_10.disable || _loc_10 == null))
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyboardShortcut, _loc_8, _loc_3.keyboardEvent.keyCode);
                    }
                    if (_loc_9 != null && _loc_10 && !_loc_10.disable)
                    {
                        if (!Shortcut.getShortcutByName(_loc_9.targetedShortcut))
                        {
                            break;
                        }
                        _loc_12 = StageShareManager.stage.focus as TextField;
                        if (_loc_12 && _loc_12.type == TextFieldType.INPUT)
                        {
                            if (!Shortcut.getShortcutByName(_loc_9.targetedShortcut).textfieldEnabled)
                            {
                                break;
                            }
                        }
                        LogFrame.log(LogTypeEnum.SHORTCUT, new KeyboardShortcut(_loc_9.targetedShortcut));
                        BindsManager.getInstance().processCallback(_loc_9, _loc_9.targetedShortcut);
                    }
                    this._isProcessingDirectInteraction = false;
                    return false;
                }
                default:
                {
                    break;
                }
            }
            this._isProcessingDirectInteraction = false;
            return false;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

    }
}
