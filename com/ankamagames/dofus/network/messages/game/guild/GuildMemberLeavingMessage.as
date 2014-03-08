package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildMemberLeavingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildMemberLeavingMessage() {
         super();
      }
      
      public static const protocolId:uint = 5923;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var kicked:Boolean = false;
      
      public var memberId:int = 0;
      
      override public function getMessageId() : uint {
         return 5923;
      }
      
      public function initGuildMemberLeavingMessage(param1:Boolean=false, param2:int=0) : GuildMemberLeavingMessage {
         this.kicked = param1;
         this.memberId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.kicked = false;
         this.memberId = 0;
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
         this.serializeAs_GuildMemberLeavingMessage(param1);
      }
      
      public function serializeAs_GuildMemberLeavingMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.kicked);
         param1.writeInt(this.memberId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildMemberLeavingMessage(param1);
      }
      
      public function deserializeAs_GuildMemberLeavingMessage(param1:IDataInput) : void {
         this.kicked = param1.readBoolean();
         this.memberId = param1.readInt();
      }
   }
}
