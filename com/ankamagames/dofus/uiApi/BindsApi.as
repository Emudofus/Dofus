package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.frames.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.shortcut.*;

    public class BindsApi extends Object implements IApi
    {
        private var _module:UiModule;

        public function BindsApi()
        {
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getBindList() : Array
        {
            return BindsManager.getInstance().binds;
        }// end function

        public function getShortcut() : Array
        {
            var _loc_3:Shortcut = null;
            var _loc_1:* = new Array();
            var _loc_2:* = Shortcut.getShortcuts();
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.visible)
                {
                    _loc_1.push(_loc_3);
                }
            }
            return _loc_1;
        }// end function

        public function getShortcutBind(param1:String, param2:Boolean = false) : Bind
        {
            return BindsManager.getInstance().getBindFromShortcut(param1, param2);
        }// end function

        public function setShortcutBind(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean) : void
        {
            BindsManager.getInstance().addBind(new Bind(param2, param1, param3, param4, param5));
            return;
        }// end function

        public function removeShortcutBind(param1:String) : void
        {
            BindsManager.getInstance().removeBind(BindsManager.getInstance().getBindFromShortcut(param1));
            return;
        }// end function

        public function getShortcutBindStr(param1:String, param2:Boolean = false) : String
        {
            var _loc_3:* = this.getShortcutBind(param1, param2);
            if (_loc_3 != null && _loc_3.key != null)
            {
                return _loc_3.toString();
            }
            return "";
        }// end function

        public function resetAllBinds() : void
        {
            BindsManager.getInstance().reset();
            return;
        }// end function

        public function avaibleKeyboard() : Array
        {
            return BindsManager.getInstance().avaibleKeyboard.concat();
        }// end function

        public function changeKeyboard(param1:String) : void
        {
            BindsManager.getInstance().changeKeyboard(param1, true);
            return;
        }// end function

        public function getCurrentLocale() : String
        {
            return BindsManager.getInstance().currentLocale;
        }// end function

        public function bindIsRegister(param1:Bind) : Boolean
        {
            return BindsManager.getInstance().isRegister(param1);
        }// end function

        public function bindIsPermanent(param1:Bind) : Boolean
        {
            return BindsManager.getInstance().isPermanent(param1);
        }// end function

        public function bindIsDisabled(param1:Bind) : Boolean
        {
            return BindsManager.getInstance().isDisabled(param1);
        }// end function

        public function setBindDisabled(param1:Bind, param2:Boolean) : void
        {
            BindsManager.getInstance().setDisabled(param1, param2);
            return;
        }// end function

        public function getRegisteredBind(param1:Bind) : Bind
        {
            return BindsManager.getInstance().getRegisteredBind(param1);
        }// end function

        public function getShortcutByName(param1:String) : Shortcut
        {
            return Shortcut.getShortcutByName(param1);
        }// end function

        public function setShortcutEnabled(param1:Boolean) : void
        {
            ShortcutsFrame.shortcutsEnabled = param1;
            return;
        }// end function

        public function getIsShortcutEnabled() : Boolean
        {
            return ShortcutsFrame.shortcutsEnabled;
        }// end function

        public function disableShortcut(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = Shortcut.getShortcutByName(param1);
            if (_loc_3 != null)
            {
                _loc_3.disable = param2;
            }
            return;
        }// end function

    }
}
