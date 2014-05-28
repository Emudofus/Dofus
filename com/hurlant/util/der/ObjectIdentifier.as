package com.hurlant.util.der
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class ObjectIdentifier extends Object implements IAsn1Type
   {
      
      {
         registerClassAlias("com.hurlant.util.der.ObjectIdentifier",ObjectIdentifier);
      }
      
      public function ObjectIdentifier(type:uint = 0, length:uint = 0, b:* = null) {
         super();
         this.type = type;
         this.len = length;
         if(b is ByteArray)
         {
            this.parse(b as ByteArray);
         }
         else if(b is String)
         {
            this.generate(b as String);
         }
         else
         {
            throw new Error("Invalid call to new ObjectIdentifier");
         }
         
      }
      
      private var type:uint;
      
      private var len:uint;
      
      private var oid:Array;
      
      private function generate(s:String) : void {
         this.oid = s.split(".");
      }
      
      private function parse(b:ByteArray) : void {
         var last:* = false;
         var o:uint = b.readUnsignedByte();
         var a:Array = [];
         a.push(uint(o / 40));
         a.push(uint(o % 40));
         var v:uint = 0;
         while(b.bytesAvailable > 0)
         {
            o = b.readUnsignedByte();
            last = (o & 128) == 0;
            o = o & 127;
            v = v * 128 + o;
            if(last)
            {
               a.push(v);
               v = 0;
            }
         }
         this.oid = a;
      }
      
      public function getLength() : uint {
         return this.len;
      }
      
      public function getType() : uint {
         return this.type;
      }
      
      public function toDER() : ByteArray {
         var v:* = 0;
         var tmp:Array = [];
         tmp[0] = this.oid[0] * 40 + this.oid[1];
         var i:int = 2;
         while(i < this.oid.length)
         {
            v = parseInt(this.oid[i]);
            if(v < 128)
            {
               tmp.push(v);
            }
            else if(v < 128 * 128)
            {
               tmp.push(v >> 7 | 128);
               tmp.push(v & 127);
            }
            else if(v < 128 * 128 * 128)
            {
               tmp.push(v >> 14 | 128);
               tmp.push(v >> 7 & 127 | 128);
               tmp.push(v & 127);
            }
            else if(v < 128 * 128 * 128 * 128)
            {
               tmp.push(v >> 21 | 128);
               tmp.push(v >> 14 & 127 | 128);
               tmp.push(v >> 7 & 127 | 128);
               tmp.push(v & 127);
            }
            else
            {
               throw new Error("OID element bigger than we thought. :(");
            }
            
            
            
            i++;
         }
         this.len = tmp.length;
         if(this.type == 0)
         {
            this.type = 6;
         }
         tmp.unshift(this.len);
         tmp.unshift(this.type);
         var b:ByteArray = new ByteArray();
         i = 0;
         while(i < tmp.length)
         {
            b[i] = tmp[i];
            i++;
         }
         return b;
      }
      
      public function toString() : String {
         return DER.indent + this.oid.join(".");
      }
      
      public function dump() : String {
         return "OID[" + this.type + "][" + this.len + "][" + this.toString() + "]";
      }
   }
}
