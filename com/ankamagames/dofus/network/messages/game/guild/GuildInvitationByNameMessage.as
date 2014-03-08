package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInvitationByNameMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInvitationByNameMessage() {
         super();
      }
      
      public static const protocolId:uint = 6115;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 6115;
      }
      
      public function initGuildInvitationByNameMessage(name:String="") : GuildInvitationByNameMessage {
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
         this.serializeAs_GuildInvitationByNameMessage(output);
      }
      
      public function serializeAs_GuildInvitationByNameMessage(output:IDataOutput) : void {
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInvitationByNameMessage(input);
      }
      
      public function deserializeAs_GuildInvitationByNameMessage(input:IDataInput) : void {
         this.name = input.readUTF();
      }
   }
}
