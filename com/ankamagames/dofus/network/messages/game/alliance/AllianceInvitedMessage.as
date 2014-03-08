package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceInvitedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInvitedMessage() {
         this.allianceInfo = new BasicNamedAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 6397;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var recruterId:uint = 0;
      
      public var recruterName:String = "";
      
      public var allianceInfo:BasicNamedAllianceInformations;
      
      override public function getMessageId() : uint {
         return 6397;
      }
      
      public function initAllianceInvitedMessage(recruterId:uint=0, recruterName:String="", allianceInfo:BasicNamedAllianceInformations=null) : AllianceInvitedMessage {
         this.recruterId = recruterId;
         this.recruterName = recruterName;
         this.allianceInfo = allianceInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.recruterId = 0;
         this.recruterName = "";
         this.allianceInfo = new BasicNamedAllianceInformations();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AllianceInvitedMessage(output);
      }
      
      public function serializeAs_AllianceInvitedMessage(output:IDataOutput) : void {
         if(this.recruterId < 0)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element recruterId.");
         }
         else
         {
            output.writeInt(this.recruterId);
            output.writeUTF(this.recruterName);
            this.allianceInfo.serializeAs_BasicNamedAllianceInformations(output);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceInvitedMessage(input);
      }
      
      public function deserializeAs_AllianceInvitedMessage(input:IDataInput) : void {
         this.recruterId = input.readInt();
         if(this.recruterId < 0)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element of AllianceInvitedMessage.recruterId.");
         }
         else
         {
            this.recruterName = input.readUTF();
            this.allianceInfo = new BasicNamedAllianceInformations();
            this.allianceInfo.deserialize(input);
            return;
         }
      }
   }
}
