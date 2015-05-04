package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceMembershipMessage extends AllianceJoinedMessage implements INetworkMessage
   {
      
      public function AllianceMembershipMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6390;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint
      {
         return 6390;
      }
      
      public function initAllianceMembershipMessage(param1:AllianceInformations = null, param2:Boolean = false) : AllianceMembershipMessage
      {
         super.initAllianceJoinedMessage(param1,param2);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceMembershipMessage(param1);
      }
      
      public function serializeAs_AllianceMembershipMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AllianceJoinedMessage(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceMembershipMessage(param1);
      }
      
      public function deserializeAs_AllianceMembershipMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
      }
   }
}
