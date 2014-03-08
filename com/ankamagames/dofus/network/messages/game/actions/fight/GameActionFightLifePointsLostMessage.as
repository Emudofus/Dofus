package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightLifePointsLostMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightLifePointsLostMessage() {
         super();
      }
      
      public static const protocolId:uint = 6312;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var loss:uint = 0;
      
      public var permanentDamages:uint = 0;
      
      override public function getMessageId() : uint {
         return 6312;
      }
      
      public function initGameActionFightLifePointsLostMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, loss:uint=0, permanentDamages:uint=0) : GameActionFightLifePointsLostMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.targetId = targetId;
         this.loss = loss;
         this.permanentDamages = permanentDamages;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.loss = 0;
         this.permanentDamages = 0;
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
         this.serializeAs_GameActionFightLifePointsLostMessage(output);
      }
      
      public function serializeAs_GameActionFightLifePointsLostMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeInt(this.targetId);
         if(this.loss < 0)
         {
            throw new Error("Forbidden value (" + this.loss + ") on element loss.");
         }
         else
         {
            output.writeShort(this.loss);
            if(this.permanentDamages < 0)
            {
               throw new Error("Forbidden value (" + this.permanentDamages + ") on element permanentDamages.");
            }
            else
            {
               output.writeShort(this.permanentDamages);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightLifePointsLostMessage(input);
      }
      
      public function deserializeAs_GameActionFightLifePointsLostMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.targetId = input.readInt();
         this.loss = input.readShort();
         if(this.loss < 0)
         {
            throw new Error("Forbidden value (" + this.loss + ") on element of GameActionFightLifePointsLostMessage.loss.");
         }
         else
         {
            this.permanentDamages = input.readShort();
            if(this.permanentDamages < 0)
            {
               throw new Error("Forbidden value (" + this.permanentDamages + ") on element of GameActionFightLifePointsLostMessage.permanentDamages.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
