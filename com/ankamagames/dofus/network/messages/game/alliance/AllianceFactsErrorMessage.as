package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceFactsErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceFactsErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6423;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allianceId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6423;
      }
      
      public function initAllianceFactsErrorMessage(allianceId:uint=0) : AllianceFactsErrorMessage {
         this.allianceId = allianceId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allianceId = 0;
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
         this.serializeAs_AllianceFactsErrorMessage(output);
      }
      
      public function serializeAs_AllianceFactsErrorMessage(output:IDataOutput) : void {
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         else
         {
            output.writeInt(this.allianceId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceFactsErrorMessage(input);
      }
      
      public function deserializeAs_AllianceFactsErrorMessage(input:IDataInput) : void {
         this.allianceId = input.readInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of AllianceFactsErrorMessage.allianceId.");
         }
         else
         {
            return;
         }
      }
   }
}
