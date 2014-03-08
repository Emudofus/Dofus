package com.ankamagames.dofus.network.messages.game.chat.channel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChannelEnablingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChannelEnablingMessage() {
         super();
      }
      
      public static const protocolId:uint = 890;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var channel:uint = 0;
      
      public var enable:Boolean = false;
      
      override public function getMessageId() : uint {
         return 890;
      }
      
      public function initChannelEnablingMessage(channel:uint=0, enable:Boolean=false) : ChannelEnablingMessage {
         this.channel = channel;
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.channel = 0;
         this.enable = false;
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
         this.serializeAs_ChannelEnablingMessage(output);
      }
      
      public function serializeAs_ChannelEnablingMessage(output:IDataOutput) : void {
         output.writeByte(this.channel);
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChannelEnablingMessage(input);
      }
      
      public function deserializeAs_ChannelEnablingMessage(input:IDataInput) : void {
         this.channel = input.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChannelEnablingMessage.channel.");
         }
         else
         {
            this.enable = input.readBoolean();
            return;
         }
      }
   }
}
