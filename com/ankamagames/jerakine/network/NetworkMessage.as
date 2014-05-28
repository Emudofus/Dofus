package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.scrambling.ScramblableElement;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class NetworkMessage extends ScramblableElement implements INetworkMessage
   {
      
      public function NetworkMessage() {
         this._instance_id = ++GLOBAL_INSTANCE_ID;
         super();
      }
      
      private static var GLOBAL_INSTANCE_ID:uint = 0;
      
      public static const BIT_RIGHT_SHIFT_LEN_PACKET_ID:uint = 2;
      
      public static const BIT_MASK:uint = 3;
      
      public static function writePacket(output:IDataOutput, id:int, data:ByteArray) : void {
         var high:uint = 0;
         var low:uint = 0;
         var typeLen:uint = computeTypeLen(data.length);
         output.writeShort(subComputeStaticHeader(id,typeLen));
         switch(typeLen)
         {
            case 0:
               return;
            case 1:
               output.writeByte(data.length);
               break;
            case 2:
               output.writeShort(data.length);
               break;
            case 3:
               high = data.length >> 16 & 255;
               low = data.length & 65535;
               output.writeByte(high);
               output.writeShort(low);
               break;
         }
         output.writeBytes(data,0,data.length);
      }
      
      private static function computeTypeLen(len:uint) : uint {
         if(len > 65535)
         {
            return 3;
         }
         if(len > 255)
         {
            return 2;
         }
         if(len > 0)
         {
            return 1;
         }
         return 0;
      }
      
      private static function subComputeStaticHeader(msgId:uint, typeLen:uint) : uint {
         return msgId << BIT_RIGHT_SHIFT_LEN_PACKET_ID | typeLen;
      }
      
      private var _instance_id:uint;
      
      public function get isInitialized() : Boolean {
         throw new AbstractMethodCallError();
      }
      
      public function getMessageId() : uint {
         throw new AbstractMethodCallError();
      }
      
      public function reset() : void {
         throw new AbstractMethodCallError();
      }
      
      public function pack(output:IDataOutput) : void {
         throw new AbstractMethodCallError();
      }
      
      public function unpack(input:IDataInput, length:uint) : void {
         throw new AbstractMethodCallError();
      }
      
      public function readExternal(input:IDataInput) : void {
         throw new AbstractMethodCallError();
      }
      
      public function writeExternal(output:IDataOutput) : void {
         throw new AbstractMethodCallError();
      }
      
      public function toString() : String {
         return getQualifiedClassName(this).split("::")[1] + " @" + this._instance_id;
      }
   }
}
