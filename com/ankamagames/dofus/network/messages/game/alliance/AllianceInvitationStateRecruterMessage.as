package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceInvitationStateRecruterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInvitationStateRecruterMessage() {
         super();
      }
      
      public static const protocolId:uint = 6396;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var recrutedName:String = "";
      
      public var invitationState:uint = 0;
      
      override public function getMessageId() : uint {
         return 6396;
      }
      
      public function initAllianceInvitationStateRecruterMessage(recrutedName:String="", invitationState:uint=0) : AllianceInvitationStateRecruterMessage {
         this.recrutedName = recrutedName;
         this.invitationState = invitationState;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.recrutedName = "";
         this.invitationState = 0;
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
         this.serializeAs_AllianceInvitationStateRecruterMessage(output);
      }
      
      public function serializeAs_AllianceInvitationStateRecruterMessage(output:IDataOutput) : void {
         output.writeUTF(this.recrutedName);
         output.writeByte(this.invitationState);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceInvitationStateRecruterMessage(input);
      }
      
      public function deserializeAs_AllianceInvitationStateRecruterMessage(input:IDataInput) : void {
         this.recrutedName = input.readUTF();
         this.invitationState = input.readByte();
         if(this.invitationState < 0)
         {
            throw new Error("Forbidden value (" + this.invitationState + ") on element of AllianceInvitationStateRecruterMessage.invitationState.");
         }
         else
         {
            return;
         }
      }
   }
}
