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
      
      public function initGuildMemberLeavingMessage(kicked:Boolean=false, memberId:int=0) : GuildMemberLeavingMessage {
         this.kicked = kicked;
         this.memberId = memberId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.kicked = false;
         this.memberId = 0;
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
         this.serializeAs_GuildMemberLeavingMessage(output);
      }
      
      public function serializeAs_GuildMemberLeavingMessage(output:IDataOutput) : void {
         output.writeBoolean(this.kicked);
         output.writeInt(this.memberId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildMemberLeavingMessage(input);
      }
      
      public function deserializeAs_GuildMemberLeavingMessage(input:IDataInput) : void {
         this.kicked = input.readBoolean();
         this.memberId = input.readInt();
      }
   }
}
