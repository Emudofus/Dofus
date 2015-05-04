package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceInvitationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInvitationMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6395;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var targetId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6395;
      }
      
      public function initAllianceInvitationMessage(param1:uint = 0) : AllianceInvitationMessage
      {
         this.targetId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetId = 0;
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
         this.serializeAs_AllianceInvitationMessage(param1);
      }
      
      public function serializeAs_AllianceInvitationMessage(param1:ICustomDataOutput) : void
      {
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         else
         {
            param1.writeVarInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInvitationMessage(param1);
      }
      
      public function deserializeAs_AllianceInvitationMessage(param1:ICustomDataInput) : void
      {
         this.targetId = param1.readVarUhInt();
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of AllianceInvitationMessage.targetId.");
         }
         else
         {
            return;
         }
      }
   }
}
