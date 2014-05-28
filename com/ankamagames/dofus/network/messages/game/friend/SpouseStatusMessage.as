package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SpouseStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpouseStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6265;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var hasSpouse:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6265;
      }
      
      public function initSpouseStatusMessage(hasSpouse:Boolean = false) : SpouseStatusMessage {
         this.hasSpouse = hasSpouse;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.hasSpouse = false;
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
         this.serializeAs_SpouseStatusMessage(output);
      }
      
      public function serializeAs_SpouseStatusMessage(output:IDataOutput) : void {
         output.writeBoolean(this.hasSpouse);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SpouseStatusMessage(input);
      }
      
      public function deserializeAs_SpouseStatusMessage(input:IDataInput) : void {
         this.hasSpouse = input.readBoolean();
      }
   }
}
