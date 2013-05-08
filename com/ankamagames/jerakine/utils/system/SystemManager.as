package com.ankamagames.jerakine.utils.system
{
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
            _singleton=new SystemManager();
         }
         return _singleton;
      }

      private var _os:String;

      private var _version:String;

      private var _cpu:String;

      public function get os() : String {
         return this._os;
      }

      public function get version() : String {
         return this._version;
      }

      public function get cpu() : String {
         return this._cpu;
      }

      public function notifyUser(always:Boolean=false) : void {
         var currentWindow:NativeWindow = null;
         currentWindow=NativeApplication.nativeApplication.openedWindows[0];
         if((always)||(!currentWindow.active))
         {
            if(this.os==OperatingSystem.MAC_OS)
            {
               DockIcon(NativeApplication.nativeApplication.icon).bounce(NotificationType.CRITICAL);
            }
            else
            {
               currentWindow.notifyUser(NotificationType.CRITICAL);
            }
         }
      }

      private function parseSystemInfo() : void {
         var cos:String = Capabilities.os;
         if(cos==OperatingSystem.LINUX)
         {
            this._os=OperatingSystem.LINUX;
            this._version="unknow";
         }
         else
         {
            if(cos.substr(0,OperatingSystem.MAC_OS.length)==OperatingSystem.MAC_OS)
            {
               this._os=OperatingSystem.MAC_OS;
               this._version=cos.substr(OperatingSystem.MAC_OS.length+1);
            }
            else
            {
               if(cos.substr(0,OperatingSystem.WINDOWS.length)==OperatingSystem.WINDOWS)
               {
                  this._os=OperatingSystem.WINDOWS;
                  this._version=cos.substr(OperatingSystem.WINDOWS.length+1);
               }
            }
         }
         this._cpu=Capabilities.cpuArchitecture;
      }
   }

}