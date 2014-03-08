package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildCreationResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildCreationResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5554;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var result:uint = 0;
      
      override public function getMessageId() : uint {
         return 5554;
      }
      
      public function initGuildCreationResultMessage(result:uint=0) : GuildCreationResultMessage {
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.result = 0;
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
         this.serializeAs_GuildCreationResultMessage(output);
      }
      
      public function serializeAs_GuildCreationResultMessage(output:IDataOutput) : void {
         output.writeByte(this.result);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildCreationResultMessage(input);
      }
      
      public function deserializeAs_GuildCreationResultMessage(input:IDataInput) : void {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of GuildCreationResultMessage.result.");
         }
         else
         {
            return;
         }
      }
   }
}
