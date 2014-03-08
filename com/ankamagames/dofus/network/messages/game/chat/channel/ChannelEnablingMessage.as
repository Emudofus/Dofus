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
      
      public function initChannelEnablingMessage(param1:uint=0, param2:Boolean=false) : ChannelEnablingMessage {
         this.channel = param1;
         this.enable = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.channel = 0;
         this.enable = false;
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
         this.serializeAs_ChannelEnablingMessage(param1);
      }
      
      public function serializeAs_ChannelEnablingMessage(param1:IDataOutput) : void {
         param1.writeByte(this.channel);
         param1.writeBoolean(this.enable);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChannelEnablingMessage(param1);
      }
      
      public function deserializeAs_ChannelEnablingMessage(param1:IDataInput) : void {
         this.channel = param1.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of ChannelEnablingMessage.channel.");
         }
         else
         {
            this.enable = param1.readBoolean();
            return;
         }
      }
   }
}
