package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MimicryObjectFeedAndAssociateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MimicryObjectFeedAndAssociateRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6460;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mimicryUID:uint = 0;
      
      public var mimicryPos:uint = 0;
      
      public var foodUID:uint = 0;
      
      public var foodPos:uint = 0;
      
      public var hostUID:uint = 0;
      
      public var hostPos:uint = 0;
      
      public var preview:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6460;
      }
      
      public function initMimicryObjectFeedAndAssociateRequestMessage(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0, param7:Boolean=false) : MimicryObjectFeedAndAssociateRequestMessage {
         this.mimicryUID = param1;
         this.mimicryPos = param2;
         this.foodUID = param3;
         this.foodPos = param4;
         this.hostUID = param5;
         this.hostPos = param6;
         this.preview = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mimicryUID = 0;
         this.mimicryPos = 0;
         this.foodUID = 0;
         this.foodPos = 0;
         this.hostUID = 0;
         this.hostPos = 0;
         this.preview = false;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1);
      }
      
      public function serializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1:IDataOutput) : void {
         if(this.mimicryUID < 0)
         {
            throw new Error("Forbidden value (" + this.mimicryUID + ") on element mimicryUID.");
         }
         else
         {
            param1.writeInt(this.mimicryUID);
            if(this.mimicryPos < 0 || this.mimicryPos > 255)
            {
               throw new Error("Forbidden value (" + this.mimicryPos + ") on element mimicryPos.");
            }
            else
            {
               param1.writeByte(this.mimicryPos);
               if(this.foodUID < 0)
               {
                  throw new Error("Forbidden value (" + this.foodUID + ") on element foodUID.");
               }
               else
               {
                  param1.writeInt(this.foodUID);
                  if(this.foodPos < 0 || this.foodPos > 255)
                  {
                     throw new Error("Forbidden value (" + this.foodPos + ") on element foodPos.");
                  }
                  else
                  {
                     param1.writeByte(this.foodPos);
                     if(this.hostUID < 0)
                     {
                        throw new Error("Forbidden value (" + this.hostUID + ") on element hostUID.");
                     }
                     else
                     {
                        param1.writeInt(this.hostUID);
                        if(this.hostPos < 0 || this.hostPos > 255)
                        {
                           throw new Error("Forbidden value (" + this.hostPos + ") on element hostPos.");
                        }
                        else
                        {
                           param1.writeByte(this.hostPos);
                           param1.writeBoolean(this.preview);
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1);
      }
      
      public function deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(param1:IDataInput) : void {
         this.mimicryUID = param1.readInt();
         if(this.mimicryUID < 0)
         {
            throw new Error("Forbidden value (" + this.mimicryUID + ") on element of MimicryObjectFeedAndAssociateRequestMessage.mimicryUID.");
         }
         else
         {
            this.mimicryPos = param1.readUnsignedByte();
            if(this.mimicryPos < 0 || this.mimicryPos > 255)
            {
               throw new Error("Forbidden value (" + this.mimicryPos + ") on element of MimicryObjectFeedAndAssociateRequestMessage.mimicryPos.");
            }
            else
            {
               this.foodUID = param1.readInt();
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
                     this.hostUID = param1.readInt();
                     if(this.hostUID < 0)
                     {
                        throw new Error("Forbidden value (" + this.hostUID + ") on element of MimicryObjectFeedAndAssociateRequestMessage.hostUID.");
                     }
                     else
                     {
                        this.hostPos = param1.readUnsignedByte();
                        if(this.hostPos < 0 || this.hostPos > 255)
                        {
                           throw new Error("Forbidden value (" + this.hostPos + ") on element of MimicryObjectFeedAndAssociateRequestMessage.hostPos.");
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
         }
      }
   }
}
