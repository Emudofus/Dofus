package com.ankamagames.berilia.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
    import com.ankamagames.berilia.types.shortcut.Shortcut;
    import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
    import flash.ui.Keyboard;
    import com.ankamagames.jerakine.messages.Message;
    import flash.text.TextField;
    import com.ankamagames.berilia.managers.BindsManager;
    import flash.system.IME;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.jerakine.handlers.FocusHandler;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.berilia.types.shortcut.Bind;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.berilia.utils.BeriliaHookList;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.text.TextFieldType;
    import com.ankamagames.jerakine.replay.LogFrame;
    import com.ankamagames.jerakine.replay.LogTypeEnum;
    import com.ankamagames.jerakine.replay.KeyboardShortcut;
    import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
    import flash.events.Event;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import __AS3__.vec.*;

    public class ShortcutsFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ShortcutsFrame));
        public static var shiftKey:Boolean = false;
        public static var ctrlKey:Boolean = false;
        public static var altKey:Boolean = false;
        public static var ctrlKeyDown:Boolean;
        public static var shortcutsEnabled:Boolean = true;

        private var _lastCtrlKey:Boolean = false;
        private var _isProcessingDirectInteraction:Boolean;
        private var _heldShortcuts:Vector.<String>;


        public function get isProcessingDirectInteraction():Boolean
        {
            return (this._isProcessingDirectInteraction);
        }

        public function get heldShortcuts():Vector.<String>
        {
            return (this._heldShortcuts);
        }

        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:KeyboardKeyDownMessage;
            var _local_3:Shortcut;
            var _local_4:KeyboardKeyUpMessage;
            this._isProcessingDirectInteraction = false;
            if (!(shortcutsEnabled))
            {
                return (false);
            };
            switch (true)
            {
                case (msg is KeyboardKeyDownMessage):
                    _local_2 = KeyboardKeyDownMessage(msg);
                    shiftKey = _local_2.keyboardEvent.shiftKey;
                    ctrlKey = _local_2.keyboardEvent.ctrlKey;
                    altKey = _local_2.keyboardEvent.altKey;
                    this._lastCtrlKey = false;
                    if (!(ctrlKeyDown))
                    {
                        ctrlKeyDown = (_local_2.keyboardEvent.keyCode == Keyboard.CONTROL);
                    };
                    _local_3 = this.getShortcut(_local_2);
                    if (((((_local_3) && (_local_3.holdKeys))) && ((this._heldShortcuts.indexOf(_local_3.defaultBind.targetedShortcut) == -1))))
                    {
                        this.handleMessage(_local_2);
                        this._heldShortcuts.push(_local_3.defaultBind.targetedShortcut);
                    };
                    return (false);
                case (msg is KeyboardKeyUpMessage):
                    _local_4 = KeyboardKeyUpMessage(msg);
                    shiftKey = _local_4.keyboardEvent.shiftKey;
                    ctrlKey = _local_4.keyboardEvent.ctrlKey;
                    altKey = _local_4.keyboardEvent.altKey;
                    if (_local_4.keyboardEvent.keyCode == Keyboard.CONTROL)
                    {
                        ctrlKeyDown = false;
                    };
                    return (this.handleMessage(_local_4));
            };
            this._isProcessingDirectInteraction = false;
            return (false);
        }

        private function handleMessage(pKeyboardMessage:KeyboardMessage):Boolean
        {
            var imeActive:Boolean;
            var sh:Shortcut;
            var tf:TextField;
            var focusAsTextField:TextField;
            var heldShortcutIndex:int;
            var keyCode:int = pKeyboardMessage.keyboardEvent.keyCode;
            if (keyCode == Keyboard.CONTROL)
            {
                this._lastCtrlKey = true;
            }
            else
            {
                if (this._lastCtrlKey)
                {
                    this._lastCtrlKey = false;
                    return (false);
                };
            };
            this._isProcessingDirectInteraction = true;
            var sShortcut:String = BindsManager.getInstance().getShortcutString(pKeyboardMessage.keyboardEvent.keyCode, this.getCharCode(pKeyboardMessage));
            if ((((((FocusHandler.getInstance().getFocus() is TextField)) && (Berilia.getInstance().useIME))) && (IME.enabled)))
            {
                tf = (FocusHandler.getInstance().getFocus() as TextField);
                if ((tf.parent is Input))
                {
                    imeActive = !((tf.text == Input(tf.parent).lastTextOnInput));
                    if (((!(imeActive)) && (Input(tf.parent).imeActive)))
                    {
                        Input(tf.parent).imeActive = false;
                        imeActive = true;
                    }
                    else
                    {
                        Input(tf.parent).imeActive = imeActive;
                    };
                };
            }
            else
            {
                IME.enabled = false;
            };
            if ((((sShortcut == null)) || (imeActive)))
            {
                this._isProcessingDirectInteraction = false;
                return (true);
            };
            var bind:Bind = new Bind(sShortcut, "", pKeyboardMessage.keyboardEvent.altKey, pKeyboardMessage.keyboardEvent.ctrlKey, pKeyboardMessage.keyboardEvent.shiftKey);
            var shortcut:Bind = BindsManager.getInstance().getBind(bind);
            if (shortcut != null)
            {
                sh = Shortcut.getShortcutByName(shortcut.targetedShortcut);
            };
            if (((BindsManager.getInstance().canBind(bind)) && (((((!((sh == null))) && (!(sh.disable)))) || ((sh == null))))))
            {
                KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyboardShortcut, bind, pKeyboardMessage.keyboardEvent.keyCode);
            };
            if (((((!((shortcut == null))) && (sh))) && (!(sh.disable))))
            {
                if (!(Shortcut.getShortcutByName(shortcut.targetedShortcut)))
                {
                    return (false);
                };
                if (sh.holdKeys)
                {
                    heldShortcutIndex = this._heldShortcuts.indexOf(sh.defaultBind.targetedShortcut);
                    if (heldShortcutIndex != -1)
                    {
                        this._heldShortcuts.splice(heldShortcutIndex, 1);
                    };
                };
                focusAsTextField = (StageShareManager.stage.focus as TextField);
                if (((focusAsTextField) && ((focusAsTextField.type == TextFieldType.INPUT))))
                {
                    if (!(Shortcut.getShortcutByName(shortcut.targetedShortcut).textfieldEnabled))
                    {
                        return (false);
                    };
                };
                LogFrame.log(LogTypeEnum.SHORTCUT, new KeyboardShortcut(shortcut.targetedShortcut));
                BindsManager.getInstance().processCallback(shortcut, shortcut.targetedShortcut);
            };
            this._isProcessingDirectInteraction = false;
            return (false);
        }

        private function getShortcut(pKeyboardMessage:KeyboardMessage):Shortcut
        {
            var sShortcut:String = BindsManager.getInstance().getShortcutString(pKeyboardMessage.keyboardEvent.keyCode, this.getCharCode(pKeyboardMessage));
            var bind:Bind = BindsManager.getInstance().getBind(new Bind(sShortcut, "", pKeyboardMessage.keyboardEvent.altKey, pKeyboardMessage.keyboardEvent.ctrlKey, pKeyboardMessage.keyboardEvent.shiftKey));
            return (((bind) ? Shortcut.getShortcutByName(bind.targetedShortcut) : null));
        }

        private function getCharCode(pKeyboardMessage:KeyboardMessage):int
        {
            var charCode:int;
            if (((pKeyboardMessage.keyboardEvent.shiftKey) && ((pKeyboardMessage.keyboardEvent.keyCode == 52))))
            {
                charCode = 39;
            }
            else
            {
                if (((pKeyboardMessage.keyboardEvent.shiftKey) && ((pKeyboardMessage.keyboardEvent.keyCode == 54))))
                {
                    charCode = 45;
                }
                else
                {
                    charCode = pKeyboardMessage.keyboardEvent.charCode;
                };
            };
            return (charCode);
        }

        private function onWindowDeactivate(pEvent:Event):void
        {
            this._heldShortcuts.length = 0;
            shiftKey = (ctrlKey = (altKey = false));
            ctrlKeyDown = false;
        }

        public function pushed():Boolean
        {
            this._heldShortcuts = new Vector.<String>(0);
            if (AirScanner.hasAir())
            {
                StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            };
            return (true);
        }

        public function pulled():Boolean
        {
            if (AirScanner.hasAir())
            {
                StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            };
            return (true);
        }


    }
}//package com.ankamagames.berilia.frames

