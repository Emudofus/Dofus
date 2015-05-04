package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceInvitedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInvitedMessage()
      {
         this.allianceInfo = new BasicNamedAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 6397;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var recruterId:uint = 0;
      
      public var recruterName:String = "";
      
      public var allianceInfo:BasicNamedAllianceInformations;
      
      override public function getMessageId() : uint
      {
         return 6397;
      }
      
      public function initAllianceInvitedMessage(param1:uint = 0, param2:String = "", param3:BasicNamedAllianceInformations = null) : AllianceInvitedMessage
      {
         this.recruterId = param1;
         this.recruterName = param2;
         this.allianceInfo = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.recruterId = 0;
         this.recruterName = "";
         this.allianceInfo = new BasicNamedAllianceInformations();
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
         this.serializeAs_AllianceInvitedMessage(param1);
      }
      
      public function serializeAs_AllianceInvitedMessage(param1:ICustomDataOutput) : void
      {
         if(this.recruterId < 0)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element recruterId.");
         }
         else
         {
            param1.writeVarInt(this.recruterId);
            param1.writeUTF(this.recruterName);
            this.allianceInfo.serializeAs_BasicNamedAllianceInformations(param1);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInvitedMessage(param1);
      }
      
      public function deserializeAs_AllianceInvitedMessage(param1:ICustomDataInput) : void
      {
         this.recruterId = param1.readVarUhInt();
         if(this.recruterId < 0)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element of AllianceInvitedMessage.recruterId.");
         }
         else
         {
            this.recruterName = param1.readUTF();
            this.allianceInfo = new BasicNamedAllianceInformations();
            this.allianceInfo.deserialize(param1);
            return;
         }
      }
   }
}
