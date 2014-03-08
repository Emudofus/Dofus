package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.DungeonPartyFinderPlayer;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonPartyFinderRoomContentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonPartyFinderRoomContentMessage() {
         this.players = new Vector.<DungeonPartyFinderPlayer>();
         super();
      }
      
      public static const protocolId:uint = 6247;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      public var players:Vector.<DungeonPartyFinderPlayer>;
      
      override public function getMessageId() : uint {
         return 6247;
      }
      
      public function initDungeonPartyFinderRoomContentMessage(param1:uint=0, param2:Vector.<DungeonPartyFinderPlayer>=null) : DungeonPartyFinderRoomContentMessage {
         this.dungeonId = param1;
         this.players = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.players = new Vector.<DungeonPartyFinderPlayer>();
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
         this.serializeAs_DungeonPartyFinderRoomContentMessage(param1);
      }
      
      public function serializeAs_DungeonPartyFinderRoomContentMessage(param1:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeShort(this.dungeonId);
            param1.writeShort(this.players.length);
            _loc2_ = 0;
            while(_loc2_ < this.players.length)
            {
               (this.players[_loc2_] as DungeonPartyFinderPlayer).serializeAs_DungeonPartyFinderPlayer(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_DungeonPartyFinderRoomContentMessage(param1);
      }
      
      public function deserializeAs_DungeonPartyFinderRoomContentMessage(param1:IDataInput) : void {
         var _loc4_:DungeonPartyFinderPlayer = null;
         this.dungeonId = param1.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonPartyFinderRoomContentMessage.dungeonId.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = new DungeonPartyFinderPlayer();
               _loc4_.deserialize(param1);
               this.players.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
