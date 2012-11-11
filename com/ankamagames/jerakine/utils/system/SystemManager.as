package com.ankamagames.jerakine.utils.system
{
    import com.ankamagames.jerakine.enum.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.system.*;

    public class SystemManager extends Object
    {
        private var _os:String;
        private var _version:String;
        private var _cpu:String;
        private static var _singleton:SystemManager;

        public function SystemManager()
        {
            this.parseSystemInfo();
            return;
        }// end function

        public function get os() : String
        {
            return this._os;
        }// end function

        public function get version() : String
        {
            return this._version;
        }// end function

        public function get cpu() : String
        {
            return this._cpu;
        }// end function

        public function notifyUser(param1:Boolean = false) : void
        {
            var currentWindow:NativeWindow;
            var always:* = param1;
            try
            {
                currentWindow = NativeApplication.nativeApplication.openedWindows[0];
                if (always || !currentWindow.active)
                {
                    if (this.os == OperatingSystem.MAC_OS)
                    {
                        DockIcon(NativeApplication.nativeApplication.icon).bounce(NotificationType.CRITICAL);
                    }
                    else
                    {
                        currentWindow.notifyUser(NotificationType.CRITICAL);
                    }
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function parseSystemInfo() : void
        {
            var _loc_1:* = Capabilities.os;
            if (_loc_1 == OperatingSystem.LINUX)
            {
                this._os = OperatingSystem.LINUX;
                this._version = "unknow";
            }
            else if (_loc_1.substr(0, OperatingSystem.MAC_OS.length) == OperatingSystem.MAC_OS)
            {
                this._os = OperatingSystem.MAC_OS;
                this._version = _loc_1.substr((OperatingSystem.MAC_OS.length + 1));
            }
            else if (_loc_1.substr(0, OperatingSystem.WINDOWS.length) == OperatingSystem.WINDOWS)
            {
                this._os = OperatingSystem.WINDOWS;
                this._version = _loc_1.substr((OperatingSystem.WINDOWS.length + 1));
            }
            this._cpu = Capabilities.cpuArchitecture;
            return;
        }// end function

        public static function getSingleton() : SystemManager
        {
            if (!_singleton)
            {
                _singleton = new SystemManager;
            }
            return _singleton;
        }// end function

    }
}
