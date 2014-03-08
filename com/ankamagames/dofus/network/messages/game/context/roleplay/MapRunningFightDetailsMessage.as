package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterLightInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class MapRunningFightDetailsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapRunningFightDetailsMessage() {
         this.attackers = new Vector.<GameFightFighterLightInformations>();
         this.defenders = new Vector.<GameFightFighterLightInformations>();
         super();
      }
      
      public static const protocolId:uint = 5751;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var attackers:Vector.<GameFightFighterLightInformations>;
      
      public var defenders:Vector.<GameFightFighterLightInformations>;
      
      override public function getMessageId() : uint {
         return 5751;
      }
      
      public function initMapRunningFightDetailsMessage(param1:uint=0, param2:Vector.<GameFightFighterLightInformations>=null, param3:Vector.<GameFightFighterLightInformations>=null) : MapRunningFightDetailsMessage {
         this.fightId = param1;
         this.attackers = param2;
         this.defenders = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.attackers = new Vector.<GameFightFighterLightInformations>();
         this.defenders = new Vector.<GameFightFighterLightInformations>();
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
         this.serializeAs_MapRunningFightDetailsMessage(param1);
      }
      
      public function serializeAs_MapRunningFightDetailsMessage(param1:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            param1.writeInt(this.fightId);
            param1.writeShort(this.attackers.length);
            _loc2_ = 0;
            while(_loc2_ < this.attackers.length)
            {
               param1.writeShort((this.attackers[_loc2_] as GameFightFighterLightInformations).getTypeId());
               (this.attackers[_loc2_] as GameFightFighterLightInformations).serialize(param1);
               _loc2_++;
            }
            param1.writeShort(this.defenders.length);
            _loc3_ = 0;
            while(_loc3_ < this.defenders.length)
            {
               param1.writeShort((this.defenders[_loc3_] as GameFightFighterLightInformations).getTypeId());
               (this.defenders[_loc3_] as GameFightFighterLightInformations).serialize(param1);
               _loc3_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MapRunningFightDetailsMessage(param1);
      }
      
      public function deserializeAs_MapRunningFightDetailsMessage(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:GameFightFighterLightInformations = null;
         var _loc8_:uint = 0;
         var _loc9_:GameFightFighterLightInformations = null;
         this.fightId = param1.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of MapRunningFightDetailsMessage.fightId.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = param1.readUnsignedShort();
               _loc7_ = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_loc6_);
               _loc7_.deserialize(param1);
               this.attackers.push(_loc7_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc8_ = param1.readUnsignedShort();
               _loc9_ = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_loc8_);
               _loc9_.deserialize(param1);
               this.defenders.push(_loc9_);
               _loc5_++;
            }
            return;
         }
      }
   }
}
