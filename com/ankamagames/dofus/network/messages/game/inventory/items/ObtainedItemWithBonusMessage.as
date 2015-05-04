package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObtainedItemWithBonusMessage extends ObtainedItemMessage implements INetworkMessage
   {
      
      public function ObtainedItemWithBonusMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6520;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var bonusQuantity:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6520;
      }
      
      public function initObtainedItemWithBonusMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ObtainedItemWithBonusMessage
      {
         super.initObtainedItemMessage(param1,param2);
         this.bonusQuantity = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.bonusQuantity = 0;
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
         this.serializeAs_ObtainedItemWithBonusMessage(param1);
      }
      
      public function serializeAs_ObtainedItemWithBonusMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ObtainedItemMessage(param1);
         if(this.bonusQuantity < 0)
         {
            throw new Error("Forbidden value (" + this.bonusQuantity + ") on element bonusQuantity.");
         }
         else
         {
            param1.writeVarInt(this.bonusQuantity);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObtainedItemWithBonusMessage(param1);
      }
      
      public function deserializeAs_ObtainedItemWithBonusMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.bonusQuantity = param1.readVarUhInt();
         if(this.bonusQuantity < 0)
         {
            throw new Error("Forbidden value (" + this.bonusQuantity + ") on element of ObtainedItemWithBonusMessage.bonusQuantity.");
         }
         else
         {
            return;
         }
      }
   }
}
