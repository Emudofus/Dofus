package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildKickRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildKickRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5887;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var kickedId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5887;
      }
      
      public function initGuildKickRequestMessage(kickedId:uint=0) : GuildKickRequestMessage {
         this.kickedId = kickedId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.kickedId = 0;
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
         this.serializeAs_GuildKickRequestMessage(output);
      }
      
      public function serializeAs_GuildKickRequestMessage(output:IDataOutput) : void {
         if(this.kickedId < 0)
         {
            throw new Error("Forbidden value (" + this.kickedId + ") on element kickedId.");
         }
         else
         {
            output.writeInt(this.kickedId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildKickRequestMessage(input);
      }
      
      public function deserializeAs_GuildKickRequestMessage(input:IDataInput) : void {
         this.kickedId = input.readInt();
         if(this.kickedId < 0)
         {
            throw new Error("Forbidden value (" + this.kickedId + ") on element of GuildKickRequestMessage.kickedId.");
         }
         else
         {
            return;
         }
      }
   }
}
