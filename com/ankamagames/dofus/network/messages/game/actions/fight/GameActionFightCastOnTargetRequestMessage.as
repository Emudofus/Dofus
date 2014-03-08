package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightCastOnTargetRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameActionFightCastOnTargetRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6330;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 6330;
      }
      
      public function initGameActionFightCastOnTargetRequestMessage(param1:uint=0, param2:int=0) : GameActionFightCastOnTargetRequestMessage {
         this.spellId = param1;
         this.targetId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellId = 0;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionFightCastOnTargetRequestMessage(param1);
      }
      
      public function serializeAs_GameActionFightCastOnTargetRequestMessage(param1:IDataOutput) : void {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            param1.writeShort(this.spellId);
            param1.writeInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightCastOnTargetRequestMessage(param1);
      }
      
      public function deserializeAs_GameActionFightCastOnTargetRequestMessage(param1:IDataInput) : void {
         this.spellId = param1.readShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastOnTargetRequestMessage.spellId.");
         }
         else
         {
            this.targetId = param1.readInt();
            return;
         }
      }
   }
}
