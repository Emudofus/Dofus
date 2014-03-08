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
      
      public function initDisplayNumericalValueWithAgeBonusMessage(param1:int=0, param2:int=0, param3:uint=0, param4:int=0) : DisplayNumericalValueWithAgeBonusMessage {
         super.initDisplayNumericalValueMessage(param1,param2,param3);
         this.valueOfBonus = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.valueOfBonus = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_DisplayNumericalValueWithAgeBonusMessage(param1);
      }
      
      public function serializeAs_DisplayNumericalValueWithAgeBonusMessage(param1:IDataOutput) : void {
         super.serializeAs_DisplayNumericalValueMessage(param1);
         param1.writeInt(this.valueOfBonus);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_DisplayNumericalValueWithAgeBonusMessage(param1);
      }
      
      public function deserializeAs_DisplayNumericalValueWithAgeBonusMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.valueOfBonus = param1.readInt();
      }
   }
}
