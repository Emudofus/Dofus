package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationDungeonRequestMessage extends PartyInvitationRequestMessage implements INetworkMessage
   {
      
      public function PartyInvitationDungeonRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6245;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6245;
      }
      
      public function initPartyInvitationDungeonRequestMessage(name:String="", dungeonId:uint=0) : PartyInvitationDungeonRequestMessage {
         super.initPartyInvitationRequestMessage(name);
         this.dungeonId = dungeonId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.dungeonId = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PartyInvitationDungeonRequestMessage(output);
      }
      
      public function serializeAs_PartyInvitationDungeonRequestMessage(output:IDataOutput) : void {
         super.serializeAs_PartyInvitationRequestMessage(output);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyInvitationDungeonRequestMessage(input);
      }
      
      public function deserializeAs_PartyInvitationDungeonRequestMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonRequestMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }
}
