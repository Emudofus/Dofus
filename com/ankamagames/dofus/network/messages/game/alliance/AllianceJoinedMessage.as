package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceJoinedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceJoinedMessage()
      {
         this.allianceInfo = new AllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 6402;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var allianceInfo:AllianceInformations;
      
      public var enabled:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 6402;
      }
      
      public function initAllianceJoinedMessage(param1:AllianceInformations = null, param2:Boolean = false) : AllianceJoinedMessage
      {
         this.allianceInfo = param1;
         this.enabled = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceInfo = new AllianceInformations();
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
         this.serializeAs_AllianceJoinedMessage(param1);
      }
      
      public function serializeAs_AllianceJoinedMessage(param1:ICustomDataOutput) : void
      {
         this.allianceInfo.serializeAs_AllianceInformations(param1);
         param1.writeBoolean(this.enabled);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceJoinedMessage(param1);
      }
      
      public function deserializeAs_AllianceJoinedMessage(param1:ICustomDataInput) : void
      {
         this.allianceInfo = new AllianceInformations();
         this.allianceInfo.deserialize(param1);
         this.enabled = param1.readBoolean();
      }
   }
}
