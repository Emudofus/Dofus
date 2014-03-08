package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceGuildLeavingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceGuildLeavingMessage() {
         super();
      }
      
      public static const protocolId:uint = 6399;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var kicked:Boolean = false;
      
      public var guildId:int = 0;
      
      override public function getMessageId() : uint {
         return 6399;
      }
      
      public function initAllianceGuildLeavingMessage(param1:Boolean=false, param2:int=0) : AllianceGuildLeavingMessage {
         this.kicked = param1;
         this.guildId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.kicked = false;
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
         this.serializeAs_AllianceGuildLeavingMessage(param1);
      }
      
      public function serializeAs_AllianceGuildLeavingMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.kicked);
         param1.writeInt(this.guildId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceGuildLeavingMessage(param1);
      }
      
      public function deserializeAs_AllianceGuildLeavingMessage(param1:IDataInput) : void {
         this.kicked = param1.readBoolean();
         this.guildId = param1.readInt();
      }
   }
}
