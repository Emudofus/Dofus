package com.hurlant.util
{
   import flash.utils.ByteArray;
   
   public class Hex extends Object
   {
      
      public function Hex() {
         super();
      }
      
      public static function toArray(hex:String) : ByteArray {
         var hex:String = hex.replace(new RegExp("\\s|:","gm"),"");
         var a:ByteArray = new ByteArray();
         if(hex.length & 1 == 1)
         {
            hex = "0" + hex;
         }
         var i:uint = 0;
         while(i < hex.length)
         {
            a[i / 2] = parseInt(hex.substr(i,2),16);
            i = i + 2;
         }
         return a;
      }
      
      public static function fromArray(array:ByteArray, colons:Boolean=false) : String {
         var s:String = "";
         var i:uint = 0;
         while(i < array.length)
         {
            s = s + ("0" + array[i].toString(16)).substr(-2,2);
            if(colons)
            {
               if(i < array.length - 1)
               {
                  s = s + ":";
               }
            }
            i++;
         }
         return s;
      }
      
      public static function toString(hex:String) : String {
         var a:ByteArray = toArray(hex);
         return a.readUTFBytes(a.length);
      }
      
      public static function fromString(str:String, colons:Boolean=false) : String {
         var a:ByteArray = new ByteArray();
         a.writeUTFBytes(str);
         return fromArray(a,colons);
      }
   }
}
