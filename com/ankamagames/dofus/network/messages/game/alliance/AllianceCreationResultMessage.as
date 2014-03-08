package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceCreationResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceCreationResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 6391;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var result:uint = 0;
      
      override public function getMessageId() : uint {
         return 6391;
      }
      
      public function initAllianceCreationResultMessage(result:uint=0) : AllianceCreationResultMessage {
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
         this.serializeAs_AllianceCreationResultMessage(output);
      }
      
      public function serializeAs_AllianceCreationResultMessage(output:IDataOutput) : void {
         output.writeByte(this.result);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceCreationResultMessage(input);
      }
      
      public function deserializeAs_AllianceCreationResultMessage(input:IDataInput) : void {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of AllianceCreationResultMessage.result.");
         }
         else
         {
            return;
         }
      }
   }
}
