package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightPlacementSwapPositionsOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightPlacementSwapPositionsOfferMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6542;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var requestId:uint = 0;
      
      public var requesterId:uint = 0;
      
      public var requesterCellId:uint = 0;
      
      public var requestedId:uint = 0;
      
      public var requestedCellId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6542;
      }
      
      public function initGameFightPlacementSwapPositionsOfferMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0) : GameFightPlacementSwapPositionsOfferMessage
      {
         this.requestId = param1;
         this.requesterId = param2;
         this.requesterCellId = param3;
         this.requestedId = param4;
         this.requestedCellId = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
         this.requesterId = 0;
         this.requesterCellId = 0;
         this.requestedId = 0;
         this.requestedCellId = 0;
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
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightPlacementSwapPositionsOfferMessage(param1);
      }
      
      public function serializeAs_GameFightPlacementSwapPositionsOfferMessage(param1:ICustomDataOutput) : void
      {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            param1.writeInt(this.requestId);
            if(this.requesterId < 0)
            {
               throw new Error("Forbidden value (" + this.requesterId + ") on element requesterId.");
            }
            else
            {
               param1.writeVarInt(this.requesterId);
               if(this.requesterCellId < 0 || this.requesterCellId > 559)
               {
                  throw new Error("Forbidden value (" + this.requesterCellId + ") on element requesterCellId.");
               }
               else
               {
                  param1.writeVarShort(this.requesterCellId);
                  if(this.requestedId < 0)
                  {
                     throw new Error("Forbidden value (" + this.requestedId + ") on element requestedId.");
                  }
                  else
                  {
                     param1.writeVarInt(this.requestedId);
                     if(this.requestedCellId < 0 || this.requestedCellId > 559)
                     {
                        throw new Error("Forbidden value (" + this.requestedCellId + ") on element requestedCellId.");
                     }
                     else
                     {
                        param1.writeVarShort(this.requestedCellId);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPlacementSwapPositionsOfferMessage(param1);
      }
      
      public function deserializeAs_GameFightPlacementSwapPositionsOfferMessage(param1:ICustomDataInput) : void
      {
         this.requestId = param1.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestId.");
         }
         else
         {
            this.requesterId = param1.readVarUhInt();
            if(this.requesterId < 0)
            {
               throw new Error("Forbidden value (" + this.requesterId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requesterId.");
            }
            else
            {
               this.requesterCellId = param1.readVarUhShort();
               if(this.requesterCellId < 0 || this.requesterCellId > 559)
               {
                  throw new Error("Forbidden value (" + this.requesterCellId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requesterCellId.");
               }
               else
               {
                  this.requestedId = param1.readVarUhInt();
                  if(this.requestedId < 0)
                  {
                     throw new Error("Forbidden value (" + this.requestedId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestedId.");
                  }
                  else
                  {
                     this.requestedCellId = param1.readVarUhShort();
                     if(this.requestedCellId < 0 || this.requestedCellId > 559)
                     {
                        throw new Error("Forbidden value (" + this.requestedCellId + ") on element of GameFightPlacementSwapPositionsOfferMessage.requestedCellId.");
                     }
                     else
                     {
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
