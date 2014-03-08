package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildInvitationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildInvitationMessage() {
         super();
      }
      
      public static const protocolId:uint = 5551;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var targetId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5551;
      }
      
      public function initGuildInvitationMessage(targetId:uint=0) : GuildInvitationMessage {
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.targetId = 0;
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
         this.serializeAs_GuildInvitationMessage(output);
      }
      
      public function serializeAs_GuildInvitationMessage(output:IDataOutput) : void {
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         else
         {
            output.writeInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildInvitationMessage(input);
      }
      
      public function deserializeAs_GuildInvitationMessage(input:IDataInput) : void {
         this.targetId = input.readInt();
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GuildInvitationMessage.targetId.");
         }
         else
         {
            return;
         }
      }
   }
}
