package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public class DER extends Object
   {
      
      public function DER() {
         super();
      }
      
      public static var indent:String = "";
      
      public static function parse(der:ByteArray, structure:*=null) : IAsn1Type {
         var type:* = 0;
         var len:* = 0;
         var b:ByteArray = null;
         var count:* = 0;
         var p:* = 0;
         var o:Sequence = null;
         var arrayStruct:Array = null;
         var s:Set = null;
         var bs:ByteString = null;
         var ps:PrintableString = null;
         var ut:UTCTime = null;
         var tmpStruct:Object = null;
         var wantConstructed:* = false;
         var isConstructed:* = false;
         var name:String = null;
         var value:* = undefined;
         var obj:IAsn1Type = null;
         var size:* = 0;
         var ba:ByteArray = null;
         type = der.readUnsignedByte();
         var constructed:Boolean = !((type & 32) == 0);
         type = type & 31;
         len = der.readUnsignedByte();
         if(len >= 128)
         {
            count = len & 127;
            len = 0;
            while(count > 0)
            {
               len = len << 8 | der.readUnsignedByte();
               count--;
            }
         }
         switch(type)
         {
            case 0:
            case 16:
               p = der.position;
               o = new Sequence(type,len);
               arrayStruct = structure as Array;
               if(arrayStruct != null)
               {
                  arrayStruct = arrayStruct.concat();
               }
               while(der.position < p + len)
               {
                  tmpStruct = null;
                  if(arrayStruct != null)
                  {
                     tmpStruct = arrayStruct.shift();
                  }
                  if(tmpStruct != null)
                  {
                     while((tmpStruct) && (tmpStruct.optional))
                     {
                        wantConstructed = tmpStruct.value is Array;
                        isConstructed = isConstructedType(der);
                        if(wantConstructed != isConstructed)
                        {
                           o.push(tmpStruct.defaultValue);
                           o[tmpStruct.name] = tmpStruct.defaultValue;
                           tmpStruct = arrayStruct.shift();
                           continue;
                        }
                        break;
                     }
                  }
                  if(tmpStruct != null)
                  {
                     name = tmpStruct.name;
                     value = tmpStruct.value;
                     if(tmpStruct.extract)
                     {
                        size = getLengthOfNextElement(der);
                        ba = new ByteArray();
                        ba.writeBytes(der,der.position,size);
                        o[name + "_bin"] = ba;
                     }
                     obj = DER.parse(der,value);
                     o.push(obj);
                     o[name] = obj;
                  }
                  else
                  {
                     o.push(DER.parse(der));
                  }
               }
               return o;
            case 17:
               p = der.position;
               s = new Set(type,len);
               while(der.position < p + len)
               {
                  s.push(DER.parse(der));
               }
               return s;
            case 2:
               b = new ByteArray();
               der.readBytes(b,0,len);
               b.position = 0;
               return new Integer(type,len,b);
            case 6:
               b = new ByteArray();
               der.readBytes(b,0,len);
               b.position = 0;
               return new ObjectIdentifier(type,len,b);
         }
      }
      
      private static function getLengthOfNextElement(b:ByteArray) : int {
         var count:* = 0;
         var p:uint = b.position;
         b.position++;
         var len:int = b.readUnsignedByte();
         if(len >= 128)
         {
            count = len & 127;
            len = 0;
            while(count > 0)
            {
               len = len << 8 | b.readUnsignedByte();
               count--;
            }
         }
         len = len + (b.position - p);
         b.position = p;
         return len;
      }
      
      private static function isConstructedType(b:ByteArray) : Boolean {
         var type:int = b[b.position];
         return !((type & 32) == 0);
      }
      
      public static function wrapDER(type:int, data:ByteArray) : ByteArray {
         var d:ByteArray = new ByteArray();
         d.writeByte(type);
         var len:int = data.length;
         if(len < 128)
         {
            d.writeByte(len);
         }
         else
         {
            if(len < 256)
            {
               d.writeByte(1 | 128);
               d.writeByte(len);
            }
            else
            {
               if(len < 65536)
               {
                  d.writeByte(2 | 128);
                  d.writeByte(len >> 8);
                  d.writeByte(len);
               }
               else
               {
                  if(len < 65536 * 256)
                  {
                     d.writeByte(3 | 128);
                     d.writeByte(len >> 16);
                     d.writeByte(len >> 8);
                     d.writeByte(len);
                  }
                  else
                  {
                     d.writeByte(4 | 128);
                     d.writeByte(len >> 24);
                     d.writeByte(len >> 16);
                     d.writeByte(len >> 8);
                     d.writeByte(len);
                  }
               }
            }
         }
         d.writeBytes(data);
         d.position = 0;
         return d;
      }
   }
}
