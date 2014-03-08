package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightTackledMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightTackledMessage() {
         this.tacklersIds = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 1004;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var tacklersIds:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 1004;
      }
      
      public function initGameActionFightTackledMessage(param1:uint=0, param2:int=0, param3:Vector.<int>=null) : GameActionFightTackledMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.tacklersIds = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.tacklersIds = new Vector.<int>();
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
         this.serializeAs_GameActionFightTackledMessage(param1);
      }
      
      public function serializeAs_GameActionFightTackledMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeShort(this.tacklersIds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.tacklersIds.length)
         {
            param1.writeInt(this.tacklersIds[_loc2_]);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightTackledMessage(param1);
      }
      
      public function deserializeAs_GameActionFightTackledMessage(param1:IDataInput) : void {
         var _loc4_:* = 0;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInt();
            this.tacklersIds.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
