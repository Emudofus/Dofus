package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightDropCharacterMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightDropCharacterMessage() {
         super();
      }
      
      public static const protocolId:uint = 5826;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var cellId:int = 0;
      
      override public function getMessageId() : uint {
         return 5826;
      }
      
      public function initGameActionFightDropCharacterMessage(param1:uint=0, param2:int=0, param3:int=0, param4:int=0) : GameActionFightDropCharacterMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.cellId = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.cellId = 0;
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
         this.serializeAs_GameActionFightDropCharacterMessage(param1);
      }
      
      public function serializeAs_GameActionFightDropCharacterMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         if(this.cellId < -1 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            param1.writeShort(this.cellId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightDropCharacterMessage(param1);
      }
      
      public function deserializeAs_GameActionFightDropCharacterMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.cellId = param1.readShort();
         if(this.cellId < -1 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionFightDropCharacterMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }
}
