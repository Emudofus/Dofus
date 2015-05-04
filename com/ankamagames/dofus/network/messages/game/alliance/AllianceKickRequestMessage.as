package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceKickRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceKickRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6400;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var kickedId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6400;
      }
      
      public function initAllianceKickRequestMessage(param1:uint = 0) : AllianceKickRequestMessage
      {
         this.kickedId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kickedId = 0;
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
         this.serializeAs_AllianceKickRequestMessage(param1);
      }
      
      public function serializeAs_AllianceKickRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.kickedId < 0)
         {
            throw new Error("Forbidden value (" + this.kickedId + ") on element kickedId.");
         }
         else
         {
            param1.writeVarInt(this.kickedId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceKickRequestMessage(param1);
      }
      
      public function deserializeAs_AllianceKickRequestMessage(param1:ICustomDataInput) : void
      {
         this.kickedId = param1.readVarUhInt();
         if(this.kickedId < 0)
         {
            throw new Error("Forbidden value (" + this.kickedId + ") on element of AllianceKickRequestMessage.kickedId.");
         }
         else
         {
            return;
         }
      }
   }
}
