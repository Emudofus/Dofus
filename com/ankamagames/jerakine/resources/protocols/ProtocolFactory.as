package com.ankamagames.jerakine.resources.protocols
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.resources.protocols.impl.*;
   import com.ankamagames.jerakine.resources.ResourceError;
   
   public class ProtocolFactory extends Object
   {
      
      public function ProtocolFactory() {
         super();
      }
      
      private static var _customProtocols:Dictionary = new Dictionary();
      
      public static function getProtocol(param1:Uri) : IProtocol {
         var _loc3_:* = undefined;
         switch(param1.protocol)
         {
            case "http":
            case "https":
               return new HttpProtocol();
            case "httpc":
               return new HttpCacheProtocol();
            case "file":
               if(AirScanner.hasAir())
               {
                  return new FileProtocol();
               }
               return new FileFlashProtocol();
            case "zip":
               return new ZipProtocol();
            case "upd":
               return new UpdaterProtocol();
            case "pak":
            case "pak2":
            case "d2p":
               return new PakProtocol2();
            case "d2pOld":
               return new PakProtocol();
            default:
               _loc2_ = _customProtocols[param1.protocol] as Class;
               if(_loc2_)
               {
                  _loc3_ = new _loc2_();
                  if(!(_loc3_ is IProtocol))
                  {
                     throw new ResourceError("Registered custom protocol for extension " + param1.protocol + " isn\'t an IProtocol class.");
                  }
                  else
                  {
                     return _loc3_;
                  }
               }
               else
               {
                  throw new ArgumentError("Unknown protocol \'" + param1.protocol + "\' in the URI \'" + param1 + "\'.");
               }
         }
      }
      
      public static function addProtocol(param1:String, param2:Class) : void {
         _customProtocols[param1] = param2;
      }
      
      public static function removeProtocol(param1:String) : void {
         delete _customProtocols[[param1]];
      }
   }
}
