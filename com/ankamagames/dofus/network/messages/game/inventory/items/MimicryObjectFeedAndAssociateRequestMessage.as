package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MimicryObjectFeedAndAssociateRequestMessage extends SymbioticObjectAssociateRequestMessage implements INetworkMessage
   {
      
      public function MimicryObjectFeedAndAssociateRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6460;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var foodUID:uint = 0;
      
      public var foodPos:uint = 0;
      
      public var preview:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 6460;
      }
      
      public function initMimicryObjectFeedAndAssociateRequestMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:Boolean = false) : MimicryObjectFeedAndAssociateRequestMessage
      {
         super.initSymbioticObjectAssociateRequestMessage(param1,param2,param3,param4);
         this.foodUID = param5;
         this.foodPos = param6;
         this.preview = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.foodUID = 0;
         this.foodPos = 0;
         this.preview = false;
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
         this.serializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1);
      }
      
      public function serializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_SymbioticObjectAssociateRequestMessage(param1);
         if(this.foodUID < 0)
         {
            throw new Error("Forbidden value (" + this.foodUID + ") on element foodUID.");
         }
         else
         {
            param1.writeVarInt(this.foodUID);
            if(this.foodPos < 0 || this.foodPos > 255)
            {
               throw new Error("Forbidden value (" + this.foodPos + ") on element foodPos.");
            }
            else
            {
               param1.writeByte(this.foodPos);
               param1.writeBoolean(this.preview);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1);
      }
      
      public function deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.foodUID = param1.readVarUhInt();
         if(this.foodUID < 0)
         {
            throw new Error("Forbidden value (" + this.foodUID + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodUID.");
         }
         else
         {
            this.foodPos = param1.readUnsignedByte();
            if(this.foodPos < 0 || this.foodPos > 255)
            {
               throw new Error("Forbidden value (" + this.foodPos + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodPos.");
            }
            else
            {
               this.preview = param1.readBoolean();
               return;
            }
         }
      }
   }
}
