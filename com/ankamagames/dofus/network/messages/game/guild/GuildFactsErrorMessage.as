package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFactsErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFactsErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6424;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6424;
      }
      
      public function initGuildFactsErrorMessage(param1:uint=0) : GuildFactsErrorMessage {
         this.guildId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildId = 0;
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
         this.serializeAs_GuildFactsErrorMessage(param1);
      }
      
      public function serializeAs_GuildFactsErrorMessage(param1:IDataOutput) : void {
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         else
         {
            param1.writeInt(this.guildId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildFactsErrorMessage(param1);
      }
      
      public function deserializeAs_GuildFactsErrorMessage(param1:IDataInput) : void {
         this.guildId = param1.readInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of GuildFactsErrorMessage.guildId.");
         }
         else
         {
            return;
         }
      }
   }
}
