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
      
      public function initMimicryObjectFeedAndAssociateRequestMessage(mimicryUID:uint = 0, mimicryPos:uint = 0, foodUID:uint = 0, foodPos:uint = 0, hostUID:uint = 0, hostPos:uint = 0, preview:Boolean = false) : MimicryObjectFeedAndAssociateRequestMessage {
         this.mimicryUID = mimicryUID;
         this.mimicryPos = mimicryPos;
         this.foodUID = foodUID;
         this.foodPos = foodPos;
         this.hostUID = hostUID;
         this.hostPos = hostPos;
         this.preview = preview;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MimicryObjectFeedAndAssociateRequestMessage(output);
      }
      
      public function serializeAs_MimicryObjectFeedAndAssociateRequestMessage(output:IDataOutput) : void {
         if(this.mimicryUID < 0)
         {
            throw new Error("Forbidden value (" + this.mimicryUID + ") on element mimicryUID.");
         }
         else
         {
            output.writeInt(this.mimicryUID);
            if((this.mimicryPos < 0) || (this.mimicryPos > 255))
            {
               throw new Error("Forbidden value (" + this.mimicryPos + ") on element mimicryPos.");
            }
            else
            {
               output.writeByte(this.mimicryPos);
               if(this.foodUID < 0)
               {
                  throw new Error("Forbidden value (" + this.foodUID + ") on element foodUID.");
               }
               else
               {
                  output.writeInt(this.foodUID);
                  if((this.foodPos < 0) || (this.foodPos > 255))
                  {
                     throw new Error("Forbidden value (" + this.foodPos + ") on element foodPos.");
                  }
                  else
                  {
                     output.writeByte(this.foodPos);
                     if(this.hostUID < 0)
                     {
                        throw new Error("Forbidden value (" + this.hostUID + ") on element hostUID.");
                     }
                     else
                     {
                        output.writeInt(this.hostUID);
                        if((this.hostPos < 0) || (this.hostPos > 255))
                        {
                           throw new Error("Forbidden value (" + this.hostPos + ") on element hostPos.");
                        }
                        else
                        {
                           output.writeByte(this.hostPos);
                           output.writeBoolean(this.preview);
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(input);
      }
      
      public function deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(input:IDataInput) : void {
         this.mimicryUID = input.readInt();
         if(this.mimicryUID < 0)
         {
            throw new Error("Forbidden value (" + this.mimicryUID + ") on element of MimicryObjectFeedAndAssociateRequestMessage.mimicryUID.");
         }
         else
         {
            this.mimicryPos = input.readUnsignedByte();
            if((this.mimicryPos < 0) || (this.mimicryPos > 255))
            {
               throw new Error("Forbidden value (" + this.mimicryPos + ") on element of MimicryObjectFeedAndAssociateRequestMessage.mimicryPos.");
            }
            else
            {
               this.foodUID = input.readInt();
               if(this.foodUID < 0)
               {
                  throw new Error("Forbidden value (" + this.foodUID + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodUID.");
               }
               else
               {
                  this.foodPos = input.readUnsignedByte();
                  if((this.foodPos < 0) || (this.foodPos > 255))
                  {
                     throw new Error("Forbidden value (" + this.foodPos + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodPos.");
                  }
                  else
                  {
                     this.hostUID = input.readInt();
                     if(this.hostUID < 0)
                     {
                        throw new Error("Forbidden value (" + this.hostUID + ") on element of MimicryObjectFeedAndAssociateRequestMessage.hostUID.");
                     }
                     else
                     {
                        this.hostPos = input.readUnsignedByte();
                        if((this.hostPos < 0) || (this.hostPos > 255))
                        {
                           throw new Error("Forbidden value (" + this.hostPos + ") on element of MimicryObjectFeedAndAssociateRequestMessage.hostPos.");
                        }
                        else
                        {
                           this.preview = input.readBoolean();
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
