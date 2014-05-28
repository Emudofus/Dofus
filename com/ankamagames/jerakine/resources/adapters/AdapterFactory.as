package com.ankamagames.jerakine.resources.adapters
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.jerakine.resources.adapters.impl.*;
   import com.ankamagames.jerakine.resources.ResourceError;
   
   public class AdapterFactory extends Object
   {
      
      public function AdapterFactory() {
         super();
      }
      
      private static var _customAdapters:Dictionary;
      
      public static function getAdapter(uri:Uri) : IAdapter {
         var ca:* = undefined;
         switch(uri.fileType)
         {
            case "xml":
            case "meta":
            case "dm":
            case "dt":
               return new XmlAdapter();
            case "png":
            case "gif":
            case "jpg":
            case "jpeg":
            case "wdp":
               return new BitmapAdapter();
            case "txt":
            case "css":
               return new TxtAdapter();
            case "swf":
               return new SwfAdapter();
            case "aswf":
               return new AdvancedSwfAdapter();
            case "swl":
               return new SwlAdapter();
            case "dx":
               return new DxAdapter();
            case "zip":
               return new ZipAdapter();
            case "mp3":
               return new MP3Adapter();
            default:
               if(uri.subPath)
               {
                  switch(FileUtils.getExtension(uri.path))
                  {
                     case "swf":
                        return new AdvancedSwfAdapter();
                  }
               }
               customAdapter = _customAdapters[uri.fileType] as Class;
               if(customAdapter)
               {
                  ca = new customAdapter();
                  if(!(ca is IAdapter))
                  {
                     throw new ResourceError("Registered custom adapter for extension " + uri.fileType + " isn\'t an IAdapter class.");
                  }
                  else
                  {
                     return ca;
                  }
               }
               else
               {
                  if(uri.fileType.substr(-1) == "s")
                  {
                     return new SignedFileAdapter();
                  }
                  return new BinaryAdapter();
               }
         }
      }
      
      public static function addAdapter(extension:String, adapter:Class) : void {
         _customAdapters[extension] = adapter;
      }
      
      public static function removeAdapter(extension:String) : void {
         delete _customAdapters[extension];
      }
      
      private var include_SimpleLoaderAdapter:SimpleLoaderAdapter = null;
   }
}
