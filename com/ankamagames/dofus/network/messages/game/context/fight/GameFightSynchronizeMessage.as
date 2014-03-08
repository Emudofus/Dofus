package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameFightSynchronizeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightSynchronizeMessage() {
         this.fighters = new Vector.<GameFightFighterInformations>();
         super();
      }
      
      public static const protocolId:uint = 5921;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fighters:Vector.<GameFightFighterInformations>;
      
      override public function getMessageId() : uint {
         return 5921;
      }
      
      public function initGameFightSynchronizeMessage(param1:Vector.<GameFightFighterInformations>=null) : GameFightSynchronizeMessage {
         this.fighters = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fighters = new Vector.<GameFightFighterInformations>();
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
         this.serializeAs_GameFightSynchronizeMessage(param1);
      }
      
      public function serializeAs_GameFightSynchronizeMessage(param1:IDataOutput) : void {
         param1.writeShort(this.fighters.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.fighters.length)
         {
            param1.writeShort((this.fighters[_loc2_] as GameFightFighterInformations).getTypeId());
            (this.fighters[_loc2_] as GameFightFighterInformations).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightSynchronizeMessage(param1);
      }
      
      public function deserializeAs_GameFightSynchronizeMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:GameFightFighterInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(GameFightFighterInformations,_loc4_);
            _loc5_.deserialize(param1);
            this.fighters.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
