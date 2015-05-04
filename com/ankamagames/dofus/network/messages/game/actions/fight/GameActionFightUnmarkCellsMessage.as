package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionFightUnmarkCellsMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightUnmarkCellsMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5570;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var markId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5570;
      }
      
      public function initGameActionFightUnmarkCellsMessage(param1:uint = 0, param2:int = 0, param3:int = 0) : GameActionFightUnmarkCellsMessage
      {
         super.initAbstractGameActionMessage(param1,param2);
         this.markId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.markId = 0;
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
         this.serializeAs_GameActionFightUnmarkCellsMessage(param1);
      }
      
      public function serializeAs_GameActionFightUnmarkCellsMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeShort(this.markId);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionFightUnmarkCellsMessage(param1);
      }
      
      public function deserializeAs_GameActionFightUnmarkCellsMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.markId = param1.readShort();
      }
   }
}
