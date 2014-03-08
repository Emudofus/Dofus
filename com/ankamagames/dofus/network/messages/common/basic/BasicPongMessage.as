package com.ankamagames.dofus.network.messages.common.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicPongMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicPongMessage() {
         super();
      }
      
      public static const protocolId:uint = 183;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var quiet:Boolean = false;
      
      override public function getMessageId() : uint {
         return 183;
      }
      
      public function initBasicPongMessage(quiet:Boolean=false) : BasicPongMessage {
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
         this.serializeAs_BasicPongMessage(output);
      }
      
      public function serializeAs_BasicPongMessage(output:IDataOutput) : void {
         output.writeBoolean(this.quiet);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicPongMessage(input);
      }
      
      public function deserializeAs_BasicPongMessage(input:IDataInput) : void {
         this.quiet = input.readBoolean();
      }
   }
}
