package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class UpdateLifePointsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function UpdateLifePointsMessage() {
         super();
      }
      
      public static const protocolId:uint = 5658;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      override public function getMessageId() : uint {
         return 5658;
      }
      
      public function initUpdateLifePointsMessage(lifePoints:uint=0, maxLifePoints:uint=0) : UpdateLifePointsMessage {
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.lifePoints = 0;
         this.maxLifePoints = 0;
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
         this.serializeAs_UpdateLifePointsMessage(output);
      }
      
      public function serializeAs_UpdateLifePointsMessage(output:IDataOutput) : void {
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
         }
         else
         {
            output.writeInt(this.lifePoints);
            if(this.maxLifePoints < 0)
            {
               throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
            }
            else
            {
               output.writeInt(this.maxLifePoints);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_UpdateLifePointsMessage(input);
      }
      
      public function deserializeAs_UpdateLifePointsMessage(input:IDataInput) : void {
         this.lifePoints = input.readInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of UpdateLifePointsMessage.lifePoints.");
         }
         else
         {
            this.maxLifePoints = input.readInt();
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
