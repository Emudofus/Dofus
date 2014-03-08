package com.ankamagames.atouin.resources.adapters
{
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.utils.ByteArray;
   import flash.errors.IOError;
   import flash.utils.Endian;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.atouin.resources.AtouinResourceType;
   import flash.net.URLLoaderDataFormat;
   
   public class MapsAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      public function MapsAdapter() {
         super();
      }
      
      override protected function getResource(param1:String, param2:*) : * {
         var dataFormat:String = param1;
         var data:* = param2;
         var ba:ByteArray = data as ByteArray;
         ba.endian = Endian.BIG_ENDIAN;
         var header:int = ba.readByte();
         if(header != 77)
         {
            ba.position = 0;
            try
            {
               ba.uncompress();
            }
            catch(ioe:IOError)
            {
               dispatchFailure("Wrong header and non-compressed file.",ResourceErrorCode.MALFORMED_MAP_FILE);
               return null;
            }
            header = ba.readByte();
            if(header != 77)
            {
               dispatchFailure("Wrong header file.",ResourceErrorCode.MALFORMED_MAP_FILE);
               return null;
            }
         }
         ba.position = 0;
         return ba;
      }
      
      override public function getResourceType() : uint {
         return AtouinResourceType.RESOURCE_MAP;
      }
      
      override protected function getDataFormat() : String {
         return URLLoaderDataFormat.BINARY;
      }
   }
}
