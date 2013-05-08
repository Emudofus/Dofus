package com.ankamagames.jerakine.resources.protocols
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.protocols.impl.HttpProtocol;
   import com.ankamagames.jerakine.resources.protocols.impl.HttpCacheProtocol;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.resources.protocols.impl.FileProtocol;
   import com.ankamagames.jerakine.resources.protocols.impl.FileFlashProtocol;
   import com.ankamagames.jerakine.resources.protocols.impl.ZipProtocol;
   import com.ankamagames.jerakine.resources.protocols.impl.UpdaterProtocol;
   import com.ankamagames.jerakine.resources.protocols.impl.PakProtocol2;
   import com.ankamagames.jerakine.resources.protocols.impl.PakProtocol;
   import com.ankamagames.jerakine.resources.ResourceError;


   public class ProtocolFactory extends Object
   {
         

      public function ProtocolFactory() {
         super();
      }

      private static var _customProtocols:Dictionary = new Dictionary();

      public static function getProtocol(uri:Uri) : IProtocol {
         var cp:* = undefined;
         switch(uri.protocol)
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
               customProtocol=_customProtocols[uri.protocol] as Class;
               if(customProtocol)
               {
                  cp=new customProtocol();
                  if(!(cp is IProtocol))
                  {
                     throw new ResourceError("Registered custom protocol for extension "+uri.protocol+" isn\'t an IProtocol class.");
                  }
                  else
                  {
                     return cp;
                  }
               }
               else
               {
                  throw new ArgumentError("Unknown protocol \'"+uri.protocol+"\' in the URI \'"+uri+"\'.");
               }
         }
      }

      public static function addProtocol(protocolName:String, protocolClass:Class) : void {
         _customProtocols[protocolName]=protocolClass;
      }

      public static function removeProtocol(protocolName:String) : void {
         delete _customProtocols[[protocolName]];
      }


   }

}