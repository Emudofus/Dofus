package com.ankamagames.jerakine.json
{
   public class JSON extends Object
   {
      
      public function JSON() {
         super();
      }
      
      public static function encode(o:Object, pMaxDepth:uint=0, pShowObjectType:Boolean=false) : String {
         return new JSONEncoder(o,pMaxDepth,pShowObjectType).getString();
      }
      
      public static function decode(s:String, strict:Boolean=true) : * {
         return new JSONDecoder(s,strict).getValue();
      }
   }
}
