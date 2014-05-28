package com.ankamagames.dofus.network.messages.game.context.display
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DisplayNumericalValueWithAgeBonusMessage extends DisplayNumericalValueMessage implements INetworkMessage
   {
      
      public function DisplayNumericalValueWithAgeBonusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6361;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var valueOfBonus:int = 0;
      
      override public function getMessageId() : uint {
         return 6361;
      }
      
      public function initDisplayNumericalValueWithAgeBonusMessage(entityId:int = 0, value:int = 0, type:uint = 0, valueOfBonus:int = 0) : DisplayNumericalValueWithAgeBonusMessage {
         super.initDisplayNumericalValueMessage(entityId,value,type);
         this.valueOfBonus = valueOfBonus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.valueOfBonus = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_DisplayNumericalValueWithAgeBonusMessage(output);
      }
      
      public function serializeAs_DisplayNumericalValueWithAgeBonusMessage(output:IDataOutput) : void {
         super.serializeAs_DisplayNumericalValueMessage(output);
         output.writeInt(this.valueOfBonus);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DisplayNumericalValueWithAgeBonusMessage(input);
      }
      
      public function deserializeAs_DisplayNumericalValueWithAgeBonusMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.valueOfBonus = input.readInt();
      }
   }
}
