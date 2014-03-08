package by.blooddy.crypto.serialization
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import __AS3__.vec.Vector;
   import flash.utils.Dictionary;
   import flash.xml.XMLDocument;
   import flash.errors.StackOverflowError;
   import flash.system.ApplicationDomain;
   
   public class JSON extends Object
   {
      
      public function JSON() {
      }
      
      public static function encode(param1:*) : String {
         var _loc2_:Object = XML.settings();
         XML.setSettings(
            {
               "ignoreComments":true,
               "ignoreProcessingInstructions":false,
               "ignoreWhitespace":true,
               "prettyIndent":false,
               "prettyPrinting":false
            });
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes("0123456789abcdef");
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.endian = Endian.LITTLE_ENDIAN;
         var cvint:Class = (new Vector.<int>() as Object).constructor;
         var cvuint:Class = (new Vector.<uint>() as Object).constructor;
         var cvdouble:Class = (new Vector.<Number>() as Object).constructor;
         var cvobject:Class = (new Vector.<Object>() as Object).constructor;
         var writeValue:Function = null;
         writeValue = function(param1:Dictionary, param2:ByteArray, param3:ByteArray, param4:*):*
         {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new IllegalOperationError("Not decompiled due to error");
         };
         XML.setSettings(_loc2_);
         var _loc5_:uint = _loc4_.position;
         _loc4_.position = 0;
         return _loc4_.readUTFBytes(_loc5_);
      }
      
      public static function decode(param1:String) : * {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
