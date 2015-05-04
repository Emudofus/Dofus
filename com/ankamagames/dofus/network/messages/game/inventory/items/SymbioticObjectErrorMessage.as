package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class SymbioticObjectErrorMessage extends ObjectErrorMessage implements INetworkMessage
   {
      
      public function SymbioticObjectErrorMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6526;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var errorCode:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6526;
      }
      
      public function initSymbioticObjectErrorMessage(param1:int = 0, param2:int = 0) : SymbioticObjectErrorMessage
      {
         super.initObjectErrorMessage(param1);
         this.errorCode = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.errorCode = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_SymbioticObjectErrorMessage(param1);
      }
      
      public function serializeAs_SymbioticObjectErrorMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectErrorMessage(param1);
         param1.writeByte(this.errorCode);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_SymbioticObjectErrorMessage(param1);
      }
      
      public function deserializeAs_SymbioticObjectErrorMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.errorCode = param1.readByte();
      }
   }
}
