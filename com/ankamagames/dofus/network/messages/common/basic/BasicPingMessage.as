package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicPingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicPingMessage() {
         super();
      }
      
      public static const protocolId:uint = 182;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var quiet:Boolean = false;
      
      override public function getMessageId() : uint {
         return 182;
      }
      
      public function initBasicPingMessage(quiet:Boolean = false) : BasicPingMessage {
         this.quiet = quiet;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.quiet = false;
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
         this.serializeAs_BasicPingMessage(output);
      }
      
      public function serializeAs_BasicPingMessage(output:IDataOutput) : void {
         output.writeBoolean(this.quiet);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicPingMessage(input);
      }
      
      public function deserializeAs_BasicPingMessage(input:IDataInput) : void {
         this.quiet = input.readBoolean();
      }
   }
}
