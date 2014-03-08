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
      
      public function initGuildModificationNameValidMessage(param1:String="") : GuildModificationNameValidMessage {
         this.guildName = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildName = "";
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GuildModificationNameValidMessage(param1);
      }
      
      public function serializeAs_GuildModificationNameValidMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.guildName);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildModificationNameValidMessage(param1);
      }
      
      public function deserializeAs_GuildModificationNameValidMessage(param1:IDataInput) : void {
         this.guildName = param1.readUTF();
      }
   }
}
