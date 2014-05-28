package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SetEnableAVARequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SetEnableAVARequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6443;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6443;
      }
      
      public function initSetEnableAVARequestMessage(enable:Boolean = false) : SetEnableAVARequestMessage {
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
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
         this.serializeAs_SetEnableAVARequestMessage(output);
      }
      
      public function serializeAs_SetEnableAVARequestMessage(output:IDataOutput) : void {
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SetEnableAVARequestMessage(input);
      }
      
      public function deserializeAs_SetEnableAVARequestMessage(input:IDataInput) : void {
         this.enable = input.readBoolean();
      }
   }
}
