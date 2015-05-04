package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class LockableCodeResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LockableCodeResultMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5672;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var result:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5672;
      }
      
      public function initLockableCodeResultMessage(param1:uint = 0) : LockableCodeResultMessage
      {
         this.result = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.result = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_LockableCodeResultMessage(param1);
      }
      
      public function serializeAs_LockableCodeResultMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.result);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_LockableCodeResultMessage(param1);
      }
      
      public function deserializeAs_LockableCodeResultMessage(param1:ICustomDataInput) : void
      {
         this.result = param1.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of LockableCodeResultMessage.result.");
         }
         else
         {
            return;
         }
      }
   }
}
