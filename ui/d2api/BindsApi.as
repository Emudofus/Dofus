package d2api
{
    import d2data.Bind;
    import d2data.Shortcut;

    public class BindsApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getBindList():Object
        {
            return (null);
        }

        [Untrusted]
        public function getShortcut():Object
        {
            return (null);
        }

        [Untrusted]
        public function getShortcutBind(shortcutName:String, returnDisabled:Boolean=false):Bind
        {
            return (null);
        }

        [Untrusted]
        public function setShortcutBind(targetedShorcut:String, key:String, alt:Boolean, ctrl:Boolean, shift:Boolean):void
        {
        }

        [Untrusted]
        public function removeShortcutBind(targetedBind:String):void
        {
        }

        [Untrusted]
        public function getShortcutBindStr(shortcutName:String, returnDisabled:Boolean=false):String
        {
            return (null);
        }

        [Trusted]
        public function resetAllBinds():void
        {
        }

        [Untrusted]
        public function availableKeyboards():Object
        {
            return (null);
        }

        [Trusted]
        public function changeKeyboard(locale:String):void
        {
        }

        [Untrusted]
        public function getCurrentLocale():String
        {
            return (null);
        }

        [Untrusted]
        public function bindIsRegister(bind:Bind):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function bindIsPermanent(bind:Bind):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function bindIsDisabled(bind:Bind):Boolean
        {
            return (false);
        }

        [Trusted]
        public function setBindDisabled(bind:Bind, disabled:Boolean):void
        {
        }

        [Untrusted]
        public function getRegisteredBind(bind:Bind):Bind
        {
            return (null);
        }

        [Untrusted]
        public function getShortcutByName(name:String):Shortcut
        {
            return (null);
        }

        [Trusted]
        public function setShortcutEnabled(enabled:Boolean):void
        {
        }

        [Untrusted]
        public function getIsShortcutEnabled():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function disableShortcut(name:String, val:Boolean):void
        {
        }

        [Untrusted]
        public function enableShortcutKey(keyCode:uint, charCode:uint, enabled:Boolean):void
        {
        }


    }
}//package d2api

