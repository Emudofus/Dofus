package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightSlideMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightSlideMessage() {
         super();
      }
      
      public static const protocolId:uint = 5525;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var startCellId:int = 0;
      
      public var endCellId:int = 0;
      
      override public function getMessageId() : uint {
         return 5525;
      }
      
      public function initGameActionFightSlideMessage(param1:uint=0, param2:int=0, param3:int=0, param4:int=0, param5:int=0) : GameActionFightSlideMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.startCellId = param4;
         this.endCellId = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.startCellId = 0;
         this.endCellId = 0;
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
         this.serializeAs_GameActionFightSlideMessage(param1);
      }
      
      public function serializeAs_GameActionFightSlideMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         if(this.startCellId < -1 || this.startCellId > 559)
         {
            throw new Error("Forbidden value (" + this.startCellId + ") on element startCellId.");
         }
         else
         {
            param1.writeShort(this.startCellId);
            if(this.endCellId < -1 || this.endCellId > 559)
            {
               throw new Error("Forbidden value (" + this.endCellId + ") on element endCellId.");
            }
            else
            {
               param1.writeShort(this.endCellId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightSlideMessage(param1);
      }
      
      public function deserializeAs_GameActionFightSlideMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.startCellId = param1.readShort();
         if(this.startCellId < -1 || this.startCellId > 559)
         {
            throw new Error("Forbidden value (" + this.startCellId + ") on element of GameActionFightSlideMessage.startCellId.");
         }
         else
         {
            this.endCellId = param1.readShort();
            if(this.endCellId < -1 || this.endCellId > 559)
            {
               throw new Error("Forbidden value (" + this.endCellId + ") on element of GameActionFightSlideMessage.endCellId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
