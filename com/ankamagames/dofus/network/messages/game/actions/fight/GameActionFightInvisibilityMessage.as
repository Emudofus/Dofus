package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightInvisibilityMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightInvisibilityMessage() {
         super();
      }
      
      public static const protocolId:uint = 5821;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var targetId:int = 0;
      
      public var state:int = 0;
      
      override public function getMessageId() : uint {
         return 5821;
      }
      
      public function initGameActionFightInvisibilityMessage(param1:uint=0, param2:int=0, param3:int=0, param4:int=0) : GameActionFightInvisibilityMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.targetId = param3;
         this.state = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.targetId = 0;
         this.state = 0;
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
         this.serializeAs_GameActionFightInvisibilityMessage(param1);
      }
      
      public function serializeAs_GameActionFightInvisibilityMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeInt(this.targetId);
         param1.writeByte(this.state);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightInvisibilityMessage(param1);
      }
      
      public function deserializeAs_GameActionFightInvisibilityMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.targetId = param1.readInt();
         this.state = param1.readByte();
      }
   }
}
