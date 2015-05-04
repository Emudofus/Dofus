package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class UpdateLifePointsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function UpdateLifePointsMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5658;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5658;
      }
      
      public function initUpdateLifePointsMessage(param1:uint = 0, param2:uint = 0) : UpdateLifePointsMessage
      {
         this.lifePoints = param1;
         this.maxLifePoints = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.lifePoints = 0;
         this.maxLifePoints = 0;
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
         this.serializeAs_UpdateLifePointsMessage(param1);
      }
      
      public function serializeAs_UpdateLifePointsMessage(param1:ICustomDataOutput) : void
      {
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
         }
         else
         {
            param1.writeVarInt(this.lifePoints);
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
            }
            else
            {
               param1.writeVarInt(this.maxLifePoints);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateLifePointsMessage(param1);
      }
      
      public function deserializeAs_UpdateLifePointsMessage(param1:ICustomDataInput) : void
      {
         this.lifePoints = param1.readVarUhInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of UpdateLifePointsMessage.lifePoints.");
         }
         else
         {
            this.maxLifePoints = param1.readVarUhInt();
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of UpdateLifePointsMessage.maxLifePoints.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
