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
            _singleton = new SystemManager();
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
      
      public function notifyUser(param1:Boolean=false) : void {
         var _loc2_:NativeWindow = null;
         try
         {
            _loc2_ = NativeApplication.nativeApplication.openedWindows[0];
            if((param1) || !_loc2_.active)
            {
               if(this.os == OperatingSystem.MAC_OS)
               {
                  DockIcon(NativeApplication.nativeApplication.icon).bounce(NotificationType.CRITICAL);
               }
               else
               {
                  _loc2_.notifyUser(NotificationType.CRITICAL);
               }
            }
         }
         catch(e:Error)
         {
         }
         return;
         if((param1) || !_loc2_.active)
         {
            if(this.os == OperatingSystem.MAC_OS)
            {
               DockIcon(NativeApplication.nativeApplication.icon).bounce(NotificationType.CRITICAL);
            }
            else
            {
               _loc2_.notifyUser(NotificationType.CRITICAL);
            }
         }
      }
      
      private function parseSystemInfo() : void {
         var _loc1_:String = Capabilities.os;
         if(_loc1_ == OperatingSystem.LINUX)
         {
            this._os = OperatingSystem.LINUX;
            this._version = "unknow";
         }
         else
         {
            if(_loc1_.substr(0,OperatingSystem.MAC_OS.length) == OperatingSystem.MAC_OS)
            {
               this._os = OperatingSystem.MAC_OS;
               this._version = _loc1_.substr(OperatingSystem.MAC_OS.length + 1);
            }
            else
            {
               if(_loc1_.substr(0,OperatingSystem.WINDOWS.length) == OperatingSystem.WINDOWS)
               {
                  this._os = OperatingSystem.WINDOWS;
                  this._version = _loc1_.substr(OperatingSystem.WINDOWS.length + 1);
               }
            }
         }
         this._cpu = Capabilities.cpuArchitecture;
      }
   }
}
