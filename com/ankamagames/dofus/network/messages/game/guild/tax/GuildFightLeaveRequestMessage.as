package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFightLeaveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFightLeaveRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5715;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var taxCollectorId:int = 0;
      
      public var characterId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5715;
      }
      
      public function initGuildFightLeaveRequestMessage(taxCollectorId:int=0, characterId:uint=0) : GuildFightLeaveRequestMessage {
         this.taxCollectorId = taxCollectorId;
         this.characterId = characterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.taxCollectorId = 0;
         this.characterId = 0;
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
         this.serializeAs_GuildFightLeaveRequestMessage(output);
      }
      
      public function serializeAs_GuildFightLeaveRequestMessage(output:IDataOutput) : void {
         output.writeInt(this.taxCollectorId);
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         else
         {
            output.writeInt(this.characterId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFightLeaveRequestMessage(input);
      }
      
      public function deserializeAs_GuildFightLeaveRequestMessage(input:IDataInput) : void {
         this.taxCollectorId = input.readInt();
         this.characterId = input.readInt();
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of GuildFightLeaveRequestMessage.characterId.");
         }
         else
         {
            return;
         }
      }
   }
}
