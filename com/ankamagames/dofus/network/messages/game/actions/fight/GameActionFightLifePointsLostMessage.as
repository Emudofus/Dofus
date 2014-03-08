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
      
      public function initGameActionFightLifePointsLostMessage(param1:uint=0, param2:int=0, param3:int=0, param4:uint=0, param5:uint=0) : GameActionFightLifePointsLostMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.loss = param4;
         this.permanentDamages = param5;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionFightLifePointsLostMessage(param1);
      }
      
      public function serializeAs_GameActionFightLifePointsLostMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         if(this.loss < 0)
         {
            throw new Error("Forbidden value (" + this.loss + ") on element loss.");
         }
         else
         {
            param1.writeShort(this.loss);
            if(this.permanentDamages < 0)
            {
               throw new Error("Forbidden value (" + this.permanentDamages + ") on element permanentDamages.");
            }
            else
            {
               param1.writeShort(this.permanentDamages);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightLifePointsLostMessage(param1);
      }
      
      public function deserializeAs_GameActionFightLifePointsLostMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.loss = param1.readShort();
         if(this.loss < 0)
         {
            throw new Error("Forbidden value (" + this.loss + ") on element of GameActionFightLifePointsLostMessage.loss.");
         }
         else
         {
            this.permanentDamages = param1.readShort();
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
