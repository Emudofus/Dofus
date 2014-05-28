package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class OrnamentGainedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function OrnamentGainedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6368;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ornamentId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6368;
      }
      
      public function initOrnamentGainedMessage(ornamentId:uint = 0) : OrnamentGainedMessage {
         this.ornamentId = ornamentId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ornamentId = 0;
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
         this.serializeAs_OrnamentGainedMessage(output);
      }
      
      public function serializeAs_OrnamentGainedMessage(output:IDataOutput) : void {
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element ornamentId.");
         }
         else
         {
            output.writeShort(this.ornamentId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_OrnamentGainedMessage(input);
      }
      
      public function deserializeAs_OrnamentGainedMessage(input:IDataInput) : void {
         this.ornamentId = input.readShort();
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element of OrnamentGainedMessage.ornamentId.");
         }
         else
         {
            return;
         }
      }
   }
}
