package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CurrentServerStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CurrentServerStatusUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6525;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var status:uint = 1;
      
      override public function getMessageId() : uint
      {
         return 6525;
      }
      
      public function initCurrentServerStatusUpdateMessage(param1:uint = 1) : CurrentServerStatusUpdateMessage
      {
         this.status = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.status = 1;
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
         this.serializeAs_CurrentServerStatusUpdateMessage(param1);
      }
      
      public function serializeAs_CurrentServerStatusUpdateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.status);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CurrentServerStatusUpdateMessage(param1);
      }
      
      public function deserializeAs_CurrentServerStatusUpdateMessage(param1:ICustomDataInput) : void
      {
         this.status = param1.readByte();
         if(this.status < 0)
         {
            throw new Error("Forbidden value (" + this.status + ") on element of CurrentServerStatusUpdateMessage.status.");
         }
         else
         {
            return;
         }
      }
   }
}
