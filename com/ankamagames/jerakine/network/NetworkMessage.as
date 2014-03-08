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
      
      public static function writePacket(param1:IDataOutput, param2:int, param3:ByteArray) : void {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = computeTypeLen(param3.length);
         param1.writeShort(subComputeStaticHeader(param2,_loc4_));
         switch(_loc4_)
         {
            case 0:
               return;
            case 1:
               param1.writeByte(param3.length);
               break;
            case 2:
               param1.writeShort(param3.length);
               break;
            case 3:
               _loc5_ = param3.length >> 16 & 255;
               _loc6_ = param3.length & 65535;
               param1.writeByte(_loc5_);
               param1.writeShort(_loc6_);
               break;
         }
         param1.writeBytes(param3,0,param3.length);
      }
      
      private static function computeTypeLen(param1:uint) : uint {
         if(param1 > 65535)
         {
            return 3;
         }
         if(param1 > 255)
         {
            return 2;
         }
         if(param1 > 0)
         {
            return 1;
         }
         return 0;
      }
      
      private static function subComputeStaticHeader(param1:uint, param2:uint) : uint {
         return param1 << BIT_RIGHT_SHIFT_LEN_PACKET_ID | param2;
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
      
      public function pack(param1:IDataOutput) : void {
         throw new AbstractMethodCallError();
      }
      
      public function unpack(param1:IDataInput, param2:uint) : void {
         throw new AbstractMethodCallError();
      }
      
      public function readExternal(param1:IDataInput) : void {
         throw new AbstractMethodCallError();
      }
      
      public function writeExternal(param1:IDataOutput) : void {
         throw new AbstractMethodCallError();
      }
      
      public function toString() : String {
         return getQualifiedClassName(this).split("::")[1] + " @" + this._instance_id;
      }
   }
}
