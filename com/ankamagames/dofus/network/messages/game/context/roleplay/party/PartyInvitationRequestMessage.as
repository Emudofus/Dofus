package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PartyInvitationRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5585;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 5585;
      }
      
      public function initPartyInvitationRequestMessage(name:String = "") : PartyInvitationRequestMessage {
         this.name = name;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.name = "";
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
         this.serializeAs_PartyInvitationRequestMessage(output);
      }
      
      public function serializeAs_PartyInvitationRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyInvitationRequestMessage(input);
      }
      
      public function deserializeAs_PartyInvitationRequestMessage(input:IDataInput) : void {
         this.name = input.readUTF();
      }
   }
}
