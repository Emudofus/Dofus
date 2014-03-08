package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightDispellMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightDispellMessage() {
         super();
      }
      
      public static const protocolId:uint = 5533;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 5533;
      }
      
      public function initGameActionFightDispellMessage(param1:uint=0, param2:int=0, param3:int=0) : GameActionFightDispellMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
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
         this.serializeAs_GameActionFightDispellMessage(param1);
      }
      
      public function serializeAs_GameActionFightDispellMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightDispellMessage(param1);
      }
      
      public function deserializeAs_GameActionFightDispellMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.targetId = param1.readInt();
      }
   }
}
