package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildModificationNameValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildModificationNameValidMessage() {
         super();
      }
      
      public static const protocolId:uint = 6327;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildName:String = "";
      
      override public function getMessageId() : uint {
         return 6327;
      }
      
      public function initGuildModificationNameValidMessage(guildName:String = "") : GuildModificationNameValidMessage {
         this.guildName = guildName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildName = "";
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
         this.serializeAs_GuildModificationNameValidMessage(output);
      }
      
      public function serializeAs_GuildModificationNameValidMessage(output:IDataOutput) : void {
         output.writeUTF(this.guildName);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildModificationNameValidMessage(input);
      }
      
      public function deserializeAs_GuildModificationNameValidMessage(input:IDataInput) : void {
         this.guildName = input.readUTF();
      }
   }
}
