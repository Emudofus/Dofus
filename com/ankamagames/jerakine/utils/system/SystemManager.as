package com.ankamagames.jerakine.utils.system
{
   import flash.external.ExternalInterface;
   import com.ankamagames.jerakine.enum.WebBrowserEnum;
   import flash.display.NativeWindow;
   import flash.desktop.NativeApplication;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import flash.desktop.DockIcon;
   import flash.desktop.NotificationType;
   import flash.system.Capabilities;
   
   public class SystemManager extends Object
   {
      
      public function SystemManager() {
         super();
         this.parseSystemInfo();
      }
      
      private static var _singleton:SystemManager;
      
      public static function getSingleton() : SystemManager {
         if(!_singleton)
         {
            _singleton = new SystemManager();
         }
         return _singleton;
      }
      
      private var _os:String;
      
      private var _version:String;
      
      private var _cpu:String;
      
      private var _browser:String;
      
      public function get os() : String {
         return this._os;
      }
      
      public function get version() : String {
         return this._version;
      }
      
      public function get cpu() : String {
         return this._cpu;
      }
      
      public function get browser() : String {
         var userAgent:String = null;
         if(!this._browser)
         {
            try
            {
               userAgent = (ExternalInterface.call("window.navigator.userAgent.toString") as String).toLowerCase();
               this._browser = WebBrowserEnum.UNKNOWN;
               switch(true)
               {
                  case !(userAgent.indexOf("chrome") == -1):
                     this._browser = WebBrowserEnum.CHROME;
                     break;
                  case !(userAgent.indexOf("firefox") == -1):
                     this._browser = WebBrowserEnum.FIREFOX;
                     break;
                  case !(userAgent.indexOf("msie") == -1):
                     this._browser = WebBrowserEnum.INTERNET_EXPLORER;
                     break;
                  case !(userAgent.indexOf("safari") == -1):
                     this._browser = WebBrowserEnum.SAFARI;
                     break;
                  case !(userAgent.indexOf("opera") == -1):
                     this._browser = WebBrowserEnum.OPERA;
                     break;
               }
            }
            catch(e:Error)
            {
               _browser = WebBrowserEnum.NONE;
            }
         }
         return this._browser;
      }
      
      public function notifyUser(always:Boolean = false) : void {
         var currentWindow:NativeWindow = null;
         try
         {
            currentWindow = NativeApplication.nativeApplication.openedWindows[0];
            if((always) || (!currentWindow.active))
            {
               if(this.os == OperatingSystem.MAC_OS)
               {
                  DockIcon(NativeApplication.nativeApplication.icon).bounce(NotificationType.CRITICAL);
               }
               else
               {
                  currentWindow.notifyUser(NotificationType.CRITICAL);
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function parseSystemInfo() : void {
         var cos:String = Capabilities.os;
         if(cos == OperatingSystem.LINUX)
         {
            this._os = OperatingSystem.LINUX;
            this._version = "unknow";
         }
         else if(cos.substr(0,OperatingSystem.MAC_OS.length) == OperatingSystem.MAC_OS)
         {
            this._os = OperatingSystem.MAC_OS;
            this._version = cos.substr(OperatingSystem.MAC_OS.length + 1);
         }
         else if(cos.substr(0,OperatingSystem.WINDOWS.length) == OperatingSystem.WINDOWS)
         {
            this._os = OperatingSystem.WINDOWS;
            this._version = cos.substr(OperatingSystem.WINDOWS.length + 1);
         }
         
         
         this._cpu = Capabilities.cpuArchitecture;
      }
   }
}
