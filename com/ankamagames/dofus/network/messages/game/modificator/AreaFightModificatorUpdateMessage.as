package com.ankamagames.dofus.network.messages.game.modificator
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AreaFightModificatorUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AreaFightModificatorUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6493;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellPairId:int = 0;
      
      override public function getMessageId() : uint {
         return 6493;
      }
      
      public function initAreaFightModificatorUpdateMessage(spellPairId:int = 0) : AreaFightModificatorUpdateMessage {
         this.spellPairId = spellPairId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellPairId = 0;
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
         this.serializeAs_AreaFightModificatorUpdateMessage(output);
      }
      
      public function serializeAs_AreaFightModificatorUpdateMessage(output:IDataOutput) : void {
         output.writeInt(this.spellPairId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AreaFightModificatorUpdateMessage(input);
      }
      
      public function deserializeAs_AreaFightModificatorUpdateMessage(input:IDataInput) : void {
         this.spellPairId = input.readInt();
      }
   }
}
