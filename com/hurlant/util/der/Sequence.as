package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public dynamic class Sequence extends Array implements IAsn1Type
   {
      
      public function Sequence(type:uint = 48, length:uint = 0) {
         super();
         this.type = type;
         this.len = length;
      }
      
      protected var type:uint;
      
      protected var len:uint;
      
      public function getLength() : uint {
         return this.len;
      }
      
      public function getType() : uint {
         return this.type;
      }
      
      public function toDER() : ByteArray {
         var e:IAsn1Type = null;
         var tmp:ByteArray = new ByteArray();
         var i:int = 0;
         while(i < length)
         {
            e = this[i];
            if(e == null)
            {
               tmp.writeByte(5);
               tmp.writeByte(0);
            }
            else
            {
               tmp.writeBytes(e.toDER());
            }
            i++;
         }
         return DER.wrapDER(this.type,tmp);
      }
      
      public function toString() : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function findAttributeValue(oid:String) : IAsn1Type {
         var set:* = undefined;
         var child:* = undefined;
         var tmp:* = undefined;
         var id:ObjectIdentifier = null;
         for each(set in this)
         {
            if(set is Set)
            {
               child = set[0];
               if(child is Sequence)
               {
                  tmp = child[0];
                  if(tmp is ObjectIdentifier)
                  {
                     id = tmp as ObjectIdentifier;
                     if(id.toString() == oid)
                     {
                        return child[1] as IAsn1Type;
                     }
                  }
               }
            }
         }
         return null;
      }
   }
}
